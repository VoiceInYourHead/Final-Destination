/obj/effect/overmap/visitable/sector/snow_cage
	name = "arctic planet"
	desc = "An arctic planet with a small number of signatures on the surface. Scans indicate non-natural structures under the planet's surface."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	initial_generic_waypoints = list(
		"nav_snowcage_1",
		"nav_snowcage_2",
		"nav_snowcage_3"
	)

/datum/map_template/ruin/away_site/snow_cage
	name = "arctic planet"
	id = "awaysite_splanet"
	spawn_cost = 1000 //NO BITCHES??
	player_cost = 2
	description = "An arctic planet with a small number of signatures on the surface. Scans indicate non-natural structures under the planet's surface."
	suffixes = list("snow_cage/snow_cage-1.dmm","snow_cage/snow_cage-2.dmm","snow_cage/snow_cage-3.dmm","snow_cage/snow_cage-4.dmm")
	area_usage_test_exempted_root_areas = list(/area/splanet/)
	apc_test_exempt_areas = list(
		/area/splanet/outdoors = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/splanet/underground = NO_SCRUBBER|NO_VENT|NO_APC
	)

/obj/effect/shuttle_landmark/nav_splanet/nav1
	name = "Forest Landing Point #1"
	landmark_tag = "nav_splanet_1"
	base_area = /area/splanet/outdoors

/obj/effect/shuttle_landmark/nav_splanet/nav2
	name = "Forest Landing Point #2"
	landmark_tag = "nav_splanet_2"
	base_area = /area/splanet/outdoors

/obj/effect/shuttle_landmark/nav_splanet/nav3
	name = "Forest Landing Point #3"
	landmark_tag = "nav_splanet_3"
	base_area = /area/splanet/outdoors

/area/splanet/outdoors
	name = "arctic forest"
	icon_state = "centcom"
	dynamic_lighting = 1
	base_turf = /turf/unsimulated/floor/exoplanet/barren
	screen_filter = /obj/screenfilter/snow

/area/splanet/underground
	name = "Ascent crashsite"
	base_turf = /turf/unsimulated/floor/exoplanet/barren