/obj/effect/overmap/visitable/ship/landable/ascent_gunboat
	name = "Ascent Gunboat"
	shuttle = "Ascent Gunboat"
	desc = "Wake signature indicates an armed vessel of unknown design."
	moving_state = "ship_moving"
	max_speed = 0.6/(2 SECONDS)
	vessel_mass = 6000
	integrity_failure_cap = 120
	repair_speed = 0.01
	skill_needed = SKILL_ADEPT
	vessel_size = SHIP_SIZE_SMALL
	fore_dir = EAST
	dir = EAST
	color = COLOR_PURPLE
	known = 0
	hide_from_reports = TRUE
	initial_restricted_waypoints = list(
		"Plecopterax Landing Zone" = list("nav_ascent_gunboat_start")
	)

/obj/machinery/computer/shuttle_control/explore/ascent_gunboat
	name = "shuttle control console"
	shuttle_tag = "Ascent Gunboat"
	icon_state = "ascent"
	icon_keyboard = "ascent_key"
	icon_screen = "ascent_screen"
	req_access = list(access_ascent)

/obj/effect/shuttle_landmark/ascent_gunboat
	name = "Ascent Gunboat Landing Zone"
	landmark_tag = "nav_ascent_gunboat_start"
	docking_controller = "ascent_gunboat_dock"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/datum/shuttle/autodock/overmap/ascent_gunboat
	name = "Ascent Gunboat"
	warmup_time = 6
	range = 1
	shuttle_area = list(/area/ship/ascent_gunboat/bridge, /area/ship/ascent_gunboat/wing_starboard, /area/ship/ascent_gunboat/wing_port, /area/ship/ascent_gunboat/fore_port, /area/ship/ascent_gunboat/fore_starboard, /area/ship/ascent_gunboat/engineering, /area/ship/ascent_gunboat/ofd, /area/ship/ascent_gunboat/aft_port, /area/ship/ascent_gunboat/aft_starboard, /area/ship/ascent_gunboat/stern_port, /area/ship/ascent_gunboat/stern_starboard, /area/ship/ascent_gunboat/port_jut, /area/ship/ascent_gunboat/starboard_jut, /area/ship/ascent_gunboat/atmos)
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/shuttle_ceiling/ascent
	current_location = "nav_ascent_gunboat_start"
