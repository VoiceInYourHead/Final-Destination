//      A R E A S     //

/area/map_template/wreck
	name = "\improper Wreck"
	icon_state = "hallC1"
	icon = 'icons/turf/areas.dmi'

/area/map_template/wreck/wreckone
	name = "\improper Fleet ship derelict"
/area/map_template/wreck/wreckone/second

/area/map_template/wreck/wrecktwo
	name = "\improper Station fragment #1"
/area/map_template/wreck/wrecktwo/second

/area/map_template/wreck/wreckthree
	name = "\improper Lost escape pod"

/area/map_template/wreck/wreckfour
	name = "\improper Station fragment #2"

/area/map_template/wreck/wreckfive
	name = "\improper Shipbreakers abandoned shuttle"

/datum/map_template/ruin/junkyard/wreck
	name = "Fleet ship derelict"
	id = "wreck1"
	description = "Just small ruins."
	suffixes = list("ruins/ruin_1.dmm")
	spawn_cost = 1
	template_flags = TEMPLATE_FLAG_NO_RUINS | TEMPLATE_FLAG_CLEAR_CONTENTS// | TEMPLATE_FLAG_ALLOW_DUPLICATES
	ruin_tags = RUIN_WRECK

/datum/map_template/ruin/junkyard/wreck/wreck2
	name = "Station fragment #1"
	id = "wreck2"
	suffixes = list("ruins/ruin_2.dmm")
	spawn_cost = 0.5

/datum/map_template/ruin/junkyard/wreck/wreck3
	name = "Lost escape pod"
	id = "wreck3"
	suffixes = list("ruins/ruin_3.dmm")
	spawn_cost = 0.2

/datum/map_template/ruin/junkyard/wreck/wreck4
	name = "Station fragment #2"
	id = "wreck4"
	suffixes = list("ruins/ruin_4.dmm")
	spawn_cost = 1

/datum/map_template/ruin/junkyard/wreck/wreck5
	name = "Shipbreakers abandoned shuttle"
	id = "wreck5"
	suffixes = list("ruins/ruin_5.dmm")
	spawn_cost = 0.5