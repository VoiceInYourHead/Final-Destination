/obj/machinery/computer/ship/hmg
	name = "heavy machine gun control"
	icon = 'icons/obj/computer.dmi'
	icon_state = "computer"

	core_skill = SKILL_DEVICES
	var/skill_offset = SKILL_ADEPT - 1 //After which skill level it starts to matter. -1, because we have to index from zero

	icon_keyboard = "rd_key"
	icon_screen = "teleport"

	var/link_range = 10 //How far can the above stuff be maximum before we start complaining

	var/overmapdir = 0

	var/caldigit = 2 //number of digits that needs calibration
	var/list/calibration //what it is
	var/list/calexpected //what is should be

	var/next_shot = 0 //round time where the next shot can start from
	var/coolinterval = 5 SECONDS //time to wait between safe shots in deciseconds

	var/obj/machinery/hmg/front_part/front
	var/obj/machinery/hmg/middle_part/middle
	var/obj/machinery/hmg/back_part/back
	var/obj/structure/ship_munition/ammobox/hmg/munition

	var/ammo_per_shot = 1
	var/danger_zone = 2
	var/burst_size = 10
	var/burst_interval = 5

	var/play_emptymag_sound = 1

	var/console_html_name = "autocannon.tmpl"
	var/gun_name = "heavy machine gun"

	// Насколько большой будет разброс в тайлах при попадании на овермап судна-цели.
	// Пример: при pew_spread = 20 снаряд будет спавниться с разбросом от -10 до 10 тайлов на нужном краю карты.
	var/pew_spread = 20

	var/fire_sound = 'sound/weapons/gunshot/gunshot3.ogg'
	var/pew_color = null

	var/muzzle_flash = /obj/effect/projectile/bullet/muzzle/autocannon
	var/muzzle_color = null

	var/overmap_icon = "bullet" // icons\effects\beam.dmi
	var/overmap_color = null


/obj/machinery/computer/ship/hmg/Initialize()
	. = ..()
	link_parts()
	reset_calibration()

/obj/machinery/computer/ship/hmg/Destroy()
	release_links()
	. = ..()

/obj/machinery/computer/ship/hmg/proc/link_parts()
	if(is_valid_setup())
		return TRUE

	for(front in SSmachines.machinery)
		if(get_dist(src, front) >= link_range)
			continue
		var/backwards = turn(front.dir, 180)
		middle = locate() in get_step(front, backwards)
		if(!middle || get_dist(src, middle) >= link_range)
			continue
		back = locate() in get_step(middle, backwards)
		if(!back || get_dist(src, back) >= link_range)
			continue
		if(is_valid_setup())
			GLOB.destroyed_event.register(front, src, .proc/release_links)
			GLOB.destroyed_event.register(middle, src, .proc/release_links)
			GLOB.destroyed_event.register(back, src, .proc/release_links)
			return TRUE
	return FALSE

/obj/machinery/computer/ship/hmg/proc/is_valid_setup()
	if(front && middle && back)
		var/everything_in_range = (get_dist(src, front) < link_range) && (get_dist(src, middle) < link_range) && (get_dist(src, back) < link_range)
		var/everything_in_order = (middle.Adjacent(front) && middle.Adjacent(back)) && (front.dir == middle.dir && middle.dir == back.dir)
		return everything_in_order && everything_in_range
	return FALSE

/obj/machinery/computer/ship/hmg/proc/release_links()
	GLOB.destroyed_event.unregister(front, src, .proc/release_links)
	GLOB.destroyed_event.unregister(middle, src, .proc/release_links)
	GLOB.destroyed_event.unregister(back, src, .proc/release_links)
	front = null
	middle = null
	back = null

/obj/machinery/computer/ship/hmg/proc/get_calibration()
	var/list/calresult[caldigit]
	for(var/i = 1 to caldigit)
		if(calibration[i] == calexpected[i])
			calresult[i] = 2
		else if(calibration[i] in calexpected)
			calresult[i] = 1
		else
			calresult[i] = 0
	return calresult

/obj/machinery/computer/ship/hmg/proc/reset_calibration()
	calexpected = new /list(caldigit)
	calibration = new /list(caldigit)
	for(var/i = 1 to caldigit)
		calexpected[i] = rand(0,9)
		calibration[i] = 0

/obj/machinery/computer/ship/hmg/proc/cal_accuracy()
	var/top = 0
	var/divisor = caldigit * 2 //maximum possible value, aka 100% accuracy
	for(var/i in get_calibration())
		top += i
	return round(top * 100 / divisor)

/obj/machinery/computer/ship/hmg/proc/get_next_shot_seconds()
	return max(0, (next_shot - world.time) / 10)

/obj/machinery/computer/ship/hmg/proc/cool_failchance()
	return get_next_shot_seconds() * 1000 / coolinterval

/obj/machinery/computer/ship/hmg/proc/get_charge()
	munition = locate() in get_turf(back)
	if(munition)
		return munition
	return 0

/obj/machinery/computer/ship/hmg/proc/get_ammo()
	munition = locate() in get_turf(back)
	if(munition)
		return munition.ammo_count

/obj/machinery/computer/ship/hmg/proc/get_ammo_type()
	munition = locate() in get_turf(back)
	if(munition)
		return munition.ammo_type

/obj/machinery/computer/ship/hmg/proc/remove_ammo()
	munition = locate() in get_turf(back)
	if(munition.ammo_count > 0)
		munition.ammo_count -= ammo_per_shot
	return

/obj/machinery/computer/ship/hmg/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = TRUE)
	if(!linked)
		display_reconnect_dialog(user, "[gun_name] synchronization")
		return

	var/data[0]

	if (!link_parts())
		data["faillink"] = TRUE
	else
		data["calibration"] = calibration
		data["overmapdir"] = overmapdir
		data["cal_accuracy"] = cal_accuracy()
		data["next_shot"] = round(get_next_shot_seconds())
		data["nopower"] = !data["faillink"] && (!front.powered() || !middle.powered() || !back.powered())
		data["skill"] = user.get_skill_value(core_skill) > skill_offset

		var/ammo_count_console = SPAN_BOLD("UNKNOWN ERROR")
		switch(get_charge())
			if(0)
				ammo_count_console = "[SPAN_BOLD("ERROR")]: No valid ammo detected."
			else
				ammo_count_console = get_ammo()
		data["chargeload"] = ammo_count_console

		var/charge = SPAN_BOLD("UNKNOWN ERROR")
		switch(get_charge())
			if(0)
				charge = "No valid ammo detected"
			else
				charge = get_charge().name
		data["chargename"] = charge

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, console_html_name, "[linked.name] [gun_name]", 400, 550)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/computer/ship/hmg/OnTopic(mob/user, list/href_list, state)
	. = ..()
	if(.)
		return

	if(!linked)
		return TOPIC_HANDLED

	if (href_list["choose"])
		overmapdir = sanitize_integer(text2num(href_list["choose"]), 0, 9, 0)
		reset_calibration()

	if(href_list["calibration"])
		var/input = input("0-9", "[gun_name] calibration", 0) as num|null
		if(!isnull(input)) //can be zero so we explicitly check for null
			var/calnum = sanitize_integer(text2num(href_list["calibration"]), 0, caldigit)//sanitiiiiize
			calibration[calnum + 1] = sanitize_integer(input, 0, 9, 0)//must add 1 because nanoui indexes from 0

	if(href_list["skill_calibration"])
		for(var/i = 1 to min(caldigit, user.get_skill_value(core_skill) - skill_offset))
			calibration[i] = calexpected[i]

	if(href_list["fire"])
		var/atomcharge_ammo = get_ammo()
		if(atomcharge_ammo <= 0)
			return TOPIC_REFRESH
		if(prob(cool_failchance())) //Some moron disregarded the cooldown warning. Let's blow in their face.
			explosion(middle,1,rand(1,2),rand(2,3))
			next_shot = coolinterval + world.time
			return TOPIC_REFRESH
		next_shot = coolinterval + world.time + burst_interval * burst_size
		log_and_message_admins("attempted to fire the [gun_name].")
		for(var/i = 1 to burst_size)
			if(get_charge() == 0)
				break
			if(atomcharge_ammo == 0 && play_emptymag_sound == 1)
				playsound(get_charge().loc, 'sound/weapons/smg_empty_alarm.ogg', 60, 1)
				break
			fire(user)
			remove_ammo()
			sleep(burst_interval)
		reset_calibration()
	return TOPIC_REFRESH

////////////////////////////////FIRE////////////////////////////////

/obj/machinery/computer/ship/hmg/proc/fire(mob/user)
	if(!link_parts())
		return FALSE //no disperser, no service
	if(!front.powered() || !middle.powered() || !back.powered())
		return FALSE //no power, no boom boom
	var/atomcharge_ammo = get_ammo()
	if(atomcharge_ammo <= 0)
		return FALSE

	var/turf/start = front
	var/direction = front.dir

	var/list/relevant_z = GetConnectedZlevels(start.z)
	for(var/mob/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!T || !(T.z in relevant_z))
			continue
		shake_camera(M, 8)
		if(!isdeaf(M))
			sound_to(M, sound('sound/effects/explosionfar.ogg', volume=10))

	var/ammo_type = get_ammo_type()
	var/obj/item/projectile/pew = new ammo_type(front.loc)
	pew.starting = front.loc
	pew.color = pew_color
	pew.launch(get_step(front.loc, front.dir), pick(BP_ALL_LIMBS))

	if(front) //Meanwhile front might have exploded
		front.layer = ABOVE_OBJ_LAYER //So the beam goes below us. Looks a lot better
	playsound(start, fire_sound, 250, 1)
	handle_muzzle(start, direction)

	var/distance = 0
	for(var/turf/T in getline(get_step(front,front.dir),get_target_turf(start, direction)))
		distance++
		if(T.density)
			if(distance <= danger_zone)
				explosion(T,1,2,2)
				return TRUE
		for(var/atom/A in T)
			if(A.density && !istype(A, /obj/effect/projectile))
				if(distance <= danger_zone)
					explosion(A,1,2,2)
					return TRUE

	handle_overbeam()

	//Success, but we missed.
	if(prob(100 - cal_accuracy()))
		return TRUE

	var/turf/overmaptarget = get_step(linked, overmapdir)
	var/list/candidates = list()

	//Next we see if there are any ships around. Logically they are between us and the sector if one exists.
	if(!length(candidates))
		for(var/obj/effect/overmap/visitable/ship/S in overmaptarget)
			if(S == linked)
				continue //Why are you shooting yourself?
			candidates += S

	if(!length(candidates))
		for(var/obj/effect/overmap/visitable/O in overmaptarget)
			if(O == linked)
				continue //Why are you shooting yourself?
			candidates += O

	//Way to waste a charge
	if(!length(candidates))
		return TRUE

	var/obj/effect/overmap/visitable/finaltarget = pick(candidates)

	var/z_level = pick(finaltarget.map_z)
	fire_at_sector(z_level, finaltarget.fore_dir, finaltarget.dir)

	return TRUE

/obj/machinery/computer/ship/hmg/proc/fire_at_sector(var/z_level, var/target_fore_dir, var/target_dir)
	var/heading = overmapdir

	if(!heading)
		heading = random_dir() // To prevent the missile from popping into the middle of the map and sitting there

	var/start_x = Floor(world.maxx / 2) + rand(-pew_spread/2, pew_spread/2)
	var/start_y = Floor(world.maxy / 2) + rand(-pew_spread/2, pew_spread/2)


	//Normalize killing people :D
	if(heading in GLOB.cornerdirs)
		if(heading == NORTHEAST)
			heading = pick(NORTH, EAST)
		if(heading == NORTHWEST)
			heading = pick(NORTH, WEST)
		if(heading == SOUTHEAST)
			heading = pick(SOUTH, EAST)
		if(heading == SOUTHWEST)
			heading = pick(SOUTH, WEST)

	if(target_dir in GLOB.cornerdirs)
		if(target_dir == NORTHEAST)
			target_dir = pick(NORTH, EAST)
		if(target_dir == NORTHWEST)
			target_dir = pick(NORTH, WEST)
		if(target_dir == SOUTHEAST)
			target_dir = pick(SOUTH, EAST)
		if(target_dir == SOUTHWEST)
			target_dir = pick(SOUTH, WEST)

	if(heading == target_dir)
		if(target_fore_dir == NORTH)
			start_y = TRANSITIONEDGE + 2
			heading = NORTH
		else if(target_fore_dir == SOUTH)
			start_y = world.maxy - TRANSITIONEDGE - 2
			heading = SOUTH
		else if(target_fore_dir == WEST)
			start_x = world.maxx - TRANSITIONEDGE - 2
			heading = WEST
		else
			start_x = TRANSITIONEDGE + 2
			heading = EAST

	else if(heading == GLOB.reverse_dir[target_dir])
		if(target_fore_dir == NORTH)
			start_y = world.maxy - TRANSITIONEDGE - 2
			heading = SOUTH
		else if(target_fore_dir == SOUTH)
			start_y = TRANSITIONEDGE + 2
			heading = NORTH
		else if(target_fore_dir == WEST)
			start_x = TRANSITIONEDGE + 2
			heading = EAST
		else
			start_x = world.maxx - TRANSITIONEDGE - 2
			heading = WEST

	else if(heading == GLOB.cw_dir[target_dir])
		if(target_fore_dir == NORTH)
			start_x = TRANSITIONEDGE + 2
			heading = EAST
		else if(target_fore_dir == SOUTH)
			start_x = world.maxx - TRANSITIONEDGE - 2
			heading = WEST
		else if(target_fore_dir == WEST)
			start_y = TRANSITIONEDGE + 2
			heading = NORTH
		else
			start_y = world.maxy - TRANSITIONEDGE - 2
			heading = SOUTH

	else if(heading == GLOB.ccw_dir[target_dir])
		if(target_fore_dir == NORTH)
			start_x = world.maxx - TRANSITIONEDGE - 2
			heading = WEST
		else if(target_fore_dir == SOUTH)
			start_x = TRANSITIONEDGE + 2
			heading = EAST
		else if(target_fore_dir == WEST)
			start_y = world.maxy - TRANSITIONEDGE - 2
			heading = SOUTH
		else
			start_y = TRANSITIONEDGE + 2
			heading = NORTH

	var/turf/start = locate(start_x, start_y, z_level)

	log_and_message_admins("[gun_name] round got it to the Z [z_level] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[start_x];Y=[start_y];Z=[z_level]'>JMP</a>)")

	var/ammo_type = get_ammo_type()
	var/obj/item/projectile/pew = new ammo_type(start)
	pew.original = get_step(locate(start_x, start_y, z_level),heading)
	pew.current = get_step(locate(start_x, start_y, z_level),heading)
	pew.starting = start
	pew.color = pew_color
	pew.launch(get_step(locate(start_x, start_y, z_level),heading), pick(BP_ALL_LIMBS), start_x, start_y)

/obj/machinery/computer/ship/hmg/proc/handle_muzzle(turf/start, direction)
	set waitfor = FALSE
	var/obj/effect/projectile/P = new muzzle_flash(get_step(get_turf(start), direction))
	P.dir = direction
	P.color = muzzle_color
	QDEL_IN(P,2)

/obj/machinery/computer/ship/hmg/proc/handle_overbeam()
	set waitfor = FALSE
	linked.Beam(get_step(linked, overmapdir), overmap_icon, time = 2, maxdistance = world.maxx)

/obj/machinery/computer/ship/hmg/proc/get_target_turf(turf/start, direction)
	switch(direction)
		if(NORTH)
			return locate(start.x,world.maxy,start.z)
		if(SOUTH)
			return locate(start.x,1,start.z)
		if(WEST)
			return locate(1,start.y,start.z)
		if(EAST)
			return locate(world.maxx,start.y,start.z)

/obj/machinery/computer/ship/hmg/telescreen	//little hacky but it's only used on one ship so it should be okay
	icon_state = "tele_hmg"
	density = FALSE
	machine_name = "HMG control telescreen"
	machine_desc = "A compact, slimmed-down version of the weapon control console."

/obj/machinery/computer/ship/hmg/telescreen/on_update_icon()
	if(reason_broken & MACHINE_BROKEN_NO_PARTS || stat & NOPOWER || stat & BROKEN)
		icon_state = "tele_off"
		set_light(0)
	else
		icon_state = "tele_hmg"
		set_light(light_max_bright_on, light_inner_range_on, light_outer_range_on, 2, light_color)