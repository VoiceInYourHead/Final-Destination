/obj/machinery/computer/ship/autocannon/proc/fire(mob/user)
	if(!link_parts())
		return FALSE //no disperser, no service
	if(!front.powered() || !middle.powered() || !back.powered())
		return FALSE //no power, no boom boom

	var/turf/start = front
	var/direction = front.dir

	var/distance = 0
	for(var/turf/T in getline(get_step(front,front.dir),get_target_turf(start, direction)))
		distance++
		if(T.density)
			if(distance < danger_zone)
				explosion(T,1,2,2)
				continue
			else
				T.ex_act(1)
		for(var/atom/A in T)
			if(A.density)
				if(distance < danger_zone)
					explosion(A,1,2,2)
					break
				else
					A.ex_act(1)

	var/list/relevant_z = GetConnectedZlevels(start.z)
	for(var/mob/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!T || !(T.z in relevant_z))
			continue
		shake_camera(M, 4)
		if(!isdeaf(M))
			sound_to(M, sound('sound/effects/explosionfar.ogg', volume=10))

	if(front) //Meanwhile front might have exploded
		front.layer = ABOVE_OBJ_LAYER //So the beam goes below us. Looks a lot better
	playsound(start, fire_sound, 250, 1)
	handle_muzzle(start, direction)
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

/obj/machinery/computer/ship/autocannon/proc/fire_at_sector(var/z_level, var/target_fore_dir, var/target_dir)
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

/obj/machinery/computer/ship/autocannon/proc/handle_muzzle(turf/start, direction)
	set waitfor = FALSE
	var/obj/effect/projectile/P = new muzzle_flash(get_step(get_turf(start), direction))
	P.dir = direction
	P.color = muzzle_color
	QDEL_IN(P,2)

/obj/machinery/computer/ship/autocannon/proc/handle_overbeam()
	set waitfor = FALSE
	linked.Beam(get_step(linked, overmapdir), overmap_icon, time = 2, maxdistance = world.maxx)

/obj/machinery/computer/ship/autocannon/proc/get_target_turf(turf/start, direction)
	switch(direction)
		if(NORTH)
			return locate(start.x,world.maxy,start.z)
		if(SOUTH)
			return locate(start.x,1,start.z)
		if(WEST)
			return locate(1,start.y,start.z)
		if(EAST)
			return locate(world.maxx,start.y,start.z)