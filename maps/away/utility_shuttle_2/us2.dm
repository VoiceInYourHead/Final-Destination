#include "shuttles.dm"


/obj/effect/overmap/visitable/sector/utility_shuttle_2
	name = "Bluespace Residue"
	desc = "/ERROR/."
	icon_state = "event"
	hide_from_reports = TRUE
	sector_flags = OVERMAP_SECTOR_IN_SPACE | OVERMAP_SECTOR_UNTARGETABLE

/obj/effect/shuttle_landmark/us2
	name = "Bluespace Residue"
	landmark_tag = "us2"
	docking_controller = "us2_shuttle_dock_airlock"
	base_turf = /turf/space
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/datum/map_template/ruin/away_site/us2
	name = "Utility Shuttle 2"
	id = "utility_shuttle_2"
	description = "Small capsule-like spacecraft with minimum capacity."
	suffixes = list("utility_shuttle_2/us2.dmm")
	spawn_cost = 1000
	area_usage_test_exempted_root_areas = list(/area/ship/utility_shuttle_2)
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/us2)

/area/ship/utility_shuttle_2
	name = "Shuttle's interior 2"
	icon_state = "bridge"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED
	req_access = list()