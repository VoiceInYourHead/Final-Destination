#include "delman_radio.dm"

// Map template data.
/datum/map_template/ruin/away_site/delman_docking_ring
	name = "PM-23 'Delman' Dropship"
	id = "awaysite_delman"
	description = "Army dropship that can bring to planet up to Platoon(42) and 4 Vehicle."
	suffixes = list("sfv_dropship/delman.dmm")
	area_usage_test_exempted_areas = list(
		/area/ship/delman,
		/area/ship/delman/central,
		/area/ship/delman/rightwing,
		/area/ship/delman/leftwing,
		/area/ship/delman/cockpit,
		/area/ship/delman/engibay
	)
	spawn_cost = 1000
	player_cost = 4
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/delman)

/obj/effect/overmap/visitable/sector/delman_ring
	name = "Small Bluespace Signature"
	desc = "Bluespace trace, left by something small"
	icon_state = "event"
	hide_from_reports = TRUE
	sector_flags = OVERMAP_SECTOR_IN_SPACE | OVERMAP_SECTOR_UNTARGETABLE
	known = 0
	free_landing = FALSE

/obj/machinery/computer/shuttle_control/explore/delman
	name = "shuttle control console"
	shuttle_tag = "PM-23 'Delman' Dropship"

/obj/effect/shuttle_landmark/delman
	name = "Delman Landing Zone"
	landmark_tag = "nav_delman_transport_start"
	docking_controller = "delman_transport_dock"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/shuttle_landmark/transit/delman
	name = "In transit"
	landmark_tag = "nav_transit_delman_transport"

/area/ship/delman/central
	name = "\improper PM-23 'Delman' Dropship | Central"
	icon_state = "bridge"

/area/ship/delman/cockpit
	name = "\improper PM-23 'Delman' Dropship | Cockpit "
	icon_state = "bridge_hall"

/area/ship/delman/rightwing
	name = "\improper PM-23 'Delman' Dropship | Right Wing"
	icon_state = "yellow"

/area/ship/delman/leftwing
	name = "\improper PM-23 'Delman' Dropship | Left Wing"
	icon_state = "red"

/area/ship/delman/engibay
	name = "\improper PM-23 'Delman' Dropship | EngiBay "
	icon_state = "engine"

/obj/effect/overmap/visitable/ship/landable/delman
	name = "PM-23 'Delman' Dropship"
	shuttle = "PM-23 'Delman' Dropship"
	desc = "Wake signature indicates a small armed vessel, broadcasting registration codes \"SCGFV-3471-S-463\"."
	fore_dir = NORTH
	color = "#0751f3"
	alpha = 155
	integrity_failure_cap = 150
	skill_needed = SKILL_BASIC
	vessel_mass = 5500
	vessel_size = SHIP_SIZE_SMALL
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	hide_from_reports = TRUE
	known = 0
	initial_restricted_waypoints = list(
		"Delman Landing Zone" = list("nav_delman_transport_start")
	)

/datum/shuttle/autodock/overmap/delman
	name = "PM-23 'Delman' Dropship"
	warmup_time = 3
	range = 0
	shuttle_area = list(
//		/area/ship/delman,
		/area/ship/delman/central,
		/area/ship/delman/rightwing,
		/area/ship/delman/leftwing,
		/area/ship/delman/cockpit,
		/area/ship/delman/engibay
	)
	defer_initialisation = TRUE
	landmark_transition = "nav_transit_delman_transport"
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/reinforced
	current_location = "nav_delman_transport_start"
