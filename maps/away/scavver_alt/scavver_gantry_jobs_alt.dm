/datum/job/submap/scavver_pilot
	title = "Salvage Pilot"
	total_positions = 1
	outfit_type = /decl/hierarchy/outfit/job/scavver/pilot
	supervisors = "The trust of your fellow crew."
	info = "You are the pilot of your meagre Scavenger Crew. Keep your crew safe, and seek supplies for your rig. \
	Your weapons are limited; trade, salvage, but avoid conflict as a matter of course."
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_IPC,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_TRITONIAN,SPECIES_MULE,SPECIES_RESOMI)
	is_semi_antagonist = TRUE
	min_skill = list(
		SKILL_HAULING = SKILL_BASIC,
		SKILL_EVA = SKILL_EXPERIENCED,
		SKILL_MECH = SKILL_MAX,
		SKILL_SCIENCE = SKILL_TRAINED,
		SKILL_PILOT = SKILL_TRAINED,
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_WEAPONS = SKILL_TRAINED
	)

	max_skill = list(
		SKILL_BUREAUCRACY = SKILL_MAX,
		SKILL_FINANCE = SKILL_MAX,
		SKILL_EVA = SKILL_MAX,
		SKILL_PILOT = SKILL_MAX,
		SKILL_HAULING = SKILL_MAX,
		SKILL_COMPUTER = SKILL_MAX,
		SKILL_BOTANY = SKILL_MAX,
		SKILL_COOKING = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_FORENSICS = SKILL_MAX,
		SKILL_CONSTRUCTION = SKILL_MAX,
		SKILL_ELECTRICAL = SKILL_EXPERIENCED,
		SKILL_ATMOS = SKILL_EXPERIENCED,
		SKILL_ENGINES = SKILL_EXPERIENCED,
		SKILL_DEVICES = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_EXPERIENCED,
		SKILL_ANATOMY = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_EXPERIENCED
	)
	skill_points = 20

/datum/job/submap/scavver
	title = "Salvager"
//	total_positions = 4
	total_positions = 3
	outfit_type = /decl/hierarchy/outfit/job/scavver/standart
	supervisors = "The trust of your fellow crew."
	info = "You are a part of your meagre Scavenger Crew. Keep yourself safe, and seek supplies for your mother-ship. \
	Your weapons are limited; trade, salvage, but avoid conflict as a matter of course."
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_IPC,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_TRITONIAN,SPECIES_MULE)
	is_semi_antagonist = TRUE
	min_skill = list(
		SKILL_HAULING = SKILL_BASIC,
		SKILL_EVA = SKILL_EXPERIENCED,
		SKILL_SCIENCE = SKILL_BASIC,
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_WEAPONS = SKILL_TRAINED
	)

	max_skill = list(
		SKILL_BUREAUCRACY = SKILL_MAX,
		SKILL_FINANCE = SKILL_MAX,
		SKILL_EVA = SKILL_MAX,
		SKILL_MECH = SKILL_MAX,
		SKILL_PILOT = SKILL_MAX,
		SKILL_HAULING = SKILL_MAX,
		SKILL_COMPUTER = SKILL_MAX,
		SKILL_BOTANY = SKILL_MAX,
		SKILL_COOKING = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_FORENSICS = SKILL_MAX,
		SKILL_CONSTRUCTION = SKILL_MAX,
		SKILL_ELECTRICAL = SKILL_TRAINED,
		SKILL_ATMOS = SKILL_TRAINED,
		SKILL_ENGINES = SKILL_EXPERIENCED,
		SKILL_DEVICES = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_MAX,
		SKILL_ANATOMY = SKILL_TRAINED,
		SKILL_CHEMISTRY = SKILL_TRAINED
	)
	skill_points = 20

/datum/job/submap/scavver_doctor
	title = "Salvage Doctor"
	total_positions = 1
	outfit_type = /decl/hierarchy/outfit/job/scavver/doctor
	supervisors = "The trust of those you heal."
	info = "You are the doctor aboard your meagre Salvage team. Keep everyone alive. Your weapons are limited; trade, salvage, but avoid conflict as a matter of course."
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_IPC,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_TRITONIAN,SPECIES_MULE)
	is_semi_antagonist = TRUE
	min_skill = list(
		SKILL_HAULING = SKILL_BASIC,
		SKILL_EVA = SKILL_EXPERIENCED,
		SKILL_MEDICAL = SKILL_EXPERIENCED,
		SKILL_ANATOMY = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_BASIC,
		SKILL_DEVICES = SKILL_TRAINED
	)

	max_skill = list(
		SKILL_BUREAUCRACY = SKILL_MAX,
		SKILL_FINANCE = SKILL_MAX,
		SKILL_EVA = SKILL_MAX,
		SKILL_MECH = SKILL_MAX,
		SKILL_PILOT = SKILL_MAX,
		SKILL_HAULING = SKILL_MAX,
		SKILL_COMPUTER = SKILL_MAX,
		SKILL_BOTANY = SKILL_MAX,
		SKILL_COOKING = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_FORENSICS = SKILL_MAX,
		SKILL_CONSTRUCTION = SKILL_TRAINED,
		SKILL_ELECTRICAL = SKILL_TRAINED,
		SKILL_ATMOS = SKILL_TRAINED,
		SKILL_ENGINES = SKILL_TRAINED,
		SKILL_DEVICES = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_MAX,
		SKILL_ANATOMY = SKILL_MAX,
		SKILL_CHEMISTRY = SKILL_MAX
	)
	skill_points = 20

/datum/job/submap/scavver_engineer
	title = "Salvage Engineer"
	total_positions = 2
	outfit_type = /decl/hierarchy/outfit/job/scavver/engineer
	supervisors = "The trust of your fellow crew."
	info = "You are an Engineer aboard your meagre Salvage team. Keep your rig in functional order, upgrade what systems you can, and don't space yourself. \
	Your weapons are limited; trade, salvage, but avoid conflict as a matter of course."
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_IPC,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_TRITONIAN,SPECIES_MULE)
	is_semi_antagonist = TRUE
	min_skill = list(
		SKILL_HAULING = SKILL_BASIC,
		SKILL_COMPUTER = SKILL_BASIC,
		SKILL_EVA = SKILL_EXPERIENCED,
		SKILL_CONSTRUCTION = SKILL_TRAINED,
		SKILL_ELECTRICAL = SKILL_BASIC,
		SKILL_ATMOS = SKILL_BASIC,
		SKILL_ENGINES = SKILL_BASIC
	)

	max_skill = list(
		SKILL_BUREAUCRACY = SKILL_MAX,
		SKILL_FINANCE = SKILL_MAX,
		SKILL_EVA = SKILL_MAX,
		SKILL_MECH = SKILL_MAX,
		SKILL_PILOT = SKILL_MAX,
		SKILL_HAULING = SKILL_MAX,
		SKILL_COMPUTER = SKILL_MAX,
		SKILL_BOTANY = SKILL_MAX,
		SKILL_COOKING = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_FORENSICS = SKILL_MAX,
		SKILL_CONSTRUCTION = SKILL_MAX,
		SKILL_ELECTRICAL = SKILL_MAX,
		SKILL_ATMOS = SKILL_MAX,
		SKILL_ENGINES = SKILL_MAX,
		SKILL_DEVICES = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_TRAINED,
		SKILL_ANATOMY = SKILL_TRAINED,
		SKILL_CHEMISTRY = SKILL_TRAINED
	)
	skill_points = 20
/*
/datum/job/submap/scavver_cook
	title = "Salvage Cook"
	total_positions = 1
	outfit_type = /decl/hierarchy/outfit/job/scavver/cook
	supervisors = "The trust of your fellow crew."
	info = "You are the cook onboard salvagers vessel. Keep your crew in good mood and well-fed. \
	Your weapons are limited; trade, salvage, but avoid conflict as a matter of course."
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_IPC,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_TRITONIAN,SPECIES_MULE,SPECIES_DIONA)
	is_semi_antagonist = TRUE
	min_skill = list(
		SKILL_HAULING = SKILL_BASIC,
		SKILL_EVA = SKILL_EXPERIENCED,
		SKILL_WEAPONS = SKILL_BASIC,
		SKILL_COOKING = SKILL_EXPERIENCED,
		SKILL_BOTANY    = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_EXPERIENCED
	)

	max_skill = list(
		SKILL_BUREAUCRACY = SKILL_MAX,
		SKILL_FINANCE = SKILL_MAX,
		SKILL_EVA = SKILL_MAX,
		SKILL_PILOT = SKILL_MAX,
		SKILL_HAULING = SKILL_MAX,
		SKILL_COMPUTER = SKILL_MAX,
		SKILL_BOTANY = SKILL_MAX,
		SKILL_COOKING = SKILL_MAX,
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_WEAPONS = SKILL_TRAINED,
		SKILL_FORENSICS = SKILL_MAX,
		SKILL_CONSTRUCTION = SKILL_MAX,
		SKILL_ELECTRICAL = SKILL_EXPERIENCED,
		SKILL_ATMOS = SKILL_EXPERIENCED,
		SKILL_ENGINES = SKILL_EXPERIENCED,
		SKILL_DEVICES = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_EXPERIENCED,
		SKILL_ANATOMY = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_EXPERIENCED
	)
	skill_points = 15
*/
/*/datum/job/submap/scavver_bar
	title = "Salvage Bartender"
	total_positions = 1
	outfit_type = /decl/hierarchy/outfit/job/scavver/bar
	supervisors = "The trust of your fellow crew."
	info = "You are the Bartender onboard salvagers vessel. Keep your crew in good mood, but don't overdo it with a drink. \
	Your weapons are limited; trade, salvage, but avoid conflict as a matter of course."
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_IPC,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_TRITONIAN,SPECIES_MULE,SPECIES_DIONA)
	is_semi_antagonist = TRUE
	min_skill = list(
		SKILL_HAULING = SKILL_BASIC,
		SKILL_EVA = SKILL_EXPERIENCED,
		SKILL_WEAPONS = SKILL_TRAINED,
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_COOKING = SKILL_BASIC,
		SKILL_BOTANY    = SKILL_BASIC,
		SKILL_CHEMISTRY = SKILL_EXPERIENCED
	)

	max_skill = list(
		SKILL_BUREAUCRACY = SKILL_MAX,
		SKILL_FINANCE = SKILL_MAX,
		SKILL_EVA = SKILL_MAX,
		SKILL_PILOT = SKILL_MAX,
		SKILL_HAULING = SKILL_MAX,
		SKILL_COMPUTER = SKILL_MAX,
		SKILL_BOTANY = SKILL_MAX,
		SKILL_COOKING = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_FORENSICS = SKILL_MAX,
		SKILL_CONSTRUCTION = SKILL_MAX,
		SKILL_ELECTRICAL = SKILL_EXPERIENCED,
		SKILL_ATMOS = SKILL_EXPERIENCED,
		SKILL_ENGINES = SKILL_EXPERIENCED,
		SKILL_DEVICES = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_EXPERIENCED,
		SKILL_ANATOMY = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_MAX
	)
	skill_points = 15*/

/datum/job/submap/scavver_cyborg
	title = "Salvage Drone"
	department_flag = MSC
	total_positions = 1
	spawn_positions = 1
	supervisors = "your laws and the AI"
	minimal_player_age = 7
	account_allowed = 0
	economic_power = 0
	loadout_allowed = FALSE
	outfit_type = /decl/hierarchy/outfit/job/silicon/cyborg
	hud_icon = "hudblank"
	skill_points = 0
	no_skill_buffs = TRUE

/datum/job/submap/scavver_cyborg/handle_variant_join(var/mob/living/carbon/human/H, var/alt_title)
	return H && H.Robotize(SSrobots.get_mob_type_by_title(alt_title || title))

/datum/job/submap/scavver_cyborg/equip(var/mob/living/carbon/human/H)
	return !!H

/datum/job/submap/scavver_cyborg/New()
	..()
	alt_titles = SSrobots.robot_alt_titles.Copy()
	alt_titles -= title // So the unit test doesn't flip out if a mob or mmi type is declared for our main title.

/obj/effect/submap_landmark/spawnpoint/scavver_pilot
	name = "Salvage Pilot"

/obj/effect/submap_landmark/spawnpoint/scavver
	name = "Salvager"

/obj/effect/submap_landmark/spawnpoint/scavver_cook
	name = "Salvage Cook"

/obj/effect/submap_landmark/spawnpoint/scavver_bar
	name = "Salvage Bartender"

/obj/effect/submap_landmark/spawnpoint/scavver_doctor
	name = "Salvage Doctor"

/obj/effect/submap_landmark/spawnpoint/scavver_engineer
	name = "Salvage Engineer"

/obj/effect/submap_landmark/spawnpoint/scavver_cyborg
	name = "Salvage Drone"

/decl/hierarchy/outfit/job/scavver
	name = "Salvager"
	l_ear = /obj/item/device/radio/headset/map_preset/scavver
	r_ear = null
	uniform = /obj/item/clothing/under/frontier
	r_pocket = /obj/item/device/radio/map_preset/scavver
	l_pocket = /obj/item/crowbar/prybar
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/thick
	belt = /obj/item/gun/energy/gun/small
	hierarchy_type = /decl/hierarchy/outfit/job/scavver
	id_types = null
	pda_type = null

/decl/hierarchy/outfit/job/scavver/standart
	name = "Salvager"
	l_ear = /obj/item/device/radio/headset/map_preset/scavver
	r_ear = null
	uniform = /obj/item/clothing/under/frontier
	r_pocket = /obj/item/device/radio/map_preset/scavver
	l_pocket = /obj/item/crowbar/prybar
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/thick
	belt = /obj/item/gun/energy/gun/small

/decl/hierarchy/outfit/job/scavver/engineer
	name = "Salvage Engineer"
	uniform = /obj/item/clothing/under/hazard
	r_pocket = /obj/item/device/radio/map_preset/scavver
	l_pocket = /obj/item/crowbar/prybar
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/thick/duty
	glasses = /obj/item/clothing/glasses/meson
//	belt = null

/decl/hierarchy/outfit/job/scavver/pilot
	name = "Salvage Pilot"
	uniform = /obj/item/clothing/under/rank/dispatch
	suit = /obj/item/clothing/suit/armor/pcarrier/light
	r_pocket = /obj/item/device/radio/map_preset/scavver
	l_pocket = /obj/item/crowbar/prybar
	shoes = /obj/item/clothing/shoes/jackboots
	belt = null

/decl/hierarchy/outfit/job/scavver/doctor
	name = "Salvage Doctor"
	uniform = /obj/item/clothing/under/caretaker
	r_pocket = /obj/item/device/radio/map_preset/scavver
	l_pocket = /obj/item/crowbar/prybar
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/white
	gloves = /obj/item/clothing/gloves/latex
	belt = null

/decl/hierarchy/outfit/job/scavver/cook
	name = "Salvage Cook"
	uniform = /obj/item/clothing/under/rank/chef
	r_pocket = /obj/item/device/radio/map_preset/scavver
	l_pocket = /obj/item/crowbar/prybar
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/thick/duty
	belt = null

/decl/hierarchy/outfit/job/scavver/bar
	name = "Salvage Bartender"
	uniform = /obj/item/clothing/under/rank/chef
	r_pocket = /obj/item/device/radio/map_preset/scavver
	l_pocket = /obj/item/crowbar/prybar
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/thick/duty
//	belt = null