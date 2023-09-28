#define QUICK_TO_STANDING      5  //How much time after standing still after running we will use STANDING_FALL_PROB instead of RUNNING_FALL_PROB
#define DELIBERATE_TO_STANDING 3  //How much time after standing still after walking we will use STANDING_FALL_PROB instead of WALKING_FALL_PROB
#define RUNNING_FALL_PROB      75
#define WALKING_FALL_PROB      50
#define STANDING_FALL_PROB     20


/obj/machinery/computer/ship/disperser/proc/fire(mob/user)
	log_and_message_admins("attempted to launch a disperser beam.")
	if(!link_parts())
		return FALSE //no disperser, no service
	if(!front.powered() || !middle.powered() || !back.powered())
		return FALSE //no power, no boom boom
	var/chargetype = get_charge_type()
	if(chargetype <= 0)
		return FALSE //no dear, you cannot fire the captain out of a cannon... unless  you put him in a box of course

	var/atom/movable/atomcharge = get_charge()

	var/turf/start = front
	var/direction = front.dir

	var/distance = 0
	for(var/turf/T in getline(get_step(front,front.dir),get_target_turf(start, direction)))
		distance++
		if(T.density)
			if(distance < 7)
				cell_explosion(T, 200, 50)
				continue
			else
				T.ex_act(1)
		for(var/atom/A in T)
			if(A.density)
				if(distance < 7)
					cell_explosion(T, 200, 50)
					if(A)
						A.Destroy()
					continue
				else
					A.ex_act(1)

	var/list/relevant_z = GetConnectedZlevels(start.z)
	for(var/mob/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!T || !(T.z in relevant_z))
			continue
		shake_camera(M, 25)
		if(!isdeaf(M))
			sound_to(M, sound('sound/effects/explosionfar.ogg', volume=10))

		if(M.can_be_floored())
			var/shouldstumble = FALSE
			var/sincelastmove = world.time - M.l_move_time

			if(sincelastmove > QUICK_TO_STANDING SECONDS) //We are standing still
				shouldstumble = prob(STANDING_FALL_PROB)
			else if(sincelastmove > DELIBERATE_TO_STANDING) //We are either standing still after running or standing still after walking/creeping
				shouldstumble = MOVING_QUICKLY(M) ? prob(RUNNING_FALL_PROB) : prob(STANDING_FALL_PROB)
			else //We are either currently running or currently walking/creeping
				shouldstumble = MOVING_QUICKLY(M) ? prob(RUNNING_FALL_PROB) : prob(WALKING_FALL_PROB)

			if(shouldstumble)
				to_chat(M, SPAN_DANGER("You stumble onto the floor from the shaking!"))
				M.AdjustStunned(2)
				M.AdjustWeakened(2)

	if(front) //Meanwhile front might have exploded
		front.layer = ABOVE_OBJ_LAYER //So the beam goes below us. Looks a lot better
	playsound(start, 'sound/machines/disperser_fire.ogg', 100, 1)
	handle_beam(start, direction)
	handle_overbeam()

	if (chargetype != OVERMAP_WEAKNESS_DROPPOD)
		qdel(atomcharge)

	//Some moron disregarded the cooldown warning. Let's blow in their face.
	if(prob(cool_failchance()))
		cell_explosion(middle, rand(200, 400), 75)
	next_shot = coolinterval + world.time

	var/turf/targetrange = get_turf(linked)
	for(var/i = 1 to range)
		targetrange = get_step(targetrange, overmapdir)

	var/turf/overmaptarget = targetrange
	var/list/candidates = list()

	//Prioritize events. Thus you can hide in meteor showers in exchange for protection from the disperser.
	for(var/obj/effect/overmap/event/O in overmaptarget)
		candidates += O
	//Next we see if there are any ships around. Logically they are between us and the sector if one exists.
	if(!length(candidates))
		for(var/obj/effect/overmap/visitable/ship/S in overmaptarget)
			if(S == linked)
				continue //Why are you shooting yourself?
			candidates += S

	//No events, no ships, the last thing to check is a sector.
	if(!length(candidates))
		for(var/obj/effect/overmap/O in overmaptarget)
			if(O == linked)
				continue //Why are you shooting yourself?
			candidates += O

	//Way to waste a charge
	if(!length(candidates))
		if(chargetype == OVERMAP_WEAKNESS_BLUESPACE)
			var/obj/effect/overmap/event/nebula/N = new /obj/effect/overmap/event/nebula(targetrange)
			N.name = "temporary bluespace nebula"
			QDEL_IN(N, rand(1 MINUTES, 3 MINUTES))
		if(chargetype == OVERMAP_WEAKNESS_WORM)
			var/obj/effect/overmap/event/gravity/danger/S = new /obj/effect/overmap/event/gravity/danger(targetrange)
			S.name = "unstable wormhole"
			QDEL_IN(S, rand(1 MINUTES, 2 MINUTES))
		return TRUE

	var/obj/effect/overmap/finaltarget = pick(candidates)

	//Success, but we missed.
	if(prob(100 - cal_accuracy()) && !istype(finaltarget, /obj/effect/overmap/visitable/sector/exoplanet))
		log_and_message_admins("Выстрел от [linked.name] из obstruction field disperser ебанул [finaltarget.name], но калибровка была говном (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[linked.x];Y=[linked.y];Z=[linked.z]'>MAP</a>)", location=get_turf(front))
		if(chargetype == OVERMAP_WEAKNESS_DROPPOD)
			atomcharge.forceMove(locate(rand(1,world.maxx),rand(1,world.maxy), GLOB.using_map.get_empty_zlevel())) //Remove it in case it's a droppod.
		return TRUE

	reset_calibration()

	log_and_message_admins("A type [chargetype] disperser beam was launched at [finaltarget].", location=finaltarget)

	//Deletion of the overmap effect and the actual event trigger. Bye bye pesky meteors.
	if(istype(finaltarget, /obj/effect/overmap/event))
		fire_at_event(finaltarget, chargetype)
		qdel(atomcharge)
	//After this point ships act basically as sectors so we stop taking care of differences
	else
		fire_at_sector(finaltarget, atomcharge, chargetype)
	return TRUE

/obj/machinery/computer/ship/disperser/proc/fire_at_event(obj/effect/overmap/event/finaltarget, chargetype)
	if(chargetype & finaltarget.weaknesses)
		var/turf/T = finaltarget.loc
		qdel(finaltarget)
		overmap_event_handler.update_hazards(T)

/obj/machinery/computer/ship/disperser/proc/fire_at_sector(obj/effect/overmap/visitable/finaltarget, obj/structure/ship_munition/disperser_charge/charge, chargetype)
	var/list/targetareas = finaltarget.get_areas()
	targetareas -= locate(/area/space)
	var/area/finalarea = pick(targetareas)
	var/turf/targetturf = pick_area_turf(finalarea.type, list(/proc/is_not_space_turf))

	log_and_message_admins("Disperser beam hit sector at [get_area(targetturf)].", location=targetturf)
	if(chargetype == OVERMAP_WEAKNESS_DROPPOD)
		if(targetturf.density)
			targetturf.ex_act(1)
		for(var/atom/A in targetturf)
			A.ex_act(3)
		charge.forceMove(targetturf)
		//The disperser is not a taxi
		for(var/mob/living/L in charge)
			to_chat(L, SPAN_DANGER("Your body shakes violently, immense and agonising forces tearing it apart."))
			L.forceMove(targetturf)
			L.ex_act(1)
	else
		charge.fire(targetturf, strength, range)
		qdel(charge)

/obj/machinery/computer/ship/disperser/proc/handle_beam(turf/start, direction)
	set waitfor = FALSE
	start.Beam(get_target_turf(start, direction), "disperser_beam", time = 50, maxdistance = world.maxx)
	if(front)
		front.layer = initial(front.layer)

/obj/machinery/computer/ship/disperser/proc/handle_overbeam()
	set waitfor = FALSE
	var/turf/targetrange = get_turf(linked)
	for(var/i = 1 to range)
		targetrange = get_step(targetrange, overmapdir)

	linked.Beam(targetrange, "disperser_beam", time = 150, maxdistance = world.maxx)

#undef QUICK_TO_STANDING
#undef DELIBERATE_TO_STANDING
#undef RUNNING_FALL_PROB
#undef WALKING_FALL_PROB
#undef STANDING_FALL_PROB
