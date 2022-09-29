#include "ascent_areas.dm"
#include "ascent_jobs.dm"

/obj/structure/wall_frame/titanium/ascent
	paint_color = COLOR_PURPLE

/obj/effect/wallframe_spawn/reinforced_phoron/titanium/ascent
	frame_path = /obj/structure/wall_frame/titanium/ascent

// Map template data.
/datum/map_template/ruin/away_site/ascent_corvette
	name = "Ascent Corvette"
	id = "awaysite_ascent_corvette"
	description = "An Ascent Corvette with average crew."
	suffixes = list("ascent_corvette/corvette-1.dmm", "ascent_corvette/corvette-2.dmm")
	area_usage_test_exempted_areas = list(
		/area/ship/ascent_corvette
	)
	spawn_cost = 1000 // Сегодня без спавна :d ~danilcus
	player_cost = 4 // Нынешнее значение основано на количестве игроков в авейке ~bear1ake

// Overmap objects.
/obj/effect/overmap/visitable/ship/ascent_corvette
	name = "Ascent Corvette"
	desc = "Wake signature indicates a small to medium sized vessel of unknown design."
	color = COLOR_PURPLE
	vessel_mass = 9000
	fore_dir = EAST
	max_speed = 0.6/(1 SECOND)
	hide_from_reports = TRUE
	known = 0

/obj/effect/submap_landmark/joinable_submap/ascent_corvette
	name = "Ascent Corvette"
	archetype = /decl/submap_archetype/ascent_corvette
	submap_datum_type = /datum/submap/ascent_corvette
