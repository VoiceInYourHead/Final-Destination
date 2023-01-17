/obj/machinery/computer/ship/autocannon
	name = "autocannon control"
	icon = 'icons/obj/computer.dmi'
	icon_state = "computer"

	core_skill = SKILL_PILOT
	var/skill_offset = SKILL_ADEPT - 1 //After which skill level it starts to matter. -1, because we have to index from zero

	icon_keyboard = "rd_key"
	icon_screen = "teleport"

	var/const/link_range = 10 //How far can the above stuff be maximum before we start complaining

	var/overmapdir = 0

	var/caldigit = 4 //number of digits that needs calibration
	var/list/calibration //what it is
	var/list/calexpected //what is should be

	var/next_shot = 0 //round time where the next shot can start from
	var/const/coolinterval = 10 SECONDS //time to wait between safe shots in deciseconds

	var/obj/machinery/disperser/autocannon/front/front
	var/obj/machinery/disperser/autocannon/middle/middle
	var/obj/machinery/disperser/autocannon/back/back
	var/obj/structure/ship_munition/autocannon_ammobox/ammobox

	var/ammo_per_shot = 1
	var/danger_zone = 3
	var/burst_size = 5
	var/burst_interval = 6

	var/gun_name = "autocannon"

	// Ќасколько большой будет разброс в тайлах при попадании на овермап судна-цели.
	// ѕример: при pew_spread = 20 снар€д будет спавнитьс€ с разбросом от -10 до 10 тайлов на нужном краю карты.
	var/pew_spread = 20

	var/fire_sound = 'sound/machines/autocannon_fire.ogg'
	var/pew_color = null

	var/muzzle_flash = /obj/effect/projectile/bullet/muzzle/autocannon
	var/muzzle_color = null

	var/overmap_icon = "bullet" // icons\effects\beam.dmi
	var/overmap_color = null

/obj/machinery/computer/ship/autocannon/Initialize()
	. = ..()
	link_parts()
	reset_calibration()

/obj/machinery/computer/ship/autocannon/Destroy()
	release_links()
	. = ..()

/obj/machinery/computer/ship/autocannon/proc/link_parts()
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

/obj/machinery/computer/ship/autocannon/proc/is_valid_setup()
	if(front && middle && back)
		var/everything_in_range = (get_dist(src, front) < link_range) && (get_dist(src, middle) < link_range) && (get_dist(src, back) < link_range)
		var/everything_in_order = (middle.Adjacent(front) && middle.Adjacent(back)) && (front.dir == middle.dir && middle.dir == back.dir)
		return everything_in_order && everything_in_range
	return FALSE

/obj/machinery/computer/ship/autocannon/proc/release_links()
	GLOB.destroyed_event.unregister(front, src, .proc/release_links)
	GLOB.destroyed_event.unregister(middle, src, .proc/release_links)
	GLOB.destroyed_event.unregister(back, src, .proc/release_links)
	front = null
	middle = null
	back = null

/obj/machinery/computer/ship/autocannon/proc/get_calibration()
	var/list/calresult[caldigit]
	for(var/i = 1 to caldigit)
		if(calibration[i] == calexpected[i])
			calresult[i] = 2
		else if(calibration[i] in calexpected)
			calresult[i] = 1
		else
			calresult[i] = 0
	return calresult

/obj/machinery/computer/ship/autocannon/proc/reset_calibration()
	calexpected = new /list(caldigit)
	calibration = new /list(caldigit)
	for(var/i = 1 to caldigit)
		calexpected[i] = rand(0,9)
		calibration[i] = 0

/obj/machinery/computer/ship/autocannon/proc/cal_accuracy()
	var/top = 0
	var/divisor = caldigit * 2 //maximum possible value, aka 100% accuracy
	for(var/i in get_calibration())
		top += i
	return round(top * 100 / divisor)

/obj/machinery/computer/ship/autocannon/proc/get_next_shot_seconds()
	return max(0, (next_shot - world.time) / 10)

/obj/machinery/computer/ship/autocannon/proc/cool_failchance()
	return get_next_shot_seconds() * 1000 / coolinterval

/obj/machinery/computer/ship/autocannon/proc/get_charge()
	ammobox = locate() in get_turf(back)
	if(ammobox)
		return ammobox
	return 0

/obj/machinery/computer/ship/autocannon/proc/get_ammo()
	ammobox = locate() in get_turf(back)
	if(ammobox)
		return ammobox.ammo

/obj/machinery/computer/ship/autocannon/proc/get_ammo_type()
	ammobox = locate() in get_turf(back)
	if(ammobox)
		return ammobox.ammo_type

/obj/machinery/computer/ship/autocannon/proc/remove_ammo()
	ammobox = locate() in get_turf(back)
	if(ammobox.ammo > 0)
		ammobox.ammo -= ammo_per_shot
	return

/obj/machinery/computer/ship/autocannon/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = TRUE)
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

		var/ammo_count = SPAN_BOLD("UNKNOWN ERROR")
		switch(get_charge())
			if(0)
				ammo_count = "[SPAN_BOLD("ERROR")]: No valid ammo detected."
			else
				ammo_count = get_ammo()
		data["chargeload"] = ammo_count

		var/charge = SPAN_BOLD("UNKNOWN ERROR")
		switch(get_charge())
			if(0)
				charge = "No valid ammo detected"
			else
				charge = get_charge().name
		data["chargename"] = charge

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "autocannon.tmpl", "[linked.name] autocannon control", 400, 550)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/computer/ship/autocannon/OnTopic(mob/user, list/href_list, state)
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
		next_shot = coolinterval + world.time
		log_and_message_admins("attempted to fire the [gun_name].")
		for(var/i = 1 to burst_size)
			if(atomcharge_ammo <= 0)
				playsound(get_charge(), 'sound/weapons/smg_empty_alarm.ogg', 60, 1)
				return TOPIC_REFRESH
			fire(user)
			remove_ammo()
			sleep(burst_interval)
		reset_calibration()
	return TOPIC_REFRESH