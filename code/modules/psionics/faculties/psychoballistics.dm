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
	cost =             15
	cooldown =         30
	use_ranged =       TRUE
	min_rank =         PSI_RANK_APPRENTICE
	use_description = "Use this ranged attack while targeting mouth on harm intent. Your mastery of Psychoballistics will determine how powerful the bullet is. Be wary of overuse, and try not to shot down yourself."

/decl/psionic_power/psychoballistics/spit/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_MOUTH)
		return FALSE
	. = ..()
	if(.)
		user.visible_message("<span class='danger'>\The [user] sneezed, spitting a bullet right from the mouth!</span>")
		user.emote("sneeze")

		var/user_rank = user.psi.get_rank(faculty)
		var/obj/item/projectile/pew
		var/pew_sound

		user.psi.set_cooldown(cooldown)
		user.psi.spend_power(cost)
		sleep(4)
		switch(user_rank)
			if(PSI_RANK_GRANDMASTER)
//				pew = new /obj/item/projectile/bullet/rifle/shell(get_turf(user))
				pew = new /obj/item/projectile/bullet/pistol/holdout(get_turf(user))
				pew.name = "round"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'
			if(PSI_RANK_MASTER)
//				pew = new /obj/item/projectile/bullet/shotgun(get_turf(user))
				pew = new /obj/item/projectile/bullet/pistol/holdout(get_turf(user))
				pew.name = "slug"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'
			if(PSI_RANK_OPERANT)
//				pew = new /obj/item/projectile/bullet/pistol/strong(get_turf(user))
				pew = new /obj/item/projectile/bullet/pistol/holdout(get_turf(user))
				pew.name = "bullet"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'
			if(PSI_RANK_APPRENTICE)
				pew = new /obj/item/projectile/bullet/pistol/holdout(get_turf(user))
				pew.name = "small bullet"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'

		if(istype(pew))
			playsound(pew.loc, pew_sound, 25, 1)
			pew.original = target
			pew.current = target
			pew.starting = get_turf(user)
			pew.shot_from = user
			pew.launch(target, user.zone_sel.selecting, (target.x-user.x), (target.y-user.y))
		sleep(1)
		switch(user_rank)
			if(PSI_RANK_GRANDMASTER)
//				pew = new /obj/item/projectile/bullet/rifle/shell(get_turf(user))
				pew = new /obj/item/projectile/bullet/pistol/holdout(get_turf(user))
				pew.name = "round"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'
			if(PSI_RANK_MASTER)
//				pew = new /obj/item/projectile/bullet/shotgun(get_turf(user))
				pew = new /obj/item/projectile/bullet/pistol/holdout(get_turf(user))
				pew.name = "slug"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'
			if(PSI_RANK_OPERANT)
//				pew = new /obj/item/projectile/bullet/pistol/strong(get_turf(user))
				pew = new /obj/item/projectile/bullet/pistol/holdout(get_turf(user))
				pew.name = "bullet"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'

		if(istype(pew))
			playsound(pew.loc, pew_sound, 25, 1)
			pew.original = target
			pew.current = target
			pew.starting = get_turf(user)
			pew.shot_from = user
			pew.launch(target, user.zone_sel.selecting, (target.x-user.x), (target.y-user.y))
		sleep(1)
		switch(user_rank)
			if(PSI_RANK_GRANDMASTER)
//				pew = new /obj/item/projectile/bullet/rifle/shell(get_turf(user))
				pew = new /obj/item/projectile/bullet/pistol/holdout(get_turf(user))
				pew.name = "round"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'
			if(PSI_RANK_MASTER)
//				pew = new /obj/item/projectile/bullet/shotgun(get_turf(user))
				pew = new /obj/item/projectile/bullet/pistol/holdout(get_turf(user))
				pew.name = "slug"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'

		if(istype(pew))
			playsound(pew.loc, pew_sound, 25, 1)
			pew.original = target
			pew.current = target
			pew.starting = get_turf(user)
			pew.shot_from = user
			pew.launch(target, user.zone_sel.selecting, (target.x-user.x), (target.y-user.y))
		sleep(1)
		switch(user_rank)
			if(PSI_RANK_GRANDMASTER)
//				pew = new /obj/item/projectile/bullet/rifle/shell(get_turf(user))
				pew = new /obj/item/projectile/bullet/pistol/holdout(get_turf(user))
				pew.name = "round"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'

		if(istype(pew))
			playsound(pew.loc, pew_sound, 25, 1)
			pew.original = target
			pew.current = target
			pew.starting = get_turf(user)
			pew.shot_from = user
			pew.launch(target, user.zone_sel.selecting, (target.x-user.x), (target.y-user.y))
		return TRUE