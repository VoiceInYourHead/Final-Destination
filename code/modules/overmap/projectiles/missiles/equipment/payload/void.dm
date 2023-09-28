/obj/item/missile_equipment/payload/void
	name = "void warhead"
	desc = "An incredibly dangerous warhead. Detonates when the missile is triggered."
	icon_state = "diffuse"
	hull_damage = 12

/obj/item/missile_equipment/payload/void/on_trigger(var/atom/triggerer)
	var/list/relevant_z = GetConnectedZlevels(loc.z)

	for(var/mob/living/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!T || !(T.z in relevant_z))
			continue
		to_chat("<font size='5' color='red'><b>The world distorts around you momentarily!</b></font>")
		if(M.eyecheck() < FLASH_PROTECTION_MAJOR)
			M.flash_eyes()
			M.updatehealth()
		if(!isdeaf(M))
			sound_to(M, sound('sound/effects/heavy_cannon_blast.ogg'))

	if(istype(triggerer, /obj/effect/shield))
		cell_explosion(get_turf(src), 1000, 40, effective = /datum/effect/effect/system/explosion/warp)
		empulse(get_turf(src), rand(1,2), rand(3,4))
	else
		cell_explosion(get_turf(triggerer), 1000, 40, effective = /datum/effect/effect/system/explosion/warp)
		empulse(get_turf(triggerer), rand(6,8), rand(8,12))

	..()
