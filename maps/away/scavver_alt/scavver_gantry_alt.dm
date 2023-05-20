#include "scavver_gantry_shuttles_alt.dm"
#include "scavver_gantry_jobs_alt.dm"
#include "scavver_gantry_radio_alt.dm"

/datum/map_template/ruin/away_site/scavver_gantry_alt
	name =  "\improper Alternative Salvage Gantry"
	id = "awaysite_gantry"
	description = "Salvage Gantry Mother-Ship"
	suffixes = list("scavver_alt/scavver_gantry-1.dmm","scavver_alt/scavver_gantry-2.dmm")
	spawn_cost = 2
	accessibility_weight = 10
	shuttles_to_initialise = list(
		/datum/shuttle/autodock/overmap/scavver_gantry,
		/datum/shuttle/autodock/overmap/scavver_gantry/two,
		/datum/shuttle/autodock/overmap/scavver_gantry/three,
		/datum/shuttle/autodock/ferry/gantry
	)
	area_usage_test_exempted_root_areas = list(/area/scavver)
	apc_test_exempt_areas = list(
		/area/scavver/yachtdown = NO_SCRUBBER|NO_VENT,
		/area/scavver/yachtup = NO_SCRUBBER|NO_VENT,
		/area/scavver/gantry/down1 = NO_SCRUBBER|NO_VENT,
		/area/scavver/gantry/down2= NO_SCRUBBER|NO_VENT,
		/area/scavver/gantry/up1 = NO_SCRUBBER|NO_VENT,
		/area/scavver/gantry/up2 = NO_SCRUBBER|NO_VENT,
		/area/scavver/gantry/lift = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/scavver/harvestpod = NO_SCRUBBER|NO_VENT
	)
	spawn_weight = 0.67

/obj/effect/submap_landmark/joinable_submap/scavver_gantry_alt
	name =  "Salvage Gantry"
	archetype = /decl/submap_archetype/derelict/scavver_gantry_alt

/decl/submap_archetype/derelict/scavver_gantry_alt
	descriptor = "Salvage Gantry Mother-Ship"
	map = "Alternative Salvage Gantry"
	crew_jobs = list(
		/datum/job/submap/scavver_pilot,
		/datum/job/submap/scavver_doctor,
		/datum/job/submap/scavver_engineer,
//		/datum/job/submap/scavver_cook,
		/datum/job/submap/scavver_cyborg,
		/datum/job/submap/scavver
	)

/obj/effect/overmap/visitable/ship/scavver_gantry_alt
	name = "Unknown Vessel"
	desc = "Sensor array detects a medium-sized vessel of irregular shape. Vessel origin is unidentifiable."
	vessel_mass = 1200
	integrity_failure_cap = 120
	fore_dir = NORTH
	burn_delay = 2 SECONDS
	hide_from_reports = TRUE
	known = 0
	color = "#7b990f"
	initial_generic_waypoints = list(
		"nav_gantry_one",
		"nav_gantry_two",
		"nav_gantry_three",
		"nav_gantry_four",
		"nav_gantry_five"
	)
	initial_restricted_waypoints = list(
		"ITV The Reclaimer" = list("nav_hangar_gantry_one"),
		"ITV Vulcan" = list("nav_hangar_gantry_two"),
		"ITV Spiritus" = list("nav_hangar_gantry_three", "nav_hangar_gantry_four", "nav_hangar_gantry_five", "nav_hangar_gantry_six"),
		"Charon" = list("nav_gantry_charon"),
		"Guppy" = list("nav_gantry_gup"),
		"Aquila" = list("nav_gantry_aquila"),
		"Desperado" = list("nav_gantry_desperado")
	)

/obj/machinery/suit_storage_unit/engineering/salvage/gantry/standart
	name = "Salvage Voidsuit Storage Unit"
	suit= /obj/item/clothing/suit/space/void/engineering/salvage
	helmet = /obj/item/clothing/head/helmet/space/void/engineering/salvage
	mask = /obj/item/clothing/mask/breath

/obj/machinery/suit_storage_unit/engineering/salvage/gantry/bar
	name = "Salvage Bartender Voidsuit Storage Unit"
	suit= /obj/item/clothing/suit/space/void/engineering/salvage
	helmet = /obj/item/clothing/head/helmet/space/void/engineering/salvage
	mask = /obj/item/clothing/mask/breath

/obj/machinery/suit_storage_unit/engineering/salvage/gantry/bar2
	name = "Salvage Cook Voidsuit Storage Unit"
	suit= /obj/item/clothing/suit/space/void/engineering/salvage
	helmet = /obj/item/clothing/head/helmet/space/void/engineering/salvage
	mask = /obj/item/clothing/mask/breath

/area/scavver/gantry/down3
	name = "\improper Salvage Gantry Bar"
	icon_state = "gantry_down_2"

/area/scavver/gantry/down4
	name = "\improper Salvage Gantry Broken Shuttle"
	icon_state = "gantry_down_2"

/area/scavver/gantry/down5
	name = "\improper Salvage Gantry Broken OFD"
	icon_state = "gantry_down_2"