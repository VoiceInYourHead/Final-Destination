/obj/effect/overmap/visitable/ship/landable/ascent_fighter
	name = "Ascent Fighter"
	shuttle = "Ascent Fighter"
	desc = "Wake signature indicates a small armed vessel of unknown design."
	max_speed = 0.4/(2 SECONDS)
	burn_delay = 0.5 SECONDS
	vessel_mass = 1500
	integrity_failure_cap = 20
	skill_needed = SKILL_ADEPT
	vessel_size = SHIP_SIZE_TINY
	fore_dir = NORTH
	color = COLOR_PURPLE
	hide_from_reports = TRUE
	known = 0
	initial_restricted_waypoints = list(
		"Fighter Landing Zone" = list("nav_ascent_fighter_start")
	)

/obj/machinery/computer/shuttle_control/explore/ascent_fighter
	name = "shuttle control console"
	shuttle_tag = "Ascent Fighter"
	icon_state = "ascent"
	icon_keyboard = "ascent_key"
	icon_screen = "ascent_screen"
	req_access = list(access_ascent)

/obj/effect/shuttle_landmark/ascent_fighter
	name = "Fighter Landing Zone"
	landmark_tag = "nav_ascent_fighter_start"
	docking_controller = "ascent_fighter_dock"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/datum/shuttle/autodock/overmap/ascent_fighter
	name = "Ascent Fighter"
	warmup_time = 3
	range = 1
	shuttle_area = /area/ship/ascent_fighter
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/shuttle_ceiling/ascent
	current_location = "nav_ascent_fighter_start"
