/obj/item/missile_equipment/payload/void
	name = "void warhead"
	desc = "An incredibly dangerous warhead. Detonates when the missile is triggered."
	icon_state = "diffuse"
	hull_damage = 12

/obj/item/missile_equipment/payload/void/on_trigger(var/atom/triggerer)
	if(istype(triggerer, /obj/effect/shield))
		explosion(get_turf(triggerer), 10, EX_ACT_DEVASTATING, turf_breaker = TRUE)
		empulse(get_turf(triggerer), rand(10,20), rand(25,50))
		var/obj/effect/shield/S = triggerer
		S.take_damage(40000)
	else
		explosion(get_turf(triggerer), 20, EX_ACT_DEVASTATING, turf_breaker = TRUE)
		empulse(get_turf(triggerer), rand(25,50), rand(50,100))

	var/list/relevant_z = GetConnectedZlevels(src.z)

	for(var/mob/living/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!T || !(T.z in relevant_z))
			continue
		to_chat("<font size='5' color='red'><b>The world distorts around you momentarily!</b></font>")
		if(M.eyecheck() < FLASH_PROTECTION_MAJOR)
			M.flash_eyes()
			M.updatehealth()
		if(!isdeaf(M)) //Meanwhile front might have exploded
			sound_to(M, sound('sound/effects/heavy_cannon_blast.ogg'))


	..()