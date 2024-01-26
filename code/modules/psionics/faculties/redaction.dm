/decl/psionic_faculty/redaction
	id = PSI_REDACTION
	name = "Redaction"
	associated_intent = I_HELP
	armour_types = list("bio", "rad")

/decl/psionic_power/redaction
	faculty = PSI_REDACTION
	admin_log = FALSE

/decl/psionic_power/redaction/proc/check_dead(var/mob/living/target)
	if(!istype(target))
		return FALSE
	if(target.stat == DEAD || (target.status_flags & FAKEDEATH))
		return TRUE
	return FALSE

/decl/psionic_power/redaction/invoke(var/mob/living/user, var/mob/living/target)
	if(check_dead(target))
		return FALSE
	. = ..()

/decl/psionic_power/redaction/skinsight
	name =            "Skinsight"
	cost =            3
	cooldown =        30
	use_grab =        TRUE
	min_rank =        PSI_RANK_APPRENTICE
	suppress_parent_proc = TRUE
	use_description = "Схватите цель, выберите верхнюю часть тела и зелёный интент, затем нажав по нему захватом ещё раз, чтобы проверить его физическое состояние."

/decl/psionic_power/redaction/skinsight/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_CHEST)
		return FALSE
	. = ..()
	if(.)
		user.visible_message(SPAN_NOTICE("[user] кладёт руку на [target]."))
		to_chat(user, medical_scan_results(target, TRUE, SKILL_MAX))
		return TRUE

/decl/psionic_power/redaction/mend
	name =            "Mend"
	cost =            7
	cooldown =        50
	use_melee =       TRUE
	min_rank =        PSI_RANK_APPRENTICE
	suppress_parent_proc = TRUE
	use_description = "Выберите любую часть тела на зелёном интенте и нажмите по цели, чтобы убрать возможные ранения с указанной зоны."

/decl/psionic_power/redaction/mend/invoke(var/mob/living/user, var/mob/living/carbon/human/target)
	if(!istype(user) || !istype(target))
		return FALSE
	. = ..()
	if(.)
		var/obj/item/organ/external/E = target.get_organ(user.zone_sel.selecting)

		if(!E)
			to_chat(user, SPAN_WARNING("Эта конечность отсутствует!."))
			return FALSE

		if(BP_IS_ROBOTIC(E))
			to_chat(user, SPAN_WARNING("Эта конечность заменена протезом."))
			return FALSE

		user.visible_message(SPAN_NOTICE("<i>[user] кладёт руку на [target]'s [E.name]...</i>"))
		to_chat(target, SPAN_NOTICE("Вы ощущаете приятное тепло..."))

		new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "green_sparkles")

		var/redaction_rank = user.psi.get_rank(PSI_REDACTION)
		var/pk_rank = user.psi.get_rank(PSI_PSYCHOKINESIS)
		if(pk_rank >= PSI_RANK_LATENT && redaction_rank >= PSI_RANK_OPERANT)
			var/removal_size = clamp(5-pk_rank, 0, 5)
			var/valid_objects = list()
			for(var/thing in E.implants)
				var/obj/imp = thing

				if(!imp)
					continue

				if(imp.w_class >= removal_size && !istype(imp, /obj/item/implant))
					valid_objects += imp
			if(LAZYLEN(valid_objects))
				var/removing = pick(valid_objects)
				target.remove_implant(removing, TRUE)
				to_chat(user, SPAN_NOTICE("Вы аккуратно извлекли [removing] из [E]."))
				return TRUE

		if(redaction_rank >= PSI_RANK_OPERANT)
			if(E.status & ORGAN_ARTERY_CUT)
				to_chat(user, SPAN_NOTICE("Вы вновь связали разованные вены в [E], останавливая внутреннее кровотечение."))
				E.status &= ~ORGAN_ARTERY_CUT
				return TRUE
			if(E.status & ORGAN_TENDON_CUT)
				to_chat(user, SPAN_NOTICE("Вы аккуратно сплели новое сухожилие на месте повреждённого в [E]."))
				E.status &= ~ORGAN_TENDON_CUT
				return TRUE

		if(E.is_stump())
			to_chat(user, SPAN_WARNING("Нет смысла тратить силы на этот обрубок. Здесь вы бессильны."))
			return FALSE

		if(E.status & ORGAN_BROKEN)
			to_chat(user, SPAN_NOTICE("Вы установили кости на их прежнее место, заделав образовавшиеся на их поверхности трещины."))
			E.status &= ~ORGAN_BROKEN
			E.stage = 0
			return TRUE

		for(var/datum/wound/W in E.wounds)
			if(W.bleeding())
				if(redaction_rank >= PSI_RANK_APPRENTICE || W.wound_damage() < 30)
					to_chat(user, SPAN_NOTICE("Вы аккуратно перекрыли поток крови, устранив протечку и зашив таковую."))
					W.bleed_timer = 0
					W.clamped = TRUE
					E.status &= ~ORGAN_BLEEDING
					return TRUE
				else
					to_chat(user, SPAN_NOTICE("Это ранение превыше ваших сил."))

		if(redaction_rank >= PSI_RANK_MASTER)
			for(var/obj/item/organ/internal/I in E.internal_organs)
				if(!BP_IS_ROBOTIC(I) && !BP_IS_CRYSTAL(I) && I.damage > 0)
					to_chat(user, SPAN_NOTICE("Вы проникаете внутрь тела [target], восстанавливая повреждённый орган: [I]."))
					var/heal_rate = redaction_rank
					I.damage = max(0, I.damage - rand(heal_rate,heal_rate*3))
					return TRUE

		to_chat(user, SPAN_NOTICE("В его [E.name] нечего лечить."))
		return FALSE

/decl/psionic_power/redaction/cleanse
	name =            "Cleanse"
	cost =            9
	cooldown =        60
	use_melee =       TRUE
	min_rank =        PSI_RANK_MASTER
	suppress_parent_proc = TRUE
	use_description = "Нажмите по цели на зелёном интенте, чтобы очистить его от генетических отклонений и иных воздействий радиации."

/decl/psionic_power/redaction/cleanse/invoke(var/mob/living/user, var/mob/living/carbon/human/target)
	if(!istype(user) || !istype(target))
		return FALSE
	. = ..()
	if(.)
		// No messages, as Mend procs them even if it fails to heal anything, and Cleanse is always checked after Mend.
		var/removing = rand(20,25)
		if(target.radiation)
			to_chat(user, SPAN_NOTICE("Вы выводите нежелательные частицы из тела [target]..."))
			if(target.radiation > removing)
				target.radiation -= removing
			else
				target.radiation = 0
			return TRUE
		if(target.getCloneLoss())
			to_chat(user, SPAN_NOTICE("Вы с трудом восстанавливаете прежнюю структуру ДНК [target]..."))
			if(target.getCloneLoss() >= removing)
				target.adjustCloneLoss(-removing)
			else
				target.adjustCloneLoss(-(target.getCloneLoss()))
			return TRUE
		to_chat(user, SPAN_NOTICE("Похоже, что у [target] нет ни радиационного заражения, не генетических отклонений."))
		return FALSE

/decl/psionic_power/revive
	name =            "Revive"
	cost =            25
	cooldown =        80
	use_grab =        TRUE
	min_rank =        PSI_RANK_GRANDMASTER
	faculty =         PSI_REDACTION
	use_description = "Схватите цель, выберите голову и зелёный интент, затем нажмите по нему захватом, чтобы попытаться вернуть его к жизни."
	admin_log = FALSE

/decl/psionic_power/revive/invoke(var/mob/living/user, var/mob/living/target)
	if(!isliving(target) || !istype(target) || user.zone_sel.selecting != BP_HEAD)
		return FALSE
	. = ..()
	if(.)
		if(target.stat != DEAD && !(target.status_flags & FAKEDEATH))
			to_chat(user, SPAN_WARNING("Этот человек ещё жив!"))
			return TRUE

		if((world.time - target.timeofdeath) > 6000)
			to_chat(user, SPAN_WARNING("[target] пролежал здесь слишком долго. Нет никакой надежды на то, что его выйдет оживить."))
			return TRUE

		user.visible_message(SPAN_NOTICE("<i>[user] кладёт обе руки на тело [target]...</i>"))
		new /obj/effect/temporary(get_turf(target),6, 'icons/effects/effects.dmi', "green_sparkles")
		if(!do_after(user, 100, target))
			user.psi.backblast(rand(10,25))
			return TRUE

		for(var/mob/observer/G in GLOB.dead_mob_list_)
			if(G.mind && G.mind.current == target && G.client)
				to_chat(G, SPAN_NOTICE("<font size = 3><b>Your body has been revived, <b>Re-Enter Corpse</b> to return to it.</b></font>"))
				break
		to_chat(target, SPAN_NOTICE("<font size = 3><b>Жизненные силы снова наполняют ваше тело.</b></font>"))
		target.visible_message(SPAN_NOTICE("[target] трясётся в ужасе!"))
		new /obj/effect/temporary(get_turf(target),8, 'icons/effects/effects.dmi', "rune_convert")
		target.adjustOxyLoss(-rand(30,45))
		target.basic_revival()
		return TRUE
