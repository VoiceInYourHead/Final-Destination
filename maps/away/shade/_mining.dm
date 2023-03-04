#include "shuttles.dm"
#include "areas.dm"

/obj/structure/closet/secure_closet/miner/shade
	name = "miner's equipment"
	closet_appearance = /decl/closet_appearance/secure_closet/mining
	req_access = null

/obj/structure/closet/secure_closet/miner/shade/WillContain()
	return list(
		new /datum/atom_creator/weighted(list(
				/obj/item/storage/backpack/industrial,
				/obj/item/storage/backpack/satchel/eng
			)),
		/obj/item/clothing/gloves/thick,
		/obj/item/clothing/shoes/black,
		/obj/item/device/scanner/gas,
		/obj/item/storage/ore,
		/obj/item/storage/ore,
		/obj/item/device/flashlight/lantern,
		/obj/item/shovel,
		/obj/item/pickaxe/jackhammer,
		/obj/item/pickaxe/drill,
		/obj/item/clothing/glasses/meson
	)

/obj/effect/paint/red/dark
	color = "#420d0d"

/obj/machinery/suit_storage_unit/mining/shade
	req_access = null
	islocked = 0

/obj/structure/sign/gml
	name = "\improper GMLtd. sign"
	desc = "A sign which signifies who this vessel belongs to."
	icon = 'maps/away/shade/gml-decals.dmi'
	icon_state = "gml"

/obj/effect/overmap/visitable/sector/shade
	name = "Bluespace Residue"
	desc = "/ERROR/."
	icon_state = "event"
	hide_from_reports = TRUE

/obj/effect/shuttle_landmark/shade
	name = "Bluespace Residue"
	landmark_tag = "nav_shade"
	docking_controller = "shade_shuttle_dock_airlock"
	base_turf = /turf/space
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/datum/map_template/ruin/away_site/shade
	name = "Shade"
	id = "awaysite_shade"
	description = "Active Grayson Manufactories Ltd. mining shuttle."
	suffixes = list("shade/shade.dmm")
	spawn_cost = 1000 // NO BITCHES???
	area_usage_test_exempted_root_areas = list(/area/ship/shade)
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/shade)