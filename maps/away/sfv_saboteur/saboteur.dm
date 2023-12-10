// Map template data.
/datum/map_template/ruin/away_site/saboteur_docking_ring
	name = "PM-14 Saboteur EW Interceptor"
	id = "awaysite_saboteur"
	description = "A small Sol interceptor with a single pilot."
	suffixes = list("sfv_saboteur/saboteur.dmm")
	area_usage_test_exempted_areas = list(
		/area/ship/saboteur
	)
	spawn_cost = 1000
	player_cost = 4
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/saboteur)

/obj/effect/overmap/visitable/sector/saboteur_ring
	name = "Small Bluespace Signature"
	desc = "Bluespace trace, left by something small"
	icon_state = "event"
	hide_from_reports = TRUE
	sector_flags = OVERMAP_SECTOR_IN_SPACE | OVERMAP_SECTOR_UNTARGETABLE
	known = 0

/decl/submap_archetype/saboteur
	descriptor = "PM-14 Saboteur EW Interceptor"
	map = "PM-14 Saboteur EW Interceptor"
	blacklisted_species = null
	whitelisted_species = null
	crew_jobs = list(/datum/job/submap/saboteur/pilot)

/obj/effect/submap_landmark/joinable_submap/saboteur
	name = "PM-14 Saboteur EW Interceptor"
	archetype = /decl/submap_archetype/saboteur

/obj/machinery/computer/shuttle_control/explore/saboteur
	name = "shuttle control console"
	shuttle_tag = "PM-14 Saboteur EW Interceptor"

/obj/effect/shuttle_landmark/saboteur
	name = "Saboteur Landing Zone"
	landmark_tag = "nav_saboteur_start"
	docking_controller = "saboteur_dock"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/area/ship/saboteur
	name = "\improper PM-14 Saboteur EW Interceptor"
	icon_state = "bridge"

/obj/effect/overmap/visitable/ship/landable/saboteur
	name = "PM-14 Saboteur EW Interceptor"
	shuttle = "PM-14 Saboteur EW Interceptor"
	desc = "Wake signature indicates a small armed vessel, broadcasting registration codes \"SCGFV-7392-S-171\"."
	fore_dir = NORTH
	color = "#0751f3"
	integrity_failure_cap = 30
	skill_needed = SKILL_BASIC
	vessel_mass = 3000
	vessel_size = SHIP_SIZE_SMALL
	max_speed = 0.4/(2 SECONDS)
	burn_delay = 0.5 SECONDS
	hide_from_reports = TRUE
	known = 0
	initial_restricted_waypoints = list(
		"Saboteur Landing Zone" = list("nav_saboteur_start")
	)

/datum/shuttle/autodock/overmap/saboteur
	name = "PM-14 Saboteur EW Interceptor"
	warmup_time = 3
	range = 0 //range = 1
	shuttle_area = /area/ship/saboteur
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/reinforced
	current_location = "nav_saboteur_start"

/datum/job/submap/saboteur/pilot
	title = "Saboteur Pilot"
	info = "Your an pilot of SFV EW Interceptor."
	outfit_type = /decl/hierarchy/outfit/scg_pilot
	total_positions = 1

/obj/effect/submap_landmark/spawnpoint/saboteur/pilot
	name = "Saboteur Pilot"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE