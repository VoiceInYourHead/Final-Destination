/decl/psionic_faculty/consciousness
	id = PSI_CONSCIOUSNESS
	name = "Consciousness"
	associated_intent = I_HELP
	armour_types = list(PSIONIC, "melee")

/decl/psionic_power/consciousness
	faculty = PSI_CONSCIOUSNESS

/decl/psionic_power/consciousnessa/invoke(var/mob/living/user, var/mob/living/target)
	if (!istype(target))
		to_chat(user, SPAN_WARNING("You cannot mentally attack \the [target]."))
		return FALSE

	. = ..()
	if(. && target.deflect_psionic_attack(user))
		return FALSE

/decl/psionic_power/consciousness/telepathy
	name =            "Telepathy"
	cost =            2
	cooldown =        50
	use_ranged =       TRUE
	use_melee = TRUE
	min_rank =        PSI_RANK_APPRENTICE
	suppress_parent_proc = TRUE
	use_description = "Выберите рот на зелёном интенте, и затем нажмите по цели с любого расстояния, чтобы установить с ней ментальную связь."

/decl/psionic_power/consciousness/telepathy/invoke(var/mob/living/user, var/mob/living/target)
	if(!isliving(target) || !istype(target) || user.zone_sel.selecting != BP_MOUTH)
		return FALSE
	. = ..()
	if(!.)
		return

	if(target.stat == DEAD || (target.status_flags & FAKEDEATH) || !target.client)
		to_chat(user, SPAN_WARNING("[target] не в состоянии ответить вам. Его мозг погрузился в вечный сон."))
		return FALSE

	var/phrase =  input(user, "Что вы хотите сказать?", "Связаться", "Ты меня слышишь?") as null|text
	if(!phrase || user.incapacitated() || !do_after(user, 40 / user.psi.get_rank(PSI_CONSCIOUSNESS)))
		return FALSE

	var/con_rank_user = user.psi.get_rank(PSI_CONSCIOUSNESS)
	to_chat(user, SPAN_NOTICE("<b>Вы пытаетесь установить контакт с сознанием [target], дабы донести до него следующее: <i>[phrase]</i></b>"))
	if(target.psi)
		var/con_rank_target = target.psi.get_rank(PSI_CONSCIOUSNESS)
		if(con_rank_target >= con_rank_user)
			to_chat(target, SPAN_OCCULT("<b>Вы слышите отчётливый голос [user] в своей голове, он говорит вам: <i>[phrase]</i></b>"))
			if(con_rank_target > con_rank_user)
				var/option =  alert(target, "Вы хотите ответить этому зову?", "Обратная связь", "Да", "Нет")
				switch(option)
					if("Да")
						var/answer =  input(user, "Что вы хотите передать в ответ?", "Связаться", "...") as null|text
						to_chat(user, SPAN_OCCULT("<b>[target] отвечает вам: <i>[answer]</i></b>"))
					else
						return
		else
			to_chat(target, SPAN_OCCULT("<b>Вы слышите чей-то отдалённый голос в своей голове, больше напоминающий шёпот...голос говорит вам: <i>[phrase]</i></b>"))
	else if(!target.psi)
		to_chat(target, SPAN_OCCULT("<b>Вы слышите чей-то отдалённый голос в своей голове, больше напоминающий шёпот...голос говорит вам: <i>[phrase]</i></b>"))
	return TRUE


/decl/psionic_power/consciousness/mindread
	name =            "Read Mind"
	cost =            6
	cooldown =        80
	use_ranged =       TRUE
	use_melee = TRUE
	min_rank =        PSI_RANK_APPRENTICE
	suppress_parent_proc = TRUE
	use_description = "Выберите голову на зелёном интенте и затем нажмите по цели находясь на любом расстоянии, чтобы попытаться прочитать его мысли."

/decl/psionic_power/consciousness/mindread/invoke(var/mob/living/user, var/mob/living/target)
	if(!isliving(target) || !istype(target) || user.zone_sel.selecting != BP_HEAD)
		return FALSE
	. = ..()
	if(!.)
		return

	if(target.stat == DEAD || (target.status_flags & FAKEDEATH) || !target.client)
		to_chat(user, SPAN_WARNING("[target] не в состоянии ответить вам. Его мозг погрузился в вечный сон."))
		return FALSE

	var/question =  input(user, "Что вы хотите сказать?", "Чтение мыслей", "Идеи?") as null|text
	if(!question || user.incapacitated() || !do_after(user, 40 / user.psi.get_rank(PSI_CONSCIOUSNESS)))
		return FALSE

	var/con_rank_user = user.psi.get_rank(PSI_CONSCIOUSNESS)
	var/started_mindread = world.time
	to_chat(user, SPAN_NOTICE("<b>Вы погружаетесь в глубины сознания [target], ища ответ на вопрос: <i>[question]</i></b>"))
	var/option = alert(target, "Кто-то пытается проникнуть в ваше сознание, дабы получить доступ к его воспоминаниям! Вы позволите этому случиться?", "Выбирай!", "Да", "Нет")
	if (!option)
		if(target.psi)
			var/con_rank_target = target.psi.get_rank(PSI_CONSCIOUSNESS)
			if(con_rank_target > con_rank_user)
				to_chat(user, SPAN_NOTICE("<b>[target]без каких-либо проблем блокирует ваши попытки узнать что-либо!</b>"))
				to_chat(target, SPAN_NOTICE("<b>Вы без проблем защитили свой разум от вторжения!</b>"))
				return
			else
				target.adjustBrainLoss(25)
				to_chat(user, SPAN_NOTICE("<b>[target] удаётся предотвратить ваше проникновение, но часть его мозга была повреждена в процессе!</b>"))
				to_chat(target, SPAN_NOTICE("<b>Вам удаётся защитить свои воспоминания, но ваше сопротивление повлекло за собой куда больше проблем. Ваша голова просто раскалывается.</b>"))
				return
		else if(!target.psi)
			target.adjustBrainLoss(25)
			to_chat(user, SPAN_NOTICE("<b>[target] удаётся предотвратить ваше проникновение, но часть его мозга была повреждена в процессе!</b>"))
			to_chat(target, SPAN_NOTICE("<b>Вам удаётся защитить свои воспоминания, но ваше сопротивление повлекло за собой куда больше проблем. Ваша голова просто раскалывается.</b>"))
			return
	if(option == "Yes")
		to_chat(target, SPAN_NOTICE("<b>Некто пытается получить ответ на вопрос: <i>[question]</i></b>"))
	if(option == "No")
		if(target.psi)
			var/con_rank_target = target.psi.get_rank(PSI_CONSCIOUSNESS)
			if(con_rank_target > con_rank_user)
				to_chat(user, SPAN_NOTICE("<b>[target]без каких-либо проблем блокирует ваши попытки узнать что-либо!</b>"))
				to_chat(target, SPAN_NOTICE("<b>Вы без проблем защитили свой разум от вторжения!</b>"))
				return
			else
				target.adjustBrainLoss(25)
				to_chat(user, SPAN_NOTICE("<b>[target] удаётся предотвратить ваше проникновение, но часть его мозга была повреждена в процессе!</b>"))
				to_chat(target, SPAN_NOTICE("<b>Вам удаётся защитить свои воспоминания, но ваше сопротивление повлекло за собой куда больше проблем. Ваша голова просто раскалывается.</b>"))
				return
		else if(!target.psi)
			target.adjustBrainLoss(25)
			to_chat(user, SPAN_NOTICE("<b>[target] удаётся предотвратить ваше проникновение, но часть его мозга была повреждена в процессе!</b>"))
			to_chat(target, SPAN_NOTICE("<b>Вам удаётся защитить свои воспоминания, но ваше сопротивление повлекло за собой куда больше проблем. Ваша голова просто раскалывается.</b>"))
			return


	var/answer =  input(target, question, "Чтение мыслей") as null|text
	if(!answer || world.time > started_mindread + 60 SECONDS || user.stat != CONSCIOUS || target.stat == DEAD)
		to_chat(user, SPAN_NOTICE("<b>Вам не удалось добиться чего-либо полезного от [target].</b>"))
	else
		to_chat(user, SPAN_NOTICE("<b>В поисках ответов в голове [target], вы нахоите следующее: <i>[answer]</i></b>"))
	msg_admin_attack("[key_name(user)] использует чтение мыслей на [key_name(target)] с вопросом \"[question]\" и [answer?"следующим ответом \"[answer]\".":"не получил никакого ответа."]")
	return TRUE

/decl/psionic_power/consciousness/focus
	name =          "Focus"
	cost =          10
	cooldown =      80
	use_grab =     TRUE
	min_rank =      PSI_RANK_APPRENTICE
	suppress_parent_proc = TRUE
	use_description = "Схватите цель, затем выберите рот на зелёном интенте и нажмите по ней захватом ещё раз, дабы частично очистить её сознание от возможного урона."

/decl/psionic_power/consciousness/focus/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_MOUTH)
		return FALSE
	. = ..()
	if(.)
		user.visible_message(SPAN_WARNING("[user] целует [target]..."))
		to_chat(user, SPAN_NOTICE("Вы проверяете разум [target] на наличие повреждений..."))
		to_chat(target, SPAN_WARNING("Вы ощущаете, как ваш разум очищается, становясь яснее."))
		if(!do_after(user, (target.stat == CONSCIOUS ? 50 : 25), target))
			user.psi.backblast(rand(5,10))
			return TRUE
		to_chat(user, SPAN_WARNING("Вы полностью очистили сознание [target] от проблем и ран."))
		to_chat(target, SPAN_WARNING("Вы ощущаете полную ясность мыслей. Словно стали новым человеком."))

		var/coercion_rank = user.psi.get_rank(PSI_COERCION)
		if(coercion_rank > PSI_RANK_APPRENTICE)
			target.AdjustParalysis(-1)
		target.drowsyness = 0
		if(istype(target, /mob/living/carbon))
			var/mob/living/carbon/M = target
			M.adjust_hallucination(-30)
			M.adjustBrainLoss(-rand(20,35))
		return TRUE

/decl/psionic_power/consciousness/assay
	name =            "Assay"
	cost =            15
	cooldown =        100
	use_grab =        TRUE
	min_rank =        PSI_RANK_APPRENTICE
	suppress_parent_proc = TRUE
	use_description = "Схватите цель, затем выберите голову и зелёный интент. После этого, нажмите по цели захватом, чтобы погрузится в глубины её разума и отыскать там скрытый потенциал."

/decl/psionic_power/consciousness/assay/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_HEAD)
		return FALSE
	. = ..()
	if(.)
		user.visible_message(SPAN_WARNING("[user] обхватывает голову [target] обеими руками..."))
		to_chat(user, SPAN_NOTICE("Вы погружаетесь в глубины сознания [target]..."))
		to_chat(target, SPAN_WARNING("Вы ощущаете, как [user] копается в вашем подсознании, что-то выискивая."))
		if(!do_after(user, (target.stat == CONSCIOUS ? 50 : 25), target))
			user.psi.backblast(rand(5,10))
			return TRUE
		to_chat(user, SPAN_NOTICE("Вы покидаете разум [target], получив желаемое."))
		to_chat(target, SPAN_DANGER("[user] наконец покидает ваше сознание, узнав желаемое."))
		target.show_psi_assay(user)
		return TRUE