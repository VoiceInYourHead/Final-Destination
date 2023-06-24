/obj/machinery/computer/ship/ship_weapon/beam_cannon/fire_at_sector(var/z_level, var/target_fore_dir, var/obj/effect/overmap/target, var/firing_at_exoplanet = FALSE)
	var/heading = overmapdir

	if(!heading)
		heading = random_dir()

	var/start_x = Floor(world.maxx / 2) + rand(-pew_spread/2, pew_spread/2)
	var/start_y = Floor(world.maxy / 2) + rand(-pew_spread/2, pew_spread/2)

	if(firing_at_exoplanet)
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

	log_and_message_admins("Луч от [linked.name], выпущенный из [gun_name] - успешно попал в [target.name] на Z [z_level] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[start_x];Y=[start_y];Z=[z_level]'>JMP</a>) (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[linked.x];Y=[linked.y];Z=[linked.z]'>MAP</a>)")

	var/list/relevant_z = GetConnectedZlevels(z_level)
	for(var/mob/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!T || !(T.z in relevant_z))
			continue
		if(!isdeaf(M))
			sound_to(M, sound(fire_sound, volume=5))

//	handle_beam(start, heading)				ебаная параша на beam() без каких либо причин не хочет проводить лучик через судно врага, ни рантаймов ни ошибок - по этому меняем на костыль
	handle_beam_on_enemy(start, heading)//	хоть и костыль но выглядит очень модно :P
	handle_beam_damage(start, heading, TRUE)

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

/obj/machinery/computer/ship/ship_weapon/beam_cannon/fire_at_exoplanet(var/z_level, var/obj/effect/overmap/target)
	fire_at_sector(z_level, random_dir(), target, TRUE)

/obj/machinery/computer/ship/ship_weapon/beam_cannon/proc/handle_beam(var/turf/s, var/d)
	set waitfor = FALSE
	s.Beam(get_target_turf(s, d), beam_icon, time = beam_time, maxdistance = world.maxx)
	if(front)
		front.layer = initial(front.layer)

/obj/machinery/computer/ship/ship_weapon/beam_cannon/proc/handle_beam_damage(var/turf/s, var/d, var/killing_floor = FALSE)
	set waitfor = FALSE
	for(var/turf/T in getline(s,get_target_turf(s, d)))
		if(istype(T,/turf/unsimulated/planet_edge))
			return
		var/deflected = FALSE
		for(var/obj/effect/shield/S in T)
			if(S.gen.check_flag(shield_modflag_counter) && S.density)
				S.take_damage(5000,SHIELD_DAMTYPE_HEAT)
				deflected = TRUE
		if(deflected)
			var/def_angle = pick(90,-90,0)
			handle_beam_damage(get_step(T, turn(d, 180)), turn(d,180 + def_angle), TRUE)
			handle_beam_on_enemy(get_step(T, turn(d, 180)), turn(d,180 + def_angle))
			log_and_message_admins("Луч [gun_name] смешно отрикошетил от щита.")
			break
		if(T.density && !killing_floor)
			sleep(beam_speed)
			if(T && T.density)
				explosion(T, 6, EX_ACT_DEVASTATING, adminlog = 0, turf_breaker = TRUE, effective = FALSE)
				if(T)
					T.ex_act(1,TRUE)
		else if(killing_floor && !istype(T, /turf/space))
			sleep(beam_speed)
			explosion(T, 6, EX_ACT_DEVASTATING, adminlog = 0, turf_breaker = TRUE, effective = FALSE)
			if(T)
				T.ex_act(1,TRUE)
			var/list/relevant_z = GetConnectedZlevels(s.z)
			for(var/mob/M in GLOB.player_list)
				var/turf/J = get_turf(M)
				if(!J || !(J.z in relevant_z))
					continue
				shake_camera(M, shake_camera_force/10, 0.5)
			var/turf/right = get_step(T,turn(d,90))
			var/turf/left = get_step(T,turn(d,-90))
			if(!right.density && !istype(right, /turf/space))
				new /obj/effect/turf_fire/star_fire/strong(right)
			if(!left.density && !istype(left, /turf/space))
				new /obj/effect/turf_fire/star_fire/strong(left)
			if(!T.density && !istype(T, /turf/space))
				new /obj/effect/turf_fire/star_fire/strong(T)
		else
			sleep(beam_speed)
		for(var/mob/living/U in T)
			U.gib()
		for(var/atom/A in T)
			if(A.density && !istype(A,/obj/effect/shield))
				explosion(T, 6, EX_ACT_DEVASTATING, adminlog = 0, turf_breaker = TRUE, effective = FALSE)
				if(A && A.density)
					A.ex_act(1,TRUE)

/obj/machinery/computer/ship/ship_weapon/beam_cannon/proc/handle_beam_on_enemy(var/turf/s, var/d)
	set waitfor = FALSE
	for(var/turf/T in getline(s,get_target_turf(s, d)))
		if(istype(T,/turf/unsimulated/planet_edge))
			return
		var/deflected = FALSE
		for(var/obj/effect/shield/S in T)
			if((S.gen.mitigation_heat > 0 || S.gen.check_flag(MODEFLAG_PHOTONIC)) && S.density)
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
		ion_beam.anchored = TRUE //иначе лазеры смешно улетают от взрывов
		ion_beam.does_spin = FALSE // ^^^
		playsound(T, beam_sound, 250, 1)
		QDEL_IN(ion_beam,beam_time)
		sleep(beam_speed)

/obj/machinery/computer/ship/ship_weapon/beam_cannon/handle_overbeam(var/missed = FALSE)
	set waitfor = FALSE
	var/turf/target_turf
	var/beam_dir = overmapdir

	if(missed)
		beam_dir = turn(overmapdir,pick(45,-45))

	if(linked.z == 11)
		target_turf = get_turf(linked)
		for(var/i = 1 to shoot_range)
			target_turf = get_step(target_turf, beam_dir)
		linked.Beam(target_turf, overmap_icon, time = beam_time, maxdistance = world.maxx)
	else
		target_turf = get_turf(linked.loc)
		for(var/i = 1 to shoot_range)
			target_turf = get_step(target_turf, beam_dir)
		linked.loc.Beam(target_turf, overmap_icon, time = beam_time, maxdistance = world.maxx)

/obj/machinery/computer/ship/ship_weapon/beam_cannon/handle_muzzle()
	set waitfor = FALSE
	var/turf/start = front
	var/direction = front.dir

	handle_beam(start, direction)
	handle_beam_damage(get_step(front,direction), direction)