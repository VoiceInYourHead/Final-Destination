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
		SKILL_BUREAUCRACY   = SKILL_EXPERT,
		SKILL_FINANCE       = SKILL_EXPERT,
		SKILL_EVA           = SKILL_EXPERT,
		SKILL_MECH          = SKILL_EXPERT,
		SKILL_PILOT         = SKILL_EXPERT,
		SKILL_HAULING       = SKILL_NONE,
		SKILL_COMPUTER      = SKILL_PROF,
		SKILL_BOTANY        = SKILL_EXPERT,
		SKILL_COOKING       = SKILL_EXPERT,
		SKILL_COMBAT        = SKILL_EXPERT,
		SKILL_WEAPONS       = SKILL_EXPERT,
		SKILL_FORENSICS     = SKILL_EXPERT,
		SKILL_CONSTRUCTION  = SKILL_EXPERT,
		SKILL_ELECTRICAL    = SKILL_EXPERT,
		SKILL_ATMOS         = SKILL_EXPERT,
		SKILL_ENGINES       = SKILL_EXPERT,
		SKILL_DEVICES       = SKILL_EXPERT,
		SKILL_SCIENCE       = SKILL_EXPERT,
		SKILL_MEDICAL       = SKILL_EXPERT,
		SKILL_ANATOMY       = SKILL_EXPERT,
		SKILL_CHEMISTRY     = SKILL_EXPERT
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