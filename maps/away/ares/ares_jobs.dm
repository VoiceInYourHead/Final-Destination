#define WEBHOOK_SUBMAP_LOADED_ARES "webhook_submap_ares"

// Submap datum and archetype.
/decl/webhook/submap_loaded/ares
	id = WEBHOOK_SUBMAP_LOADED_ARES

/decl/submap_archetype/ares
	descriptor = "Company Mining Ship"
	map = "Ares"
	crew_jobs = list(/datum/job/submap/ares, /datum/job/submap/ares_cyborg)
	call_webhook = WEBHOOK_SUBMAP_LOADED_ARES

/decl/hierarchy/outfit/job/cargo/mining/ares
	uniform = /obj/item/clothing/under/grayson
	pda_type = null
	l_ear = null

/datum/job/submap/ares
	title = "Prospectoring Specialist"
	total_positions = 6
	supervisors = "nobody but yourself"
	info = "FOR ROCK AND STONE BROTHA!"
	outfit_type = /decl/hierarchy/outfit/job/cargo/mining/ares
	loadout_allowed = FALSE
	min_skill = list(
		SKILL_EVA = SKILL_ADEPT,
		SKILL_HAULING = SKILL_ADEPT,
		SKILL_DEVICES = SKILL_BASIC,
		SKILL_MEDICAL = SKILL_BASIC
	)

/datum/job/submap/ares_cyborg
	title = "Corporate Bot"
	total_positions = 1
	supervisors = "your laws and corporate miners"
	minimal_player_age = 7
	account_allowed = 0
	economic_power = 0
	loadout_allowed = FALSE
	outfit_type = /decl/hierarchy/outfit/job/silicon/cyborg
	hud_icon = "hudblank"
	skill_points = 0

/datum/job/submap/ares_cyborg/handle_variant_join(var/mob/living/carbon/human/H, var/alt_title)
	return H && H.Robotize(SSrobots.get_mob_type_by_title(alt_title || title))

/datum/job/submap/ares_cyborg/equip(var/mob/living/carbon/human/H)
	return !!H

/datum/job/submap/ares_cyborg/New()
	..()
	alt_titles = SSrobots.robot_alt_titles.Copy()
	alt_titles -= title // So the unit test doesn't flip out if a mob or mmi type is declared for our main title.


/obj/effect/submap_landmark/spawnpoint/ares
	name = "Prospectoring Specialist"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/submap_landmark/spawnpoint/ares/cyborg
	name = "Corporate Bot"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

#undef WEBHOOK_SUBMAP_LOADED_ARES
