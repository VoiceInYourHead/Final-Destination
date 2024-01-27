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
	use_description = "Target the mouth on help intent at any range to attempt to connect with victim's mind."

/decl/psionic_power/consciousness/telepathy/invoke(var/mob/living/user, var/mob/living/target)
	if(!isliving(target) || !istype(target) || user.zone_sel.selecting != BP_MOUTH)
		return FALSE
	. = ..()
	if(!.)
		return

	if(target.stat == DEAD || (target.status_flags & FAKEDEATH) || !target.client)
		to_chat(user, SPAN_WARNING("\The [target] is in no state for a mind-ream."))
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
	use_description = "Target the head on help intent at any range to attempt to read a victim's surface thoughts."

/decl/psionic_power/consciousness/mindread/invoke(var/mob/living/user, var/mob/living/target)
	if(!isliving(target) || !istype(target) || user.zone_sel.selecting != BP_HEAD)
		return FALSE
	. = ..()
	if(!.)
		return

	if(target.stat == DEAD || (target.status_flags & FAKEDEATH) || !target.client)
		to_chat(user, SPAN_WARNING("\The [target] is in no state for a mind-ream."))
		return FALSE

	var/question =  input(user, "Say something?", "Read Mind", "Penny for your thoughts?") as null|text
	if(!question || user.incapacitated() || !do_after(user, 40 / user.psi.get_rank(PSI_CONSCIOUSNESS)))
		return FALSE

	var/con_rank_user = user.psi.get_rank(PSI_CONSCIOUSNESS)
	var/started_mindread = world.time
	to_chat(user, SPAN_NOTICE("<b>You dip your mentality into the surface layer of \the [target]'s mind, seeking an answer: <i>[question]</i></b>"))
	var/option = alert(target, "Someone trying to access your memories, will you accept this?", "Choose something!", "Yes", "No")
	if (!option)
		if(target.psi)
			var/con_rank_target = target.psi.get_rank(PSI_CONSCIOUSNESS)
			if(con_rank_target > con_rank_user)
				to_chat(user, SPAN_NOTICE("<b>[target] blocks your psionic attack without any problem!</b>"))
				to_chat(target, SPAN_NOTICE("<b>You easily protected your memories!</b>"))
				return
			else
				target.adjustBrainLoss(25)
				to_chat(user, SPAN_NOTICE("<b>[target] manages to prevent your attack, but with a big cost!</b>"))
				to_chat(target, SPAN_NOTICE("<b>You managed to protect your memories, but it's affected your brain very much!</b>"))
				return
		else if(!target.psi)
			target.adjustBrainLoss(25)
			to_chat(user, SPAN_NOTICE("<b>[target] manages to prevent your attack, but with a big cost!</b>"))
			to_chat(target, SPAN_NOTICE("<b>You managed to protect your memories, but it's affected your brain very much!</b>"))
			return
	if(option == "Yes")
		to_chat(target, SPAN_NOTICE("<b>Your mind is compelled to answer: <i>[question]</i></b>"))
	if(option == "No")
		if(target.psi)
			var/con_rank_target = target.psi.get_rank(PSI_CONSCIOUSNESS)
			if(con_rank_target > con_rank_user)
				to_chat(user, SPAN_NOTICE("<b>[target] blocks your psionic attack without any problem!</b>"))
				to_chat(target, SPAN_NOTICE("<b>You easily protected your memories!</b>"))
				return
			else
				target.adjustBrainLoss(25)
				to_chat(user, SPAN_NOTICE("<b>[target] manages to prevent your attack, but with a big cost!</b>"))
				to_chat(target, SPAN_NOTICE("<b>You managed to protect your memories, but it's affected your brain very much!</b>"))
				return
		else if(!target.psi)
			target.adjustBrainLoss(25)
			to_chat(user, SPAN_NOTICE("<b>[target] manages to prevent your attack, but with a big cost!</b>"))
			to_chat(target, SPAN_NOTICE("<b>You managed to protect your memories, but it's affected your brain very much!</b>"))
			return


	var/answer =  input(target, question, "Read Mind") as null|text
	if(!answer || world.time > started_mindread + 60 SECONDS || user.stat != CONSCIOUS || target.stat == DEAD)
		to_chat(user, SPAN_NOTICE("<b>You receive nothing useful from \the [target].</b>"))
	else
		to_chat(user, SPAN_NOTICE("<b>You skim thoughts from the surface of \the [target]'s mind: <i>[answer]</i></b>"))
	msg_admin_attack("[key_name(user)] read mind of [key_name(target)] with question \"[question]\" and [answer?"got answer \"[answer]\".":"got no answer."]")
	return TRUE

/decl/psionic_power/consciousness/focus
	name =          "Focus"
	cost =          10
	cooldown =      80
	use_grab =     TRUE
	min_rank =      PSI_RANK_APPRENTICE
	suppress_parent_proc = TRUE
	use_description = "Grab a patient, target the mouth, then use the grab on them while on help intent, in order to cure ailments of the mind."

/decl/psionic_power/consciousness/focus/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_MOUTH)
		return FALSE
	. = ..()
	if(.)
		user.visible_message(SPAN_WARNING("\The [user] kisses \the [target]..."))
		to_chat(user, SPAN_NOTICE("You probe \the [target]'s mind for various ailments.."))
		to_chat(target, SPAN_WARNING("Your mind is being cleansed of ailments by \the [user]."))
		if(!do_after(user, (target.stat == CONSCIOUS ? 50 : 25), target))
			user.psi.backblast(rand(5,10))
			return TRUE
		to_chat(user, SPAN_WARNING("You clear \the [target]'s mind of ailments."))
		to_chat(target, SPAN_WARNING("Your mind is cleared of ailments."))

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
	use_description = "Grab a patient, target the head, then use the grab on them while on help intent, in order to perform a deep coercive-redactive probe of their psionic potential."

/decl/psionic_power/consciousness/assay/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_HEAD)
		return FALSE
	. = ..()
	if(.)
		user.visible_message(SPAN_WARNING("\The [user] holds the head of \the [target] in both hands..."))
		to_chat(user, SPAN_NOTICE("You insinuate your mentality into that of \the [target]..."))
		to_chat(target, SPAN_WARNING("Your persona is being probed by the psychic lens of \the [user]."))
		if(!do_after(user, (target.stat == CONSCIOUS ? 50 : 25), target))
			user.psi.backblast(rand(5,10))
			return TRUE
		to_chat(user, SPAN_NOTICE("You retreat from \the [target], holding your new knowledge close."))
		to_chat(target, SPAN_DANGER("Your mental complexus is laid bare to judgement of \the [user]."))
		target.show_psi_assay(user)
		return TRUE