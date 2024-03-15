/obj/effect/overmap/visitable/sector/city
	name = "City"
	desc = "A urban area."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	color = "gray"
	initial_generic_waypoints = list()

/datum/map_template/ruin/away_site/city
	name = "City"
	id = "awaysite_psycho_city"
	spawn_cost = 1000 //NO BITCHES??
	player_cost = 4
	description = "PSY City. For events only."
	suffixes = list("psycho_away2/city_street-1.dmm")
	area_usage_test_exempted_root_areas = list(/area/psionic_school)
	apc_test_exempt_areas = list(
		/area/psionic_school = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/psionic_school/outdoor = NO_SCRUBBER|NO_VENT|NO_APC
	)

/obj/effect/submap_landmark/joinable_submap/city_psi
	name = "City"
	archetype = /decl/submap_archetype/city_psi

/decl/submap_archetype/city_psi
	descriptor = "City Psi"
	map = "City"
	crew_jobs = list(/datum/job/submap/city_psi/psi_student)

/datum/job/submap/city_psi/psi_student
	title = "New Student"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/city_psi/psi_student
	name = "New Student"