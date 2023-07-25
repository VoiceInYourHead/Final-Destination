#define  COAST_VALUE  cell_range + 1
/datum/random_map/noise/junkyard
	descriptor = "junkyard"
	smoothing_iterations = 1
	smooth_single_tiles = 1

	var/land_type = /turf/unsimulated/floor

	//intended x*y size, used to adjust spawn probs
	var/intended_x = 150
	var/intended_y = 150
//	var/fauna_prob = 2
//	var/megafauna_spawn_prob = 0.5 //chance that a given fauna mob will instead be a megafauna

/datum/random_map/noise/junkyard/New(seed, tx, ty, tz, tlx, tly, do_not_apply, do_not_announce, never_be_priority = 0, used_area)
	if (target_turf_type == null)
		target_turf_type = world.turf
	//automagically adjust probs for bigger maps to help with lag
//	var/size_mod = intended_x / tlx * intended_y / tly
//	fauna_prob *= size_mod
	..()

	GLOB.using_map.base_turf_by_z[num2text(tz)] = land_type

/datum/random_map/noise/junkyard/get_map_char(var/value)
	return "[noise2value(value)]"

/datum/random_map/noise/junkyard/get_appropriate_path(value)
	return land_type

/datum/random_map/noise/junkyard/get_additional_spawns(value, turf/T)
	if (T.is_wall())
		return
//	var/parsed_value = noise2value(value)
/*	switch(parsed_value)
		if (2 to 3)
			if (prob(fauna_prob))
				spawn_fauna(T)*/

/*/datum/random_map/noise/junkyard/proc/spawn_fauna(turf/T)
	if (prob(megafauna_spawn_prob))
		new /obj/effect/landmark/junkyard_spawn/megafauna(T)
	else
		new /obj/effect/landmark/junkyard_spawn(T)*/