#include "carrier_areas.dm"
#include "carrier_jobs.dm"
#include "carrier_shuttles.dm"
#include "carrier_radio.dm"

/obj/effect/submap_landmark/joinable_submap/carrier
	name = "FTU-SV Bigsby"
	archetype = /decl/submap_archetype/derelict/carrier

/decl/submap_archetype/derelict/carrier
	descriptor = "FTU-SV Bigsby"
	map = "FTU-SV Bigsby"
	crew_jobs = list(
		/datum/job/submap/carrier_captain,
		/datum/job/submap/carrier_pilot,
		/datum/job/submap/carrier_doctor,
		/datum/job/submap/carrier_crewman,
		/datum/job/submap/carrier_cyborg,
		/datum/job/submap/carrier_chef,
		/datum/job/submap/carrier_salvager
	)

/obj/effect/overmap/visitable/ship/carrier
	name = "FTU-SV Bigsby"
	desc = "Sensor array detects a large vessel, identifying itself as 'FTU-SV Bigsby'. It's broadcasting next registration codes \"FTUSV-1986-M-331\"."
	vessel_mass = 20000
	integrity_failure_cap = 200
	color = "#00ffff"
	max_speed = 1/(5 SECONDS)
	burn_delay = 5 SECONDS
	fore_dir = NORTH
	initial_restricted_waypoints = list(
			"FTU-SV GUP #1" = list("nav_hangar_carrier_1", "nav_carrier_1"),
			"FTU-SV GUP #2" = list("nav_hangar_carrier_2", "nav_carrier_2"),
			"FTU-SV GUP #3" = list("nav_hangar_carrier_3", "nav_carrier_3"),
			"FTU-SV GUP #4" = list("nav_hangar_carrier_4", "nav_carrier_4"),
			"FTU-SV GUP #5" = list("nav_hangar_carrier_5", "nav_carrier_5"),
			"FTU-SV GUP #6" = list("nav_hangar_carrier_6", "nav_carrier_6")
	)
	initial_generic_waypoints = list(
		"nav_carrier_1",
		"nav_carrier_2",
		"nav_carrier_3",
		"nav_carrier_4",
		"nav_carrier_5",
		"nav_carrier_6",
	)

/datum/map_template/ruin/away_site/carrier
	name = "FTU-SV Bigsby"
	id = "awaysite_carrier"
	description = "Free Trade Union salvage ship"
	suffixes = list("drone_carrier/carrier-1.dmm", "drone_carrier/carrier-2.dmm")
	spawn_cost = 2
	player_cost = 6
	spawn_weight = 0.33
	area_usage_test_exempted_root_areas = list(/area/ship/carrier)
	shuttles_to_initialise = list(
		/datum/shuttle/autodock/overmap/carrier1,
		/datum/shuttle/autodock/overmap/carrier2,
		/datum/shuttle/autodock/overmap/carrier3,
		/datum/shuttle/autodock/overmap/carrier4,
		/datum/shuttle/autodock/overmap/carrier5,
		/datum/shuttle/autodock/overmap/carrier6,
	)



