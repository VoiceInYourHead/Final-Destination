/obj/item/missile_equipment/payload/nuclear
	name = "nuclear warhead"
	desc = "An incredibly dangerous warhead. Detonates when the missile is triggered."
	icon_state = "ion"

/obj/item/missile_equipment/payload/nuclear/on_trigger(var/atom/triggerer)
	if(istype(triggerer, /obj/effect/shield))
		explosion(get_turf(src), 5, 10, 10, 10)
		empulse(get_turf(src), rand(10,20), rand(25,50))
		var/obj/effect/shield/S = triggerer
		S.take_damage(50000)
	else
		explosion(get_turf(src), 20, 30, 30, 30)
		empulse(get_turf(src), rand(25,50), rand(50,100))

	for(var/mob/living/carbon/human/M in GLOB.player_list)
		if(M.eyecheck() < FLASH_PROTECTION_MAJOR)
			M.flash_eyes()
			M.updatehealth()

	to_world("<font size='4' color='red'><b>Suddenly a blinding bright flash appears in nearby outer space, followed by a distant shockwave.</b></font>")
	sound_to(world, sound('sound/effects/explosionfar.ogg'))


	..()

/obj/item/missile_equipment/payload/nuclear/doomsday
	name = "doomsday warhead"
	desc = "An incredibly dangerous warhead. Detonates when the missile is triggered."
	icon_state = "ion"

/obj/item/missile_equipment/payload/doomsday/on_trigger(var/atom/triggerer)
	if(istype(triggerer, /obj/effect/shield))
		explosion(get_turf(src), 15, 30, 30, 30)
		empulse(get_turf(src), rand(10,20), rand(25,50))
		var/obj/effect/shield/S = triggerer
		S.take_damage(150000)
	else
		explosion(get_turf(src), 60, 90, 90, 90)
		empulse(get_turf(src), rand(50,75), rand(75,100))

	for(var/mob/living/carbon/human/M in GLOB.player_list)
		if(M.eyecheck() < FLASH_PROTECTION_MAJOR)
			M.flash_eyes()
			M.updatehealth()

	to_world("<font size='4' color='red'><b>The doomsday is calling...</b></font>")
	sound_to(world, sound('sound/effects/explosionfar.ogg'))


	..()