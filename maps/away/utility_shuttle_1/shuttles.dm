/obj/effect/overmap/visitable/ship/landable/utility_shuttle_1
	name = "Utility Shuttle"
	shuttle = "US1"
	desc = "Small capsule-like spacecraft with minimum capacity."
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 1500
	integrity_failure_cap = 30
	skill_needed = SKILL_BASIC
	vessel_size = SHIP_SIZE_TINY
	fore_dir = NORTH
	color = "#6e0000"
	hide_from_reports = TRUE
	known = 0
	initial_restricted_waypoints = list(
		"Bluespace Residue" = list("us1")
	)


/obj/machinery/computer/shuttle_control/explore/us1
	name = "shuttle control console"
	shuttle_tag = "US1"

/datum/shuttle/autodock/overmap/us1
	name = "US1"
	range = 0 //range = 1
	shuttle_area = /area/ship/utility_shuttle_1
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/shuttle_ceiling
	current_location = "us1"
