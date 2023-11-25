/datum/species/resomi
	name = SPECIES_RESOMI
	name_plural = "Resomii"
	description = "A race of feathered raptors who developed in a cold world. \
	Extremely fragile, they developed hunting skills that emphasized taking \
	out their prey without themselves getting hit. They are pretty new species, \
	discovered by humans."

	min_age = 15
	max_age = 65
	hidden_from_codex = FALSE
	health_hud_intensity = 3

	blood_color = "#d514f7"
	flesh_color = "#5f7bb0"
	base_color = "#001144"
	tail = "resomitail"
	tail_hair = "feathers"
	strength = STR_HIGH
	reagent_tag = IS_RESOMI
	breath_pressure = 12

	move_trail = /obj/effect/decal/cleanable/blood/tracks/paw

	icobase = 			'icons/mob/human_races/species/resomi/body.dmi'
	deform = 			'icons/mob/human_races/species/resomi/body.dmi'
	damage_overlays = 	'icons/mob/human_races/species/resomi/damage_overlay.dmi'
	damage_mask = 		'icons/mob/human_races/species/resomi/damage_mask.dmi'
	blood_mask = 		'icons/mob/human_races/species/resomi/blood_mask.dmi'
	preview_icon =		'icons/mob/human_races/species/resomi/preview.dmi'
	husk_icon = 		'icons/mob/human_races/species/resomi/husk.dmi'

	slowdown = -0.8 //speed fix?

	darksight_range = 6
	darksight_tint = DARKTINT_GOOD
	flash_mod = 2
	total_health = 150
	brute_mod = 1.35
	burn_mod =  1.35
	metabolism_mod = 2.0
	mob_size = MOB_SMALL
	holder_type = /obj/item/holder/human
	light_sensitive = 6
	blood_volume = 280
	hunger_factor = DEFAULT_HUNGER_FACTOR * 1.5
	thirst_factor = DEFAULT_THIRST_FACTOR * 1.3
	taste_sensitivity = TASTE_SENSITIVE
	pulse_rate_mod = 1.5
	body_temperature = 314.15

	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED | SPECIES_NO_FBP_CONSTRUCTION | SPECIES_NO_FBP_CHARGEN
	appearance_flags = HAS_HAIR_COLOR | HAS_SKIN_COLOR | HAS_EYE_COLOR | HAS_A_SKIN_TONE
	bump_flag = MONKEY
	swap_flags = MONKEY|SLIME|SIMPLE_ANIMAL
	push_flags = MONKEY|SLIME|SIMPLE_ANIMAL|ALIEN

	cold_level_1 = 180
	cold_level_2 = 130
	cold_level_3 = 70
	heat_level_1 = 320
	heat_level_2 = 370
	heat_level_3 = 600
	heat_discomfort_level = 292
	heat_discomfort_strings = list(
		"Your feathers prickle in the heat.",
		"You feel uncomfortably warm.",
		)
	cold_discomfort_level = 200
	cold_discomfort_strings = list(
		"You can't feel your paws because of the cold.",
		"You feel sluggish and cold.",
		"Your feathers bristle against the cold.")

	has_limbs = list(
		BP_CHEST =  list("path" = /obj/item/organ/external/chest),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin),
		BP_HEAD =   list("path" = /obj/item/organ/external/head),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand/resomi),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right/resomi),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot/resomi),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right/resomi)
		)

	has_organ = list(
		BP_HEART =    /obj/item/organ/internal/heart,
		BP_LUNGS =    /obj/item/organ/internal/lungs,
		BP_LIVER =    /obj/item/organ/internal/liver/resomi,
		BP_STOMACH =  /obj/item/organ/internal/stomach,
		BP_KIDNEYS =  /obj/item/organ/internal/kidneys/resomi,
		BP_BRAIN =    /obj/item/organ/internal/brain,
		BP_EYES =     /obj/item/organ/internal/eyes/resomi
		)

	unarmed_types = list(
		/datum/unarmed_attack/bite/sharp,
		/datum/unarmed_attack/claws,
		/datum/unarmed_attack/punch,
		/datum/unarmed_attack/stomp/weak
		)

	inherent_verbs = list(
		/mob/living/carbon/human/proc/resomi_sonar_ping,
		/mob/living/proc/toggle_pass_table,
		/mob/proc/switch_tail_layer
		)

	descriptors = list(
		/datum/mob_descriptor/height = -8,
		/datum/mob_descriptor/build = -8
		)

	available_cultural_info = list(
		TAG_CULTURE = list(
			CULTURE_RESOMI_TEMALI,
			CULTURE_RESOMI_SHAYAMI,
			CULTURE_RESOMI_SHOSHONI,
			CULTURE_RESOMI_ATARI,
			CULTURE_RESOMI_OTHER,
			CULTURE_RESOMI_SPACER,
			CULTURE_OTHER
		),
		TAG_HOMEWORLD = list(
			HOME_SYSTEM_RESOMI_ALISH,
			HOME_SYSTEM_OTHER
		),
		TAG_FACTION = list(
			FACTION_RESOMI_URE,
			FACTION_RESOMI_CONCORD,
			FACTION_RESOMI_INDEPENDENT,
			FACTION_EXPEDITIONARY,
			FACTION_OTHER
		),
		TAG_RELIGION =  list(
			RELIGION_OTHER
		)
	)

	species_bonus = 2

/datum/species/resomi/equip_survival_gear(var/mob/living/carbon/human/H)
	..()
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/lenses(H), slot_glasses)

/datum/species/resomi/get_surgery_overlay_icon(var/mob/living/carbon/human/H)
	return 'icons/mob/human_races/species/resomi/surgery.dmi'

/datum/species/resomi/skills_from_age(age)
	switch(age)
		if(0 to 17)		. = -2
		if(18 to 25)	. = 0
		if(26 to 35)	. = 4
		else			. = 0