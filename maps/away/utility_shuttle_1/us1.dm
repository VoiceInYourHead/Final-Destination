#include "shuttles.dm"


/obj/effect/overmap/visitable/sector/utility_shuttle_1
	name = "Bluespace Residue"
	desc = "/ERROR/."
	icon_state = "event"
	hide_from_reports = TRUE
	sector_flags = OVERMAP_SECTOR_IN_SPACE | OVERMAP_SECTOR_UNTARGETABLE

/obj/effect/shuttle_landmark/us1
	name = "Bluespace Residue"
	landmark_tag = "us1"
	docking_controller = "us1_shuttle_dock_airlock"
	base_turf = /turf/space
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/datum/map_template/ruin/away_site/us1
	name = "Utility Shuttle 1"
	id = "utility_shuttle_1"
	description = "Small capsule-like spacecraft with minimum capacity."
	suffixes = list("utility_shuttle_1/us1.dmm")
	spawn_cost = 1000
	area_usage_test_exempted_root_areas = list(/area/ship/utility_shuttle_1)
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/us1)

/area/ship/utility_shuttle_1
	name = "Shuttle's interior"
	icon_state = "bridge"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED
	req_access = list()