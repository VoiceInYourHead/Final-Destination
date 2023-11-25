// Map template data.
/datum/map_template/ruin/away_site/comet_docking_ring
	name = "PM-07-L Comet Bomber"
	id = "awaysite_comet"
	description = "A small Sol bomber with a single pilot."
	suffixes = list("sfv_bomber/comet.dmm")
	area_usage_test_exempted_areas = list(
		/area/ship/comet
	)
	spawn_cost = 1000
	player_cost = 4
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/comet)

/obj/effect/overmap/visitable/sector/comet_ring
	name = "Small Bluespace Signature"
	desc = "Bluespace trace, left by something small"
	icon_state = "event"
	hide_from_reports = TRUE
	sector_flags = OVERMAP_SECTOR_IN_SPACE | OVERMAP_SECTOR_UNTARGETABLE
	known = 0

/decl/submap_archetype/comet
	descriptor = "PM-07-L Comet Bomber"
	map = "PM-07-L Comet Bomber"
	blacklisted_species = null
	whitelisted_species = null
	crew_jobs = list(/datum/job/submap/comet/pilot)

/obj/effect/submap_landmark/joinable_submap/comet
	name = "PM-07-L Comet Bomber"
	archetype = /decl/submap_archetype/comet

/obj/machinery/computer/shuttle_control/explore/comet
	name = "shuttle control console"
	shuttle_tag = "PM-07-L Comet Bomber"

/obj/effect/shuttle_landmark/comet
	name = "Comet Landing Zone"
	landmark_tag = "nav_comet_bomber_start"
	docking_controller = "comet_bomber_dock"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/area/ship/comet
	name = "\improper PM-07-L Comet Bomber"
	icon_state = "bridge"

/obj/effect/overmap/visitable/ship/landable/comet
	name = "PM-07-L Comet Bomber"
	shuttle = "PM-07-L Comet Bomber"
	desc = "Wake signature indicates a small armed vessel, broadcasting registration codes \"SCGFV-3563-S-371\"."
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
		"Comet Landing Zone" = list("nav_comet_bomber_start")
	)

/datum/shuttle/autodock/overmap/comet
	name = "PM-07-L Comet Bomber"
	warmup_time = 3
	range = 0 //range = 1
	shuttle_area = /area/ship/comet
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/reinforced
	current_location = "nav_comet_bomber_start"

/datum/job/submap/comet/pilot
	title = "Comet Pilot"
	info = "Your an pilot of SFV Bomber."
	outfit_type = /decl/hierarchy/outfit/scg_pilot
	total_positions = 1

/obj/effect/submap_landmark/spawnpoint/comet/pilot
	name = "Comet Pilot"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE