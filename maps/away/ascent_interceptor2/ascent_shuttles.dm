/obj/effect/overmap/visitable/ship/landable/ascent_interceptor2
	name = "Ascent Interceptor"
	shuttle = "Ascent Interceptor(2)"
	desc = "Wake signature indicates a small armed vessel of unknown design."
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 3000
	integrity_failure_cap = 60
	skill_needed = SKILL_BASIC
	vessel_size = SHIP_SIZE_TINY
	fore_dir = NORTH
	known = 0
	color = COLOR_PURPLE
	hide_from_reports = TRUE
	initial_restricted_waypoints = list(
		"Interceptor(2) Landing Zone" = list("nav_ascent_interceptor_2_start")
	)

/obj/machinery/computer/shuttle_control/explore/ascent_interceptor2
	name = "shuttle control console"
	shuttle_tag = "Ascent Interceptor(2)"
	icon_state = "ascent"
	icon_keyboard = "ascent_key"
	icon_screen = "ascent_screen"
	req_access = list(access_ascent)

/obj/effect/shuttle_landmark/ascent_interceptor2
	name = "Interceptor(2) Landing Zone"
	landmark_tag = "nav_ascent_interceptor2_start"
	docking_controller = "ascent_interceptor2_dock"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/datum/shuttle/autodock/overmap/ascent_interceptor2
	name = "Ascent Interceptor(2)"
	warmup_time = 3
	range = 1
	shuttle_area = /area/ship/ascent_interceptor2
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/shuttle_ceiling/ascent
	current_location = "nav_ascent_interceptor2_start"
