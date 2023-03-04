// Map template data.
/datum/map_template/ruin/away_site/swordfish_docking_ring
	name = "Swordfish II"
	id = "awaysite_fish"
	description = "A small unknown interceptor with a single pilot."
	suffixes = list("cowboy_bebop/swordfish.dmm")
	area_usage_test_exempted_areas = list(
		/area/ship/swordfish
	)
	spawn_cost = 1000
	player_cost = 4
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/swordfish)

/obj/effect/overmap/visitable/sector/swordfish_ring
	name = "Small Bluespace Signature"
	desc = "Bluespace trace, left by something small"
	icon_state = "event"
	hide_from_reports = TRUE
	known = 0

/decl/submap_archetype/swordfish
	descriptor = "Swordfish II"
	map = "Swordfish II"
	blacklisted_species = null
	whitelisted_species = null
	crew_jobs = list(/datum/job/submap/swordfish/pilot)

/obj/effect/submap_landmark/joinable_submap/swordfish
	name = "Swordfish II"
	archetype = /decl/submap_archetype/swordfish

/obj/machinery/computer/shuttle_control/explore/swordfish
	name = "shuttle control console"
	shuttle_tag = "Swordfish II"

/obj/effect/shuttle_landmark/swordfish
	name = "Swordfish Landing Zone"
	landmark_tag = "nav_swordfish_fighter_start"
	docking_controller = "swordfish_fighter_dock"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/area/ship/swordfish
	name = "\improper Swordfish II"
	icon_state = "bridge"

/obj/effect/overmap/visitable/ship/landable/swordfish
	name = "Swordfish II"
	shuttle = "Swordfish II"
	desc = "Wake signature indicates a small armed vessel."
	fore_dir = NORTH
	color = "#b11717"
	skill_needed = SKILL_BASIC
	vessel_mass = 1500
	integrity_failure_cap = 20
	vessel_size = SHIP_SIZE_SMALL
	max_speed = 0.4/(2 SECONDS)
	burn_delay = 0.5 SECONDS
	hide_from_reports = TRUE
	known = 0
	initial_restricted_waypoints = list(
		"Swordfish Landing Zone" = list("nav_swordfish_fighter_start")
	)

/datum/shuttle/autodock/overmap/swordfish
	name = "Swordfish II"
	warmup_time = 3
	range = 0 //range = 1
	shuttle_area = /area/ship/swordfish
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/reinforced
	current_location = "nav_swordfish_fighter_start"

/datum/job/submap/swordfish/pilot
	title = "Swordfish Pilot"
	info = "Your an lone mercenary, searching for the prey."
	outfit_type = /decl/hierarchy/outfit/swordfish
	total_positions = 1

/decl/hierarchy/outfit/swordfish
	name = "Swordfish Pilot"

	uniform = /obj/item/clothing/under/syndicate/tacticool
	suit = /obj/item/clothing/suit/storage/toggle/bomber
	back = /obj/item/storage/backpack/satchel/pocketbook/gray
	belt = /obj/item/storage/belt/holster/security
	shoes = /obj/item/clothing/shoes/dutyboots
	head = /obj/item/clothing/head/helmet/solgov/pilot
	mask = /obj/item/clothing/mask/breath/scba
	glasses = /obj/item/clothing/glasses/meson
	id = /obj/item/card/id/torch/crew/pilot
	l_pocket = /obj/item/ammo_magazine/pistol/double
	backpack_contents = list(/obj/item/device/flashlight/flare=2,/obj/item/device/radio/hailing=1,/obj/item/gun/projectile/pistol/military/alt=1)
	id_types = list(/obj/item/card/id/torch/crew/pilot)

/obj/effect/submap_landmark/spawnpoint/swordfish/pilot
	name = "Swordfish Pilot"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE