/obj/effect/submap_landmark/joinable_submap/providence
	name = "IPV Providence"
	archetype = /decl/submap_archetype/providence

/decl/submap_archetype/providence
	descriptor = "IPV Providence"
	map = "IPV Providence"
	crew_jobs = list(
		/datum/job/submap/providence/trucker
	)

/datum/job/submap/providence/trucker
	title = "Pilot Freelancer"
	total_positions = 1
	supervisors = "nobody but yourself"
	info = "It's a best job in your entire life"
	outfit_type = /decl/hierarchy/outfit/trucker
	loadout_allowed = TRUE
	min_skill = list(
		SKILL_EVA = SKILL_TRAINED,
		SKILL_HAULING = SKILL_TRAINED,
		SKILL_PILOT = SKILL_TRAINED,
		SKILL_DEVICES = SKILL_BASIC,
		SKILL_MEDICAL = SKILL_BASIC
	)

/obj/effect/submap_landmark/spawnpoint/providence/trucker
	name = "Pilot Freelancer"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE