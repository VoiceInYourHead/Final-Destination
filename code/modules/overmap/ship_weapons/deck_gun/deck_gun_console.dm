/obj/machinery/computer/ship/ship_weapon/deck_gun
	name = "Deck gun control"
	caldigit = 4		//number of digits that needs calibration
	coolinterval = 30 SECONDS
	gun_name = "Deck Gun"

	front_type = /obj/machinery/ship_weapon/front_part/deck_gun
	middle_type = /obj/machinery/ship_weapon/middle_part/deck_gun
	back_type = /obj/machinery/ship_weapon/back_part/deck_gun
	munition_type = /obj/item/ammo_magazine/ammobox/deck_gun

	burst_size = 1		//������� ��� ���

	shake_camera_force = 16

	muzzle_flash = "deck_turret_firing" //now we use this var as icon name for shooting anim

	var/starting_dir = 1

	var/safety_active = TRUE // should we refrain from turning if there is something in the way
	var/rotating = FALSE // are we rotating now?

	var/old_overmapdir
	var/rotation_speed = 5
	var/tower_angle = 0

/obj/machinery/computer/ship/ship_weapon/deck_gun/link_parts()
	if(is_valid_setup())
		return TRUE

	for(front in SSmachines.machinery)
		if(get_dist(src, front) >= link_range || front.z <= src.z || !istype(front,front_type))
			continue
		var/downwards = front.z - 1
		middle = locate() in locate(front.x, front.y, downwards)
		if(!middle || get_dist(src, middle) >= link_range || middle.z != src.z || !istype(middle,middle_type))
			continue
		var/backwards = turn(middle.dir, 180)
		back = locate() in get_step(middle, backwards)
		if(!back || get_dist(src, back) >= link_range || back.z != src.z || !istype(back,back_type))
			continue
		if(is_valid_setup())
			GLOB.destroyed_event.register(front, src, .proc/release_links)
			GLOB.destroyed_event.register(middle, src, .proc/release_links)
			GLOB.destroyed_event.register(back, src, .proc/release_links)
			rotate(starting_dir, TRUE)
			overmapdir = front.dir
			return TRUE
	return FALSE

/obj/machinery/computer/ship/ship_weapon/deck_gun/is_valid_setup()
	if(front && middle && back)
		var/everything_in_range = get_dist(src, front) < link_range && get_dist(src, middle) < link_range && get_dist(src, back) < link_range
		var/everything_in_order = middle.Adjacent(back) && middle.dir == back.dir
		var/everything_has_valid_path = istype(front,front_type) && istype(middle,middle_type) && istype(back,back_type)
		return everything_in_order && everything_in_range && everything_has_valid_path
	return FALSE

/obj/machinery/computer/ship/ship_weapon/deck_gun/get_charge()
	munition = locate() in get_turf(back)
	if(munition && istype(munition,munition_type))
		return munition
	return 0
/*
/obj/machinery/computer/ship/ship_weapon/deck_gun/get_ammo()

/obj/machinery/computer/ship/ship_weapon/deck_gun/get_ammo_type()

/obj/machinery/computer/ship/ship_weapon/deck_gun/remove_ammo()
*/
/obj/machinery/computer/ship/ship_weapon/deck_gun/OnTopic(mob/user, list/href_list, state)
	if(!linked)
		return TOPIC_HANDLED

	if (href_list["choose"])
		if(!front || !front.powered() || rotating)
			return TOPIC_REFRESH
		overmapdir = sanitize_integer(text2num(href_list["choose"]), 0, 10, 0)
		if(safety_active && overmapdir != 0)
			var/turf/getline_end = get_step(front,overmapdir)
			for(var/i = 0 to 15)
				getline_end = get_step(getline_end,overmapdir)
				i++
			for(var/turf/T in getline(get_step(front,overmapdir),getline_end))
				if(T.density && !istype(T, /turf/unsimulated/planet_edge))
					overmapdir = old_overmapdir
					return TOPIC_REFRESH
				for(var/atom/A in T)
					if(((A.density && A.layer != TABLE_LAYER) && !istype(A, /obj/item/projectile) && (!istype(A, /obj/effect) || istype(A, /obj/effect/shield))))
						overmapdir = old_overmapdir
						return TOPIC_REFRESH

		rotate(overmapdir)
		reset_calibration()
		return TOPIC_HANDLED

	if(href_list["calibration"])
		var/input = input("0-9", "[gun_name] calibration", 0) as num|null
		if(!isnull(input)) //can be zero so we explicitly check for null
			var/calnum = sanitize_integer(text2num(href_list["calibration"]), 0, caldigit)//sanitiiiiize
			calibration[calnum + 1] = sanitize_integer(input, 0, 9, 0)//must add 1 because nanoui indexes from 0

	if(href_list["skill_calibration"])
		for(var/i = 1 to min(caldigit, user.get_skill_value(core_skill) - skill_offset))
			calibration[i] = calexpected[i]

	if(href_list["fire"])
		if(!front || !front.powered() || rotating)
			return TOPIC_REFRESH
		var/atomcharge_ammo = get_ammo()
		if(atomcharge_ammo < ammo_per_shot)
			return TOPIC_REFRESH
		if(prob(cool_failchance())) //Some moron disregarded the cooldown warning. Let's blow in their face.
			log_and_message_admins("[gun_name] ������ �����������", location=get_turf(middle))
			cell_explosion(middle, rand(300, 500), 100)

			next_shot = coolinterval + world.time
			return TOPIC_REFRESH
		next_shot = coolinterval + world.time + fire_interval * burst_size
		log_and_message_admins("attempted to fire the [gun_name].")
		for(var/i = 1 to burst_size)
			if(atomcharge_ammo == 0 && play_emptymag_sound)
				playsound(get_charge(), 'sound/weapons/smg_empty_alarm.ogg', 100, 0)
			if(!get_charge())
				break
			fire(user)
			remove_ammo()
			sleep(fire_interval)
		reset_calibration()
	return TOPIC_REFRESH

/obj/machinery/computer/ship/ship_weapon/deck_gun/rotate(overmapdir)
	if(overmapdir == old_overmapdir || overmapdir == 0)
		return FALSE

	old_overmapdir = overmapdir
	var/old_tower_angle = tower_angle
	if(old_tower_angle == 360)
		old_tower_angle = 0

	//clock
	if(overmapdir == front.dir)
		tower_angle = 360
	else if(overmapdir == turn(front.dir,-45*1))
		tower_angle = 45*1
	else if(overmapdir == turn(front.dir,-45*2))
		tower_angle = 45*2
	else if(overmapdir == turn(front.dir,-45*3))
		tower_angle = 45*3
	else if(overmapdir == turn(front.dir,-45*4))
		tower_angle = 45*4
	else if(overmapdir == turn(front.dir,-45*5))
		tower_angle = 45*5
	else if(overmapdir == turn(front.dir,-45*6))
		tower_angle = 45*6
	else if(overmapdir == turn(front.dir,-45*7))
		tower_angle = 45*7
	else
		return FALSE

	playsound(get_turf(front), 'sound/mecha/hydraulic.ogg', 100, 1)
	playsound(get_turf(middle), 'sound/mecha/hydraulic.ogg', 100, 1)

	var/rotation_time = (tower_angle - old_tower_angle)
	if(tower_angle == 360)
		rotation_time -= 360
	if(rotation_time < 0)
		rotation_time *= -1
	if(rotation_time >= 180)
		rotation_time -= 90 * (rotation_time / 90 - 1)
	rotation_time /= rotation_speed

	var/matrix/rotate
	rotating = TRUE

	// We split rotation part cause turn() with angle more than 180 causes unfunny sprite flip
	// NWM its shit
//	rotate = matrix(transform).Update(rotation = tower_angle / 2)
//	animate(front, transform = rotate, time = rotation_time)

	rotate = matrix(transform).Update(rotation = tower_angle)
	animate(front, transform = rotate, time = rotation_time, easing = SINE_EASING)
	sleep(rotation_time)

	rotating = FALSE
	return TRUE
