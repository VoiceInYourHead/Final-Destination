#include "trading_areas.dm"
#include "trading_jobs.dm"
#include "trading_shuttles.dm"

// Map template data.
/datum/map_template/ruin/away_site/trading
	name = "FTU Miss Fortune"
	id = "awaysite_smuggler"
	description = "."
	suffixes = list("smugglers_ship/smuggler.dmm")
	spawn_cost = 1000 // NO BITCHES???
	area_usage_test_exempted_root_areas = /area/ship/smuggler

/obj/effect/submap_landmark/joinable_submap/trading
	name = "FTU Miss Fortune"
	archetype = /decl/submap_archetype/smuggler

/obj/effect/shuttle_landmark/nav_trading/hangar
	name = "Hangar"
	landmark_tag = "nav_tradingstation_hangar"
	base_area =
	base_turf = /turf/simulated/floor/plating