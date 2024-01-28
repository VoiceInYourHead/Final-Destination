#include "areas.dm"
#include "shuttle.dm"
#include "presets.dm"

/obj/effect/overmap/visitable/ship/clover
	name = "Station Clover"
	desc = "Rusty station of an very old design."
	icon_state = "station"
	known = TRUE
	initial_restricted_waypoints = list(
			"TCGV-24" = list("nav_hangar_odysseus", "nav_cs_1")
			)
	initial_generic_waypoints = list(
		"nav_cs_1"
	)

/obj/effect/submap_landmark/joinable_submap/clover
	name = "Station Clover"
	archetype = /decl/submap_archetype/clover

/decl/submap_archetype/clover
	descriptor = "Station Clover"
	map = "Station Clover"
	crew_jobs = list(
		/datum/job/submap/clover/crew
	)

/datum/job/submap/clover/crew
	title = "Station Crew"
	total_positions = 9
	supervisors = "nobody but yourself"
	info = "You slept for a long time. Now you should face the consequences of the world that you left behind."
	outfit_type = /decl/hierarchy/outfit/clover_crew
	loadout_allowed = TRUE
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_IPC,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_TRITONIAN,SPECIES_MULE)
	min_skill = list(
		SKILL_EVA = SKILL_TRAINED,
		SKILL_HAULING = SKILL_TRAINED,
		SKILL_DEVICES = SKILL_BASIC,
		SKILL_MEDICAL = SKILL_BASIC
	)

/decl/hierarchy/outfit/clover_crew
	name = "Station Crew"

	uniform = /obj/item/clothing/under/syndicate/tacticool
	suit = null
	back = null
	belt = null
	shoes = null
	glasses = null
	id_types = list(/obj/item/card/id)
	backpack_contents = list()

/obj/effect/submap_landmark/spawnpoint/clover/crew
	name = "Station Crew"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/datum/map_template/ruin/away_site/clover
	name = "Station Clover"
	id = "awaysite_cs_station"
	description = "An old rusted station."
	suffixes = list("constructed_station/constructed_station.dmm")
	spawn_cost = 1
	generate_mining_by_z = 1
	player_cost = 2
	shuttles_to_initialise = list(
		/datum/shuttle/autodock/overmap/clover
	)
	area_usage_test_exempted_root_areas = list(/area/ship/clover)