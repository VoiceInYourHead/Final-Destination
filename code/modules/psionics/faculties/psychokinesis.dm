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
	use_description = "Нажмите по отдалённом объекту или существу на жёлтом интенте, чтобы захватить его телекинезом."
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
			to_chat(user, "<span class='warning'>Ваших сил недостаточно, чтобы достать до этого объекта.</span>")
			return FALSE

		if(istype(target, /obj/structure))
			user.visible_message("<span class='notice'>[user] вытягивает руку вперёд, чуть сжимая пальцы.</span>")
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
				user.visible_message("<span class='notice'>[user] вытягивает руку вперёд, чуть сжимая пальцы.</span>")
				return tk

	return FALSE

/decl/psionic_power/psychokinesis/gravigeddon
	name =           "Repulse"
	cost =           30
	cooldown =       150
	use_ranged =     TRUE
	use_melee =      TRUE
	min_rank =       PSI_RANK_OPERANT
	use_description = "Выберите руки или кисти на жёлтом интенте, а затем нажмите куда угодно, чтобы разбросать всё вокруг себя мощной волной."

/decl/psionic_power/psychokinesis/gravigeddon/invoke(var/mob/living/user, var/mob/living/target)
	if(!(user.zone_sel.selecting in list(BP_L_ARM, BP_R_ARM, BP_L_HAND, BP_R_HAND)))
		return FALSE
	. = ..()
	if(.)
		user.visible_message(SPAN_DANGER("[user] размахивает руками, крича!"))
		to_chat(user, SPAN_DANGER("Вы выпускаете мощную псионическую волну, разметая всё вокруг!"))
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
				to_chat(M, SPAN_DANGER("Грубая сила ударяет в твоё тело, отправляя тебя в свободный полёт!"))
				new /obj/effect/temporary(get_turf(M),4, 'icons/effects/effects.dmi', "smash")
				M.throw_at(get_edge_target_turf(M, get_dir(user, M)), pk_rank*2, pk_rank*2, user)
		return TRUE
