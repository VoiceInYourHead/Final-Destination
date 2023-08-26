#include "ecoffice_areas.dm"

//ECO OFFICE

/obj/effect/overmap/visitable/sector/ecoffice
	name = "Marsian ECO Office"
	desc = "The office of Marsian EC Observatory branch. Designed for formal and ceremonical occasions."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "object"
	color = "#9412a5"
	initial_generic_waypoints = list(
		"nav_eco_1",
	)
	initial_restricted_waypoints = list(
		"GEV L.M.O." = list("nav_lmo")
	)

/datum/map_template/ruin/away_site/ecoffice
	name = "Marsian ECO Office"
	id = "awaysite_ecoffice"
	spawn_cost = 1000 //No spawn
	player_cost = 1
	description = "The Marsian branch of EC Observatory. For special occasions."
	suffixes = list("ecoffice/ecoffice-1.dmm", "ecoffice/ecoffice-2.dmm")
	area_usage_test_exempted_root_areas = list(/area/ec_office)
	apc_test_exempt_areas = list(
		/area/ec_office = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/ec_office/outdoor = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/ec_office/indoor = NO_SCRUBBER|NO_VENT,
		/area/ec_office/shuttle = NO_SCRUBBER|NO_VENT,
	)

/obj/effect/submap_landmark/joinable_submap/ecoffice
	name = "Marsian ECO Office"
	archetype = /decl/submap_archetype/ecoffice

/decl/submap_archetype/ecoffice
	descriptor = "Marsian ECO Office"
	map = "Marsian ECO Office"
	crew_jobs = list(
		/datum/job/submap/ecoffice/co,
		/datum/job/submap/ecoffice/staff,
		/datum/job/submap/ecoffice/doctor,
		/datum/job/submap/ecoffice/technican,
		/datum/job/submap/ecoffice/security,
	)

//SGV L.M.O. Shuttle

/obj/effect/overmap/visitable/ship/landable/lmo
	name = "SGV L.M.O."
	desc = "An Low Mars Orbit shuttle, broadcasting SCGEC codes and the callsign \"SCGECO Mars - L.M.O.\"."
	shuttle = "SGV L.M.O."
	max_speed = 1/(3 SECONDS)
	burn_delay = 2 SECONDS
	integrity_failure_cap = 20
	vessel_mass = 2500
	fore_dir = EAST
	dir = EAST
	skill_needed = SKILL_BASIC
	vessel_size = SHIP_SIZE_TINY

/obj/machinery/computer/shuttle_control/explore/lmo
	name = "shuttle control console"
	shuttle_tag = "SGV L.M.O."

/datum/shuttle/autodock/overmap/lmo
	name = "SGV L.M.O."
	range = 0 //range = 1
	shuttle_area = list(/area/ec_office/shuttle)
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/shuttle_ceiling
	current_location = "nav_lmo"

//SPAWN POINTS

/obj/effect/submap_landmark/spawnpoint/ecoffice/co
	name = "ECO Commanding Officer"

/obj/effect/submap_landmark/spawnpoint/ecoffice/staff
	name = "ECO Staff Officer"

/obj/effect/submap_landmark/spawnpoint/ecoffice/doctor
	name = "ECO Physician"

/obj/effect/submap_landmark/spawnpoint/ecoffice/technican
	name = "ECO Technican"

/obj/effect/submap_landmark/spawnpoint/ecoffice/security
	name = "ECO Honor Guard"

/obj/effect/submap_landmark/spawnpoint/ecoffice/exo
	name = "ECO Corporate Liaison"

/obj/effect/submap_landmark/spawnpoint/ecoffice/fleet
	name = "ECO Armed Forces Liaison"

//OUTFITS

/decl/hierarchy/outfit/job/ecoffice
	hierarchy_type = /decl/hierarchy/outfit/job/ecoffice
	uniform = /obj/item/clothing/under/solgov/service/expeditionary
	shoes = /obj/item/clothing/shoes/dress
	pda_type = /obj/item/modular_computer/pda/ert

/decl/hierarchy/outfit/job/ecoffice/co
	suit = /obj/item/clothing/suit/storage/solgov/service/expeditionary/command
	head = /obj/item/clothing/head/solgov/service/expedition/captain
	belt = /obj/item/storage/belt/holster/general
	id_types = list(/obj/item/card/id/gold)
	backpack_contents = list(/obj/item/melee/telebaton=1, /obj/item/device/flash=1, /obj/item/clothing/accessory/solgov/rank/ec/officer/o6=1)

/decl/hierarchy/outfit/job/ecoffice/staff
	suit = /obj/item/clothing/suit/storage/solgov/service/expeditionary
	head = /obj/item/clothing/head/beret/solgov/expedition/branch/observatory
	belt = /obj/item/storage/belt/general
	id_types = list(/obj/item/card/id/silver)
	backpack_contents = list(/obj/item/clothing/accessory/solgov/rank/ec/officer=1)

/decl/hierarchy/outfit/job/ecoffice/staff/fleet
	uniform = /obj/item/clothing/under/solgov/service/fleet
	suit = /obj/item/clothing/suit/storage/solgov/service/fleet
	head = /obj/item/clothing/head/solgov/dress/fleet
	belt = /obj/item/storage/belt/general
	backpack_contents = list(/obj/item/clothing/accessory/solgov/rank/fleet/officer/o2=1)

/decl/hierarchy/outfit/job/ecoffice/staff/exo
	uniform = /obj/item/clothing/under/suit_jacket/corp
	shoes = /obj/item/clothing/shoes/laceup
	belt = /obj/item/storage/belt/general
	id_types = list(/obj/item/card/id/torch/passenger/corporate/liaison)
	backpack_contents = list(/obj/item/clothing/accessory/badge/nanotrasen=1)

/decl/hierarchy/outfit/job/ecoffice/staff/scientist
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/science
	head = /obj/item/clothing/head/beret/solgov/research
	belt = /obj/item/storage/belt/general
	backpack_contents = list(/obj/item/clothing/accessory/solgov/rank/ec/officer=1)

/decl/hierarchy/outfit/job/ecoffice/doctor
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	belt = /obj/item/storage/belt/medical
	id_types = list(/obj/item/card/id/medical)
	backpack_contents = list(/obj/item/clothing/accessory/solgov/rank/ec/officer/o3=1)

/decl/hierarchy/outfit/job/ecoffice/technican
	uniform = /obj/item/clothing/under/solgov/utility/expeditionary
	suit = /obj/item/clothing/suit/storage/hazardvest
	belt = /obj/item/storage/belt/utility
	head = /obj/item/clothing/head/hardhat/orange
	id_types = list(/obj/item/card/id/engineering)
	backpack_contents = list(/obj/item/clothing/accessory/solgov/rank/ec/enlisted/e3=1, /obj/item/stack/material/steel/fifty=1, /obj/item/stack/cable_coil/random=1)

/decl/hierarchy/outfit/job/ecoffice/security
	uniform = /obj/item/clothing/under/solgov/dress/expeditionary
	suit = /obj/item/clothing/suit/storage/solgov/dress/expedition
	head = /obj/item/clothing/head/solgov/service/expedition
	gloves = /obj/item/clothing/gloves/white
	belt = /obj/item/storage/belt/holster/security
	id_types = list(/obj/item/card/id/security)
	backpack_contents = list(/obj/item/clothing/accessory/armband=1, /obj/item/material/hatchet/machete/deluxe=1, /obj/item/clothing/accessory/solgov/rank/ec/enlisted/e7=1)

//JOBS

/datum/job/submap/ecoffice/co
	title = "ECO Commanding Officer"
	info = "You are Commanding Officer of the ECO Office on Mars. Make sure things run as usual and utilize your staff."
	supervisors = "SCG EC Observatory"
	outfit_type = /decl/hierarchy/outfit/job/ecoffice/co
	total_positions = 1
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_BASIC,
		SKILL_PILOT   = SKILL_BASIC,
		SKILL_BUREAUCRACY = SKILL_TRAINED,
		SKILL_SCIENCE = SKILL_TRAINED,
	)

	max_skill = list(
		SKILL_PILOT   = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_EXPERIENCED,
		SKILL_ANATOMY = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_EXPERIENCED,
	)
	skill_points = 23

/datum/job/submap/ecoffice/staff
	title = "ECO Staff Officer"
	info = "You are staff at the Mars ECO office. Help CO write and handle situations."
	supervisors = "the Commanding Officer"
	outfit_type = /decl/hierarchy/outfit/job/ecoffice/staff
	total_positions = 8
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_BASIC,
		SKILL_BUREAUCRACY = SKILL_TRAINED,
		SKILL_SCIENCE = SKILL_TRAINED,
	)

	max_skill = list(
		SKILL_SCIENCE = SKILL_EXPERIENCED,
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_WEAPONS = SKILL_TRAINED,
	)
	skill_points = 17

/datum/job/submap/ecoffice/doctor
	title = "ECO Physician"
	info = "You are Physician at the Mars ECO office. Run checks on recruits and help CO in health regards."
	supervisors = "the Commanding Officer"
	outfit_type = /decl/hierarchy/outfit/job/ecoffice/doctor
	total_positions = 1
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_BASIC,
		SKILL_MEDICAL = SKILL_TRAINED,
		SKILL_ANATOMY = SKILL_BASIC,
	)

	max_skill = list(
		SKILL_SCIENCE = SKILL_TRAINED,
		SKILL_MEDICAL = SKILL_MAX,
		SKILL_ANATOMY = SKILL_MAX,
		SKILL_CHEMISTRY = SKILL_EXPERIENCED,
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_WEAPONS = SKILL_TRAINED,
	)
	skill_points = 20

/datum/job/submap/ecoffice/technican
	title = "ECO Technican"
	info = "You are Technican at the Mars ECO office. Maintain the office and clean it up."
	supervisors = "the Commanding Officer"
	outfit_type = /decl/hierarchy/outfit/job/ecoffice/technican
	total_positions = 2
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_BASIC,
		SKILL_CONSTRUCTION = SKILL_TRAINED,
		SKILL_ELECTRICAL = SKILL_BASIC,
	)

	max_skill = list(
		SKILL_SCIENCE = SKILL_TRAINED,
		SKILL_CONSTRUCTION = SKILL_MAX,
		SKILL_ELECTRICAL = SKILL_EXPERIENCED,
		SKILL_ENGINES = SKILL_EXPERIENCED,
		SKILL_ATMOS = SKILL_EXPERIENCED,
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_WEAPONS = SKILL_TRAINED,
	)
	skill_points = 17

/datum/job/submap/ecoffice/security
	title = "ECO Honor Guard"
	info = "You are EC Honor Guard at the Mars ECO office. Protect the office and memorial from threats, stand in a fancy uniform with your machete."
	supervisors = "the Commanding Officer"
	outfit_type = /decl/hierarchy/outfit/job/ecoffice/security
	total_positions = 4
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_BASIC,
		SKILL_BUREAUCRACY = SKILL_BASIC,
		SKILL_COMBAT = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_TRAINED,
		SKILL_HAULING = SKILL_TRAINED,
	)

	max_skill = list(
		SKILL_SCIENCE = SKILL_TRAINED,
		SKILL_MEDICAL = SKILL_TRAINED,
		SKILL_ANATOMY = SKILL_BASIC,
		SKILL_CHEMISTRY = SKILL_BASIC,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_HAULING = SKILL_MAX,
	)
	skill_points = 20

/datum/job/submap/ecoffice/corporate
	title = "ECO Corporate Liaison"
	info = "You are EXO Liaison on the ECO Office at Mars. Keep corporate interests."
	supervisors = "the EXO"
	outfit_type = /decl/hierarchy/outfit/job/ecoffice/staff/exo
	total_positions = 1
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_FINANCE = SKILL_TRAINED,
		SKILL_BUREAUCRACY = SKILL_TRAINED,
	)

	max_skill = list(
		SKILL_SCIENCE = SKILL_EXPERIENCED,
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_WEAPONS = SKILL_TRAINED,
	)
	skill_points = 17

/datum/job/submap/ecoffice/fleet
	title = "ECO Armed Forces Liaison"
	info = "You are SCG Armed Forcers Liaison on the ECO Office at Mars. Keep interests of Fleet and Army personnel on EC vessels."
	supervisors = "the EXO"
	outfit_type = /decl/hierarchy/outfit/job/ecoffice/staff/fleet
	total_positions = 1
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_BUREAUCRACY = SKILL_BASIC,
		SKILL_COMBAT = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_BASIC,
	)
	skill_points = 17
