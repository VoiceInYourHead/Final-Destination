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

/area/ship/stomper
	name = "\improper PV Stomper"
	icon_state = "bridge"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED

/area/ship/coffin
	name = "\improper IPV Turtle"
	icon_state = "bridge"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED

/area/ship/coffin/cargo
/area/ship/coffin/back

/area/map_template/wreck/wreck7
	name = "\improper Abandoned Container"

/area/map_template/wreck/wreck8
	name = "\improper Meteor Stash"
	requires_power = FALSE

/area/map_template/wreck/wrecknine
	name = "\improper Station fragment #3"

/area/map_template/wreck/wreckten
	name = "\improper Station fragment #4"
/area/map_template/wreck/wreckten/two
/area/map_template/wreck/wreckten/three

/area/map_template/wreck/wreckeleven
	name = "\improper Station fragment #5"
/area/map_template/wreck/wreckeleven/two

/area/map_template/wreck/wreck13
	name = "\improper Unknown Location"

/area/map_template/wreck/wreck14
	name = "\improper Colony Ship"

/area/map_template/wreck/wreck15
	name = "\improper Station fragment #6"

//////////    D A T U M S     /////////////

/datum/map_template/ruin/junkyard/wreck
	name = "Fleet ship derelict"
	id = "wreck1"
	description = "Just small ruins."
	suffixes = list("ruins/ruin_1.dmm")
	spawn_cost = 2
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

/datum/map_template/ruin/junkyard/wreck/wreck6		// S T O M P E R (shuttle)
	name = "Stomper"
	id = "wreck6"
	suffixes = list("ruins/ruin_6.dmm")
	spawn_cost = 3
	area_usage_test_exempted_root_areas = /area/ship/stomper
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/stomper)

/datum/map_template/ruin/junkyard/wreck/wreck7container
	name = "Abandoned Container"
	id = "wreck7"
	suffixes = list("ruins/ruin_7.dmm")
	spawn_cost = 0.5

/datum/map_template/ruin/junkyard/wreck/wreck8meteor
	name = "Stash Meteor"
	id = "wreck8"
	suffixes = list("ruins/ruin_8.dmm")
	spawn_cost = 0.2

/datum/map_template/ruin/junkyard/wreck/wreck9
	name = "Station fragment #3"
	id = "wreck9"
	suffixes = list("ruins/ruin_9.dmm")
	spawn_cost = 1

/datum/map_template/ruin/junkyard/wreck/wreck10
	name = "Station fragment #4"
	id = "wreck10"
	suffixes = list("ruins/ruin_10.dmm")
	spawn_cost = 3

/datum/map_template/ruin/junkyard/wreck/wreck11
	name = "Station fragment #5"
	id = "wreck11"
	suffixes = list("ruins/ruin_11.dmm")
	spawn_cost = 2

/datum/map_template/ruin/junkyard/wreck/wreck12
	name = "IPV Turtle"
	id = "wreck12"
	suffixes = list("ruins/ruin_12.dmm")
	spawn_cost = 3
	area_usage_test_exempted_root_areas = /area/ship/coffin/
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/coffin)

/datum/map_template/ruin/junkyard/wreck/wreck13
	name = "Cult Ruin"
	id = "wreck13"
	suffixes = list("ruins/ruin_13.dmm")
	spawn_cost = 0.5

/datum/map_template/ruin/junkyard/wreck/wreck14
	name = "Wrecked Colony Ship"
	id = "wreck14"
	suffixes = list("ruins/ruin_14.dmm")
	spawn_cost = 1

/datum/map_template/ruin/junkyard/wreck/wreck15
	name = "Station fragment #6 (Supermatter)"
	id = "wreck15"
	suffixes = list("ruins/ruin_15.dmm")
	spawn_cost = 5

/*
					Additional Things for wrecks
*/


/obj/effect/overmap/visitable/ship/landable/stomper
	name = "PV Stomper"
	shuttle = "Stomper"
	desc = "Sensor array is detecting a small private vessel."
	max_speed = 1/(2 SECONDS)
	burn_delay = 0.5 SECONDS
	vessel_mass = 900
	integrity_failure_cap = 70
	skill_needed = SKILL_BASIC
	vessel_size = SHIP_SIZE_TINY
	fore_dir = NORTH
	dir = NORTH
	color = "#51ff00"
	hide_from_reports = TRUE
	known = 0

/obj/machinery/computer/shuttle_control/explore/stomper
	name = "vessel control console"
	shuttle_tag = "Stomper"

/obj/effect/shuttle_landmark/stomper
	name = "Stomper Landing Zone"
	landmark_tag = "nav_stomper"
	docking_controller = "stomper_dock"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/datum/shuttle/autodock/overmap/stomper
	name = "Stomper"
	range = 0 //range = 1
	shuttle_area = list(/area/ship/stomper)
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/shuttle_ceiling
	current_location = "nav_stomper"



/obj/effect/overmap/visitable/ship/landable/coffin
	name = "IPV Turtle"
	shuttle = "IPV Turtle"
	desc = "Sensor array is detecting a small private vessel, broadcasting registration codes \"IPV-7442-S-135\"."
	max_speed = 1/(2 SECONDS)
	burn_delay = 0.5 SECONDS
	vessel_mass = 900
	integrity_failure_cap = 70
	skill_needed = SKILL_BASIC
	vessel_size = SHIP_SIZE_TINY
	fore_dir = NORTH
	dir = NORTH
	color = "#51ff00"
	hide_from_reports = TRUE
	known = 0

/obj/machinery/computer/shuttle_control/explore/coffin
	name = "vessel control console"
	shuttle_tag = "IPV Turtle"

/obj/effect/shuttle_landmark/coffin
	name = "IPV Turtle Landing Zone"
	landmark_tag = "nav_coffin"
	docking_controller = "coffin_dock"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/datum/shuttle/autodock/overmap/coffin
	name = "IPV Turtle"
	range = 0 //range = 1
	shuttle_area = list(/area/ship/coffin/cargo, /area/ship/coffin/back)
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/shuttle_ceiling
	current_location = "nav_coffin"

/decl/submap_archetype/playablecoffin
	descriptor = "IPV Turtle"
	crew_jobs = list(/datum/job/submap/coffinprisoner)

/datum/job/submap/coffinprisoner
	title = "Corporation Borrower"
	info = "You are a prisoner of your own ambitions. Now, your main objective - is filling quota for survival."
	total_positions = 2
	loadout_allowed = FALSE
	outfit_type = /decl/hierarchy/outfit/survivor

/obj/effect/submap_landmark/spawnpoint/coffinprisoner_spawn
	name = "Corporation Borrower"

/obj/effect/submap_landmark/joinable_submap/coffin
	name = "IPV Turtle"
	archetype = /decl/submap_archetype/playablecoffin
