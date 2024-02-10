//MOBS

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
	health = 80
	maxHealth = 80
	ranged = 1
	speed = 1
	projectiletype = /obj/item/projectile/beam/smalllaser
	base_attack_cooldown = 3 SECONDS
	loot_drop = /obj/item/stack/school/coin5

	ai_holder = /datum/ai_holder/simple_animal/hivebot/ranged

/mob/living/simple_animal/hostile/school_robot/death()
	..(null, "blows apart!")
	new /obj/effect/decal/cleanable/blood/gibs/robot(src.loc)
	new loot_drop(src.loc)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	qdel(src)
	return