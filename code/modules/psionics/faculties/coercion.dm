/decl/psionic_faculty/coercion
	id = PSI_COERCION
	name = "Coercion"
	associated_intent = I_HELP
	armour_types = list(PSIONIC, "melee")

/decl/psionic_power/coercion
	faculty = PSI_COERCION

/decl/psionic_power/coercion/invoke(var/mob/living/user, var/mob/living/target)
	if (!istype(target))
		to_chat(user, SPAN_WARNING("You cannot mentally attack \the [target]."))
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
	use_description = "Target the eyes on help intent and click anywhere to use a radial attack that blinds, deafens and disorients everyone near you."

/decl/psionic_power/coercion/blindstrike/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_EYES)
		return FALSE
	. = ..()
	if(.)
		user.visible_message(SPAN_DANGER("\The [user] suddenly throws back their head, as though screaming silently!"))
		to_chat(user, SPAN_DANGER("You strike at all around you with a deafening psionic scream!"))
		var/cn_rank = user.psi.get_rank(PSI_COERCION)
		for(var/mob/living/M in range(user, user.psi.get_rank(PSI_COERCION)))
			if(M == user)
				continue
			var/blocked = 100 * M.get_blocked_ratio(null, PSIONIC)
			if(prob(blocked))
				to_chat(M, SPAN_DANGER("A psionic onslaught strikes your mind, but you withstand it!"))
				continue
			if(prob(cn_rank * 20) && iscarbon(M))
				var/mob/living/carbon/C = M
				if(C.can_feel_pain())
					M.emote("scream")
			to_chat(M, SPAN_DANGER("Your senses are blasted into oblivion by a psionic scream!"))
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
	use_description = "Target the groin on help intent to use a melee attack equivalent to a strike from a stun baton."

/decl/psionic_power/coercion/agony/invoke(var/mob/living/user, var/mob/living/target)
	if(!istype(target))
		return FALSE
	if(user.zone_sel.selecting != BP_GROIN)
		return FALSE
	. = ..()
	if(.)
		user.visible_message("<span class='danger'>\The [target] has been struck by \the [user]!</span>")
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
	use_description = "Target the arms or hands on help intent to use a ranged attack that may rip the weapons away from the target."

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
				to_chat(user, "<span class='danger'>You lash out, stabbing into \the [target] with a lance of psi-energy.</span>")
				to_chat(target, SPAN_DANGER("Your muscles feels locked, leaving you unable to move!"))
				target.Stun(1000)
				user.emote("snap")
			else if(target.stunned >= 10)
				to_chat(user, "<span class='danger'>You lash out, removing \the [target] muscle lock.</span>")
				to_chat(target, SPAN_DANGER("You feel like you can move your body again."))
				target.AdjustStunned(target.stunned * -1)
				user.emote("snap")
			return TRUE
		to_chat(user, "<span class='danger'>You lash out, stabbing into \the [target] with a lance of psi-power.</span>")
		to_chat(target, "<span class='danger'>The muscles in your arms cramp horrendously!</span>")
		if(prob(80))
			target.emote("scream")
		if(prob(cn_rank * 20) && target.l_hand && target.l_hand.simulated && target.unEquip(target.l_hand))
			target.visible_message("<span class='danger'>\The [target] drops what they were holding as their left hand spasms!</span>")
		if(prob(cn_rank * 20) && target.r_hand && target.r_hand.simulated && target.unEquip(target.r_hand))
			target.visible_message("<span class='danger'>\The [target] drops what they were holding as their right hand spasms!</span>")
		new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "white_electricity_constant")
		return TRUE

/decl/psionic_power/coercion/mindslave
	name =          "Mindslave"
	cost =          28
	cooldown =      200
	use_grab =      TRUE
	min_rank =      PSI_RANK_GRANDMASTER
	suppress_parent_proc = TRUE
	use_description = "Grab a victim, target the left or right hand, then use the grab on them while on help intent, in order to convert them into a loyal mind-slave. The process takes some time, and failure is punished harshly."

/decl/psionic_power/coercion/mindslave/invoke(var/mob/living/user, var/mob/living/target)
	if(!istype(target))
		return FALSE
	if(!(user.zone_sel.selecting in list(BP_L_HAND, BP_R_HAND)))
		return FALSE
	. = ..()
	if(.)
		if(target.stat == DEAD || (target.status_flags & FAKEDEATH))
			to_chat(user, "<span class='warning'>\The [target] is dead!</span>")
			return FALSE
		if(!target.mind || !target.key)
			to_chat(user, "<span class='warning'>\The [target] is mindless!</span>")
			return FALSE
		if(GLOB.thralls.is_antagonist(target.mind))
			to_chat(user, "<span class='warning'>\The [target] is already in thrall to someone!</span>")
			return FALSE
		user.visible_message("<span class='danger'><i>\The [user] seizes the head of \the [target] in both hands...</i></span>")
		to_chat(user, "<span class='warning'>You plunge your mentality into that of \the [target]...</span>")
		to_chat(target, "<span class='danger'>Your mind is invaded by the presence of \the [user]! They are trying to make you a slave!</span>")
		if(!do_after(user, target.stat == CONSCIOUS ? 80 : 40, target))
			user.psi.backblast(rand(10,25))
			return TRUE
		to_chat(user, "<span class='danger'>You sear through \the [target]'s neurons, reshaping as you see fit and leaving them subservient to your will!</span>")
		to_chat(target, "<span class='danger'>Your defenses have eroded away and \the [user] has made you their mindslave.</span>")
		GLOB.thralls.add_antagonist(target.mind, new_controller = user)
		return TRUE
