#include "providence_areas.dm"
#include "providence_jobs.dm"
#include "providence_shuttles.dm"

// Map template data.
/datum/map_template/ruin/away_site/providence
	name = "ITV Providence"
	id = "awaysite_trucker"
	description = "."
	suffixes = list("itv_providence/providence.dmm")
	spawn_cost = 1 // NO BITCHES???
	area_usage_test_exempted_root_areas = /area/ship/providence
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/providence)

/obj/effect/overmap/visitable/sector/providence
	name = "Bluespace Residue"
	desc = "/ERROR/."
	icon_state = "event"
	hide_from_reports = TRUE

/obj/effect/submap_landmark/joinable_submap/providence
	name = "ITV Providence"
	archetype = /decl/submap_archetype/providence