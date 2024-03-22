/obj/effect/overmap/visitable/sector/rancho
	name = "colonized planetoid"
	desc = "Scanner indicates an phoron rich exoplanet, with a few small villages on it."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	color = "#0e5010"
	free_landing = FALSE
	initial_generic_waypoints = list(
		"nav_rancho_1",
		"nav_rancho_2"
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
	suffixes = list("rancho/rancho-2.dmm")
	area_usage_test_exempted_root_areas = list(/area/rancho/)
	apc_test_exempt_areas = list(
		/area/rancho/outdoors = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/rancho/indoors = NO_SCRUBBER|NO_VENT|NO_APC
	)

/area/rancho
	name = "Block #7"
	icon_state = "unknown"

/area/rancho/outdoors
	name = "Block #7 - Outdoors"
	requires_power = 0
	dynamic_lighting = 1

/area/rancho/outdoors_swamp
	name = "Block #7 - Swamp"
	requires_power = 0
	dynamic_lighting = 1

/area/rancho/indoors
	name = "Block #7 - Indoors"
	requires_power = 1

/area/rancho/indoors/cargo
	name = "Block #7 - Cargo"

/area/rancho/indoors/swampman
	name = "Block #7 - Swampman House"

/area/rancho/indoors/forestman
	name = "Block #7 - Lumberjack's House"

/area/rancho/indoors/techman
	name = "Block #7 - Mechanic's House"

/obj/effect/shuttle_landmark/nav_rancho/nav1
	name = "Farmer's Block #7 - MAIN"
	landmark_tag = "nav_rancho_1"
	base_area = /area/rancho/outdoors
	base_turf = /turf/simulated/floor/plating

/obj/effect/shuttle_landmark/nav_rancho/nav2
	name = "Farmer's Block #7 - SECONDARY"
	landmark_tag = "nav_rancho_2"
	base_area = /area/rancho/outdoors
	base_turf = /turf/simulated/floor/plating

/obj/structure/flora/tree/swamp
	icon = 'icons/fd/structures/mojave/talltrees.dmi'
	icon_state = "tree_1"
	pixel_x = -16

/obj/structure/flora/tree/swamp/New()
	..()
	icon_state = "tree_[rand(1, 3)]"

/obj/structure/flora/tree/swamp/dead_small
	icon = 'icons/fd/structures/mojave/trees.dmi'
	icon_state = "deadtree_1"
	pixel_x = -16

/obj/structure/flora/tree/swamp/dead_small/New()
	..()
	icon_state = "tree_[rand(1, 6)]"

/obj/structure/flora/swamp
	anchored = TRUE

/obj/structure/flora/swamp/tallgrass
	name = "dead grass"
	icon = 'icons/fd/structures/mojave/flora.dmi'
	icon_state = "tall_grass2_1"

/obj/structure/flora/swamp/tallgrass/New()
	..()
	icon_state = "tall_grass2_[rand(1, 4)]"

/obj/structure/flora/swamp/grass
	name = "dead grass"
	icon = 'icons/fd/structures/mojave/flora.dmi'
	icon_state = "tall_grass1_1"

/obj/structure/flora/swamp/grass/New()
	..()
	icon_state = "tall_grass1_[rand(1, 4)]"