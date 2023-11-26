/decl/psionic_faculty/psychokinesis
	id = PSI_PSYCHOKINESIS
	name = "Psychokinesis"
	associated_intent = I_GRAB
	armour_types = list("bullet", "melee")

/decl/psionic_power/psychokinesis
	faculty = PSI_PSYCHOKINESIS
	use_sound = null

/decl/psionic_power/psychokinesis/telekinesis
	name =            "Telekinesis"
	cost =            10
	cooldown =        15
	use_ranged =      TRUE
	min_rank =        PSI_RANK_APPRENTICE
	use_description = "Click on a distant target while on grab intent to manifest a psychokinetic grip. Use it manipulate objects at a distance."
	admin_log = FALSE
	use_sound = 'sound/effects/psi/power_used.ogg'
	var/global/list/valid_machine_types = list(
		/obj/machinery
	)

/decl/psionic_power/psychokinesis/telekinesis/invoke(var/mob/living/user, var/mob/living/target)
	if((user.zone_sel.selecting in list(BP_L_ARM, BP_R_ARM, BP_L_HAND, BP_R_HAND)))
		return FALSE
	if(user.a_intent != I_GRAB)
		return FALSE
	. = ..()
	if(.)

		var/distance = get_dist(user, target)
		if(distance > user.psi.get_rank(PSI_PSYCHOKINESIS) + 2)
			to_chat(user, "<span class='warning'>Your telekinetic power won't reach that far.</span>")
			return FALSE

		if(istype(target, /obj/structure))
			user.visible_message("<span class='notice'>\The [user] makes a strange gesture.</span>")
			var/obj/O = target
			O.attack_hand(user)
			return TRUE
		else if(istype(target, /obj/machinery))
			for(var/mtype in valid_machine_types)
				if(istype(target, mtype))
					var/obj/machinery/machine = target
					return machine.do_simple_ranged_interaction(user)
		else if(istype(target, /mob) || istype(target, /obj))
			var/obj/item/psychic_power/telekinesis/tk = new(user)
			if(tk.set_focus(target))
				tk.sparkle()
				user.visible_message("<span class='notice'>\The [user] reaches out.</span>")
				return tk

	return FALSE

/decl/psionic_power/psychokinesis/gravigeddon
	name =           "Repulse"
	cost =           30
	cooldown =       150
	use_ranged =     TRUE
	use_melee =      TRUE
	min_rank =       PSI_RANK_OPERANT
	use_description = "Target the arms or hands on grab intent and click anywhere to use a radial attack that throws everyone away from you."

/decl/psionic_power/psychokinesis/gravigeddon/invoke(var/mob/living/user, var/mob/living/target)
	if(!(user.zone_sel.selecting in list(BP_L_ARM, BP_R_ARM, BP_L_HAND, BP_R_HAND)))
		return FALSE
	. = ..()
	if(.)
		user.visible_message(SPAN_DANGER("\The [user] suddenly throws up their hands, as though screaming silently!"))
		to_chat(user, SPAN_DANGER("You strike at all around you with a psionic wave, pushing them away!"))
		var/pk_rank = user.psi.get_rank(PSI_PSYCHOKINESIS)
		new /obj/effect/temporary(get_turf(user),9, 'icons/effects/effects.dmi', "summoning")
		for(var/mob/living/M in range(user, user.psi.get_rank(PSI_PSYCHOKINESIS)))
			if(M == user)
				continue
			if(prob(20) && iscarbon(M))
				var/mob/living/carbon/C = M
				if(C.can_feel_pain())
					C.emote("scream")
			if(!M.anchored && !M.buckled)
				to_chat(M, SPAN_DANGER("A violent force slams into your body, pushing you away!"))
				new /obj/effect/temporary(get_turf(M),4, 'icons/effects/effects.dmi', "smash")
				M.throw_at(get_edge_target_turf(M, get_dir(user, M)), pk_rank*2, pk_rank*2, user)
		return TRUE
