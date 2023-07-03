/obj/machinery/computer/ship/ship_weapon/deck_gun/fire(mob/user)
	if(!link_parts())
		return FALSE //no disperser, no service
	if(!front.powered() || !middle.powered() || !back.powered())
		return FALSE //no power, no boom boom
	var/atomcharge_ammo = get_ammo()
	if(atomcharge_ammo < ammo_per_shot)
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

	if(get_ammo_type())
		var/ammo_type = get_ammo_type()
		var/obj/item/projectile/pew = new ammo_type(get_step(get_step(get_step(front.loc, overmapdir), overmapdir), overmapdir))
		pew.starting = get_step(get_step(get_step(front.loc, overmapdir), overmapdir), overmapdir)
		pew.color = pew_color
		pew.launch(get_step(pew.starting, overmapdir), pick(BP_ALL_LIMBS))

	for(var/turf/T in getline(get_step(front,front.dir),get_target_turf(start, direction)))
		if(T.density && !istype(T, /turf/unsimulated/planet_edge))
			return TRUE
		for(var/atom/A in T)
			if(((A.density && A.layer != TABLE_LAYER) && !istype(A, /obj/item/projectile) && (!istype(A, /obj/effect) || istype(A, /obj/effect/shield))))
				if(istype(A, /obj/effect/shield))
					var/obj/effect/shield/S = A
					if(S.gen.check_flag(shield_modflag_counter))
						return TRUE
				if(!ignore_blockage)
					return TRUE

	if(istype(front.loc.loc, /area/exoplanet) && !ground_to_space)
		return TRUE //Ты чё ебанутый, как твои пули без мини-двигателя собрались атмосферу покидать??

	var/turf/target_turf
	if(linked.z == 11)
		target_turf = get_turf(linked)
		for(var/i = 1 to shoot_range)
			target_turf = get_step(target_turf, overmapdir)

	else
		target_turf = get_turf(linked.loc)
		for(var/i = 1 to shoot_range)
			target_turf = get_step(target_turf, overmapdir)

	var/turf/overmaptarget = target_turf
	var/list/candidates = list()

	//Next we see if there are any targets around. Logically they are between us and the sector if one exists.

	if(!length(candidates) && canhit_ships)
		for(var/obj/effect/overmap/visitable/ship/S in overmaptarget)
			if(S == linked || S.destroyed)
				continue //Why are you shooting yourself?
			candidates += S

	if(!length(candidates) && canhit_missiles)
		for(var/obj/effect/overmap/projectile/M in overmaptarget)
			candidates += M

	if(!length(candidates) && canhit_sectors)
		for(var/obj/effect/overmap/visitable/sector/O in overmaptarget)
			if(O == linked || istype(O,/obj/effect/overmap/visitable/sector/exoplanet))
				continue //Why are you shooting yourself?
			candidates += O

	if(!length(candidates) && destroy_event_flags)
		for(var/obj/effect/overmap/event/E in overmaptarget)
			candidates += E

	if(!length(candidates) && canhit_planets)
		for(var/obj/effect/overmap/visitable/sector/exoplanet/P in overmaptarget)
			candidates += P

	//Way to waste a charge
	if(!length(candidates))
		handle_overbeam()
		return TRUE


	var/obj/effect/overmap/target = pick(candidates)

	if(istype(target, /obj/effect/overmap/event))
		var/obj/effect/overmap/event/E = target
		if(destroy_event_flags & E.weaknesses)
			var/turf/T = E.loc
			qdel(E)
			overmap_event_handler.update_hazards(T)
		handle_overbeam()
		return TRUE

	if(istype(target, /obj/effect/overmap/projectile))
		if(prob(100 - cal_accuracy() / 2)) // максимум 50% шанс попасть по торпеде
			target.Destroy()
		handle_overbeam()
		return TRUE

	var/obj/effect/overmap/visitable/finaltarget = target
	var/z_level = pick(finaltarget.map_z)

	//Success, but we missed.
	if(prob(100 - cal_accuracy()) && !istype(finaltarget, /obj/effect/overmap/visitable/sector/exoplanet))
		log_and_message_admins("Выстрел от [linked.name] из [gun_name] ебанул [finaltarget.name], но калибровка была говном (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[linked.x];Y=[linked.y];Z=[linked.z]'>MAP</a>)", location=get_turf(front))
		handle_overbeam(TRUE)
		return TRUE

	if(istype(finaltarget,/obj/effect/overmap/visitable/sector/exoplanet))
		fire_at_exoplanet(z_level, finaltarget)
	else
		fire_at_sector(z_level, finaltarget.fore_dir, finaltarget)

	handle_overbeam()

	return TRUE

/obj/machinery/computer/ship/ship_weapon/deck_gun/handle_muzzle()
	front.icon_state = muzzle_flash
	sleep(1)
	front.icon_state = initial(front.icon_state)