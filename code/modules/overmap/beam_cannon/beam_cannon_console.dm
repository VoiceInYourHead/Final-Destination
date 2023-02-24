/obj/machinery/computer/ship/beam_cannon
	name = "ion beam emitter control"
	icon = 'icons/obj/computer.dmi'
	icon_state = "computer"

	core_skill = SKILL_DEVICES
	var/skill_offset = SKILL_ADEPT - 1 //After which skill level it starts to matter. -1, because we have to index from zero

	icon_keyboard = "rd_key"
	icon_screen = "teleport"

	var/link_range = 10 //How far can the above stuff be maximum before we start complaining

	var/overmapdir = 0

	var/caldigit = 6 //number of digits that needs calibration
	var/list/calibration //what it is
	var/list/calexpected //what is should be

	var/next_shot = 0 //round time where the next shot can start from
	var/coolinterval = 120 SECONDS //time to wait between safe shots in deciseconds

	var/console_html_name = "autocannon.tmpl"
	var/gun_name = "Ion beam emitter"

	var/structural_damage = 75

	var/obj/machinery/beam_cannon/front_part/front
	var/obj/machinery/beam_cannon/middle_part/middle
	var/obj/machinery/beam_cannon/back_part/back
	var/obj/structure/ship_munition/ammobox/cell/munition

	var/fire_type = /obj/effect/turf_fire/star_fire/strong

	var/ammo_per_shot = 1000
	var/burst_size = 1
	var/beam_speed = 1

	var/fire_delay = 200
	var/beam_time = 70

	var/play_emptymag_sound = 1

	// Ќасколько большой будет разброс в тайлах при попадании на овермап судна-цели.
	// ѕример: при pew_spread = 20 снар€д будет спавнитьс€ с разбросом от -10 до 10 тайлов на нужном краю карты.
	var/pew_spread = 20

	var/fire_sound = 'sound/machines/superlaser_firing.ogg'
	var/prefire_sound = 'sound/machines/superlaser_prefire.ogg'

	var/beam_sound = 'sound/machines/ion_beam_hit.ogg'
	var/beam_light_color = COLOR_RED_LIGHT
	var/beam_icon = "ion_beam" // icons\effects\beam.dmi

/obj/machinery/computer/ship/beam_cannon/Initialize()
	. = ..()
	link_parts()
	reset_calibration()

/obj/machinery/computer/ship/beam_cannon/Destroy()
	release_links()
	. = ..()

/obj/machinery/computer/ship/beam_cannon/proc/link_parts()
	if(is_valid_setup())
		return TRUE

	for(front in SSmachines.machinery)
		if(get_dist(src, front) >= link_range || front.z != src.z)
			continue
		var/backwards = turn(front.dir, 180)
		middle = locate() in get_step(front, backwards)
		if(!middle || get_dist(src, middle) >= link_range || middle.z != src.z)
			continue
		back = locate() in get_step(middle, backwards)
		if(!back || get_dist(src, back) >= link_range || back.z != src.z)
			continue
		if(is_valid_setup())
			GLOB.destroyed_event.register(front, src, .proc/release_links)
			GLOB.destroyed_event.register(middle, src, .proc/release_links)
			GLOB.destroyed_event.register(back, src, .proc/release_links)
			return TRUE
	return FALSE

/obj/machinery/computer/ship/beam_cannon/proc/is_valid_setup()
	if(front && middle && back)
		var/everything_in_range = (get_dist(src, front) < link_range) && (get_dist(src, middle) < link_range) && (get_dist(src, back) < link_range)
		var/everything_in_order = (middle.Adjacent(front) && middle.Adjacent(back)) && (front.dir == middle.dir && middle.dir == back.dir)
		return everything_in_order && everything_in_range
	return FALSE

/obj/machinery/computer/ship/beam_cannon/proc/release_links()
	GLOB.destroyed_event.unregister(front, src, .proc/release_links)
	GLOB.destroyed_event.unregister(middle, src, .proc/release_links)
	GLOB.destroyed_event.unregister(back, src, .proc/release_links)
	front = null
	middle = null
	back = null

/obj/machinery/computer/ship/beam_cannon/proc/get_calibration()
	var/list/calresult[caldigit]
	for(var/i = 1 to caldigit)
		if(calibration[i] == calexpected[i])
			calresult[i] = 2
		else if(calibration[i] in calexpected)
			calresult[i] = 1
		else
			calresult[i] = 0
	return calresult

/obj/machinery/computer/ship/beam_cannon/proc/reset_calibration()
	calexpected = new /list(caldigit)
	calibration = new /list(caldigit)
	for(var/i = 1 to caldigit)
		calexpected[i] = rand(0,9)
		calibration[i] = 0

/obj/machinery/computer/ship/beam_cannon/proc/cal_accuracy()
	var/top = 0
	var/divisor = caldigit * 2 //maximum possible value, aka 100% accuracy
	for(var/i in get_calibration())
		top += i
	return round(top * 100 / divisor)

/obj/machinery/computer/ship/beam_cannon/proc/get_next_shot_seconds()
	return max(0, (next_shot - world.time) / 10)

/obj/machinery/computer/ship/beam_cannon/proc/cool_failchance()
	return get_next_shot_seconds() * 1000 / coolinterval

/obj/machinery/computer/ship/beam_cannon/proc/get_charge()
	munition = locate() in get_turf(back)
	if(munition)
		return munition
	return 0

/obj/machinery/computer/ship/beam_cannon/proc/get_ammo()
	munition = locate() in get_turf(back)
	if(munition)
		return munition.ammo_count

/obj/machinery/computer/ship/beam_cannon/proc/get_ammo_type()
	munition = locate() in get_turf(back)
	if(munition)
		return munition.ammo_type

/obj/machinery/computer/ship/beam_cannon/proc/remove_ammo()
	munition = locate() in get_turf(back)
	if(get_ammo() >= ammo_per_shot)
		munition.ammo_count -= ammo_per_shot
	return

/obj/machinery/computer/ship/beam_cannon/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = TRUE)
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

/obj/machinery/computer/ship/beam_cannon/OnTopic(mob/user, list/href_list, state)
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
		if(atomcharge_ammo < ammo_per_shot)
			return TOPIC_REFRESH
		if(prob(cool_failchance())) //Some moron disregarded the cooldown warning. Let's blow in their face.
			explosion(middle,1,rand(1,2),rand(2,3))
			next_shot = coolinterval + world.time + fire_delay + beam_time
			return TOPIC_REFRESH
		next_shot = coolinterval + world.time
		log_and_message_admins("attempted to fire the [gun_name].")
		for(var/i = 1 to burst_size)
			if(get_charge() == 0)
				break
			if(atomcharge_ammo == 0 && play_emptymag_sound == 1)
				playsound(get_charge().loc, 'sound/weapons/smg_empty_alarm.ogg', 60, 1)
				break
			fire(user)
			remove_ammo()
		reset_calibration()
	return TOPIC_REFRESH

////////////////////////////////FIRE////////////////////////////////

/obj/machinery/computer/ship/beam_cannon/proc/fire(mob/user)
	if(!link_parts())
		return FALSE //no disperser, no service
	if(!front.powered() || !middle.powered() || !back.powered())
		return FALSE //no power, no boom boom
	var/atomcharge_ammo = get_ammo()
	if(atomcharge_ammo < ammo_per_shot)
		return FALSE

	var/turf/start = front
	var/direction = front.dir

	if(!front || !munition) //Meanwhile front might have exploded
		return

	var/list/relevant_z = GetConnectedZlevels(start.z)
	for(var/mob/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!T || !(T.z in relevant_z))
			continue
		if(!isdeaf(M) && front) //Meanwhile front might have exploded
			sound_to(M, sound(prefire_sound, volume=5))

	for(var/mob/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!T || !(T.z == start.z))
			continue
		if(!isdeaf(M) && front) //Meanwhile front might have exploded
			sound_to(M, sound(prefire_sound, volume=50))

	if(front && munition) //Meanwhile front might have exploded
		playsound(start, prefire_sound, 250, 0)

	sleep(fire_delay)

	if(!front || !munition) //Meanwhile front might have exploded
		return

	if(front) //Meanwhile front might have exploded
		front.layer = ABOVE_OBJ_LAYER //So the beam goes below us. Looks a lot better

	handle_beam(start, direction)
	handle_beam_damage(get_step(front,direction), direction)

	for(var/mob/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!T || !(T.z in relevant_z))
			continue
		shake_camera(M, 50)
		if(!isdeaf(M) && front) //Meanwhile front might have exploded
			sound_to(M, sound(fire_sound, volume=10))

	for(var/mob/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!T || !(T.z == start.z))
			continue
		shake_camera(M, 60)
		if(!isdeaf(M) && front) //Meanwhile front might have exploded
			sound_to(M, sound(fire_sound, volume=50))

	if(front) //Meanwhile front might have exploded
		playsound(start, fire_sound, 250, 0)

	for(var/turf/T in getline(get_step(front,front.dir),get_target_turf(start, direction)))
		for(var/obj/effect/shield/S in T)
			if((S.gen.mitigation_heat > 0 || S.gen.check_flag(MODEFLAG_PHOTONIC)) && !S.disabled_for)
				return TRUE

	handle_overbeam()

	var/turf/overmaptarget = get_step(linked, overmapdir)
	var/list/candidates = list()

	//Next we see if there are any ships around. Logically they are between us and the sector if one exists.
	if(!length(candidates))
		for(var/obj/effect/overmap/visitable/ship/S in overmaptarget)
			if(S == linked)
				continue //Why are you shooting yourself?
			candidates += S

	if(!length(candidates))
		for(var/obj/effect/overmap/O in overmaptarget)
			if(O == linked)
				continue //Why are you shooting yourself?
			candidates += O

	//Way to waste a charge
	if(!length(candidates))
		return TRUE

	var/obj/effect/overmap/target = pick(candidates)

	if(istype(target, /obj/effect/overmap/event))
		if(istype(target, /obj/effect/overmap/event/meteor))
			QDEL_IN(target, rand(beam_time / 2, beam_time))
		return TRUE
	if(istype(target, /obj/effect/overmap/projectile))
		if(!prob(100 - cal_accuracy() / 2))
			target.Destroy()
		return TRUE

	var/obj/effect/overmap/visitable/finaltarget = target
	var/z_level = pick(finaltarget.map_z)

	//Success, but we missed.
	if(prob(100 - cal_accuracy()) && !istype(finaltarget, /obj/effect/overmap/visitable/sector/exoplanet))
		log_and_message_admins("заебись выстрелил с [linked.name] из [gun_name], и снар€д даже нашЄл цель в виде [finaltarget.name], но калибровка дала осечку! (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[linked.x];Y=[linked.y];Z=[linked.z]'>MAP</a>)")
		return TRUE
	if(istype(finaltarget, /obj/effect/overmap/visitable/sector/exoplanet))
		fire_at_sector(z_level, finaltarget.fore_dir, finaltarget.dir, finaltarget, firing_on_planet = TRUE)
		return TRUE
	fire_at_sector(z_level, finaltarget.fore_dir, finaltarget.dir, finaltarget)

	return TRUE

/obj/machinery/computer/ship/beam_cannon/proc/fire_at_sector(var/z_level, var/target_fore_dir, var/target_dir, var/obj/effect/overmap/target, var/firing_on_planet = FALSE)
	var/heading = overmapdir

	if(!heading)
		heading = random_dir()

	var/start_x = Floor(world.maxx / 2) + rand(-pew_spread/2, pew_spread/2)
	var/start_y = Floor(world.maxy / 2) + rand(-pew_spread/2, pew_spread/2)

	if(firing_on_planet)
		start_x = Floor(rand(8,world.maxx-8))
		start_y = Floor(rand(8,world.maxy-8))

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

	log_and_message_admins("Ћуч от [linked.name], выпущенный из [gun_name] - успешно попал в [target.name] на Z [z_level] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[start_x];Y=[start_y];Z=[z_level]'>JMP</a>) (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[linked.x];Y=[linked.y];Z=[linked.z]'>MAP</a>)")

	var/list/relevant_z = GetConnectedZlevels(z_level)
	for(var/mob/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!T || !(T.z in relevant_z))
			continue
		if(!isdeaf(M))
			sound_to(M, sound(fire_sound, volume=5))

//	handle_beam(start, heading)				ебана€ параша на beam() без каких либо причин не хочет проводить лучик через судно врага, ни рантаймов ни ошибок - по этому замен€ю костылЄм
	handle_beam_on_enemy(start, heading)//	хоть и костыль но выгл€дит очень модно :P
	handle_beam_damage(start, heading, TRUE)

	if(istype(target, /obj/effect/overmap/visitable/ship))
		var/must_damage = FALSE
		var/obj/effect/overmap/visitable/ship/target_vessel = target
		for(var/turf/T in getline(start,get_target_turf(start, heading)))
			if(T.density)
				must_damage = TRUE
			for(var/atom/A in T)
				if(A.density && istype(A, /obj/effect/shield))
					must_damage = FALSE
		if(must_damage) target_vessel.damage_hull(structural_damage)

/obj/machinery/computer/ship/beam_cannon/proc/handle_beam(var/turf/s, var/d)
	set waitfor = FALSE
	s.Beam(get_target_turf(s, d), beam_icon, time = beam_time, maxdistance = world.maxx)
	if(front)
		front.layer = initial(front.layer)

/obj/machinery/computer/ship/beam_cannon/proc/handle_beam_damage(var/turf/s, var/d, var/killing_floor = FALSE)
	set waitfor = FALSE
	for(var/turf/T in getline(s,get_target_turf(s, d)))
		var/deflected = FALSE
		for(var/obj/effect/shield/S in T)
			S.take_damage(5000,SHIELD_DAMTYPE_HEAT)
			if((S.gen.mitigation_heat > 0 || S.gen.check_flag(MODEFLAG_PHOTONIC)) && !S.disabled_for)
				S.take_damage(5000,SHIELD_DAMTYPE_HEAT)
				deflected = TRUE
		if(deflected)
			var/def_angle = pick(90,-90,0)
			handle_beam_damage(get_step(T, turn(d, 180)), turn(d,180 + def_angle), TRUE)
			handle_beam_on_enemy(get_step(T, turn(d, 180)), turn(d,180 + def_angle))
			log_and_message_admins("Ћуч [gun_name] смешно отрикошетил от щита.")
			break
		if(T.density && !killing_floor)
			sleep(beam_speed)
			explosion(T,1,1,2,3,adminlog = 0)
			if(T)
				T.Destroy()
		else if(killing_floor && !istype(T, /turf/space))
			sleep(beam_speed)
			explosion(T,1,1,2,3,adminlog = 0)
			if(istype(T, /turf/simulated/wall))
				var/turf/simulated/wall/W = T
				if(W)
					W.dismantle_wall()
			var/list/relevant_z = GetConnectedZlevels(s.z)
			for(var/mob/M in GLOB.player_list)
				var/turf/J = get_turf(M)
				if(!J || !(J.z in relevant_z))
					continue
				shake_camera(M, 4)
			var/turf/right = get_step(T,turn(d,90))
			var/turf/left = get_step(T,turn(d,-90))
			if(!right.density && !istype(right, /turf/space))
				new fire_type(right)
			if(!left.density && !istype(left, /turf/space))
				new fire_type(left)
			if(!T.density && !istype(T, /turf/space))
				new fire_type(T)
		else
			sleep(beam_speed)
		for(var/mob/living/U in T)
			U.gib()
		for(var/atom/A in T)
			if(A.density)
				explosion(A,1,1,2,3,adminlog = 0)

/obj/machinery/computer/ship/beam_cannon/proc/handle_beam_on_enemy(var/turf/s, var/d)
	set waitfor = FALSE
	for(var/turf/T in getline(s,get_target_turf(s, d)))
		var/deflected = FALSE
		for(var/obj/effect/shield/S in T)
			if((S.gen.mitigation_heat > 0 || S.gen.check_flag(MODEFLAG_PHOTONIC)) && !S.disabled_for)
				deflected = TRUE
		if(deflected)
			break
		var/obj/effect/ion_beam = new /obj/effect/projectile(T)
		ion_beam.dir = d
		ion_beam.icon = 'icons/effects/beam.dmi'
		ion_beam.icon_state = beam_icon
		ion_beam.light_outer_range = 2
		ion_beam.light_max_bright = 1
		ion_beam.light_color = beam_light_color
		playsound(T, beam_sound, 250, 1)
		QDEL_IN(ion_beam,beam_time)
		sleep(beam_speed)

/obj/machinery/computer/ship/beam_cannon/proc/handle_overbeam()
	set waitfor = FALSE
	if(linked.z == 11)
		linked.Beam(get_step(linked, overmapdir), beam_icon, time = beam_time, maxdistance = world.maxx)
	else
		linked.loc.Beam(get_step(linked.loc, overmapdir), beam_icon, time = beam_time, maxdistance = world.maxx)

/obj/machinery/computer/ship/beam_cannon/proc/get_target_turf(var/turf/s, var/d)
	switch(d)
		if(NORTH)
			return locate(s.x,world.maxy,s.z)
		if(SOUTH)
			return locate(s.x,1,s.z)
		if(WEST)
			return locate(1,s.y,s.z)
		if(EAST)
			return locate(world.maxx,s.y,s.z)