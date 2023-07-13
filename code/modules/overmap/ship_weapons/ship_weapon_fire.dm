/obj/machinery/computer/ship/ship_weapon/proc/fire(mob/user)
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
				sound_to(M, sound(far_prefire_sound, volume=10))

	sleep(fire_delay)

	if(!front || !get_charge()) //Meanwhile front might have exploded
		return FALSE

	for(var/mob/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!T || !(T.z in relevant_z))
			continue
		shake_camera(M, shake_camera_force)
		if(!isdeaf(M))
			sound_to(M, sound(far_fire_sound, volume=10))

	playsound(start, fire_sound, 250, 1)
	handle_muzzle(start, direction)

	if(get_ammo_type())
		var/ammo_type = get_ammo_type()
		var/obj/item/projectile/pew = new ammo_type(front.loc)
		pew.starting = front.loc
		pew.color = pew_color
		pew.launch(get_step(front.loc, front.dir), pick(BP_ALL_LIMBS))

	if(front) //Meanwhile front might have exploded
		front.layer = ABOVE_OBJ_LAYER //So the beam goes below us. Looks a lot better

	for(var/turf/T in getline(get_step(front,front.dir),get_target_turf(start, direction)))
		if(T.density && !istype(T, /turf/unsimulated/planet_edge) && !ignore_blockage)
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

		for(var/obj/effect/overmap/trading/T in overmaptarget)
			candidates += T

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

/obj/machinery/computer/ship/ship_weapon/proc/fire_at_sector(var/z_level, var/target_fore_dir, var/obj/effect/overmap/target)
	var/heading = overmapdir

	if(!heading)
		heading = random_dir()

	var/actual_spread = pew_spread / 2

	var/obj/effect/overmap/visitable/ship/target_ship = target
	if(istype(target_ship, /obj/effect/overmap/visitable/ship))
		actual_spread = (target_ship.get_helm_skill()+1) / 2 * (pew_spread/2)

		if(target_ship.is_still() || target_ship.get_speed() <= SHIP_SPEED_SLOW)
			actual_spread = pew_spread / 2

	var/start_x = Floor(world.maxx / 2) + round( rand(-actual_spread, actual_spread) )
	var/start_y = Floor(world.maxy / 2) + round( rand(-actual_spread, actual_spread) )

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

	if(target.dir in GLOB.cornerdirs)
		if(target.dir == NORTHEAST)
			target.dir = pick(NORTH, EAST)
		if(target.dir == NORTHWEST)
			target.dir = pick(NORTH, WEST)
		if(target.dir == SOUTHEAST)
			target.dir = pick(SOUTH, EAST)
		if(target.dir == SOUTHWEST)
			target.dir = pick(SOUTH, WEST)

	if(heading == target.dir)
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

	else if(heading == GLOB.reverse_dir[target.dir])
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

	else if(heading == GLOB.cw_dir[target.dir])
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

	else if(heading == GLOB.ccw_dir[target.dir])
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

	log_and_message_admins("Выстрел от [linked.name] из [gun_name] попал в [target.name] на Z [z_level] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[start_x];Y=[start_y];Z=[z_level]'>JMP</a>) (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[linked.x];Y=[linked.y];Z=[linked.z]'>MAP</a>)", location=get_turf(front))

	var/ammo_type = get_ammo_type()
	var/obj/item/projectile/pew = new ammo_type(start)
	pew.original = get_step(start,heading)
	pew.current = get_step(start,heading)
	pew.starting = start
	pew.color = pew_color
	pew.launch(get_step(start,heading), pick(BP_ALL_LIMBS), start_x, start_y)

	if(istype(target, /obj/effect/overmap/visitable/ship))
		var/must_damage = FALSE
		var/met_shield = FALSE
		var/obj/effect/overmap/visitable/ship/target_vessel = target
		for(var/turf/T in getline(start,get_target_turf(start, heading)))
			if(T.density)
				must_damage = TRUE
				break
			for(var/atom/A in T)
				if(A.density && istype(A, /obj/effect/shield))
					var/obj/effect/shield/S = A
					if(S.gen.check_flag(shield_modflag_counter))
						must_damage = FALSE
						met_shield = TRUE
			if(met_shield)
				break
		if(must_damage) target_vessel.damage_hull(hull_damage)

/obj/machinery/computer/ship/ship_weapon/proc/fire_at_exoplanet(var/z_level, var/obj/effect/overmap/target)
	var/turf/start = locate(rand(8,world.maxx-8),rand(8,world.maxy-8), z_level)

	for(var/mob/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!T || !(T.z == z_level))
			continue
		if(!isdeaf(M))
			sound_to(M, sound(far_fire_sound, volume=10))
			if(prob(33))
				if(prob(33))
					to_chat(M, SPAN_DANGER("The sky overhead roars as bullets slice through exoplanet's atmosphere from orbit! This isn't good..."))
				else
					to_chat(M, SPAN_DANGER("The sky overhead roars as bullets slice through exoplanet's atmosphere from orbit!"))

	log_and_message_admins("Выстрел от [linked.name] из [gun_name] попал в {[start.x] ; [start.y]} на [target] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[start.x];Y=[start.y];Z=[z_level]'>JMP</a>) (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[linked.x];Y=[linked.y];Z=[linked.z]'>MAP</a>)", location=get_turf(front))

	var/ammo_type = get_ammo_type()
	var/obj/item/projectile/pew = new ammo_type(start)
	pew.original = start
	pew.current = start
	pew.starting = start
	pew.color = pew_color
	pew.launch(get_step(start,random_dir()), pick(BP_ALL_LIMBS), start.x, start.y)
	pew.Bump(start)

/obj/machinery/computer/ship/ship_weapon/proc/handle_muzzle(turf/start, direction = 1)
	set waitfor = FALSE
	if(!muzzle_flash || !start)
		return
	var/obj/effect/projectile/P = new muzzle_flash(get_step(get_turf(start), direction))
	P.dir = direction
	P.color = muzzle_color
	QDEL_IN(P,2)

/obj/machinery/computer/ship/ship_weapon/proc/handle_overbeam(var/missed = FALSE)
	set waitfor = FALSE
	var/turf/target_turf
	var/beam_dir = overmapdir

	if(missed)
		beam_dir = turn(overmapdir,pick(45,-45))

	if(linked.z == 11)
		target_turf = get_turf(linked)
		for(var/i = 1 to shoot_range)
			target_turf = get_step(target_turf, beam_dir)
		linked.Beam(target_turf, overmap_icon, time = 2, maxdistance = world.maxx)
	else
		target_turf = get_turf(linked.loc)
		for(var/i = 1 to shoot_range)
			target_turf = get_step(target_turf, beam_dir)
		linked.loc.Beam(target_turf, overmap_icon, time = 2, maxdistance = world.maxx)

/obj/machinery/computer/ship/ship_weapon/proc/get_target_turf(turf/start, direction)
	switch(direction)
		if(NORTH)
			return locate(start.x,world.maxy,start.z)
		if(SOUTH)
			return locate(start.x,1,start.z)
		if(WEST)
			return locate(1,start.y,start.z)
		if(EAST)
			return locate(world.maxx,start.y,start.z)