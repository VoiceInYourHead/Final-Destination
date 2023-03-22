// Jinx

/area/jinx
	name = "\improper Jinx"
	icon_state = "shuttle"

/area/jinx/main
	name = "\improper Jinx Airlock Compartment"

/area/jinx/cockpit
	name = "\improper Jinx Cockpit"

/area/jinx/engine
	name = "\improper Jinx Engine"

/obj/effect/overmap/visitable/ship/landable/jinx
	name = "Jinx"
	shuttle = "Jinx"
	desc = "Sensor array detects a small Vessel of unknown origin with the ability to hide in any space."
	fore_dir = NORTH
	color = "#0751f3"
	alpha = 30
	integrity_failure_cap = 50
	skill_needed = SKILL_BASIC
	vessel_mass = 750
	vessel_size = SHIP_SIZE_SMALL

/obj/machinery/computer/shuttle_control/explore/jinx
	name = "landing control console"
	shuttle_tag = "Jinx"

/datum/shuttle/autodock/overmap/jinx
	name = "Jinx"
	move_time = 20
	shuttle_area = list(/area/jinx/main, /area/jinx/cockpit, /area/jinx/engine)
	current_location = "nav_hangar_jinx"
	landmark_transition = "nav_transit_jinx"
	range = 0 //range = 2
	fuel_consumption = 1
//	logging_home_tag = "nav_hangar_jinx"
	ceiling_type = /turf/simulated/floor/shuttle_ceiling
	flags = SHUTTLE_FLAGS_PROCESS
	defer_initialisation = TRUE

/obj/effect/shuttle_landmark/jinx
	name = "jinx Hangar"
	landmark_tag = "nav_hangar_jinx"
//	docking_controller = "jinx_shuttle_dock_airlock"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/transit/jinx
	name = "In transit"
	landmark_tag = "nav_transit_jinx"
