/obj/machinery/computer/ship/ship_weapon/deck_gun/fire(mob/user)
	if(!link_parts())
		return FALSE //no disperser, no service
	if(!front.powered() || !middle.powered() || !back.powered())
		return FALSE //no power, no boom boom
	if(get_ammo() < ammo_per_shot || !get_ammo_type())
		return FALSE

	var/turf/start = front
	var/direction = front.dir

	if(prefire_sound)
		playsound(start, prefire_sound, 250, 0)

	var/list/relevant_z = GetConnectedZlevels(start.z)
	if(far_prefire_sound)
		for(var/mob/M in GLOB.player_list)
			var/turf/T = get_turf(M)
			if(!T || !(T.z in relevant_z))
				continue
			if(!isdeaf(M))
				sound_to(M, sound(far_prefire_sound, volume=30))

	sleep(fire_delay)

	if(!front || !get_charge()) //Meanwhile front might have exploded
		return FALSE

	for(var/mob/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!T || !(T.z in relevant_z))
			continue
		shake_camera(M, shake_camera_force)
		if(!isdeaf(M))
			sound_to(M, sound(far_fire_sound, volume=30))

	playsound(start, fire_sound, 250, 1)
	handle_muzzle(start, direction)

	var/ammo_type = get_ammo_type()
	var/obj/item/projectile/bullet/huge_caliber/pew = new ammo_type(get_step(get_step(get_step(front.loc, overmapdir), overmapdir), overmapdir))
	pew.starting = get_step(get_step(get_step(front.loc, overmapdir), overmapdir), overmapdir)
	pew.cal_accuracy = cal_accuracy()
	pew.launch(get_step(pew.starting, overmapdir), pick(BP_ALL_LIMBS))

	return TRUE

/obj/machinery/computer/ship/ship_weapon/deck_gun/handle_muzzle()
	flick(muzzle_flash,front)