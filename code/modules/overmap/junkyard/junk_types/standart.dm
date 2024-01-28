/obj/effect/overmap/visitable/sector/junkyard/standart
	name = "junkyard"
	desc = "An old junkyard"
	color = "#b4aeae"
	junkyard_area = /area/junkyard/standart
	possible_themes = list(/datum/junkyard_theme/robotic_guardians)
	map_generators = list(/datum/random_map/noise/junkyard/standart)
	ruin_tags_blacklist = RUIN_HABITAT|RUIN_WATER|RUIN_RAINWORLD
	features_budget = 30

/*/obj/effect/overmap/visitable/sector/junkyard/standart/handle_repopulation()
	return*/

/datum/random_map/noise/junkyard/standart
	descriptor = "junkyard"
	smoothing_iterations = 4
	land_type = /turf/space
//	fauna_prob = 0

/area/junkyard/standart
	name = "\improper Junkyard area"
	base_turf = /turf/space
