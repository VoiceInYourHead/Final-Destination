#include "aegis_areas.dm"
#include "aegis_radio.dm"
#include "aegis_shuttles.dm"

/obj/effect/overmap/visitable/ship/aegis
	name = "Aegis"
	desc = "Sen#ors det3cTed a m3d-ium war5hIp 7ran5mit-tIng the c0des 'PV AEGIS 89-671'. The-re a9e m-Any t6pes 0f w3Ap0n5 0n b0aRd. RadiAti0n f50m energ4 5Hi3lds is present. RadIati8n of unkno@n energy is &r%s#3^. The shape is similar to a bud with many petals, merges with the background."
	//Sensors detected a medium warship transmitting the codes 'PV AEGIS 89-671'. There are many types of weapons on board. Radiation from energy shields is present. Radiation of unknown energy is present. The shape is similar to a bud with many petals, merges with the background.
	color = "#272f31"
	alpha = 200
	fore_dir = WEST
	dir = WEST

	integrity_failure_cap = 500 // утверждено Воидом
	do_repair_hull = TRUE
	repair_speed = 0.1
	vessel_mass = 50000 // this is fucking flying plasteel ingot, утверждено Воидом
	max_speed = 1/(2 SECONDS)
	initial_generic_waypoints = list(
		"nav_aegis_1",
		"nav_aegis_2",
		"nav_aegis_3",
		"nav_aegis_antag"
	)
	initial_restricted_waypoints = list("Leaper" = list("nav_hangar_leaper"))

/obj/effect/overmap/visitable/ship/aegis/New(nloc, max_x, max_y)
	name = "PV Aegis"
	..()

/datum/map_template/ruin/away_site/aegis
	name = "PV Aegis"
	id = "awaysite_aegis"
	description = "Private Military Force high-armored medium ship, with ton of guns and combat equipment."
	suffixes = list("aegis/aegis1.dmm", "aegis/aegis2.dmm")
	spawn_cost = 10 // dont do it man
	area_usage_test_exempted_root_areas = list(/area/aegis)
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/leaper)

/obj/effect/shuttle_landmark/nav_aegis/nav1
	name = "PV Aegis Navpoint #1"
	landmark_tag = "nav_aegis_1"

/obj/effect/shuttle_landmark/nav_aegis/nav2
	name = "PV Aegis Navpoint #2"
	landmark_tag = "nav_aegis_2"

/obj/effect/shuttle_landmark/nav_aegis/nav3
	name = "PV Aegis Navpoint #3"
	landmark_tag = "nav_aegis_3"

/obj/effect/shuttle_landmark/nav_aegis/nav4
	name = "PV Aegis Navpoint #4"
	landmark_tag = "nav_aegis_antag"



//		ACCESS

/var/const/access_aegis = "ACCESS_AEGIS" //g
/datum/access/aegis
	id = access_aegis
	desc = "Aegis Crewman"
	region = ACCESS_REGION_NONE

/var/const/access_aegis_captain = "ACCESS_AEGIS_CAPTAIN" //g
/datum/access/aegis_captain
	id = access_aegis_captain
	desc = "Aegis Captain"
	region = ACCESS_REGION_NONE

/obj/item/card/id/aegis
	access = list(access_aegis)

/obj/item/card/id/aegis_captain
	access = list(access_aegis, access_aegis_captain)

//		ITEMS

/obj/structure/closet/secure_closet/aegis
	name = "Aegis locker"
	req_access = list(access_aegis)
	closet_appearance = /decl/closet_appearance/secure_closet/security

/obj/structure/closet/secure_closet/aegis/crew
	name = "Aegis Crewman's locker"

/obj/structure/closet/secure_closet/aegis/crew/WillContain()
	return list(
		new/datum/atom_creator/weighted(list(/obj/item/storage/backpack/security, /obj/item/storage/backpack/satchel/sec)),
		new/datum/atom_creator/simple(/obj/item/storage/backpack/dufflebag/sec, 50),
		new/datum/atom_creator/simple(/obj/item/reagent_containers/hypospray/autoinjector/combatpain, 50),
		new/datum/atom_creator/simple(/obj/item/clothing/glasses/tacgoggles, 50),
		/obj/item/clothing/head/helmet,
		/obj/item/device/radio/headset/map_preset/aegis,
		/obj/item/device/flash,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/clothing/glasses/sunglasses,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/under/tactical,
		/obj/item/clothing/suit/storage/vest/tactical,
		/obj/item/storage/belt/holster/security/tactical,
		/obj/item/clothing/shoes/tactical,
		/obj/item/storage/firstaid/individual/military,
		/obj/item/clothing/gloves/tactical
	)

/obj/machinery/suit_storage_unit/security/alt/aegis
	name = "Aegis Voidsuit Storage Unit"
	req_access = list(access_aegis)

/obj/machinery/power/apc/aegis
	req_access = list(access_aegis)
	cell_type = /obj/item/cell/high

/obj/machinery/alarm/aegis
	req_access = list(access_aegis)

/obj/item/rig/military/equipped/aegis
	req_access = list(access_aegis)

/obj/item/gun/energy/k342/aegis
	req_access = list(access_aegis)

/obj/item/gun/energy/k342/sniper/aegis
	req_access = list(access_aegis)


//		ROLES		//

/decl/submap_archetype/aegis
	descriptor = "PV Aegis"
	map = "PV Aegis"
	blacklisted_species = null
	whitelisted_species = null
	crew_jobs = list(/datum/job/submap/aegis/captain,/datum/job/submap/aegis/officer,/datum/job/submap/aegis/pilot,/datum/job/submap/aegis/gunner,/datum/job/submap/aegis/surgeon,/datum/job/submap/aegis/field_engineer,/datum/job/submap/aegis/field_medic,/datum/job/submap/aegis/rifleman)

/obj/effect/submap_landmark/joinable_submap/aegis
	name = "PV Aegis"
	archetype = /decl/submap_archetype/aegis

/obj/effect/submap_landmark/spawnpoint/aegis
	name = "Aegis Crew Member"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/submap_landmark/spawnpoint/aegis/captain
	name = "Aegis Captain"
/obj/effect/submap_landmark/spawnpoint/aegis/officer
	name = "Aegis First Officer"
/obj/effect/submap_landmark/spawnpoint/aegis/pilot
	name = "Aegis Pilot"
/obj/effect/submap_landmark/spawnpoint/aegis/gunner
	name = "Aegis Gunner"
obj/effect/submap_landmark/spawnpoint/aegis/surgeon
	name = "Aegis Surgeon"
/obj/effect/submap_landmark/spawnpoint/aegis/field_engineer
	name = "Aegis Field Engineer"
/obj/effect/submap_landmark/spawnpoint/aegis/field_medic
	name = "Aegis Field Medic"
/obj/effect/submap_landmark/spawnpoint/aegis/rifleman
	name = "Aegis Rifleman"

/datum/job/submap/aegis/captain
	title = "Aegis Captain"
	info = "You are the captain of the ship. Protect, fight for the life of the team and remember: The captain goes to the bottom with his ship."
	outfit_type = /decl/hierarchy/outfit/aegis/captain
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

/datum/job/submap/aegis/officer
	title = "Aegis First Officer"
	info = "You Are The First Officer. You answer directly to the captain of the ship and make sure that everyone follows his orders."
	outfit_type = /decl/hierarchy/outfit/aegis/officer
	total_positions = 1
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_TRAINED,
		SKILL_COMBAT = SKILL_BASIC,
		SKILL_DEVICES = SKILL_BASIC,
		SKILL_PILOT   = SKILL_TRAINED,
		SKILL_BUREAUCRACY = SKILL_BASIC,
	)

	max_skill = list(
		SKILL_PILOT   = SKILL_MAX,
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_EXPERIENCED,
		SKILL_ANATOMY = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_EXPERIENCED,
	)
	skill_points = 20

/datum/job/submap/aegis/pilot
	title = "Aegis Pilot"
	info = "You're a pilot. Do your pilot stuff."
	outfit_type = /decl/hierarchy/outfit/aegis/pilot
	total_positions = 2
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_IPC,SPECIES_SKRELL)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_TRAINED,
		SKILL_WEAPONS = SKILL_BASIC,
		SKILL_COMBAT = SKILL_BASIC,
		SKILL_DEVICES = SKILL_BASIC,
		SKILL_SCIENCE = SKILL_BASIC,
		SKILL_PILOT   = SKILL_EXPERIENCED,
	)

	max_skill = list(
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_PILOT   = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_EXPERIENCED,
		SKILL_ANATOMY = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_EXPERIENCED,
	)
	skill_points = 20

/datum/job/submap/aegis/gunner
	title = "Aegis Gunner"
	info = "You are the gun operator. Your task is to eliminate, destroy, neutralize and completely annihilate the enemy with the help of huge guns."
	outfit_type = /decl/hierarchy/outfit/aegis/gunner
	total_positions = 2
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_IPC,SPECIES_SKRELL)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_EVA     = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_TRAINED,
		SKILL_COMBAT = SKILL_BASIC,
		SKILL_DEVICES = SKILL_BASIC,
		SKILL_PILOT   = SKILL_EXPERIENCED,
	)

	max_skill = list(
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_PILOT   = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_EXPERIENCED,
		SKILL_ANATOMY = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_EXPERIENCED,
	)
	skill_points = 20

/datum/job/submap/aegis/surgeon
	title = "Aegis Surgeon"
	info = "You're the ship's surgeon. Your professional knowledge of anatomy and medicine allows you to perform complex operations on a person to save his life."
	outfit_type = /decl/hierarchy/outfit/aegis/medic
	total_positions = 1
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_IPC,SPECIES_SKRELL)
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
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_MAX,
		SKILL_ANATOMY = SKILL_MAX,
		SKILL_CHEMISTRY = SKILL_MAX,
	)
	skill_points = 20

/datum/job/submap/aegis/field_engineer
	title = "Aegis Field Engineer"
	info = "You're A Field Engineer. Do your engineering stuff, make Freeman and Clark proud of you."
	outfit_type = /decl/hierarchy/outfit/aegis/engineer
	total_positions = 1
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_IPC,SPECIES_SKRELL)
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
		SKILL_PILOT   = SKILL_EXPERIENCED,
		SKILL_SCIENCE = SKILL_EXPERIENCED,
		SKILL_MEDICAL = SKILL_EXPERIENCED,
		SKILL_ANATOMY = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_EXPERIENCED,
	)
	skill_points = 20

/datum/job/submap/aegis/field_medic
	title = "Aegis Field Medic"
	info = "You're A Field Medic. Collect your partners as a lego constructor and don't let anyone die until they are ordered to."
	outfit_type = /decl/hierarchy/outfit/aegis/medic
	total_positions = 2
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_IPC,SPECIES_SKRELL)
	required_language = LANGUAGE_HUMAN_EURO
	min_skill = list(
		SKILL_COMBAT = SKILL_BASIC,
		SKILL_DEVICES = SKILL_BASIC,
		SKILL_SCIENCE = SKILL_BASIC,
		SKILL_MEDICAL = SKILL_TRAINED,
		SKILL_ANATOMY = SKILL_BASIC,
		SKILL_CHEMISTRY = SKILL_BASIC,
	)

	max_skill = list(
		SKILL_WEAPONS = SKILL_TRAINED,
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_PILOT   = SKILL_TRAINED,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_MAX,
		SKILL_ANATOMY = SKILL_MAX,
		SKILL_CHEMISTRY = SKILL_MAX,
	)
	skill_points = 20

/datum/job/submap/aegis/rifleman
	title = "Aegis Rifleman"
	info = "You are a professional shooter. Do everything possible not to die and not to let your comrades be killed."
	outfit_type = /decl/hierarchy/outfit/aegis/rifleman
	total_positions = 4
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_IPC,SPECIES_SKRELL)
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



//		OUTFITS		//

/decl/hierarchy/outfit/aegis/captain
	name = "Aegis Captain"

	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/hos/jensen
	back = /obj/item/storage/backpack/satchel/pocketbook/gray
	belt = /obj/item/melee/whip/chainofcommand
	gloves = /obj/item/clothing/gloves/thick/combat
	glasses = /obj/item/clothing/glasses/sunglasses
	shoes = /obj/item/clothing/shoes/dutyboots
	l_pocket = /obj/item/ammo_magazine/magnum
	r_pocket = /obj/item/device/radio/map_preset/aegis
	l_ear = /obj/item/device/radio/headset/map_preset/aegis
	id_types = list(/obj/item/card/id/aegis_captain)
	id = /obj/item/card/id/aegis_captain
	suit_store = /obj/item/gun/projectile/pistol/magnum_pistol
	backpack_contents = list(/obj/item/ammo_magazine/magnum=2, /obj/item/card/id/aegis_captain=1)

/decl/hierarchy/outfit/aegis/officer
	name = "Aegis First Officer"

	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/pcarrier/tan/tactical
	back = /obj/item/storage/backpack/satchel/pocketbook/brown
	belt = /obj/item/storage/belt/holster/security
	gloves = /obj/item/clothing/gloves/thick/combat
	glasses = /obj/item/clothing/glasses/sunglasses
	shoes = /obj/item/clothing/shoes/dutyboots
	l_pocket = /obj/item/ammo_magazine/magnum
	r_pocket = /obj/item/device/radio/map_preset/aegis
	l_ear = /obj/item/device/radio/headset/map_preset/aegis
	id_types = list(/obj/item/card/id/aegis)
	id = /obj/item/card/id/aegis
	suit_store = /obj/item/gun/projectile/pistol/magnum_pistol
	backpack_contents = list(/obj/item/ammo_magazine/magnum=2)

/decl/hierarchy/outfit/aegis/pilot
	name = "Aegis Pilot"

	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/pcarrier/medium
	back = /obj/item/storage/backpack/satchel/grey
	belt = /obj/item/storage/belt/holster/security
	gloves = /obj/item/clothing/gloves/thick/combat
	shoes = /obj/item/clothing/shoes/dutyboots
	head = /obj/item/clothing/head/helmet/solgov/pilot
	l_pocket = /obj/item/storage/firstaid/individual/military
	r_pocket = /obj/item/device/radio/map_preset/aegis
	l_ear = /obj/item/device/radio/headset/map_preset/aegis
	id_types = list(/obj/item/card/id/aegis)
	id = /obj/item/card/id/aegis
	suit_store = /obj/item/gun/projectile/pistol/military/icarus
	backpack_contents = list(/obj/item/device/flashlight/flare=2, /obj/item/ammo_magazine/pistol/double=2)

/decl/hierarchy/outfit/aegis/gunner
	name = "Aegis Gunner"

	uniform = /obj/item/clothing/under/syndicate/combat
	back = /obj/item/storage/backpack/satchel/grey
	belt = /obj/item/storage/belt/holster/security
	gloves = /obj/item/clothing/gloves/thick/combat
	shoes = /obj/item/clothing/shoes/dutyboots
	l_pocket = /obj/item/storage/firstaid/individual/military
	r_pocket = /obj/item/device/radio/map_preset/aegis
	l_ear = /obj/item/device/radio/headset/map_preset/aegis
	id_types = list(/obj/item/card/id/aegis)
	id = /obj/item/card/id/aegis
	suit_store = /obj/item/gun/projectile/pistol/military/icarus
	backpack_contents = list(/obj/item/device/flashlight/flare=2, /obj/item/ammo_magazine/pistol/double=2)

/decl/hierarchy/outfit/aegis/surgeon
	name = "Aegis Surgeon"

	uniform = /obj/item/clothing/under/sterile
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	back = /obj/item/storage/backpack/satchel/med
	belt = /obj/item/storage/belt/medical
	gloves = /obj/item/clothing/gloves/latex/nitrile
	shoes = /obj/item/clothing/shoes/dutyboots
	head = /obj/item/clothing/head/surgery/purple
	l_pocket = /obj/item/storage/pill_bottle/bicaridine
	r_pocket = /obj/item/device/radio/map_preset/aegis
	l_ear = /obj/item/device/radio/headset/map_preset/aegis
	r_ear = /obj/item/reagent_containers/hypospray/autoinjector/combatpain
	id_types = list(/obj/item/card/id/aegis)
	id = /obj/item/card/id/aegis
	backpack_contents = list(/obj/item/reagent_containers/hypospray/autoinjector/combatpain=4, /obj/item/storage/firstaid/combat=2, /obj/item/storage/firstaid/adv=1)

/decl/hierarchy/outfit/aegis/engineer
	name = "Aegis Engineer"

	uniform = /obj/item/clothing/under/syndicate/combat
	back = /obj/item/storage/backpack/satchel/eng
	belt = /obj/item/storage/belt/utility/full
	gloves = /obj/item/clothing/gloves/insulated/combat
	shoes = /obj/item/clothing/shoes/dutyboots
	l_pocket = /obj/item/storage/firstaid/individual/military
	r_pocket = /obj/item/device/radio/map_preset/aegis
	l_ear = /obj/item/device/radio/headset/map_preset/aegis
	id_types = list(/obj/item/card/id/aegis)
	id = /obj/item/card/id/aegis
	backpack_contents = list(/obj/item/gun/energy/plasmacutter=1)

/decl/hierarchy/outfit/aegis/medic
	name = "Aegis Medic"

	uniform = /obj/item/clothing/under/syndicate/combat
	back = /obj/item/storage/backpack/satchel/med
	belt = /obj/item/storage/belt/medical
	gloves = /obj/item/clothing/gloves/latex
	shoes = /obj/item/clothing/shoes/dutyboots
	l_pocket = /obj/item/storage/firstaid/individual/military
	r_pocket = /obj/item/device/radio/map_preset/aegis
	l_ear = /obj/item/device/radio/headset/map_preset/aegis
	r_ear = /obj/item/reagent_containers/hypospray/autoinjector/pouch_auto/adrenaline
	id_types = list(/obj/item/card/id/aegis)
	id = /obj/item/card/id/aegis
	backpack_contents = list(/obj/item/storage/firstaid/adv=1, /obj/item/reagent_containers/hypospray/autoinjector/combatpain=2)

/decl/hierarchy/outfit/aegis/rifleman
	name = "Aegis Rifleman"

	uniform = /obj/item/clothing/under/syndicate/combat
	back = /obj/item/storage/backpack/satchel/grey
	belt = /obj/item/storage/belt/holster/security
	gloves = /obj/item/clothing/gloves/thick/combat
	shoes = /obj/item/clothing/shoes/dutyboots
	r_pocket = /obj/item/device/radio/map_preset/aegis
	l_ear = /obj/item/device/radio/headset/map_preset/aegis
	id_types = list(/obj/item/card/id/aegis)
	id = /obj/item/card/id/aegis
