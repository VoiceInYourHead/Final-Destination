/decl/psionic_faculty/energistics
	id = PSI_ENERGISTICS
	name = "Energistics"
	associated_intent = I_HURT
	armour_types = list("laser", "melee") //"bomb"

/decl/psionic_power/energistics
	faculty = PSI_ENERGISTICS

/decl/psionic_power/energistics/zorch
	name =             "Zorch"
	cost =             20
	cooldown =         20
	use_ranged =       TRUE
	min_rank =         PSI_RANK_APPRENTICE
	use_description = "Выберите красный интент и нажмите по цели на дистанции чтобы запустить в неё луч концентрированной псионической энергии."

/decl/psionic_power/energistics/zorch/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting == BP_MOUTH)
		return FALSE
	. = ..()
	if(.)
		user.visible_message("<span class='danger'>Глаза [user] загораются ярким светом!</span>")

		var/user_rank = user.psi.get_rank(faculty)
		var/obj/item/projectile/pew
		var/pew_sound

		switch(user_rank)
			if(PSI_RANK_GRANDMASTER)
				pew = new /obj/item/projectile/beam/heavylaser(get_turf(user))
				pew.name = "gigawatt mental laser"
				pew_sound = 'sound/weapons/pulse.ogg'
			if(PSI_RANK_MASTER)
				pew = new /obj/item/projectile/beam/megabot(get_turf(user))
				pew.name = "megawatt mental laser"
				pew_sound = 'sound/weapons/Laser.ogg'
			if(PSI_RANK_OPERANT)
				pew = new /obj/item/projectile/beam/midlaser(get_turf(user))
				pew.name = "mental laser"
				pew_sound = 'sound/weapons/scan.ogg'
			if(PSI_RANK_APPRENTICE)
				pew = new /obj/item/projectile/beam/smalllaser(get_turf(user))
				pew.name = "mental beam"
				pew_sound = 'sound/weapons/taser2.ogg'

		if(istype(pew))
			playsound(pew.loc, pew_sound, 25, 1)
			pew.original = target
			pew.current = target
			pew.starting = get_turf(user)
			pew.shot_from = user
			pew.launch(target, user.zone_sel.selecting, (target.x-user.x), (target.y-user.y))
			return TRUE

/decl/psionic_power/electromagnetics/disrupt
	name =            "Disrupt"
	cost =            10
	cooldown =        60
	use_melee =       TRUE
	min_rank =        PSI_RANK_APPRENTICE
	use_description = "Выберите голову или глаза на красном интенте и нажмите на любой объект, чтобы создать мощный электромагнитный импульс, направленный в него."

/decl/psionic_power/electromagnetics/disrupt/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_HEAD && user.zone_sel.selecting != BP_EYES)
		return FALSE
	if(istype(target, /turf))
		return FALSE
	. = ..()
	if(.)
		new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "blue_electricity_constant")
		target.visible_message("<span class='danger'>[user] взмахивает рукой, поражая [target] градом из молний!</span>")
		empulse(target, 0, 1)
		return TRUE