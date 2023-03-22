/obj/effect/overmap/visitable/sector/truck_wreck
	name = "Crashed truck"
	desc = "This is truck, somehow crushed into asteroid"
	icon_state = "object"
	color = "#00ffff"

	initial_generic_waypoints = list(
		"nav_truck_1",
		"nav_truck_2",
		"nav_truck_3",
		"nav_truck_antag"
	)

/datum/map_template/ruin/away_site/broken_truck
	name = "Space truck crashsite"
	id = "awaysite_truck_crashsite"
	description = "Space truck crashsite."
	suffixes = list("cowboy_bebop/space_truck_broken.dmm")
	spawn_cost = 2
	generate_mining_by_z = 1
	area_usage_test_exempted_root_areas = list(/area/ship/truck)

/obj/effect/shuttle_landmark/nav_truck_crashsite/nav1
	name = "Truck crashsite Navpoint #1"
	landmark_tag = "nav_truck_1"

/obj/effect/shuttle_landmark/nav_truck_crashsite/nav2
	name = "Truck crashsite Navpoint #2"
	landmark_tag = "nav_truck_base_2"

/obj/effect/shuttle_landmark/nav_truck_crashsite/nav3
	name = "Truck crashsite Navpoint #3"
	landmark_tag = "nav_truck_base_3"

/obj/effect/shuttle_landmark/nav_truck_crashsite/navantag
	name = "Truck crashsite Navpoint #4"
	landmark_tag = "nav_truck_antag"

/area/ship/truck
	name = "\improper FTV Metal Queen"
	icon_state = "bridge"

/area/ship/truck/asteroid
	name = "\improper FTV Metal Queen"
	icon_state = "bridge"