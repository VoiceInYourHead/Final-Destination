/obj/effect/overmap/visitable/ship/landable/space_truck
	name = "FTV Metal Queen"
	shuttle = "Metal Queen"
	desc = "Sensor array detects a small unarmed vessel, claiming to be 'FTV Metal Queen' - small cargo truck."
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 4000
	integrity_failure_cap = 60
	skill_needed = SKILL_TRAINED
	vessel_size = SHIP_SIZE_SMALL
	fore_dir = NORTH
	color = "#00ffff"
	hide_from_reports = TRUE
	initial_restricted_waypoints = list(
		"Bluespace Residue" = list("nav_truck")
	)

/obj/effect/overmap/visitable/ship/landable/space_truck/New(nloc, max_x, max_y)
	name = "FTV Metal Queen"
	..()

/obj/machinery/computer/shuttle_control/explore/space_truck
	name = "shuttle control console"
	shuttle_tag = "Metal Queen"

/datum/shuttle/autodock/overmap/space_truck
	name = "Metal Queen"
	fuel_consumption = 2
	range = 0 //range = 1
	shuttle_area = /area/ship/truck
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	landmark_transition = "nav_transit_truck"
	ceiling_type = /turf/simulated/floor/shuttle_ceiling
	current_location = "nav_truck"

//----------------------------

/obj/effect/overmap/visitable/sector/space_truck
	name = "Bluespace Residue"
	desc = "A trace of recent bluespace jump."
	icon_state = "event"
	hide_from_reports = TRUE
	sector_flags = OVERMAP_SECTOR_IN_SPACE | OVERMAP_SECTOR_UNTARGETABLE

/obj/effect/shuttle_landmark/space_truck
	name = "Bluespace Residue"
	landmark_tag = "nav_truck"
	docking_controller = "truck_dock_airlock"
	base_turf = /turf/space
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/datum/map_template/ruin/away_site/space_truck
	name = "Metal Queen"
	id = "awaysite_truck"
	description = "aye."
	suffixes = list("cowboy_bebop/space_truck.dmm")
	spawn_cost = 1000
	area_usage_test_exempted_root_areas = list(/area/ship/truck)
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/space_truck)

/obj/effect/shuttle_landmark/transit/space_truck
	name = "In transit"
	landmark_tag = "nav_transit_truvk"

/obj/effect/submap_landmark/joinable_submap/space_truck
	name = "FTV Metal Queen"
	archetype = /decl/submap_archetype/space_truck

/decl/submap_archetype/space_truck
	descriptor = "Space truck"
	map = "FTV Metal Queen"
	crew_jobs = list(
		/datum/job/submap/space_truck/trucker
	)

/datum/job/submap/space_truck/trucker
	title = "Truck driver"
	total_positions = 1
	supervisors = "nobody but yourself"
	info = "It's a best job in your entire life"
	outfit_type = /decl/hierarchy/outfit/trucker
	loadout_allowed = TRUE
	min_skill = list(
		SKILL_EVA = SKILL_TRAINED,
		SKILL_HAULING = SKILL_TRAINED,
		SKILL_DEVICES = SKILL_BASIC,
		SKILL_MEDICAL = SKILL_BASIC
	)

/decl/hierarchy/outfit/trucker
	name = "Truck driver"

	uniform = /obj/item/clothing/under/mbill
	suit = /obj/item/clothing/suit/storage/toggle/brown_jacket
	head = /obj/item/clothing/head/cowboy_hat
	back = /obj/item/storage/backpack/satchel/pocketbook/gray
	belt = /obj/item/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/dutyboots
	backpack_contents = list(/obj/item/device/flashlight/flare=2,/obj/item/device/radio/hailing=1)

/obj/effect/submap_landmark/spawnpoint/space_truck/trucker
	name = "Truck driver"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/area/ship/truck
	name = "\improper FTV Metal Queen"
	icon_state = "bridge"