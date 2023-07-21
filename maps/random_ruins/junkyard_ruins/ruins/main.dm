//      A R E A S     //

/area/map_template/wreck
	name = "\improper Wreck"
	icon_state = "hallC1"
	icon = 'icons/turf/areas.dmi'

/area/map_template/wreck/wreckone
/area/map_template/wreck/wreckone/second

/datum/map_template/ruin/junkyard/wreck
	name = "Fleet ship derelict"
	id = "wreck1"
	description = "Just small ruins."
	suffixes = list("ruins/ruin_1.dmm")
	spawn_cost = 0.5
	template_flags = TEMPLATE_FLAG_NO_RUINS | TEMPLATE_FLAG_CLEAR_CONTENTS// | TEMPLATE_FLAG_ALLOW_DUPLICATES
	ruin_tags = RUIN_WRECK