/obj/effect/turf_fire/endless
	fire_power = 30
	interact_with_atmos = FALSE
	passive_loss = FALSE

/area/psionic_school/outdoor/rainy
	screen_filter = /obj/screenfilter/rain
	ambience = list('sound/ambience/rainforest.ogg', 'sound/ambience/rainout.ogg')

/obj/structure/fd/placeholder/better/team1
	name = "TEAM 1"

/obj/structure/fd/placeholder/better/team2
	name = "TEAM 2"

/obj/structure/fd/placeholder/better/team3
	name = "TEAM 3"

/obj/structure/fd/placeholder/better/team4
	name = "TEAM 4"

/obj/effect/submap_landmark/joinable_submap/escape_route
	name = "Season Ending"
	archetype = /decl/submap_archetype/escape_route

/decl/submap_archetype/escape_route
	descriptor = "Season Ending"
	map = "Season Ending"
	crew_jobs = list(
		/datum/job/submap/camp/ardent,
		/datum/job/submap/camp/maxim,
		/datum/job/submap/camp/okita,
		/datum/job/submap/camp/numerius,
		/datum/job/submap/camp/akira,
		/datum/job/submap/camp/manea,
		/datum/job/submap/camp/trueman,

		/datum/job/submap/camp/vivian,
		/datum/job/submap/camp/mara,
		/datum/job/submap/camp/demetra,

		/datum/job/submap/camp/teacher1,
		/datum/job/submap/camp/teacher2,
		/datum/job/submap/camp/teacher3,
		/datum/job/submap/camp/cook,
		/datum/job/submap/camp/doctor
	)

/obj/effect/overmap/visitable/sector/psyonic_school_ruins2
	name = "jungle planet 5"
	desc = "A jungle planet."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	color = "#6db8b8"
	initial_generic_waypoints = list()

	var/list/lightup
	var/lightlevel = 0.3 //This default makes turfs not generate light. Adjust to have exoplanents be lit.

/obj/effect/overmap/visitable/sector/psyonic_school_ruins2/Initialize()
	..()

	lightup = block(locate(world.maxx, world.maxy, max(map_z)), locate(1, 1, min(map_z)))
	for(var/atom/A as anything in lightup)
		if(!istype(A.loc, /area/psionic_school/outdoor) || A.density || istype(A.loc, /area/psionic_school/outdoor/cave))
			lightup -= A
	update_daynight()

/obj/effect/overmap/visitable/sector/psyonic_school_ruins2/proc/update_daynight(light = 0.4, light_color = "#5c5c5c")
	for(var/turf/T as anything in lightup)
		T.set_light(light, 0.1, 2, l_color = light_color)

/datum/map_template/ruin/away_site/psyonic_school_ruins2
	name = "Jungle Planet 5 (2-z-lvls ruins)"
	id = "awaysite_psyruins2"
	spawn_cost = 1000 //NO BITCHES??
	player_cost = 4
	description = "PSY ruins with 2 z-lvls. For events only."
	suffixes = list("psycho_away5/ruins-1.dmm", "psycho_away5/ruins-2.dmm", "psycho_away5/ruins-3.dmm")
	area_usage_test_exempted_root_areas = list(/area/psionic_school)
	apc_test_exempt_areas = list(
		/area/psionic_school = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/psionic_school/outdoor = NO_SCRUBBER|NO_VENT|NO_APC
	)
