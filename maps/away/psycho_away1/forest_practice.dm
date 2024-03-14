/obj/effect/overmap/visitable/sector/forest_practice
	name = "jungle planet 2"
	desc = "A jungle planet."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	color = "#6db8b8"
	initial_generic_waypoints = list()

	var/list/lightup
	var/lightlevel = 0.3 //This default makes turfs not generate light. Adjust to have exoplanents be lit.

/obj/effect/overmap/visitable/sector/forest_practice/Initialize()
	..()

	lightup = block(locate(world.maxx, world.maxy, max(map_z)), locate(1, 1, min(map_z)))
	for(var/atom/A as anything in lightup)
		if(!istype(A.loc, /area/psionic_school/outdoor) || A.density || istype(A.loc, /area/psionic_school/outdoor/cave))
			lightup -= A
	update_daynight()

/obj/effect/overmap/visitable/sector/forest_practice/proc/update_daynight(light = 0.7, light_color = "#e2d1b2")
	for(var/turf/T as anything in lightup)
		T.set_light(light, 0.1, 2, l_color = light_color)

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
