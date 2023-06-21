/decl/submap_archetype/ascent_auto
	descriptor = "Ascent Scout Drone"
	map = "Ascent Scout Drone"
	blacklisted_species = null
	whitelisted_species = null
	crew_jobs = list(
		/datum/job/submap/ascent_auto,
	)

/datum/job/submap/ascent_auto
	title = "Ascent AI"

	total_positions = 0 // Not used for AI, see is_position_available below and modules/mob/living/silicon/ai/latejoin.dm
	spawn_positions = 1
	supervisors = "your hive"
	outfit_type = /decl/hierarchy/outfit/job/silicon/ai
	loadout_allowed = FALSE
	hud_icon = "hudblank"
	skill_points = 0
	no_skill_buffs = TRUE
	min_skill = list(
		SKILL_BUREAUCRACY   = SKILL_EXPERIENCED,
		SKILL_FINANCE       = SKILL_EXPERIENCED,
		SKILL_EVA           = SKILL_EXPERIENCED,
		SKILL_MECH          = SKILL_EXPERIENCED,
		SKILL_PILOT         = SKILL_EXPERIENCED,
		SKILL_HAULING       = SKILL_UNSKILLED,
		SKILL_COMPUTER      = SKILL_MASTER,
		SKILL_BOTANY        = SKILL_EXPERIENCED,
		SKILL_COOKING       = SKILL_EXPERIENCED,
		SKILL_COMBAT        = SKILL_EXPERIENCED,
		SKILL_WEAPONS       = SKILL_EXPERIENCED,
		SKILL_FORENSICS     = SKILL_EXPERIENCED,
		SKILL_CONSTRUCTION  = SKILL_EXPERIENCED,
		SKILL_ELECTRICAL    = SKILL_EXPERIENCED,
		SKILL_ATMOS         = SKILL_EXPERIENCED,
		SKILL_ENGINES       = SKILL_EXPERIENCED,
		SKILL_DEVICES       = SKILL_EXPERIENCED,
		SKILL_SCIENCE       = SKILL_EXPERIENCED,
		SKILL_MEDICAL       = SKILL_EXPERIENCED,
		SKILL_ANATOMY       = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY     = SKILL_EXPERIENCED
	)

/datum/job/submap/ascent_auto/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0
	return 1

/datum/job/submap/ascent_auto/is_position_available()
	return (empty_playable_ai_cores.len != 0)

/datum/job/submap/ascent_auto/handle_variant_join(var/mob/living/carbon/human/H, var/alt_title)
	return H

// Spawn points.

/obj/effect/submap_landmark/spawnpoint/ascent_auto
	name = "Ascent AI"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE