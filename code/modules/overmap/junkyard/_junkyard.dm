//GLOBAL_VAR(junkyard_repopulation_disabled)

/obj/effect/overmap/visitable/sector/junkyard
	name = "junkyard"
	icon_state = "junkyard"
	sector_flags = OVERMAP_SECTOR_KNOWN
	free_landing = TRUE
	var/area/junkyard_area
//	var/list/fauna_types = list()		// possible types of mobs to spawn
//	var/list/megafauna_types = list() 	// possibble types of megafauna to spawn
//	var/list/animals = list()
	var/max_animal_count = 40

	var/maxx
	var/maxy
	var/landmark_type = /obj/effect/shuttle_landmark/automatic

	var/vessel_mass = 20000

//	var/repopulating = FALSE
//	var/repopulate_types = list() // animals which have died that may come back

	var/list/possible_themes = list(
		/datum/junkyard_theme/robotic_guardians = 45
		)
	var/list/themes = list()

	var/list/map_generators = list()

	//Flags deciding what features to pick
	var/ruin_tags_whitelist
	var/ruin_tags_blacklist = RUIN_RAINWORLD
	var/features_budget = 30
	var/list/possible_features = list()
	var/list/spawned_features

/obj/effect/overmap/visitable/sector/junkyard/New(nloc, max_x, max_y)
	if (!GLOB.using_map.use_overmap)
		return

	maxx = max_x ? max_x : world.maxx
	maxy = max_y ? max_y : world.maxy

	var/junkyard_name = generate_junkyard_name()
	name = "[junkyard_name], \a [name]"

	junkyard_area = new junkyard_area()
	GLOB.using_map.area_purity_test_exempt_areas += junkyard_area.type
	junkyard_area.name = "Junkyard #[junkyard_name]"
	junkyard_area.assigned_junkyard = src

	INCREMENT_WORLD_Z_SIZE
	forceMove(locate(1,1,world.maxz))

	if (LAZYLEN(possible_themes))
		var/datum/junkyard_theme/T = pick(possible_themes)
		themes += new T
		possible_themes -= T

	for (var/datum/junkyard_theme/T in themes)
		if (T.ruin_tags_whitelist)
			ruin_tags_whitelist |= T.ruin_tags_whitelist
		if (T.ruin_tags_blacklist)
			ruin_tags_blacklist |= T.ruin_tags_blacklist

	for (var/T in subtypesof(/datum/map_template/ruin/junkyard))
		var/datum/map_template/ruin/junkyard/ruin = T
		if (ruin_tags_whitelist && !(ruin_tags_whitelist & initial(ruin.ruin_tags)))
			continue
		if (ruin_tags_blacklist & initial(ruin.ruin_tags))
			continue
		possible_features += new ruin
	..()

/obj/effect/overmap/visitable/sector/junkyard/proc/build_level()
	generate_map()
	generate_features()
	for (var/datum/junkyard_theme/T in themes)
		T.after_map_generation(src)
	generate_landing(2)
	START_PROCESSING(SSobj, src)

/*/obj/effect/overmap/visitable/sector/junkyard/Process(wait, tick)
	if (animals.len < 0.5*max_animal_count && !repopulating)
		repopulating = TRUE
		max_animal_count = max_animal_count

	for (var/zlevel in map_z)
		if (repopulating && !GLOB.junkyard_repopulation_disabled)
			handle_repopulation()*/

/obj/effect/overmap/visitable/sector/junkyard/proc/generate_map()

	for (var/datum/junkyard_theme/T in themes)
		T.before_map_generation(src)
	for (var/zlevel in map_z)
		var/list/edges
		edges += block(locate(1, 1, zlevel), locate(TRANSITIONEDGE, maxy, zlevel))
		edges |= block(locate(maxx-TRANSITIONEDGE, 1, zlevel),locate(maxx, maxy, zlevel))
		edges |= block(locate(1, 1, zlevel), locate(maxx, TRANSITIONEDGE, zlevel))
		edges |= block(locate(1, maxy-TRANSITIONEDGE, zlevel),locate(maxx, maxy, zlevel))
		for (var/turf/T in edges)
			T.ChangeTurf(/turf/unsimulated/junkyard_edge)
		var/padding = TRANSITIONEDGE
		for (var/map_type in map_generators)
			if (ispath(map_type, /datum/random_map/noise/junkyard))
				new map_type(null,padding,padding,zlevel,maxx-padding,maxy-padding,0,1,1,junkyard_area)
			else
				new map_type(null,1,1,zlevel,maxx,maxy,0,1,1,junkyard_area)

/obj/effect/overmap/visitable/sector/junkyard/proc/generate_features()
	spawned_features = seedRuins(map_z, features_budget, possible_features, /area/junkyard, maxx, maxy)

/obj/effect/landmark/junkyard_spawn/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/landmark/junkyard_spawn/LateInitialize()
	. = ..()
//	var/obj/effect/overmap/visitable/sector/junkyard/E = map_sectors["[z]"]
/*	if (istype(E))
		do_spawn(E)*/

//Tries to generate num landmarks, but avoids repeats.
/obj/effect/overmap/visitable/sector/junkyard/proc/generate_landing(num = 1)
	var/places = list()
	var/attempts = 30*num
	var/new_type = landmark_type
	while(num)
		attempts--
		var/turf/T = locate(rand(TRANSITIONEDGE + LANDING_ZONE_RADIUS, maxx - TRANSITIONEDGE - LANDING_ZONE_RADIUS), rand(TRANSITIONEDGE + LANDING_ZONE_RADIUS, maxy - TRANSITIONEDGE - LANDING_ZONE_RADIUS),map_z[map_z.len])
		if (!T || (T in places)) // Two landmarks on one turf is forbidden as the landmark code doesn't work with it.
			continue
		if (attempts >= 0) // While we have the patience, try to find better spawn points. If out of patience, put them down wherever, so long as there are no repeats.
			var/valid = TRUE
			var/list/block_to_check = block(locate(T.x - LANDING_ZONE_RADIUS, T.y - LANDING_ZONE_RADIUS, T.z), locate(T.x + LANDING_ZONE_RADIUS, T.y + LANDING_ZONE_RADIUS, T.z))
			for (var/turf/check in block_to_check)
				if (!istype(get_area(check), /area/junkyard) || check.turf_flags & TURF_FLAG_NORUINS)
					valid = FALSE
					break
			if (attempts >= 10)
				if (check_collision(T.loc, block_to_check)) //While we have lots of patience, ensure landability
					valid = FALSE
			else //Running out of patience, but would rather not clear ruins, so switch to clearing landmarks and bypass landability check
				new_type = /obj/effect/shuttle_landmark/automatic/clearing

			if (!valid)
				continue

		num--
		places += T
		new new_type(T)

/obj/effect/overmap/visitable/sector/junkyard/get_scan_data(mob/user)
	. = ..()
	var/list/extra_data = list("<hr>")

/*	if (animals.len && user.skill_check(SKILL_SCIENCE, SKILL_BASIC))
		extra_data += "Life traces detected"*/

	for (var/datum/junkyard_theme/T in themes)
		if (T.get_sensor_data())
			extra_data += T.get_sensor_data()
	. += jointext(extra_data, "<br>")

/area/junkyard
	name = "\improper Junkyard"
	always_unpowered = TRUE
	area_flags = AREA_FLAG_EXTERNAL
	junkyard_surface = TRUE

	has_gravity = FALSE
