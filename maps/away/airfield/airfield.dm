#include "airfield_areas.dm"
//#include "airfield_jobs.dm"
#include "airfield_shuttles.dm"

/obj/effect/submap_landmark/joinable_submap/airfield
	name = "Rubicon 3 Airfield"
	archetype = /decl/submap_archetype/derelict/airfield

/decl/submap_archetype/derelict/airfield
	descriptor = "Rubicon 3 Airfield"
	map = "Rubicon 3 Airfield"
	crew_jobs = list(
	)

/obj/effect/overmap/visitable/ship/airfield
	name = "Rubicon 3 Airfield"
	desc = "Sensor array detects a large planet, named Rubicon 3, with big amount of various infrastructure on it."
	vessel_mass = 100000
	integrity_failure_cap = 9999
	icon_state = "globe"
	color = "#6db8b8"
	fore_dir = NORTH
	initial_restricted_waypoints = list(
			"PM-55-L Star #1" = list("nav_airfield_star_1", "nav_airfield_1"),
			"PM-55-L Star #2" = list("nav_airfield_star_2", "nav_airfield_2"),
			"PM-55-L Star #3" = list("nav_airfield_star_3", "nav_airfield_3"),
			"PM-55-L Star #4" = list("nav_airfield_star_4", "nav_airfield_4"),
			"PM-08 Bull #1" = list("nav_airfield_bull_1", "nav_airfield_5"),
			"PM-08 Bull #2" = list("nav_airfield_bull_2", "nav_airfield_6"),
			"PM-15 Nightbat #1" = list("nav_airfield_nightbat_1", "nav_airfield_7"),
			"PM-15 Nightbat #2" = list("nav_airfield_nightbat_2", "nav_airfield_8"),
			"PM-57 Spear #1" = list("nav_airfield_spear_1", "nav_airfield_9"),
			"PM-57 Spear #2" = list("nav_airfield_spear_2", "nav_airfield_10"),
			"PM-100 Scarab" = list("nav_airfield_scarab", "nav_airfield_11")
	)
	initial_generic_waypoints = list(
		"nav_airfield_1",
		"nav_airfield_2",
		"nav_airfield_3",
		"nav_airfield_4",
		"nav_airfield_5",
		"nav_airfield_6",
		"nav_airfield_7",
		"nav_airfield_8",
		"nav_airfield_9",
		"nav_airfield_10",
		"nav_airfield_11",
	)

/datum/map_template/ruin/away_site/airfield
	name = "Rubicon 3 Airfield"
	id = "awaysite_airfield"
	description = "Free Trade Union salvage ship"
	suffixes = list("airfield/airfield-1.dmm", "airfield/airfield-2.dmm")
	spawn_cost = 999
	player_cost = 6
	area_usage_test_exempted_root_areas = list(/area/ship/airfield)
	shuttles_to_initialise = list(
		/datum/shuttle/autodock/overmap/airfield1,
		/datum/shuttle/autodock/overmap/airfield2,
		/datum/shuttle/autodock/overmap/airfield3,
		/datum/shuttle/autodock/overmap/airfield4,
		/datum/shuttle/autodock/overmap/airfield5,
		/datum/shuttle/autodock/overmap/airfield6,
		/datum/shuttle/autodock/overmap/airfield7,
		/datum/shuttle/autodock/overmap/airfield8,
		/datum/shuttle/autodock/overmap/airfield9,
		/datum/shuttle/autodock/overmap/airfield10,
		/datum/shuttle/autodock/overmap/airfield11
	)
	apc_test_exempt_areas = list(
		/area/ship/airfield/outdoors = NO_SCRUBBER|NO_VENT|NO_APC
	)