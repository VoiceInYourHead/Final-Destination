/obj/effect/overmap/visitable/sector/forest_practice
	name = "jungle planet 2"
	desc = "A jungle planet."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	color = "#6db8b8"
	initial_generic_waypoints = list()

/datum/map_template/ruin/away_site/forest_practice
	name = "Jungle Planet 2"
	id = "awaysite_forest_practice"
	spawn_cost = 1000 //NO BITCHES??
	player_cost = 4
	description = "PSY forest. For events only."
	suffixes = list("psycho_away1/forest_practice-1.dmm", "psycho_away1/forest_practice-2.dmm", "psycho_away1/forest_practice-3.dmm", "psycho_away1/forest_practice-4.dmm")
	area_usage_test_exempted_root_areas = list(/area/psionic_school)
	apc_test_exempt_areas = list(
		/area/psionic_school = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/psionic_school/outdoor = NO_SCRUBBER|NO_VENT|NO_APC
	)