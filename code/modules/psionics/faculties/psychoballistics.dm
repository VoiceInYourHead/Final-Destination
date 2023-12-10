/decl/psionic_faculty/psychoballistics
	id = PSI_PSYCHOBALLISTICS
	name = "Psychoballistics"
	associated_intent = I_HURT
	armour_types = list("bullet", "melee")

/decl/psionic_power/psychoballistics
	faculty = PSI_PSYCHOBALLISTICS
	use_sound = null

/decl/psionic_power/psychoballistics/spit
	name =             "Bullet Spit"
	cost =             20
	cooldown =         45
	use_ranged =       TRUE
	min_rank =         PSI_RANK_APPRENTICE
	use_description = "Use this ranged attack while targeting mouth on harm intent. Your mastery of Psychoballistics will determine how powerful the bullet is. Be wary of overuse, and try not to shot down yourself."

/obj/item/projectile/psi
	name = "psionic projectile"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "dark_pellet"
	damage = 20
	distance_falloff = 1
	penetration_modifier = 1.0
	damage_type = BRUTE
	damage_flags = DAM_BULLET | DAM_SHARP
	miss_sounds = list('sound/weapons/guns/miss1.ogg','sound/weapons/guns/miss2.ogg','sound/weapons/guns/miss3.ogg','sound/weapons/guns/miss4.ogg')
	ricochet_sounds = list('sound/weapons/guns/ricochet1.ogg', 'sound/weapons/guns/ricochet2.ogg',
							'sound/weapons/guns/ricochet3.ogg', 'sound/weapons/guns/ricochet4.ogg')
	impact_sounds = list(BULLET_IMPACT_MEAT = SOUNDS_BULLET_MEAT, BULLET_IMPACT_METAL = SOUNDS_BULLET_METAL)

/obj/item/projectile/psi/strong
	damage = 15
	icon_state = "plasma_bolt"
	color = "#c40eed"
	var/explosion_power = 150
	var/explosion_falloff = 50

/obj/item/projectile/psi/strong/on_hit(var/atom/target, var/blocked = 0)
	cell_explosion(get_turf(target), explosion_power, explosion_falloff)
	..()

/decl/psionic_power/psychoballistics/spit/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_MOUTH)
		return FALSE
	. = ..()
	if(.)
		user.visible_message("<span class='danger'>\The [user] sneezing, spitting a bullet right from a mouth!</span>")
		user.emote("sneeze")

		var/user_rank = user.psi.get_rank(faculty)
		var/obj/item/projectile/pew
		var/pew_sound

		user.psi.set_cooldown(cooldown)
		sleep(4)
		user.psi.spend_power(cost)
		switch(user_rank)
			if(PSI_RANK_GRANDMASTER)
				pew = new /obj/item/projectile/psi/strong(get_turf(user))
				pew.name = "big psionic round"
				pew.damage = 25
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'
			if(PSI_RANK_MASTER)
				pew = new /obj/item/projectile/psi/strong(get_turf(user))
				pew.name = "psionic round"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'
			if(PSI_RANK_OPERANT)
				pew = new /obj/item/projectile/psi(get_turf(user))
				pew.name = "psionic bullet"
				pew.damage = 40
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'
			if(PSI_RANK_APPRENTICE)
				pew = new /obj/item/projectile/psi(get_turf(user))
				pew.name = "small psionic bullet"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'

		if(istype(pew))
			playsound(pew.loc, pew_sound, 25, 1)
			pew.original = target
			pew.current = target
			pew.starting = get_turf(user)
			pew.shot_from = user
			pew.launch(target, user.zone_sel.selecting, (target.x-user.x), (target.y-user.y))
		return TRUE

/decl/psionic_power/psychoballistics/storm
	name =             "Bullet Storm"
	cost =             30
	cooldown =         120
	min_rank =         PSI_RANK_APPRENTICE
	use_melee =        TRUE
	use_description = "Use this ranged attack while targeting mouth on harm intent. Your mastery of Psychoballistics will determine how powerful the bullet is. Be wary of overuse, and try not to shot down yourself."

/decl/psionic_power/psychoballistics/storm/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_MOUTH)
		return FALSE
	. = ..()
	if(.)
		user.visible_message("<span class='danger'>\The [user] sneezing, summoning bullets in all directions!</span>")
		user.emote("sneeze")

		var/user_rank = user.psi.get_rank(faculty)

		user.psi.set_cooldown(cooldown)
		sleep(4)
		user.psi.spend_power(cost)
		var/turf/O = get_turf(src)
		switch(user_rank)
			if(PSI_RANK_GRANDMASTER)
				user.fragmentate(O, 40, 7, list(/obj/item/projectile/psi = 1))
			if(PSI_RANK_MASTER)
				user.fragmentate(O, 30, 6, list(/obj/item/projectile/psi = 1))
			if(PSI_RANK_OPERANT)
				user.fragmentate(O, 20, 5, list(/obj/item/projectile/psi = 1))
			if(PSI_RANK_APPRENTICE)
				user.fragmentate(O, 10, 4, list(/obj/item/projectile/psi = 1))
		return TRUE

/mob/proc/fragmentate(var/turf/T=get_turf(src), var/fragment_number = 30, var/spreading_range = 5, var/list/fragtypes=list(/obj/item/projectile/))
	set waitfor = 0
	var/list/target_turfs = getcircle(T, spreading_range)
	for(var/turf/O in target_turfs)
		sleep(0)
		var/fragment_type = pickweight(fragtypes)
		var/obj/item/projectile/P = new fragment_type(T)
		P.shot_from = src.name
		P.launch(O)
