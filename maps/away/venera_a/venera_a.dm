#include "venera_a_shuttles.dm"

/obj/effect/overmap/visitable/ship/venera_a
	name = "SGV Venera"
	desc = "Sensor array is detecting a Sol Gov GunBoat Vessel."
	color = "#1d96f8"
	integrity_failure_cap = 150
	vessel_mass = 3000 /// Venera is small and fast ship
	max_speed = 1/(2 SECONDS)
	initial_generic_waypoints = list(
		"nav_venera_a_1",
		"nav_venera_a_2",
		"nav_venera_a_3",
		"nav_venera_a_antag"
	)


/obj/effect/overmap/visitable/ship/venera_a/New(nloc, max_x, max_y)
	name = "SGV Venera"
	..()

/datum/map_template/ruin/away_site/venera_a
	name = "SGV Venera_a"
	id = "awaysite_venera_a"
	description = "Active SolGov movable medium ship with shuttle."
	suffixes = list("venera_a/venera_a.dmm")
	spawn_cost = 50 // nice try lol
	area_usage_test_exempted_root_areas = list(/area/venera)
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/jinx)

/obj/effect/shuttle_landmark/nav_venera_a/nav1
	name = "SGV Venera Navpoint #1"
	landmark_tag = "nav_venera_a_1"

/obj/effect/shuttle_landmark/nav_venera_a/nav2
	name = "SGV Venera Navpoint #2"
	landmark_tag = "nav_venera_a_2"

/obj/effect/shuttle_landmark/nav_venera_a/nav3
	name = "SGV Venera Navpoint #3"
	landmark_tag = "nav_venera_a_3"

/obj/effect/shuttle_landmark/nav_venera_a/nav4
	name = "SGV Venera Navpoint #4"
	landmark_tag = "nav_venera_a_antag"
