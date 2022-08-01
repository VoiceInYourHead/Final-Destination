/obj/effect/overmap/visitable/ship/landable/ares
	name = "GML Ares"
	shuttle = "Ares"
	desc = "Sensor array is detecting a mining vessel, property of Grayson Manufactories Ltd."
	moving_state = "ship_moving"
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 5000
	skill_needed = SKILL_ADEPT
	vessel_size = SHIP_SIZE_SMALL
	fore_dir = EAST
	color = "#6e0000"
	hide_from_reports = TRUE
	initial_restricted_waypoints = list(
		"Bluespace Residue" = list("nav_ares")
	)

/obj/machinery/computer/shuttle_control/explore/ares
	name = "vessel control console"
	shuttle_tag = "Ares"

/obj/effect/shuttle_landmark/ares
	name = "Ares Landing Zone"
	landmark_tag = "nav_ares"
	docking_controller = "ares_dock"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/datum/shuttle/autodock/overmap/ares
	name = "Ares"
	warmup_time = 3
	range = 1
	shuttle_area = list(/area/ship/ares/bridge, /area/ship/ares/interior, /area/ship/ares/kitchen, /area/ship/ares/bar, /area/ship/ares/mess_hall, /area/ship/ares/eng, /area/ship/ares/cargo, /area/ship/ares/mining, /area/ship/ares/janitor)
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/shuttle_ceiling
	current_location = "nav_ares"
