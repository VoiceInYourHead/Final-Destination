//MOBS

/mob/living/simple_animal/hostile/school_police
	name = "\improper SWAT member"
	desc = "I AM THE LAW."
	icon = 'icons/mob/human_races/species/human/npc.dmi'
	icon_state = "npc_police_special1"
	icon_living = "npc_police_special1"
	icon_dead = "npc_police_special_dead"
	icon_gib = "npc_police_special_dead"
	turns_per_move = 5
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 1
	maxHealth = 20
	health = 20
	harm_intent_damage = 5
	natural_weapon = /obj/item/natural_weapon/punch
	can_escape = TRUE
	a_intent = I_HURT
	unsuitable_atmos_damage = 15
	environment_smash = 1
	faction = "police"
	status_flags = CANPUSH

/mob/living/simple_animal/hostile/school_police/ranged
	ranged = 1
	rapid = 1
	icon_state = "npc_police_special2"
	icon_living = "npc_police_special2"
	casingtype = /obj/item/ammo_casing/pistol
	projectilesound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	projectiletype = /obj/item/projectile/bullet/pistol

/mob/living/simple_animal/hostile/school_robot
	name = "bot"
	desc = "A shiny humanoid robot with urge to kill."
	icon = 'icons/fd/animals/ameridian.dmi'
	icon_state = "tender"
	icon_living = "tender"
	icon_dead = "tender_dead"
	health = 120
	maxHealth = 120
	natural_weapon = /obj/item/natural_weapon/hivebot
	faction = "school"
	min_gas = null
	max_gas = null
	minbodytemp = 0
	speed = 3
	armor = list(			// Values for normal getarmor() checks
				"melee" = 20,
				"bullet" = 40,
				"laser" = 10,
				"energy" = 10,
				"bomb" = 40,
				"bio" = 100,
				"rad" = 100
				)
	bleed_colour = SYNTH_BLOOD_COLOUR

	meat_type =     null
	meat_amount =   0
	bone_material = null
	bone_amount =   0
	skin_material = null
	skin_amount =   0

	var/loot_drop = /obj/item/stack/school/coin10

	ai_holder = /datum/ai_holder/simple_animal/hivebot
	say_list_type = /datum/say_list/hivebot

/mob/living/simple_animal/hostile/school_robot/ranged
	icon = 'icons/fd/smallrobot.dmi'
	icon_state = "deimoslaser"
	icon_living = "deimoslaser"
	icon_dead = "deimoslaser_dead"
	health = 80
	maxHealth = 80
	ranged = 1
	speed = 1
	projectiletype = /obj/item/projectile/bullet/pistol/rubber
	base_attack_cooldown = 3 SECONDS
	loot_drop = /obj/item/stack/school/coin5

	ai_holder = /datum/ai_holder/simple_animal/humanoid/hostile

/mob/living/simple_animal/hostile/school_robot/death()
	..(null, "blows apart!")
	new /obj/effect/decal/cleanable/blood/gibs/robot(src.loc)
	new loot_drop(src.loc)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	qdel(src)
	return
