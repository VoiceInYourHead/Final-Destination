/obj/effect/overmap/visitable/ship/landable/glasburg
	name = "GCDV Glasburg"
	shuttle = "Glasburg"
	desc = "Sensor array detects a small unarmed vessel, claiming to be 'GCDV Glasburg' - a diplomatic shuttle that belongs to ICCG state. Seem's like it wasn't designed for deep space travel."
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 2500
	integrity_failure_cap = 35
	skill_needed = SKILL_ADEPT
	vessel_size = SHIP_SIZE_SMALL
	fore_dir = NORTH
	color = "#940004"
	hide_from_reports = TRUE
	initial_restricted_waypoints = list(
		"Ruined Bluespace Jump Ring" = list("nav_glasburg")
	)

/obj/effect/overmap/visitable/ship/landable/glasburg/New(nloc, max_x, max_y)
	name = "GCDV Glasburg"
	..()

/obj/machinery/computer/shuttle_control/explore/glasburg
	name = "shuttle control console"
	shuttle_tag = "Glasburg"

/datum/shuttle/autodock/overmap/glasburg
	name = "Glasburg"
	fuel_consumption = 2
	range = 0 //range = 1
	shuttle_area = /area/ship/glasburg
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	landmark_transition = "nav_transit_glasburg"
	ceiling_type = /turf/simulated/floor/shuttle_ceiling
	current_location = "nav_glasburg"