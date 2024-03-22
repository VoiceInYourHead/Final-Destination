// Ulyanovsk Jobs
/*
https://yandex.ru/q/question/kakie_est_dolzhnosti_na_korable_8a6eaca0/?ysclid=ltzmzsv57x865681182

Comandir Korablya
Starpom
Officer - не забыть добавить при спавне /obj/item/gun/projectile/pistol/iccgn
Starshiy Mehanic
Mehanic (Elektromehanik)
Bocman

Pilot - Не забыть добавить при спавне /obj/item/gun/projectile/revolver/rsh21
Gunner (Cannoneer)
Landing Crew (Landing Party Member) - Корабельный Десант, абордажная команда.
*/

/decl/submap_archetype/gccv_ulyanovsk
	descriptor = "GCCV - Ulyanovsk, Heavy Cruiser"
	map = "GCCV - Ulyanovsk"
	crew_jobs = list(/datum/job/submap/gccv_ulyanovsk_crew, )

/datum/job/submap/gccv_ulyanovsk_crew
	title = "Ulyanovsk Crew"
	total_positions = 6
	supervisors = "Your current ship captain and the Commandant of the Pioneering Corps"
	info = "You are the Crew of GCCV-Ulyanovsk, your task is to follow the orders of the command and defend the interests of the Confederation."
	outfit_type = /decl/hierarchy/outfit/job/iccg
	loadout_allowed = TRUE
	selection_color = "#ee380a"
	hud_icon = "hudiccg"
	whitelisted_species = list(SPECIES_HUMAN, SPECIES_VATGROWN, SPECIES_GRAVWORLDER, SPECIES_SPACER, SPECIES_IPC)
	is_semi_antagonist = TRUE
	required_language = LANGUAGE_HUMAN_RUSSIAN
	skill_points = 25
	min_skill = list(
		SKILL_EVA = SKILL_TRAINED,
		SKILL_HAULING = SKILL_TRAINED,
		SKILL_ARMAMENT = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_BASIC
	)

/decl/hierarchy/outfit/job/iccg
	name = "ICCG Crew"
	hierarchy_type = /decl/hierarchy/outfit/job

	uniform = /obj/item/clothing/under/iccgn/utility
	suit = /obj/item/clothing/suit/iccgn/utility
	head = /obj/item/clothing/head/iccgn/beret
	gloves = /obj/item/clothing/gloves/iccgn/duty
	l_ear = /obj/item/device/radio/headset/map_preset/ulyanovsk
	shoes = /obj/item/clothing/shoes/iccgn/utility

	id_slot = slot_wear_id
	id_types = list(/obj/item/card/id/civilian)
	pda_slot = slot_belt
	pda_type = /obj/item/modular_computer/pda/wrist/syndicate

	flags = OUTFIT_FLAGS_JOB_DEFAULT

/obj/effect/submap_landmark/spawnpoint/gccv_ulyanovsk_crew
	name = "Ulyanovsk Crew"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE
