#include "aegis_alt_areas.dm"
#include "aegis_alt_radio.dm"
#include "aegis_alt_agents.dm"

/obj/effect/overmap/visitable/ship/aegis_alt
	name = "B-CV-12 Aegis"
	desc = "Sen#ors det3cTed a m3d-ium war5hIp 7ran5mit-tIng the c0des 'B-CV-12 Aegis 89-671'. The-re a9e m-Any t6pes 0f w3Ap0n5 0n b0aRd. RadiAti0n f50m energ4 5Hi3lds is present. RadIati8n of unkno@n energy is &r%s#3^. The shape is similar to a bud with many petals, merges with the background."
	//Sensors detected a medium warship transmitting the codes 'B-CV-12 Aegis 89-671'. There are many types of weapons on board. Radiation from energy shields is present. Radiation of unknown energy is present. The shape is similar to a bud with many petals, merges with the background.
	color = "#272f31"
	fore_dir = WEST
	dir = WEST
	integrity_failure_cap = 500
	do_repair_hull = TRUE
	repair_speed = 0.1
	vessel_mass = 50000
	max_speed = 1/(2 SECONDS)
	initial_generic_waypoints = list(
		"nav_aegis_alt_1",
		"nav_aegis_alt_2",
		"nav_aegis_alt_3",
		"nav_aegis_alt_antag"
	)
	initial_restricted_waypoints = list("Leaper" = list("nav_hangar_leaper"))

/obj/effect/overmap/visitable/ship/aegis_alt/New(nloc, max_x, max_y)
	name = "B-CV-12 Aegis"
	..()

/obj/effect/shuttle_landmark/nav_aegis_alt/nav1
	name = "B-CV-12 Aegis Navpoint #1"
	landmark_tag = "nav_aegis_alt_1"

/obj/effect/shuttle_landmark/nav_aegis_alt/nav2
	name = "B-CV-12 Aegis Navpoint #2"
	landmark_tag = "nav_aegis_alt_2"

/obj/effect/shuttle_landmark/nav_aegis_alt/nav3
	name = "B-CV-12 Aegis Navpoint #3"
	landmark_tag = "nav_aegis_alt_3"

/obj/effect/shuttle_landmark/nav_aegis_alt/nav4
	name = "B-CV-12 Aegis Navpoint #4"
	landmark_tag = "nav_aegis_alt_antag"

/datum/map_template/ruin/away_site/aegis_alt
	name = "B-CV-12 Aegis"
	id = "awaysite_aegis_alt"
	description = "B-CV-12 Aegis"
	suffixes = list("aaaa_event/aegis_alt/aegis_alt1.dmm", "aaaa_event/aegis_alt/aegis_alt2.dmm")
	spawn_cost = 10 // dont do it man
	area_usage_test_exempted_root_areas = list(/area/aegis)
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/leaper)

/obj/machinery/suit_storage_unit/battlewiz
	name = "Aegis Voidsuit Storage Unit"
	suit= /obj/item/clothing/suit/space/void/battlewizards
	helmet = /obj/item/clothing/head/helmet/space/void/battlewizards
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen
	mask = /obj/item/clothing/mask/breath

/obj/machinery/suit_storage_unit/battlewiz/captain
	name = "Aegis Leader Voidsuit Storage Unit"
	suit= /obj/item/clothing/suit/space/void/battlewizards/captain
	helmet = /obj/item/clothing/head/helmet/space/void/battlewizards/captain
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen
	mask = /obj/item/clothing/mask/breath

//		ROLES		//

/decl/submap_archetype/aegis_alt
	descriptor = "B-CV-12 Aegis"
	map = "B-CV-12 Aegis"
	blacklisted_species = null
	whitelisted_species = null
	crew_jobs = list(/datum/job/submap/aegis_alt/leader,
	 /datum/job/submap/aegis_alt/merc,
	 /datum/job/submap/aegis_alt/merc_spec,
	 /datum/job/submap/aegis_alt/merc_pilot,
	 /datum/job/submap/aegis_alt/engineer,
	 /datum/job/submap/aegis_alt/surgeon,
	 /datum/job/submap/aaaa_head/agent/leader/aegis,
	 /datum/job/submap/aaaa_head/agent/aegis,
	 /datum/job/submap/aaaa_head/robot/aegis)

/obj/effect/submap_landmark/joinable_submap/aegis_alt
	name = "B-CV-12 Aegis"
	archetype = /decl/submap_archetype/aegis_alt

/obj/effect/submap_landmark/spawnpoint/aegis_alt
	name = "Merc"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/submap_landmark/spawnpoint/aegis_alt/leader
	name = "Merc Leader"

/obj/effect/submap_landmark/spawnpoint/aegis_alt/spec
	name = "Merc Specialist"

/obj/effect/submap_landmark/spawnpoint/aegis_alt/engineer
	name = "Merc Engineer"

/obj/effect/submap_landmark/spawnpoint/aegis_alt/surgeon
	name = "Ripperdoc"

/obj/effect/submap_landmark/spawnpoint/aegis_alt/pilot
	name = "Merc Pilot"

/datum/job/submap/aegis_alt/leader
	title = "Merc Leader"
	info = "You are the leader of a small mercenary squad. Your main objective is to provide safety to the Agency people you with."
	outfit_type = /decl/hierarchy/outfit/aegis_alt/leader
	total_positions = 1
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_TRAINED,
		SKILL_COMBAT = SKILL_BASIC,
		SKILL_PILOT   = SKILL_BASIC,
		SKILL_BUREAUCRACY = SKILL_BASIC,
	)

	max_skill = list(
		SKILL_PILOT   = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_MEDICAL = SKILL_EXPERIENCED,
		SKILL_ANATOMY = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_EXPERIENCED,
	)
	skill_points = 20

/datum/job/submap/aegis_alt/merc
	title = "Merc"
	info = "You are the part of a small mercenary squad. Your main objective is to provide safety to the Agency people you with."
	outfit_type = /decl/hierarchy/outfit/aegis_alt
	total_positions = 3
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_TRITONIAN,SPECIES_IPC,SPECIES_UNATHI)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_TRAINED,
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_HAULING = SKILL_BASIC,
	)

	max_skill = list(
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_PILOT   = SKILL_MAX,
		SKILL_MEDICAL = SKILL_EXPERIENCED,
		SKILL_ANATOMY = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_EXPERIENCED,
	)
	skill_points = 20

/datum/job/submap/aegis_alt/merc_spec
	title = "Merc Specialist"
	info = "You are the part of a small mercenary squad. Your main objective is to provide safety to the Agency people you with."
	outfit_type = /decl/hierarchy/outfit/aegis_alt
	total_positions = 1
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_TRITONIAN,SPECIES_IPC,SPECIES_UNATHI)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_HAULING = SKILL_EXPERIENCED,
	)

	max_skill = list(
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_PILOT   = SKILL_MAX,
		SKILL_MEDICAL = SKILL_TRAINED,
		SKILL_ANATOMY = SKILL_TRAINED,
		SKILL_CHEMISTRY = SKILL_TRAINED,
		SKILL_PILOT   = SKILL_TRAINED,
		SKILL_SCIENCE = SKILL_TRAINED,
	)
	skill_points = 10

/datum/job/submap/aegis_alt/merc_pilot
	title = "Merc Pilot"
	info = "You are the part of a small mercenary squad. Your main objective is to provide safety to the Agency people you with."
	outfit_type = /decl/hierarchy/outfit/aegis_alt/pilot
	total_positions = 1
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_TRITONIAN,SPECIES_IPC,SPECIES_UNATHI,SPECIES_SKRELL,SPECIES_RESOMI)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_TRAINED,
		SKILL_WEAPONS = SKILL_BASIC,
		SKILL_COMBAT = SKILL_BASIC,
		SKILL_PILOT = SKILL_TRAINED,
		SKILL_HAULING = SKILL_BASIC
	)

	max_skill = list(
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_PILOT   = SKILL_MAX,
		SKILL_MEDICAL = SKILL_EXPERIENCED,
		SKILL_ANATOMY = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_EXPERIENCED,
	)
	skill_points = 20

/datum/job/submap/aegis_alt/engineer
	title = "Merc Engineer"
	info = "You are the part of a small mercenary squad. Your main objective is to provide safety to the Agency people you with."
	outfit_type = /decl/hierarchy/outfit/aegis_alt
	total_positions = 1
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_IPC,SPECIES_UNATHI,SPECIES_SKRELL,SPECIES_RESOMI)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_TRAINED,
		SKILL_COMBAT = SKILL_BASIC,
		SKILL_CONSTRUCTION = SKILL_TRAINED,
		SKILL_COMPUTER = SKILL_BASIC,
		SKILL_ATMOS = SKILL_BASIC,
		SKILL_MECH = SKILL_TRAINED,
		SKILL_ENGINES = SKILL_BASIC,
		SKILL_ELECTRICAL = SKILL_TRAINED,
		SKILL_DEVICES = SKILL_BASIC,
	)

	max_skill = list(
		SKILL_ELECTRICAL = SKILL_MAX,
		SKILL_CONSTRUCTION = SKILL_MAX,
		SKILL_WEAPONS = SKILL_EXPERIENCED,
		SKILL_COMBAT = SKILL_EXPERIENCED,
		SKILL_PILOT   = SKILL_TRAINED,
		SKILL_SCIENCE = SKILL_EXPERIENCED,
		SKILL_MEDICAL = SKILL_TRAINED,
		SKILL_ANATOMY = SKILL_TRAINED,
		SKILL_CHEMISTRY = SKILL_TRAINED,
	)
	skill_points = 20

/datum/job/submap/aegis_alt/surgeon
	title = "Ripperdoc"
	info = "You are the part of a small mercenary squad. Your main objective is to provide safety to the Agency people you with."
	outfit_type = /decl/hierarchy/outfit/aegis_alt/medic
	total_positions = 1
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_IPC,SPECIES_UNATHI,SPECIES_SKRELL)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_COMBAT = SKILL_BASIC,
		SKILL_DEVICES = SKILL_BASIC,
		SKILL_SCIENCE = SKILL_TRAINED,
		SKILL_MEDICAL = SKILL_EXPERIENCED,
		SKILL_ANATOMY = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_TRAINED,
	)

	max_skill = list(
		SKILL_WEAPONS = SKILL_TRAINED,
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_PILOT   = SKILL_TRAINED,
		SKILL_SCIENCE = SKILL_EXPERIENCED,
		SKILL_MEDICAL = SKILL_MAX,
		SKILL_ANATOMY = SKILL_MAX,
		SKILL_CHEMISTRY = SKILL_MAX,
	)
	skill_points = 20

/decl/hierarchy/outfit/aegis_alt/pilot
	name = "Merc Pilot"

	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/pcarrier/medium
	belt = /obj/item/storage/belt/holster/security
	gloves = /obj/item/clothing/gloves/thick/combat
	shoes = /obj/item/clothing/shoes/dutyboots
	head = /obj/item/clothing/head/helmet/solgov/pilot
	r_pocket = /obj/item/device/radio/map_preset/aegis
	l_ear = /obj/item/device/radio/headset/map_preset/aegis_alt
	id_types = list(/obj/item/card/id/aegis)
	id = /obj/item/card/id/aegis

/decl/hierarchy/outfit/aegis_alt
	name = "Merc"

	uniform = /obj/item/clothing/under/ftu/official
	suit = /obj/item/clothing/suit/armor/pcarrier/medium
	belt = /obj/item/storage/belt/holster/security
	gloves = /obj/item/clothing/gloves/thick/combat
	shoes = /obj/item/clothing/shoes/dutyboots
	head = /obj/item/clothing/head/soft/grey
	r_pocket = /obj/item/device/radio/map_preset/aegis
	l_ear = /obj/item/device/radio/headset/map_preset/aegis_alt
	id_types = list(/obj/item/card/id/aegis)
	id = /obj/item/card/id/aegis

/decl/hierarchy/outfit/aegis_alt/medic
	name = "Ripperdoc"

	uniform = /obj/item/clothing/under/sterile/emrs
	suit = /obj/item/clothing/suit/armor/bulletproof/vest
	belt = /obj/item/storage/belt/medical
	glasses = /obj/item/clothing/glasses/hud/health
	gloves = /obj/item/clothing/gloves/latex/nitrile
	shoes = /obj/item/clothing/shoes/dutyboots
	r_pocket = /obj/item/device/radio/map_preset/aegis
	l_ear = /obj/item/device/radio/headset/map_preset/aegis_alt
	id_types = list(/obj/item/card/id/aegis)
	id = /obj/item/card/id/aegis

/decl/hierarchy/outfit/aegis_alt/leader
	name = "Merc Leader"

	uniform = /obj/item/clothing/under/pcrc
	glasses = /obj/item/clothing/glasses/aviators_black
	suit = /obj/item/clothing/suit/armor/bulletproof/vest
	belt = /obj/item/storage/belt/holster/security
	gloves = /obj/item/clothing/gloves/thick/combat
	shoes = /obj/item/clothing/shoes/dutyboots
	head = /obj/item/clothing/head/soft/grey
	r_pocket = /obj/item/device/radio/map_preset/aegis
	l_ear = /obj/item/device/radio/headset/map_preset/aegis_alt
	id_types = list(/obj/item/card/id/aegis_captain)
	id = /obj/item/card/id/aegis_captain

// Leaper

/area/leaper
	name = "\improper leaper"
	icon_state = "shuttle"

/area/leaper/main
	name = "\improper leaper Airlock Compartment"

/area/leaper/cockpit
	name = "\improper leaper Cockpit"

/area/leaper/engine
	name = "\improper leaper Engine"

/obj/effect/overmap/visitable/ship/landable/leaper
	name = "Leaper"
	shuttle = "Leaper"
	desc = "Sensor array detected a small shuttle transmitting the 'PS LEAPER' codes, the coating does not allow to extract more data."
	fore_dir = SOUTH
	color = "#0c2d47"
	alpha = 150
	integrity_failure_cap = 60
	skill_needed = SKILL_BASIC
	vessel_mass = 5000
	vessel_size = SHIP_SIZE_SMALL

/obj/machinery/computer/shuttle_control/explore/leaper
	name = "landing control console"
	shuttle_tag = "Leaper"

/datum/shuttle/autodock/overmap/leaper
	name = "Leaper"
	move_time = 10
	shuttle_area = list(/area/leaper/cockpit, /area/leaper/main, /area/leaper/engine)
	current_location = "nav_hangar_leaper"
	dock_target = "aegis_shuttle_dock_airlock"
	//landmark_transition = "nav_transit_leaper"
	range = 0 //range = 2
	fuel_consumption = 1
	ceiling_type = /turf/simulated/floor/shuttle_ceiling
	flags = SHUTTLE_FLAGS_PROCESS
	defer_initialisation = TRUE

/obj/effect/shuttle_landmark/leaper
	name = "Leaper Hangar"
	landmark_tag = "nav_hangar_leaper"
	base_area = /area/aegis/engineering/hangar
	base_turf = /turf/simulated/floor/plating
	docking_controller = "aegis_shuttle_dock_airlock"
