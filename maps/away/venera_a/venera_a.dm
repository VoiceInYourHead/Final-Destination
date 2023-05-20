#include "venera_a_shuttles.dm"

/obj/effect/overmap/visitable/ship/venera_a
	name = "SGV Venera"
	desc = "Sensor array is detecting a Sol Gov GunBoat Vessel."
	color = "#1d96f8"
	integrity_failure_cap = 150
	vessel_mass = 3000 /// Venera is small and fast ship
	max_speed = 1/(2 SECONDS)
	initial_generic_waypoints = list(
		"nav_venera_a_1",
		"nav_venera_a_2",
		"nav_venera_a_3",
		"nav_venera_a_antag"
	)
	initial_restricted_waypoints = list(
		"Jinx" = list("nav_hangar_jinx")
	)


/obj/effect/overmap/visitable/ship/venera_a/New(nloc, max_x, max_y)
	name = "SGV Venera"
	..()

/datum/map_template/ruin/away_site/venera_a
	name = "SGV Venera_a"
	id = "awaysite_venera_a"
	description = "Active SolGov movable medium ship with shuttle."
	suffixes = list("venera_a/venera_a.dmm")
	spawn_cost = 50 // nice try lol
	area_usage_test_exempted_root_areas = list(/area/venera)
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/jinx)

/obj/effect/shuttle_landmark/nav_venera_a/nav1
	name = "SGV Venera Navpoint #1"
	landmark_tag = "nav_venera_a_1"

/obj/effect/shuttle_landmark/nav_venera_a/nav2
	name = "SGV Venera Navpoint #2"
	landmark_tag = "nav_venera_a_2"

/obj/effect/shuttle_landmark/nav_venera_a/nav3
	name = "SGV Venera Navpoint #3"
	landmark_tag = "nav_venera_a_3"

/obj/effect/shuttle_landmark/nav_venera_a/nav4
	name = "SGV Venera Navpoint #4"
	landmark_tag = "nav_venera_a_antag"


/decl/submap_archetype/venera
	descriptor = "SGV Venera"
	map = "SGV Venera"
	blacklisted_species = null
	whitelisted_species = null
	crew_jobs = list(/datum/job/submap/venera/pilot,/datum/job/submap/venera/captain,/datum/job/submap/venera/gunner,/datum/job/submap/venera/rifleman)

/obj/effect/submap_landmark/joinable_submap/venera
	name = "SGV Venera"
	archetype = /decl/submap_archetype/venera

/obj/effect/submap_landmark/spawnpoint/venera
	name = "Venera Crew Member"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/submap_landmark/spawnpoint/venera/captain
	name = "Venera Captain"

/obj/effect/submap_landmark/spawnpoint/venera/pilot
	name = "Venera Pilot"

/obj/effect/submap_landmark/spawnpoint/venera/gunner
	name = "Venera Gunner"

/obj/effect/submap_landmark/spawnpoint/venera/rifleman
	name = "Venera Rifleman"

/datum/job/submap/venera/captain
	title = "Venera Captain"
	info = "You are the captain of the ship SGV Venera. Protect, fight for the life of the team and remember: The captain goes to the bottom with his ship."
	outfit_type = /decl/hierarchy/outfit/venera/captain
	total_positions = 1
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_ADEPT,
		SKILL_COMBAT = SKILL_ADEPT,
		SKILL_DEVICES = SKILL_BASIC,
		SKILL_PILOT   = SKILL_BASIC,
		SKILL_BUREAUCRACY = SKILL_BASIC,
	)

	max_skill = list(
		SKILL_PILOT   = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_EXPERT,
		SKILL_ANATOMY = SKILL_EXPERT,
		SKILL_CHEMISTRY = SKILL_EXPERT,
	)
	skill_points = 20

/datum/job/submap/venera/pilot
	title = "Venera Pilot"
	info = "Your an pilot of SGV Venera. You are the hands of the captain, his faith and hope, your task is simple and complex, and the fate of the whole team is in your hands."
	outfit_type = /decl/hierarchy/outfit/venera/pilot
	total_positions = 1
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_ADEPT,
		SKILL_PILOT   = SKILL_EXPERT,
	)

	max_skill = list(
		SKILL_PILOT   = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_EXPERT,
		SKILL_ANATOMY = SKILL_EXPERT,
		SKILL_CHEMISTRY = SKILL_EXPERT,
	)
	skill_points = 20


/datum/job/submap/venera/gunner
	title = "Venera Gunner"
	info = "You are the gunner of the ship, you are responsible for the safety and proper use of the ship's guns. You tear and destroy all those who stand in your way, it depends on you whether your team will wake up next time."
	outfit_type = /decl/hierarchy/outfit/venera/rifleman
	total_positions = 2
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_IPC,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_EXPERT,
		SKILL_DEVICES = SKILL_BASIC,
		SKILL_SCIENCE = SKILL_BASIC,
		SKILL_PILOT   = SKILL_ADEPT,
	)

	max_skill = list(
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_DEVICES = SKILL_MAX,
		SKILL_MEDICAL = SKILL_ADEPT,
		SKILL_ANATOMY = SKILL_ADEPT,
		SKILL_CHEMISTRY = SKILL_ADEPT,
		SKILL_PILOT   = SKILL_MAX,
	)
	skill_points = 20


/datum/job/submap/venera/rifleman
	title = "Venera Rifleman"
	info = "You are a soldier, you are the shield and sword of this ship. Unknown dangers lurk in the distant and beautiful space, you are responsible for ensuring that you and your team cope with any danger on the way, whether it is an external threat or an internal enemy. You cannot go back, you cannot retreat, you have a goal and your life depends on you, stand back to back with your team and remember: NO STEP BACK."
	outfit_type = /decl/hierarchy/outfit/venera/rifleman
	total_positions = 4
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_IPC,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_ADEPT,
		SKILL_COMBAT = SKILL_ADEPT,
		SKILL_HAULING = SKILL_BASIC,
	)

	max_skill = list(
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_MEDICAL = SKILL_MAX,
		SKILL_ANATOMY = SKILL_MAX,
		SKILL_CHEMISTRY = SKILL_MAX,
		SKILL_PILOT   = SKILL_ADEPT,
	)
	skill_points = 20



//				O U T F I T S			//


/decl/hierarchy/outfit/venera/pilot
	name = "Ship Pilot"

	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/pcarrier/light
	back = /obj/item/storage/backpack/satchel/pocketbook/gray
	belt = /obj/item/storage/belt/holster/security
	gloves = /obj/item/clothing/gloves/thick/combat
	shoes = /obj/item/clothing/shoes/dutyboots
	head = /obj/item/clothing/head/helmet/nt/pilot
	l_pocket = /obj/item/ammo_magazine/pistol/double
	r_pocket = /obj/item/device/radio/map_preset/venera
	l_ear = /obj/item/device/radio/headset/map_preset/venera
	suit_store = /obj/item/gun/projectile/pistol/military/alt
	backpack_contents = list(/obj/item/device/flashlight/flare=2, /obj/item/storage/mre/random=1)

/decl/hierarchy/outfit/venera/captain
	name = "Ship Captain"

	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/hos/jensen
	back = /obj/item/storage/backpack/satchel/pocketbook/gray
	belt = /obj/item/material/sword/katana/raiden
	gloves = /obj/item/clothing/gloves/thick/combat
	glasses = /obj/item/clothing/glasses/sunglasses
	shoes = /obj/item/clothing/shoes/dutyboots
	l_pocket = /obj/item/ammo_magazine/pistol/double
	r_pocket = /obj/item/device/radio/map_preset/venera
	l_ear = /obj/item/device/radio/headset/map_preset/venera
	suit_store = /obj/item/gun/projectile/pistol/military/alt
	backpack_contents = list(/obj/item/device/flashlight/flare=2, /obj/item/storage/mre/random=1)

/decl/hierarchy/outfit/venera/rifleman
	name = "Ship Rifleman"

	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/pcarrier/medium
	back = /obj/item/storage/backpack/satchel/grey
	belt = /obj/item/storage/belt/holster/security
	gloves = /obj/item/clothing/gloves/thick/combat
	shoes = /obj/item/clothing/shoes/dutyboots
	head = /obj/item/clothing/head/helmet/ballistic
	l_pocket = /obj/item/ammo_magazine/pistol/double
	r_pocket = /obj/item/device/radio/map_preset/venera
	l_ear = /obj/item/device/radio/headset/map_preset/venera
	suit_store = /obj/item/gun/projectile/pistol/military/alt
	backpack_contents = list(/obj/item/device/flashlight/flare=2, /obj/item/storage/mre/random=1, /obj/item/ammo_magazine/pistol/double=5)
