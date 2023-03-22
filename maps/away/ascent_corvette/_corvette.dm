#include "ascent_areas.dm"
#include "ascent_jobs.dm"

// Map template data.
/datum/map_template/ruin/away_site/ascent_corvette
	name = "Ascent Corvette"
	id = "awaysite_ascent_corvette"
	description = "An Ascent Corvette with average crew."
	suffixes = list("ascent_corvette/corvette-1.dmm", "ascent_corvette/corvette-2.dmm")
	area_usage_test_exempted_areas = list(
		/area/ship/ascent_corvette
	)
	spawn_cost = 1000 // Сегодня без спавна :p ~danilcus
	player_cost = 4 // Нынешнее значение основано на количестве игроков в авейке ~bear1ake

// Overmap objects.
/obj/effect/overmap/visitable/ship/ascent_corvette
	name = "Ascent Corvette"
	desc = "Wake signature indicates a small to medium sized vessel of unknown design."
	color = COLOR_PURPLE
	vessel_mass = 9000
	integrity_failure_cap = 250
	repair_speed = 0.01
	fore_dir = EAST
	dir = EAST
	max_speed = 0.6/(1 SECOND)
	hide_from_reports = TRUE
	known = 0

/obj/effect/submap_landmark/joinable_submap/ascent_corvette
	name = "Ascent Corvette"
	archetype = /decl/submap_archetype/ascent_corvette
	submap_datum_type = /datum/submap/ascent_corvette

/obj/effect/submap_landmark/joinable_submap/ascent_corvette/Initialize(mapload)
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
