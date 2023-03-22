#include "ares_areas.dm"
#include "ares_jobs.dm"
#include "ares_shuttles.dm"

/obj/effect/paint/red/dark
	color = "#420d0d"

/obj/machinery/door/airlock/multi_tile/ares
	door_color = COLOR_DARK_GUNMETAL
	stripe_color = COLOR_SILVER

/obj/machinery/door/airlock/ares
	door_color = COLOR_DARK_GUNMETAL
	stripe_color = COLOR_SILVER

/obj/machinery/door/airlock/glass/ares
	door_color = COLOR_DARK_GUNMETAL
	stripe_color = COLOR_SILVER

/obj/machinery/suit_storage_unit/mining/ares
	req_access = list(access_ares)

/obj/structure/closet/secure_closet/miner/ares
	name = "miner's equipment"
	closet_appearance = /decl/closet_appearance/secure_closet/mining
	req_access = list(access_ares)

/obj/structure/closet/secure_closet/miner/ares/WillContain()
	return list(
		/obj/item/clothing/accessory/storage/brown_vest,
		/obj/item/clothing/mask/gas/half,
		/obj/item/clothing/gloves/thick,
		/obj/item/clothing/shoes/workboots,
		/obj/item/device/flashlight/lantern,
		/obj/item/shovel,
		/obj/item/clothing/under/grayson,
		/obj/item/device/scanner/gas,
		/obj/item/pickaxe/jackhammer,
		/obj/item/pickaxe/drill,
		/obj/item/crowbar,
		/obj/item/wrench,
		/obj/item/storage/ore,
		/obj/item/device/scanner/mining,
		/obj/item/device/gps,
		/obj/item/device/radio,
		/obj/item/clothing/glasses/material,
		/obj/item/clothing/glasses/meson,
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/industrial, /obj/item/storage/backpack/satchel/eng, /obj/item/storage/backpack/messenger/engi)),
		/obj/item/storage/backpack/dufflebag/eng
	)

/obj/structure/sign/gml
	name = "\improper GMLtd. sign"
	desc = "A sign which signifies who this vessel belongs to."
	icon = 'maps/away/shade/gml-decals.dmi'
	icon_state = "gml"

/obj/machinery/vending/cigarette/noprice
	prices = null

/decl/stock_part_preset/radio/receiver/vent_pump/ares
	frequency = 1997

/decl/stock_part_preset/radio/event_transmitter/vent_pump/ares
	frequency = 1997

/obj/machinery/atmospherics/unary/vent_pump/high_volume/ares
	stock_part_presets = list(
		/decl/stock_part_preset/radio/receiver/vent_pump/ares = 1,
		/decl/stock_part_preset/radio/event_transmitter/vent_pump/ares = 1
	)

/decl/stock_part_preset/radio/receiver/vent_scrubber/ares
	frequency = 1997

/decl/stock_part_preset/radio/event_transmitter/vent_scrubber/ares
	frequency = 1997

/obj/machinery/atmospherics/unary/vent_scrubber/ares
	stock_part_presets = list(
		/decl/stock_part_preset/radio/receiver/vent_scrubber/ares = 1,
		/decl/stock_part_preset/radio/event_transmitter/vent_scrubber/ares = 1
	)

// Map template data.
/datum/map_template/ruin/away_site/ares
	name = "Ares"
	id = "awaysite_ares"
	description = "Active Grayson Manufactories Ltd. mining vessel."
	suffixes = list("ares/ares.dmm")
	spawn_cost = 3
	area_usage_test_exempted_root_areas = /area/ship/ares
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/ares)

/obj/effect/overmap/visitable/sector/ares
	name = "Bluespace Residue"
	desc = "/ERROR/."
	icon_state = "event"
	hide_from_reports = TRUE

/obj/effect/submap_landmark/joinable_submap/ares
	name = "GM Ltd. mining vessel"
	archetype = /decl/submap_archetype/ares