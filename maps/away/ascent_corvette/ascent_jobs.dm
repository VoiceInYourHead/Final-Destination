#define WEBHOOK_SUBMAP_LOADED_ASCENT_CORVETTE "webhook_submap_ascent_corvette"

// Submap datum and archetype.
/decl/webhook/submap_loaded/ascent_corvette
	id = WEBHOOK_SUBMAP_LOADED_ASCENT_CORVETTE

/decl/submap_archetype/ascent_corvette
	descriptor = "Ascent Corvette"
	map = "Ascent Corvette"
	blacklisted_species = null
	whitelisted_species = null
	crew_jobs = list(
		/datum/job/submap/ascent_corvette,
		/datum/job/submap/ascent_corvette/alate,
		/datum/job/submap/ascent_corvette/alate/pilot,
		/datum/job/submap/ascent_corvette/serpentid,
		/datum/job/submap/ascent_corvette/serpentid/queen,
		/datum/job/submap/ascent_corvette/drone
	)
	call_webhook = WEBHOOK_SUBMAP_LOADED_ASCENT_CORVETTE

/datum/submap/ascent_corvette
	var/gyne_name

/datum/submap/ascent_corvette/sync_cell(obj/effect/overmap/visitable/cell)
	return

/mob/living/carbon/human/proc/gyne_rename_lineage_corvette()
	set name = "Name Nest-Lineage"
	set category = "IC"
	set desc = "Rename yourself and your alates."

	if(species.name == SPECIES_MANTID_GYNE && mind && istype(mind.assigned_job, /datum/job/submap/ascent_corvette))
		var/datum/job/submap/ascent/ascent_job = mind.assigned_job
		var/datum/submap/ascent/cutter = ascent_job.owner
		if(istype(cutter))

			var/new_number = input("What is your position in your lineage?", "Name Nest-Lineage") as num|null
			if(!new_number)
				return
			new_number = clamp(new_number, 1, 999)
			var/new_name = sanitize(input("What is the true name of your nest-lineage?", "Name Nest-Lineage") as text|null, MAX_NAME_LEN)
			if(!new_name)
				return

			if(species.name != SPECIES_MANTID_GYNE || !mind || mind.assigned_job != ascent_job)
				return

			// Rename ourselves.
			fully_replace_character_name("[new_number] [new_name]")

			// Rename our alates (and only our alates).
			cutter.gyne_name = new_name
			for(var/mob/living/carbon/human/H in GLOB.human_mob_list)
				if(!H.mind || H.species.name != SPECIES_MANTID_ALATE)
					continue
				var/datum/job/submap/ascent/temp_ascent_job = H.mind.assigned_job
				if(!istype(temp_ascent_job) || temp_ascent_job.owner != ascent_job.owner)
					continue


				var/new_alate_number = is_species_whitelisted(H, SPECIES_MANTID_GYNE) ? random_id(/datum/species/mantid, 1000, 9999) : random_id(/datum/species/mantid, 10000, 99999)
				H.fully_replace_character_name("[new_alate_number] [new_name]")
				to_chat(H, SPAN_NOTICE("<font size = 3>Your gyne, [real_name], has awakened, and you recall your place in the nest-lineage: <b>[H.real_name]</b>.</font>"))

	verbs -= /mob/living/carbon/human/proc/gyne_rename_lineage_corvette

// Jobs.
/datum/job/submap/ascent_corvette
	title = "Ascent Gyne"
	total_positions = 1
	supervisors = "nobody but yourself"
	info = "You are a Gyne of the Ascent, fleeing the murderous Kharmaani political sphere after your first molt. Your search for safe harbour has brought you to this remote unsettled sector. Find a safe nest, and bring prosperity to your lineage."
	outfit_type = /decl/hierarchy/outfit/job/ascent
	blacklisted_species = null
	whitelisted_species = null
	loadout_allowed = FALSE
	is_semi_antagonist = TRUE
	min_skill = list(
		SKILL_EVA = SKILL_TRAINED,
		SKILL_PILOT = SKILL_TRAINED,
		SKILL_HAULING = SKILL_TRAINED,
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_WEAPONS = SKILL_TRAINED,
		SKILL_SCIENCE = SKILL_TRAINED,
		SKILL_MEDICAL = SKILL_BASIC
	)
	skill_points = 24
	var/requires_supervisor = FALSE
	var/set_species_on_join = SPECIES_MANTID_GYNE

/datum/job/submap/ascent_corvette/handle_variant_join(var/mob/living/carbon/human/H, var/alt_title)

	if(ispath(set_species_on_join, /mob/living/silicon/robot))
		return H.Robotize(set_species_on_join)
	if(ispath(set_species_on_join, /mob/living/silicon/ai))
		return H.AIize(set_species_on_join, move = FALSE)

	var/datum/submap/ascent_corvette/cutter = owner
	if(!istype(cutter))
		crash_with("Ascent submap job is being used by a non-Ascent submap, aborting variant join.")
		return

	if(!cutter.gyne_name)
		cutter.gyne_name = create_gyne_name()

	if(set_species_on_join)
		H.set_species(set_species_on_join)
	switch(H.species.name)
		if(SPECIES_MANTID_GYNE)
			H.real_name = "[random_id(/datum/species/mantid, 1, 99)] [cutter.gyne_name]"
			H.verbs |= /mob/living/carbon/human/proc/gyne_rename_lineage_corvette
		if(SPECIES_MANTID_ALATE)
			var/new_alate_number = is_species_whitelisted(H, SPECIES_MANTID_GYNE) ? random_id(/datum/species/mantid, 1000, 9999) : random_id(/datum/species/mantid, 10000, 99999)
			H.real_name = "[new_alate_number] [cutter.gyne_name]"
		if(SPECIES_MONARCH_WORKER)
			H.real_name = "[create_worker_name()]"
			H.verbs |= /mob/living/carbon/human/proc/serpentid_namepick
		if(SPECIES_MONARCH_QUEEN)
			H.real_name = "["Queen "][create_queen_name()]"
			H.verbs |= /mob/living/carbon/human/proc/serpentid_namepick
	H.name = H.real_name
	if(H.mind)
		H.mind.name = H.real_name
	return H

/datum/job/submap/ascent_corvette/alate
	title = "Ascent Alate Worker"
	total_positions = 9
	supervisors = "the Gyne"
	info = "You are an Alate of a powerful Gyne. She has led you to this remote sector to guard it's territories. Follow given instructions and bring prosperity to your nest-lineage."
	set_species_on_join = SPECIES_MANTID_ALATE
	outfit_type = /decl/hierarchy/outfit/job/ascent/tech
	requires_supervisor = "Ascent Gyne"
	use_species_whitelist = null
	min_skill = list(SKILL_EVA = SKILL_TRAINED,
					SKILL_HAULING = SKILL_BASIC,
					SKILL_COMBAT = SKILL_BASIC,
					SKILL_WEAPONS = SKILL_BASIC,
					SKILL_MEDICAL = SKILL_BASIC,
					SKILL_ENGINEERING = SKILL_BASIC)
	skill_points = 18

/datum/job/submap/ascent_corvette/alate/pilot
	title = "Ascent Alate Pilot"
	total_positions = 1
	min_skill = list(SKILL_EVA = SKILL_TRAINED,
					SKILL_HAULING = SKILL_TRAINED,
					SKILL_COMBAT = SKILL_BASIC,
					SKILL_WEAPONS = SKILL_BASIC,
					SKILL_PILOT = SKILL_EXPERIENCED)
	skill_points = 18

/datum/job/submap/ascent_corvette/serpentid
	title = "Ascent Monarch Soldier"
	total_positions = 6
	supervisors = "the Queen"
	info = "You are an Monarch Serpentid soldier of a powerful Queen. She has led you to this remote sector to guard it's territories. Follow given instructions and bring prosperity to your Monarch Queen."
	set_species_on_join = SPECIES_MONARCH_WORKER
	outfit_type = /decl/hierarchy/outfit/job/ascent/soldier
	requires_supervisor = "Ascent Gyne"
	use_species_whitelist = null
	min_skill = list(SKILL_EVA = SKILL_TRAINED,
					SKILL_HAULING = SKILL_TRAINED,
					SKILL_COMBAT = SKILL_TRAINED,
					SKILL_WEAPONS = SKILL_TRAINED,
					SKILL_MEDICAL = SKILL_BASIC)
	skill_points = 18

/datum/job/submap/ascent_corvette/serpentid/queen
	title = "Ascent Monarch Queen"
	total_positions = 1
	supervisors = "the Gyne"
	info = "You are an Monarch Serpentid Queen. Follow youre gyne orders."
	set_species_on_join = SPECIES_MONARCH_QUEEN
	outfit_type = /decl/hierarchy/outfit/job/ascent/queen
	use_species_whitelist = null
	min_skill = list(
		SKILL_EVA = SKILL_TRAINED,
		SKILL_PILOT = SKILL_BASIC,
		SKILL_HAULING = SKILL_TRAINED,
		SKILL_SCIENCE = SKILL_TRAINED,
		SKILL_MEDICAL = SKILL_BASIC
	)
	skill_points = 24

/datum/job/submap/ascent_corvette/drone
	title = "Ascent Drone"
	supervisors = "the Gyne"
	total_positions = 2
	info = "You are a Machine Intelligence of an independent Ascent vessel. The Gyne you assist has fled her sisters, ending up in this sector full of primitive bioforms. Try to keep her alive, and assist where you can."
	set_species_on_join = /mob/living/silicon/robot/flying/ascent
	requires_supervisor = "Ascent Gyne"
	use_species_whitelist = null

// Spawn points.

/obj/effect/submap_landmark/spawnpoint/ascent_corvette
	name = "Ascent Gyne"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/submap_landmark/spawnpoint/ascent_corvette/pilot
	name = "Ascent Alate Pilot"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/submap_landmark/spawnpoint/ascent_corvette/serpentid
	name = "Ascent Monarch Soldier"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/submap_landmark/spawnpoint/ascent_corvette/worker
	name = "Ascent Alate Worker"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/submap_landmark/spawnpoint/ascent_corvette/queen
	name = "Ascent Monarch Queen"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/submap_landmark/spawnpoint/ascent_corvette/drone
	name = "Ascent Drone"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

#undef WEBHOOK_SUBMAP_LOADED_ASCENT_CORVETTE
