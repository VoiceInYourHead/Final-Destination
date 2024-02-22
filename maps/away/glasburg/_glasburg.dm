#include "shuttles.dm"
#include "areas.dm"
#include "iccg_jobs.dm"

#define MATERIAL_GLASS_RED                   "painted glass"

/obj/machinery/door/airlock/glasburg
	req_access = list(access_iccg)
	door_color = "#212d38"
	stripe_color = "#960000"

/obj/effect/paint/iccg_hull
	color = "#1c2730"

/obj/effect/floor_decal/industrial/outline/red/iccg
	name = "bloody-red outline"
	color = "#940004"

/material/glass/red
	name = MATERIAL_GLASS_RED
	icon_colour = COLOR_RED

/obj/structure/window/reinforced/red
	init_material = MATERIAL_GLASS_RED

/obj/structure/wall_frame/glasburg
	color = "#1c2730"
	stripe_color = "#1c2730"

/turf/simulated/wall/r_wall/glasburg
	color = "#1c2730"

/obj/structure/window/reinforced/full/glasburg
	init_material = MATERIAL_GLASS_RED

/obj/effect/wallframe_spawn/reinforced/glasburg
	name = "reinforced glasburg hull wall frame window spawner"
	frame_path = /obj/structure/wall_frame/glasburg
	win_path = /obj/structure/window/reinforced/full/glasburg

/obj/item/clothing/suit/space/void/security/alt/iccg
	name = "armored terran voidsuit"
	icon_state = "rig_iccg"
	allowed = list(/obj/item/device/flashlight,/obj/item/tank,/obj/item/device/suit_cooling_unit,/obj/item/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/melee/energy/sword,/obj/item/handcuffs)

/obj/item/clothing/head/helmet/space/void/security/alt/iccg
	name = "armored terran voidsuit helmet"
	icon_state = "rig_iccg"
	item_state = "rig_iccg"

/obj/machinery/suit_storage_unit/glasburg
	name = "Terran Voidsuit Storage Unit"
	suit = /obj/item/clothing/suit/space/void/security/alt/iccg
	helmet = /obj/item/clothing/head/helmet/space/void/security/alt/iccg
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/jetpack/oxygen
	mask = /obj/item/clothing/mask/gas/half
	req_access = list(access_iccg)

/obj/effect/overmap/visitable/sector/glasburg
	name = "Ruined Bluespace Jump Ring"
	desc = "A ruined jumpdrive ring used to transport individual ships at FTL speeds."
	icon_state = "event"
	hide_from_reports = TRUE
	sector_flags = OVERMAP_SECTOR_IN_SPACE | OVERMAP_SECTOR_UNTARGETABLE

/obj/effect/shuttle_landmark/glasburg
	name = "Ruined Bluespace Jump Ring"
	landmark_tag = "nav_glasburg"
	docking_controller = "glasburg_shuttle_dock_airlock"
	base_turf = /turf/space
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/datum/map_template/ruin/away_site/glasburg
	name = "Glasburg"
	id = "awaysite_glasburg"
	description = "aye."
	suffixes = list("glasburg/glasburg.dmm")
	spawn_cost = 1000 // NO BITCHES???
	area_usage_test_exempted_root_areas = list(/area/ship/glasburg)
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/glasburg)

/obj/effect/shuttle_landmark/transit/glasburg
	name = "In transit"
	landmark_tag = "nav_transit_glasburg"

/obj/effect/submap_landmark/joinable_submap/glasburg
	name = "GCDV Glasburg"
	archetype = /decl/submap_archetype/glasburg

/obj/machinery/computer/ship/sensors/panslavic
	construct_state = /decl/machine_construction/default/panel_closed/computer/no_deconstruct
	base_type = /obj/machinery/computer/ship/sensors
	print_language = LANGUAGE_HUMAN_RUSSIAN
