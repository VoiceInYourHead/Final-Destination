/obj/effect/overmap/visitable/sector/junk_planet
	name = "Lush planetoid"
	desc = "Sensor array detects an lush planet with a large amount of wastes on the planet's surface. Scans further indicate an emergency signal broadcasting SCG codes, coming from beneath of the planet's ocean."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	color = "#0c5709"
	initial_generic_waypoints = list(
		"nav_jplanet_1",
		"nav_jplanet_2",
		"nav_jplanet_3"
	)

/datum/map_template/ruin/away_site/junk_planet
	name = "Lush planetoid"
	id = "awaysite_jplanet"
	spawn_cost = 1000 //NO BITCHES??
	player_cost = 2
	description = "Junk Planet with SEV Magnus crashsite. For events only."
	suffixes = list("junk_planet/jplanet-1.dmm")
	area_usage_test_exempted_root_areas = list(/area/jplanet/)
	apc_test_exempt_areas = list(
		/area/jplanet/outdoors = NO_SCRUBBER|NO_VENT|NO_APC
	)

/obj/effect/shuttle_landmark/nav_jplanet/nav1
	name = "Beach Landing Point #1"
	landmark_tag = "nav_jplanet_1"
	base_area = /area/jplanet/outdoors

/obj/effect/shuttle_landmark/nav_jplanet/nav2
	name = "Beach Landing Point #2"
	landmark_tag = "nav_jplanet_2"
	base_area = /area/jplanet/outdoors

/obj/effect/shuttle_landmark/nav_jplanet/nav3
	name = "Beach Landing Point #3"
	landmark_tag = "nav_jplanet_3"
	base_area = /area/jplanet/outdoors

/area/jplanet/outdoors
	name = "Junk Planet"
	icon_state = "centcom"
	dynamic_lighting = 0
	ambience = list('sound/ambience/fd/shore.ogg', 'sound/ambience/fd/jungle.ogg')
	base_turf = /turf/unsimulated/floor/exoplanet/desert

/area/jplanet/indoors
	name = "Junk Planet Indoors"
	icon_state = "centcom"
	dynamic_lighting = 1
	base_turf = /turf/unsimulated/floor/exoplanet/barren

/area/jplanet/outdoors/water
	name = "Junk Planet Ocean"
	ambience = list('sound/ambience/fd/shore.ogg')
	base_turf = /turf/unsimulated/floor/exoplanet/water/shallow

//‘ÀŒ–¿

/obj/structure/flora/tree/tropic
	icon = 'icons/fd/structures/cm/joshuatree.dmi'
	icon_state = "joshua_2"

/obj/structure/flora/tree/tropic/New()
	..()
	icon_state = "joshua_[rand(1, 4)]"

/obj/structure/flora/tropic
	anchored = TRUE

/obj/structure/flora/tropic/rock
	icon_state = "brown_1"
	density = TRUE
	icon = 'icons/fd/structures/cm/rocks.dmi'

/obj/structure/flora/tropic/rock/New()
	..()
	icon_state = "brown_[rand(1, 2)]"

/obj/structure/flora/tropic/small_tree
	icon_state = "tree_1"
	icon = 'icons/fd/structures/cm/dam.dmi'

/obj/structure/flora/tropic/small_tree/New()
	..()
	icon_state = "tree_[rand(1, 2)]"

/obj/structure/flora/tropic/small_tree/orange
	icon_state = "tree_3"
	icon = 'icons/fd/structures/cm/dam.dmi'

/obj/structure/flora/tropic/small_tree/orange/New()
	..()
	icon_state = "tree_[rand(3, 4)]"

/obj/structure/flora/tropic/cactus
	icon_state = "cactus_4"
	icon = 'icons/fd/structures/cm/dam.dmi'

/obj/structure/flora/tropic/cactus/New()
	..()
	icon_state = "cactus_[rand(1, 4)]"

/obj/structure/flora/tropic/cactus/alt
	icon_state = "cacti_8"
	icon = 'icons/fd/structures/cm/dam.dmi'

/obj/structure/flora/tropic/cactus/alt/New()
	..()
	icon_state = "cacti_[rand(1, 4)]"