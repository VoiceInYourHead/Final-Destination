#include "ascent_areas.dm"
#include "ascent_jobs.dm"
#include "ascent_shuttles.dm"

/obj/structure/wall_frame/titanium/ascent
	paint_color = COLOR_PURPLE

/obj/effect/wallframe_spawn/reinforced_phoron/titanium/ascent
	frame_path = /obj/structure/wall_frame/titanium/ascent

// Map template data.
/datum/map_template/ruin/away_site/ascent_gunboat_docking_ring
	name = "Ascent Gunboat"
	id = "awaysite_ascent_gunboat"
	description = "An Ascent Gunboat with average crew."
	suffixes = list("ascent_gunboat/gunboat.dmm")
	area_usage_test_exempted_areas = list(
		/area/ship/ascent_gunboat
	)
	spawn_cost = 1000 // Сегодня без спавна :d ~danilcus
	player_cost = 4 // Нынешнее значение основано на количестве игроков в авейке ~bear1ake
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/ascent_gunboat)

/obj/effect/overmap/visitable/sector/ascent_gunboat_ring
	name = "Ruined Bluespace Jump Ring"
	desc = "A ruined jumpdrive ring of Ascent design, used to transport individual ships at FTL speeds."
	icon_state = "event"
	hide_from_reports = TRUE

/obj/effect/submap_landmark/joinable_submap/ascent_gunboat
	name = "Ascent Gunboat"
	archetype = /decl/submap_archetype/ascent_gunboat
	submap_datum_type = /datum/submap/ascent_gunboat

/obj/effect/submap_landmark/joinable_submap/ascent_gunboat/Initialize(mapload)
	var/list/all_elements = list(
		"Hydrogen",      "Helium",     "Lithium",     "Beryllium",    "Carbon",       "Nitrogen",      "Oxygen",
		"Fluorine",      "Neon",       "Sodium",      "Magnesium",    "Silicon",      "Phosphorus",    "Sulfur",
		"Chlorine",      "Argon",      "Potassium",   "Calcium",      "Scandium",     "Titanium",      "Chromium",
		"Manganese",     "Iron",       "Cobalt",      "Nickel",       "Zinc",         "Gallium",       "Germanium",
		"Arsenic",       "Selenium",   "Bromine",     "Krypton",      "Rubidium",     "Strontium",     "Zirconium",
		"Molybdenum",    "Technetium", "Ruthenium",   "Rhodium",      "Palladium",    "Silver",        "Cadmium",
		"Indium",        "Tin",        "Antimony",    "Tellurium",    "Iodine",       "Xenon",         "Caesium",
		"Barium",        "Lanthanum",  "Cerium",      "Praseodymium", "Neodymium",    "Promethium",    "Samarium",
		"Gadolinium",    "Dysprosium", "Holmium",     "Erbium",       "Ytterbium",    "Hafnium",       "Tantalum",
		"Tungsten",      "Rhenium",    "Osmium",      "Iridium",      "Gold",         "Mercury",       "Lead",
		"Bismuth",       "Polonium",   "Astatine",    "Radon",        "Francium",     "Radium",        "Actinium",
		"Thorium",       "Uranium",    "Plutonium",   "Americium",    "Curium",       "Berkelium",     "Californium",
		"Einsteinium",   "Fermium",    "Mendelevium", "Nobelium",     "Lawrencium",   "Rutherfordium", "Dubnium",
		"Seaborgium",    "Bohrium",    "Hassium",     "Meitnerium",   "Darmstadtium", "Roentgenium",   "Copernicium",
		"Nihonium",      "Flerovium",  "Moscovium",   "Livermorium",  "Tennessine",   "Oganesson"
	)
	name = "[pick(all_elements)]-[rand(10,99)]-[rand(10,99)]"
	. = ..()
