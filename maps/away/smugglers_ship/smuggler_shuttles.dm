/obj/effect/overmap/visitable/ship/landable/smuggler
	name = "FTV Miss Fortune"
	shuttle = "Smuggler"
	desc = "Sensor array is detecting a small cargo vessel, broadcasting FTU codes and the designation \"FTV Prosperity, 13-1-OL\"."
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 9000
	integrity_failure_cap = 80
	skill_needed = SKILL_ADEPT
	vessel_size = SHIP_SIZE_SMALL
	fore_dir = EAST
	dir = EAST
	hide_from_reports = TRUE
	known = 0
	initial_restricted_waypoints = list(
		"Bluespace Residue" = list("nav_smuggler")
	)

/obj/machinery/computer/shuttle_control/explore/smuggler
	name = "vessel control console"
	shuttle_tag = "Smuggler"

/obj/effect/shuttle_landmark/smuggler
	name = "Smuggler Landing Zone"
	landmark_tag = "nav_smuggler"
	docking_controller = "smuggler_dock"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/datum/shuttle/autodock/overmap/smuggler
	name = "Smuggler"
	warmup_time = 3
	range = 0 //range = 1
	shuttle_area = list(/area/ship/smuggler/generator, /area/ship/smuggler/kitchen, /area/ship/smuggler/eng, /area/ship/smuggler/engine, /area/ship/smuggler/rw, /area/ship/smuggler/lw, /area/ship/smuggler/bar, /area/ship/smuggler/bridge, /area/ship/smuggler/container, /area/ship/smuggler/living, /area/ship/smuggler/med)
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/shuttle_ceiling
	current_location = "nav_smuggler"
