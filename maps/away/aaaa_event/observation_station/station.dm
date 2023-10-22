#include "station_areas.dm"
#include "station_presets.dm"

/obj/effect/overmap/visitable/sector/obs_station
	name = "observation station"
	desc = "This is orbital observation station."
	icon_state = "junkyard"
	known = 1

	initial_generic_waypoints = list(
		"obs_1"
	)

/datum/map_template/ruin/away_site/obs_station
	name = "Observation Station"
	id = "obs"
	description = "An old Observation Station, hitted by bluespace anomaly"
	suffixes = list("aaaa_event/observation_station/station.dmm")
	spawn_cost = 999
	area_usage_test_exempted_root_areas = list(/area/fd/obs)
	apc_test_exempt_areas = list(
		/area/fd/obs = NO_SCRUBBER|NO_VENT
	)

/obj/effect/shuttle_landmark/obs
	name = "Observation Station"
	landmark_tag = "obs_1"
	base_area = /area/space