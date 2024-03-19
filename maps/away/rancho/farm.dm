/obj/effect/overmap/visitable/sector/rancho
	name = "colonized planetoid"
	desc = "Scanner indicates an phoron rich exoplanet, with a few small villages on it."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	color = "#0e5010"
	free_landing = FALSE
	initial_generic_waypoints = list(
		"nav_rancho_1"
	)

/obj/effect/overmap/visitable/sector/rancho/New(nloc, max_x, max_y)
	name = "[generate_planet_name()], \a [name]"
	..()

/datum/map_template/ruin/away_site/rancho
	name = "colonized planetoid"
	id = "awaysite_rancho"
	spawn_cost = 1000 //NO BITCHES??
	player_cost = 2
	description = "Phoron rich exoplanet, with a few small villages on it"
	suffixes = list()
	area_usage_test_exempted_root_areas = list(/area/rancho/)
	apc_test_exempt_areas = list(
		/area/rancho/outdoors = NO_SCRUBBER|NO_VENT|NO_APC
	)

/area/rancho
	name = "Block #7"
	icon_state = "unknown"

/area/rancho/outdoors
	name = "Block #7 - Outdoors"
	requires_power = 0
	dynamic_lighting = 1

/obj/effect/shuttle_landmark/nav_rancho/nav1
	name = "Farmer's Block #7"
	landmark_tag = "nav_rancho_1"
	base_area = /area/rancho/outdoors
	base_turf = /turf/unsimulated/floor/exoplanet/barren