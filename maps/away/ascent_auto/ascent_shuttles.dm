/obj/effect/overmap/visitable/ship/landable/ascent_auto
	name = "Ascent Scout Drone"
	shuttle = "Ascent Scout Drone"
	desc = "Wake signature indicates a small armed vessel of unknown design."
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 1500
	integrity_failure_cap = 30
	skill_needed = SKILL_BASIC
	vessel_size = SHIP_SIZE_TINY
	fore_dir = NORTH
	known = 0
	color = COLOR_PURPLE
	hide_from_reports = TRUE
	initial_restricted_waypoints = list(
		"Scout Drone Landing Zone" = list("nav_ascent_auto_start")
	)

/obj/machinery/computer/shuttle_control/explore/ascent_auto
	name = "shuttle control console"
	shuttle_tag = "Ascent Scout Drone"
	icon_state = "ascent"
	icon_keyboard = "ascent_key"
	icon_screen = "ascent_screen"
	req_access = list(access_ascent)

/obj/effect/shuttle_landmark/ascent_auto
	name = "Scout Drone Landing Zone"
	landmark_tag = "nav_ascent_auto_start"
	docking_controller = "ascent_auto_dock"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/datum/shuttle/autodock/overmap/ascent_auto
	name = "Ascent Scout Drone"
	warmup_time = 3
	range = 1
	shuttle_area = /area/ship/ascent_auto
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/shuttle_ceiling/ascent
	current_location = "nav_ascent_auto_start"
