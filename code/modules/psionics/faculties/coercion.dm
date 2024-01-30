/decl/psionic_faculty/coercion
	id = PSI_COERCION
	name = "Coercion"
	associated_intent = I_DISARM
	armour_types = list(PSIONIC, "melee")

/decl/psionic_power/coercion
	faculty = PSI_COERCION

/decl/psionic_power/coercion/invoke(var/mob/living/user, var/mob/living/target)
	if (!istype(target))
		to_chat(user, SPAN_WARNING("Вы не можете пробиться в сознание [target]."))
		return FALSE

	. = ..()
	if(. && target.deflect_psionic_attack(user))
		return FALSE

/decl/psionic_power/coercion/blindstrike
	name =           "Blindstrike"
	cost =           25
	cooldown =       120
	use_ranged =     TRUE
	use_melee =      TRUE
	min_rank =       PSI_RANK_APPRENTICE
	use_description = "Выберите глаза и переключитесь на синий интент. Затем, нажмите куда угодно чтобы применить радиальную атаку, слепящую и оглушающую всех, кто оказался поблизости."

/decl/psionic_power/coercion/blindstrike/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_EYES)
		return FALSE
	. = ..()
	if(.)
		user.visible_message(SPAN_DANGER("[user] закидывает голову назад, издавая пронзительный крик!"))
		to_chat(user, SPAN_DANGER("Вы издаёте пронзительный псионический крик, оглушая всех вокруг!"))
		var/cn_rank = user.psi.get_rank(PSI_COERCION)
		for(var/mob/living/M in range(user, user.psi.get_rank(PSI_COERCION)))
			if(M == user)
				continue
			var/blocked = 100 * M.get_blocked_ratio(null, PSIONIC)
			if(prob(blocked))
				to_chat(M, SPAN_DANGER("Псионик пытается добраться до твоего разума, но тебе удаётся пресечь его попытки!"))
				continue
			if(prob(cn_rank * 20) && iscarbon(M))
				var/mob/living/carbon/C = M
				if(C.can_feel_pain())
					M.emote("scream")
			to_chat(M, SPAN_DANGER("Ты ощущаешь, как земля уходит у тебя из под ног!"))
			M.flash_eyes()
			new /obj/effect/temporary(get_turf(user),6, 'icons/effects/effects.dmi', "summoning")
			new /obj/effect/temporary(get_turf(M),3, 'icons/effects/effects.dmi', "purple_electricity_constant")
			M.eye_blind = max(M.eye_blind,cn_rank)
			M.ear_deaf = max(M.ear_deaf,cn_rank * 2)
			M.confused = cn_rank * rand(1,3)
		return TRUE

/decl/psionic_power/coercion/agony
	name =          "Agony"
	cost =          8
	cooldown =      60
	use_melee =     TRUE
	min_rank =      PSI_RANK_APPRENTICE
	use_description = "Выберите нижнюю часть тела на синем интенте, а затем нажмите по цели вблизи, дабы совершить по ней удар, по силе сравнимый с шоковой дубинкой."

/decl/psionic_power/coercion/agony/invoke(var/mob/living/user, var/mob/living/target)
	if(!istype(target))
		return FALSE
	if(user.zone_sel.selecting != BP_GROIN)
		return FALSE
	. = ..()
	if(.)
		user.visible_message("<span class='danger'>\[target] только что получил мощный разряд от [user]!</span>")
		playsound(user.loc, 'sound/weapons/Egloves.ogg', 50, 1, -1)
		var/cn_rank = user.psi.get_rank(PSI_COERCION)
		new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "blue_electricity_constant")
		target.stun_effect_act(0, cn_rank * 30, user.zone_sel.selecting)
		return TRUE

/decl/psionic_power/coercion/spasm
	name =           "Spasm"
	cost =           15
	cooldown =       100
	use_ranged =     TRUE
	min_rank =       PSI_RANK_APPRENTICE
	use_description = "Выберите кисти или руки на синем интенте. Затем, совершите дистанционную атаку по цели, чтобы попытаться вырвать оружие(или иной предмет) из ранее выбранной конечности."

/decl/psionic_power/coercion/spasm/invoke(var/mob/living/user, var/mob/living/carbon/human/target)
	if(!istype(target))
		return FALSE

	if(!(user.zone_sel.selecting in list(BP_L_ARM, BP_R_ARM, BP_L_HAND, BP_R_HAND)))
		return FALSE

	. = ..()

	if(.)
		var/cn_rank = user.psi.get_rank(PSI_COERCION)
		if(cn_rank == PSI_RANK_GRANDMASTER)
//			if(target.psi.get_rank(PSI_COERCION > 4) || target.psi.get_rank(PSI_CONSCIOUSNESS) > 4)
//				to_chat(user, "<span class='danger'>You lash out, trying to stab into \the [target], but fail to breach [target]'s defense!</span>")
//				return TRUE
			if(target.stunned == 0)
				to_chat(user, "<span class='danger'>Вы совершаете выпад вперёд, поражая [target] 'копьём' из чистой пси-энергии.</span>")
				to_chat(target, SPAN_DANGER("Вы ощущаете, как защемило каждую мышцу вашего тела. Боль невыносима!"))
				target.Stun(1000)
				user.emote("snap")
			else if(target.stunned >= 10)
				to_chat(user, "<span class='danger'>Вы взмахиваете рукой, разжимая мышцы [target].</span>")
				to_chat(target, SPAN_DANGER("Вы ощущаете, как снова можете пошевелить рукой."))
				target.AdjustStunned(target.stunned * -1)
				user.emote("snap")
			return TRUE
		to_chat(user, "<span class='danger'>Вы совершаете выпад вперёд, поражая [target] 'копьём' из чистой пси-энергии.</span>")
		to_chat(target, "<span class='danger'>Ваша кисть разжимается от внезапной боли, пронизывающей всю руку!</span>")
		if(prob(80))
			target.emote("scream")
		if(prob(cn_rank * 20) && target.l_hand && target.l_hand.simulated && target.unEquip(target.l_hand))
			target.visible_message("<span class='danger'>[target] невольно роняет предмет, находившийся в его левой руке!</span>")
		if(prob(cn_rank * 20) && target.r_hand && target.r_hand.simulated && target.unEquip(target.r_hand))
			target.visible_message("<span class='danger'>[target] невольно роняет предмет, находившийся в его правой руке!</span>")
		new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "white_electricity_constant")
		return TRUE

/decl/psionic_power/coercion/mindslave
	name =          "Mindslave"
	cost =          28
	cooldown =      200
	use_grab =      TRUE
	min_rank =      PSI_RANK_GRANDMASTER
	suppress_parent_proc = TRUE
	use_description = "Схватите жертву, выберите левую или правую кисть, затем переключитесь на синий интент и используйте захват НА НЕЙ, дабы обратить её в своего верного подчинённого."

/decl/psionic_power/coercion/mindslave/invoke(var/mob/living/user, var/mob/living/target)
	if(!istype(target))
		return FALSE
	if(!(user.zone_sel.selecting in list(BP_L_HAND, BP_R_HAND)))
		return FALSE
	. = ..()
	if(.)
		if(target.stat == DEAD || (target.status_flags & FAKEDEATH))
			to_chat(user, "<span class='warning'>[target] мёрта!</span>")
			return FALSE
		if(!target.mind || !target.key)
			to_chat(user, "<span class='warning'>[target] находится в бессознательном состоянии!</span>")
			return FALSE
		if(GLOB.thralls.is_antagonist(target.mind))
			to_chat(user, "<span class='warning'>[target] уже находится под чьим-то контролем!</span>")
			return FALSE
		user.visible_message("<span class='danger'><i>[user] обхватывает обе руки [target], прислоняя их к своим губам...</i></span>")
		to_chat(user, "<span class='warning'>Вы проникаете в хрупкое сознание [target]...</span>")
		to_chat(target, "<span class='danger'>Вы ощущаете присутствие [user] в своей голове! Его настойчивые мысли и желания постепенно заражают ваш разум!</span>")
		if(!do_after(user, target.stat == CONSCIOUS ? 80 : 40, target))
			user.psi.backblast(rand(10,25))
			return TRUE
		to_chat(user, "<span class='danger'>Вы реконструируете сознание [target] под свои собственные желания, превращая его в покорного раба.</span>")
		to_chat(target, "<span class='danger'>Ваши стены наконец пали и вы стали покорной куклой [user].</span>")
		GLOB.thralls.add_antagonist(target.mind, new_controller = user)
		return TRUE
