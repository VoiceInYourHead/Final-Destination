/obj/effect/overmap/visitable/ship/landable/clover/truck
	name = "TCGV-24 \"Odysseus\""
	shuttle = "TCGV-24"
	desc = "An old cargo craft, broadcasting clearly expired TCGSV codes and the callsign \"TCGV-24 ODYSSEUS\"."
	fore_dir = NORTH
	integrity_failure_cap = 30
	max_speed = 1/(2 SECONDS) //same stats as charon
	burn_delay = 1 SECONDS
	vessel_mass = 5000
	skill_needed = SKILL_BASIC
	free_landing = FALSE

/area/ship/clover/shuttle
	name = "\improper TCGV-24 \"Odysseus\""

/obj/machinery/computer/shuttle_control/explore/clover/truck
	name = "landing control console"
	shuttle_tag = "TCGV-24"

/datum/shuttle/autodock/overmap/clover
	name = "TCGV-24 \"Odysseus\""
	move_time = 20
	shuttle_area = list(/area/ship/clover/shuttle)
	current_location = "nav_dock_cs_1"
	landmark_transition = "nav_transit_cs_1"
	dock_target = "cs_1_shuttle_dock"
	range = 0 //range = 2
	fuel_consumption = 1
	ceiling_type = /turf/simulated/floor/shuttle_ceiling/heist
	flags = SHUTTLE_FLAGS_PROCESS
	defer_initialisation = TRUE

/obj/effect/shuttle_landmark/clover/truck
	name = "TCGV-24 \"Odysseus\" docking port"
	landmark_tag = "nav_dock_cs_1"
	docking_controller = "cs_1_shuttle_dock"
	base_area = /area/ship/clover/modules/m5

/obj/effect/shuttle_landmark/transit/clover/truck
	name = "In transit"
	landmark_tag = "nav_transit_cs_1"