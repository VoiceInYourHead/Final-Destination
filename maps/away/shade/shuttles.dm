/obj/effect/overmap/visitable/ship/landable/shade
	name = "GMMV Shade"
	shuttle = "Shade"
	desc = "Sensor array is detecting a small mining vessel, property of Grayson Manufactories Ltd."
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 3000
	integrity_failure_cap = 35
	skill_needed = SKILL_BASIC
	vessel_size = SHIP_SIZE_SMALL
	fore_dir = NORTH
	color = "#6e0000"
	hide_from_reports = TRUE
	known = 0
	initial_restricted_waypoints = list(
		"Bluespace Residue" = list("nav_shade")
	)

/obj/effect/overmap/visitable/ship/landable/shade/New(nloc, max_x, max_y)
	name = "GML Shade"
	..()

/obj/machinery/computer/shuttle_control/explore/shade
	name = "shuttle control console"
	shuttle_tag = "Shade"

/datum/shuttle/autodock/overmap/shade
	name = "Shade"
	range = 0 //range = 1
	shuttle_area = /area/ship/shade
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/shuttle_ceiling
	current_location = "nav_shade"
