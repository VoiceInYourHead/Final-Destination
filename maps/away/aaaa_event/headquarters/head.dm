#include "head_radio.dm"
#include "head_agents.dm"
/obj/effect/overmap/visitable/sector/aaaa_head
	name = "Bureau 12 Headquarters"
	desc = "..."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	color = "#6db8b8"
	initial_generic_waypoints = list("nav_aaaa_1")

/obj/effect/submap_landmark/joinable_submap/aaaa_head
	name = "Bureau 12 Headquarters"
	archetype = /decl/submap_archetype/aaaa_head

/decl/submap_archetype/aaaa_head
	descriptor = "Bureau 12 Headquarters"
	map = "Bureau 12 Headquarters"
	crew_jobs = list(
		/datum/job/submap/aaaa_head/agent,
		/datum/job/submap/aaaa_head/agent/leader,
		/datum/job/submap/aaaa_head/robot,
	)

/obj/effect/shuttle_landmark/nav_aaaa/nav1
	name = "Bureau 12 Headquarters Navpoint #1"
	landmark_tag = "nav_aaaa_1"

/datum/map_template/ruin/away_site/aaaa_head
	name = "Bureau 12 Headquarters"
	id = "awaysite_aaaa_head"
	description = "Bureau 12 Headquarters"
	suffixes = list("/aaaa_event/headquarters/head-1.dmm", "/aaaa_event/headquarters/head-2.dmm")
	spawn_cost = 999
	player_cost = 6
	area_usage_test_exempted_root_areas = list(/area/fd/aaaa_head)
	shuttles_to_initialise = list(/datum/shuttle/autodock/ferry/aaaa_head)
	apc_test_exempt_areas = list(
		/area/fd/aaaa_head = NO_SCRUBBER|NO_VENT|NO_APC
	)

/area/fd/aaaa_head
	name = "\improper Bureau 12 Headquarters"
	icon_state = "centcom"
	requires_power = 0
	dynamic_lighting = 1

/area/fd/aaaa_head/up
/area/fd/aaaa_head/lift1

//elevator

/obj/machinery/computer/shuttle_control/lift/aaaa_head
	name = "Bureau 12 controls"
	shuttle_tag = "Bureau 12 lift"
	ui_template = "shuttle_control_console_lift.tmpl"
	icon_state = "tiny"
	icon_keyboard = "tiny_keyboard"
	icon_screen = "lift"
	density = FALSE

/datum/shuttle/autodock/ferry/aaaa_head
	name = "Bureau 12 lift"
	shuttle_area = /area/fd/aaaa_head/lift1
	warmup_time = 3
	waypoint_station = "nav_aaaa_head_lift_top"
	waypoint_offsite = "nav_aaaa_head_lift_bottom"
	sound_takeoff = 'sound/effects/lift_heavy_start.ogg'
	sound_landing = 'sound/effects/lift_heavy_stop.ogg'
	ceiling_type = null
	knockdown = 0
	defer_initialisation = TRUE

/obj/effect/shuttle_landmark/lift/aaaa_head/top1
	name = "Top Deck"
	landmark_tag = "nav_aaaa_head_lift_top"
	base_area = /area/fd/aaaa_head
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/lift/aaaa_head/bottom1
	name = "Lower Deck"
	landmark_tag = "nav_aaaa_head_lift_bottom"
	flags = SLANDMARK_FLAG_AUTOSET
	base_area = /area/fd/aaaa_head
	base_turf = /turf/simulated/floor/plating
