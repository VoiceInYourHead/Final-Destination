/obj/effect/overmap/missile
	name = "missile"
	icon_state = "missile"
	sector_flags = OVERMAP_SECTOR_KNOWN // technically in space, but you can't visit the missile during its flight
	scannable = TRUE
	var/obj/structure/missile/actual_missile = null

	var/walking = FALSE // walking towards something on the overmap?
	var/moving = FALSE // is the missile moving on the overmap?
	var/dangerous = FALSE
	var/should_enter_zs = FALSE

/obj/effect/overmap/missile/Initialize(var/maploading, var/sx, var/sy)
	. = ..()
	x = sx
	y = sy
	z = GLOB.using_map.overmap_z
	START_PROCESSING(SSobj, src)


/obj/effect/overmap/missile/Destroy()
	if(!QDELETED(actual_missile))
		QDEL_NULL(actual_missile)
	actual_missile = null

	. = ..()

/obj/effect/overmap/missile/Bump(var/atom/A)
	if(istype(A,/turf/unsimulated/map/edge))
		// Destroy() in the missile will qdel this object as well
		qdel(actual_missile)
	..()

/obj/effect/overmap/missile/proc/set_missile(var/obj/structure/missile/missile)
	actual_missile = missile

/obj/effect/overmap/missile/proc/set_dangerous(var/is_dangerous)
	dangerous = is_dangerous

/obj/effect/overmap/missile/proc/set_moving(var/is_moving)
	moving = is_moving

/obj/effect/overmap/missile/proc/set_enter_zs(var/enter_zs)
	should_enter_zs = enter_zs

/obj/effect/overmap/missile/get_scan_data(mob/user)
	. = ..()
	. += "<br>General purpose projectile frame"
	. += "<br>Additional information:<br>[get_additional_info()]"

/obj/effect/overmap/missile/proc/get_additional_info()
	if(actual_missile)
		return actual_missile.get_additional_info()
	return "N/A"

/obj/effect/overmap/missile/proc/move_to(var/datum/target, var/min_speed, var/speed)
	if(isnull(target) || !speed)
		walk(src, 0)
		walking = FALSE
		update_icon()
		return

	walk_towards(src, target, min_speed - speed)

	walking = TRUE
	update_icon()

/obj/effect/overmap/missile/Process()
	// Whether overmap movement occurs is controlled by the missile itself
	if(!moving || !actual_missile)
		return

	check_enter()

	// let equipment alter speed/course
	for(var/obj/item/missile_equipment/E in actual_missile.equipment)
		E.do_overmap_work(src)

	for(var/obj/effect/overmap/event/E in get_turf(src))
		if(istype(E, /obj/effect/overmap/event/nebula))
			var/turf/destination = locate(rand(2, 54), rand(2, 54), GLOB.using_map.overmap_z)
			if (!isturf(destination))
				return
			dropInto(destination)

		if(istype(E, /obj/effect/overmap/event/meteor))
			if(prob(10))
				Destroy()

		if(istype(E, /obj/effect/overmap/event/gravity/danger))
			if(prob(50))
				Destroy()

		if(istype(E, /obj/effect/overmap/event/electric))
			if(prob(33))
				for(var/obj/item/missile_equipment/thruster/T in actual_missile.equipment)
					var/list/targets_around = list()
					for(var/obj/effect/overmap/visitable/V in range(src, 7))
						if(T.is_target_valid(V))
							targets_around += V
					if(targets_around.len)
						T.target = pick(targets_around)
				actual_missile.origin = null

	update_icon()

// Checks if the missile should enter the z level of an overmap object
/obj/effect/overmap/missile/proc/check_enter()
	if(!should_enter_zs)
		return

	var/list/potential_levels
	var/turf/T = get_turf(src)
	for(var/obj/effect/overmap/visitable/O in T)
		if(actual_missile.origin)
			if(O == actual_missile.origin)
				continue

		var/valid = FALSE
		for(var/obj/item/missile_equipment/thruster/E in actual_missile.equipment)
			if(E.is_target_valid(O))
				valid = TRUE
		if(!valid)
			continue

		if(!LAZYLEN(O.map_z))
			continue

		LAZYINITLIST(potential_levels)
		potential_levels[O] = 0

		// Missile equipment "votes" on what to enter
		for(var/obj/item/missile_equipment/E in actual_missile.equipment)
			if(E.should_enter(O))
				potential_levels[O]++

	// Nothing to enter
	if(!LAZYLEN(potential_levels))
		return

	var/total_votes = 0
	for(var/O in potential_levels)
		total_votes += potential_levels[O]

	// Default behavior, just enter the first thing in space we encounter
	if(!total_votes)
		// Must be in motion for this to happen
		if(!walking)
			return

		for(var/obj/effect/overmap/O in potential_levels)
			if((O.sector_flags & OVERMAP_SECTOR_IN_SPACE))
				var/obj/effect/overmap/visitable/winner = pick(O)
				actual_missile.enter_level(pick(winner.map_z), winner, winner.fore_dir, winner.dir)
	else // Enter the thing with most "votes"
		var/obj/effect/overmap/visitable/winner = pick(potential_levels)
		for(var/O in potential_levels)
			if(potential_levels[O] > potential_levels[winner])
				winner = O
		actual_missile.enter_level(pick(winner.map_z), winner, winner.fore_dir, winner.dir)

/obj/effect/overmap/missile/on_update_icon()
	icon_state = initial(icon_state)
	if(dangerous)
		icon_state  += "_danger"