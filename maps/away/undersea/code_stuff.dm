/obj/effect/overmap/visitable/sector/undersea
	name = "water planetoid"
	desc = "Scanner indicates an large amount of artificial constructions all around the planet surface."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	color = "#203046"
	initial_generic_waypoints = list(
		"nav_undersea_1"
	)

/obj/effect/overmap/visitable/sector/undersea/New(nloc, max_x, max_y)
	name = "[generate_planet_name()], \a [name]"
	..()

/datum/map_template/ruin/away_site/undersea
	name = "water planetoid"
	id = "awaysite_undersea"
	spawn_cost = 1000 //NO BITCHES??
	player_cost = 2
	description = "Large ruined underwater civilization on very dark planet"
	suffixes = list("undersea/undersea-1.dmm", "undersea/undersea-2.dmm", "undersea/undersea-3.dmm", "undersea/undersea-4.dmm", "undersea/undersea-5.dmm")
	area_usage_test_exempted_root_areas = list(/area/undersea/)
	apc_test_exempt_areas = list(
		/area/jplanet/outdoors = NO_SCRUBBER|NO_VENT|NO_APC
	)

/obj/effect/shuttle_landmark/nav_undersea/nav1
	name = "Coral Reef"
	landmark_tag = "nav_undersea_1"
	base_area = /area/undersea/outdoors
	base_turf = /turf/unsimulated/floor/exoplanet/barren/darker

/turf/unsimulated/floor/exoplanet/barren/darker
	color = "#2e2e2e"

/turf/unsimulated/floor/exoplanet/barren/darker_flooded
	flooded = TRUE
	color = "#25283d"

/area/undersea/outdoors
	name = "'Liris' sea"
	icon_state = "centcom"
	dynamic_lighting = 1
	requires_power = 0
	ambience = list('sound/ambience/fd/shore.ogg')
	base_turf = /turf/unsimulated/floor/exoplanet/barren/darker

/area/undersea/indoors
	name = "'Liris' Ruins"
	icon_state = "centcom"
	requires_power = 0
	dynamic_lighting = 1
	ambience = list('sound/ambience/fd/shore.ogg')
	base_turf = /turf/simulated/floor/plating

/area/undersea/indoors_under
	name = "'Liris' Underground City"
	icon_state = "centcom"
	requires_power = 0
	dynamic_lighting = 1
	base_turf = /turf/unsimulated/floor/exoplanet/barren/darker

/area/undersea/indoors_caves
	name = "'Liris' Flooded Caves"
	icon_state = "centcom"
	requires_power = 0
	dynamic_lighting = 1
	base_turf = /turf/unsimulated/floor/exoplanet/barren/darker

/area/undersea/indoors_caves/flooded

/area/undersea/indoors_caves/flooded/Entered(mob/living/L)
	..()
	if(istype(L))
		L.overlay_fullscreen("underwater", /obj/screen/fullscreen/underwater)

/area/undersea/indoors_caves/flooded/Exited(mob/living/L)
	..()
	if(istype(L))
		L.clear_fullscreen("underwater")
