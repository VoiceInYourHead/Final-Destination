// Map template data.
/datum/map_template/ruin/away_site/shikra_docking_ring
	name = "PM-55 Shikra Interceptor"
	id = "awaysite_shikra"
	description = "A small Sol fighter with a single pilot."
	suffixes = list("sfv_interceptor/shikra.dmm")
	area_usage_test_exempted_areas = list(
		/area/ship/shikra
	)
	spawn_cost = 1000
	player_cost = 4
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/shikra)

/obj/effect/overmap/visitable/sector/shikra_ring
	name = "Small Bluespace Signature"
	desc = "Bluespace trace, left by something small"
	icon_state = "event"
	hide_from_reports = TRUE
	sector_flags = OVERMAP_SECTOR_IN_SPACE | OVERMAP_SECTOR_UNTARGETABLE
	known = 0

/decl/submap_archetype/shikra
	descriptor = "PM-55 Shikra Interceptor"
	map = "PM-55 Shikra Interceptor"
	blacklisted_species = null
	whitelisted_species = null
	crew_jobs = list(/datum/job/submap/shikra/pilot)

/obj/effect/submap_landmark/joinable_submap/shikra
	name = "PM-55 Shikra Interceptor"
	archetype = /decl/submap_archetype/shikra

/obj/machinery/computer/shuttle_control/explore/shikra
	name = "shuttle control console"
	shuttle_tag = "PM-55 Shikra Interceptor"

/obj/effect/shuttle_landmark/shikra
	name = "Shikra Landing Zone"
	landmark_tag = "nav_shikra_fighter_start"
	docking_controller = "shikra_fighter_dock"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/area/ship/shikra
	name = "\improper PM-55 Shikra Interceptor"
	icon_state = "bridge"

/obj/effect/overmap/visitable/ship/landable/shikra
	name = "PM-55 Shikra Interceptor"
	shuttle = "PM-55 Shikra Interceptor"
	desc = "Wake signature indicates a small armed vessel, broadcasting registration codes \"SCGFV-3471-S-463\"."
	fore_dir = NORTH
	color = "#0751f3"
	alpha = 30
	integrity_failure_cap = 30
	skill_needed = SKILL_BASIC
	vessel_mass = 3000
	vessel_size = SHIP_SIZE_SMALL
	max_speed = 0.4/(2 SECONDS)
	burn_delay = 0.5 SECONDS
	hide_from_reports = TRUE
	known = 0
	initial_restricted_waypoints = list(
		"Shikra Landing Zone" = list("nav_shikra_fighter_start")
	)

/datum/shuttle/autodock/overmap/shikra
	name = "PM-55 Shikra Interceptor"
	warmup_time = 3
	range = 1
	shuttle_area = /area/ship/shikra
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/reinforced
	current_location = "nav_shikra_fighter_start"

/datum/job/submap/shikra/pilot
	title = "Shikra Pilot"
	info = "Your an pilot of SFV interceptor."
	outfit_type = /decl/hierarchy/outfit/scg_pilot
	total_positions = 1

/decl/hierarchy/outfit/scg_pilot
	name = "SCG Pilot"

	uniform = /obj/item/clothing/under/solgov/utility/fleet/combat/security
	suit = /obj/item/clothing/suit/armor/pcarrier/light
	back = /obj/item/storage/backpack/satchel/pocketbook/gray
	belt = /obj/item/storage/belt/holster/security
	gloves = /obj/item/clothing/gloves/thick/duty/solgov/sec
	shoes = /obj/item/clothing/shoes/dutyboots
	head = /obj/item/clothing/head/helmet/solgov/pilot
	mask = /obj/item/clothing/mask/breath/scba
	glasses = /obj/item/clothing/glasses/meson
	id = /obj/item/card/id/torch/crew/pilot
	l_pocket = /obj/item/ammo_magazine/pistol/double
	suit_store = /obj/item/gun/projectile/pistol/military/alt
	backpack_contents = list(/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e5=1,/obj/item/clothing/accessory/solgov/fleet_patch/third=1,/obj/item/device/flashlight/flare=2,/obj/item/device/radio/hailing=1)
	id_types = list(/obj/item/card/id/torch/crew/pilot)

/obj/effect/submap_landmark/spawnpoint/shikra/pilot
	name = "Shikra Pilot"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE