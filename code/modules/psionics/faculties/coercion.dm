/decl/psionic_faculty/coercion
	id = PSI_COERCION
	name = "Catastellia"
	associated_intent = I_DISARM
	armour_types = list(PSIONIC, "melee")

/decl/psionic_power/coercion
	faculty = PSI_COERCION

/decl/psionic_power/coercion/invoke(var/mob/living/user, var/mob/living/target)
	. = ..()
	if (!.)
		return FALSE

	if (!istype(target))
		to_chat(user, SPAN_WARNING("Вы не можете пробиться в сознание [target]."))
		return FALSE

	if(. && target.deflect_psionic_attack(user))
		return FALSE

/decl/psionic_power/coercion/blindstrike
	name =           "Blindstrike"
	cost =           25
	cooldown =       120
	use_ranged =     TRUE
	use_melee =      TRUE
	min_rank =       PSI_RANK_OPERANT
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


/decl/psionic_power/coercion/emotions
	name =            "Emotion Amplifier"
	cost =            20
	cooldown =        30
	use_melee =     TRUE
	use_ranged =     TRUE
	min_rank =        PSI_RANK_OPERANT
	use_description = "Выберите грудь и переключитесь на синий интент. Затем, нажмите по вашей цели, чтобы многократно усилить одну из её эмоций."

/decl/psionic_power/coercion/emotions/invoke(var/mob/living/user, var/mob/living/target)
	var/list/options = list(
		"Joy" = image('icons/screen/psi.dmi', "JOY"),
		"Sadness" = image('icons/screen/psi.dmi', "SADNESS"),
		"Fear" = image('icons/screen/psi.dmi', "FEAR"),
		"Caution" = image('icons/screen/psi.dmi', "ANXIETY"),
		"Anger" = image('icons/screen/psi.dmi', "ANGER"),
		"Stillness" = image('icons/screen/psi.dmi', "STILLNESS")
	)

	if(user.zone_sel.selecting != BP_CHEST)
		return FALSE
	if(target == user)
		return FALSE
	if(isrobot(target))
		return FALSE
	. = ..()
	if(.)

		var/chosen_option = show_radial_menu(user, user, options, radius = 25, require_near = TRUE)
		if (!chosen_option)
			return 0
		if(user.psi.suppressed)
			return 0
		switch(chosen_option)
			if("Joy")
				var/funny_option = pick("вспоминаете крайне смешную шутку", "вспоминаете очень глупую историю", "всматриваетесь в лицо [user]")
				to_chat(target, SPAN_WARNING("Внезапно, вы [funny_option], начиная истошно смеяться и кататься по полу."))
				var/mob/living/carbon/C = target
				C.Weaken(5)
				C.spin(32,2)
				C.emote("giggle")
				spawn(3 SECONDS)
					C.emote("giggle")
				spawn(6 SECONDS)
					C.emote("giggle")
				return 1
			if("Sadness")
				var/sad_option = pick("погружаетесь в ваши детские воспоминания", "вспоминаете о ужасной потере", "на секунду замечаете перед собой знакомый силуэт", "вспоминаете о своих прошлых ошибках")
				to_chat(target, SPAN_WARNING("Внезапно, вы [sad_option], не замечая, как по вашим щекам текут слёзы."))
				var/mob/living/carbon/C = target
				C.eye_blurry = max(C.eye_blurry, 10)
				C.emote("whimper")
				spawn(3 SECONDS)
					C.emote("whimper")
				spawn(6 SECONDS)
					C.emote("whimper")
				return 1
			if("Fear")
				to_chat(target, SPAN_OCCULT("Внезапно, ваше тело цепенеет от одного только взгляда в сторону [user]. Вы дрожите, словно ваш мозг испытывает какой-то подсознательный страх."))
				var/cn_rank = user.psi.get_rank(PSI_COERCION)
				var/mob/living/carbon/C = target
				C.make_dizzy(10)
				C.Stun(5 + cn_rank)
				return 1
			if("Caution")
				var/strange_option = pick("ощущаете чьё-то зловещее присутствие", "сильно потеете", "чувствуете, что за вами что-то наблюдает", "ощущаете странный холод", "чувствуете, как что-то ползает по вам")
				to_chat(target, SPAN_DANGER("Вы [strange_option]."))
				return 1
			if("Anger")
				var/anger_option = pick("к самому себе", "к человеку, что стоит рядом", "к месту, в котором вы находитесь", "к своей жизни", "по отношению к данной ситуации", "к сегодняшнему дню", "к сегодняшней погоде", "к вашей работе", "к тому, что было вчера")
				to_chat(target, SPAN_DANGER("Внезапно, вы ощущаете странную злобу [anger_option]."))
				return 1
			if("Stillness")
				to_chat(target, SPAN_NOTICE("Вы ощущаете странное умиротворение."))
				if(target.psi)
					target.psi.stamina = min(target.psi.max_stamina, target.psi.stamina + rand(15,20))
				return 1

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

/decl/psionic_power/coercion/mind_control
	name =          "Mind Control"
	cost =          28
	cooldown =      10 SECONDS
	use_ranged =    TRUE
	use_melee =     TRUE
	min_rank =      PSI_RANK_OPERANT
	suppress_parent_proc = TRUE
	use_description = "Переключитесь на синий интент, затем выберите голову и нажмите по цели дабы ВРЕМЕННО обратить её в своего верного подчинённого."

	var/invoking = FALSE

/decl/psionic_power/coercion/mind_control/invoke(mob/living/user, mob/living/target)
	if(!istype(target))
		return FALSE

	if(user.zone_sel.selecting != BP_HEAD)
		return FALSE

	if(!can_use(user, target))
		return FALSE

	if(user == target)
		return FALSE

	if(!..())
		return FALSE

	user.visible_message("<span class='notice'><i>[user] прижимает палец к веску, старательно концентрируясь над чем-то...</i></span>")
	to_chat(user, "<span class='warning'>Вы проникаете в хрупкое сознание [target]...</span>")
	to_chat(target, "<span class='danger'>Вы ощущаете присутствие [user] в своей голове! Его настойчивые мысли и желания постепенно заражают ваш разум!</span>")

	invoking = TRUE

	var/rank = user.psi.get_rank(faculty)
	var/delay = 30 SECONDS / (rank - 2) // 30, 20, 10
	if(!do_after(user, delay, target, DO_SHOW_PROGRESS|DO_USER_SAME_HAND|DO_BOTH_CAN_TURN|DO_TARGET_CAN_MOVE))
		user.psi.backblast(rand(2,10))
		invoking = FALSE
		return TRUE

	invoking = FALSE

	if(get_dist(user, target) > world.view)
		to_chat(user, "<span class='warning'>[target] находится слишком далеко!</span>")
		return TRUE

	if(!can_use(user, target))
		return TRUE

	var/flags = rank > PSI_RANK_OPERANT ? null : MIND_CONTROL_ALLOW_SAY
	var/duration = 1 MINUTE + 2 MINUTE * (rank - 3) // 1, 3, 5

	user.set_control_mind(target, duration, flags)
	handle_mind_link(user, duration, target)

	to_chat(user, "<span class='danger'>Вы вторгаетесь в сознание [target], ощущая частичный контроль над его телом!</span>")
	to_chat(target, "<span class='danger'>Ваши стены наконец пали, и вы потеряли контроль над своим телом!</span>")

	return TRUE

/decl/psionic_power/coercion/mind_control/proc/can_use(mob/living/user, mob/living/target)
	if(invoking)
		return FALSE

	if(target.stat == UNCONSCIOUS)
		to_chat(user, "<span class='warning'>[target] находится в бессознательном состоянии!</span>")
		return FALSE

	if(target.stat == DEAD || (target.status_flags & FAKEDEATH))
		to_chat(user, "<span class='warning'>[target] мёртв!</span>")
		return FALSE

	var/datum/mind_control/mind_controller = user.mind_controller
	if(mind_controller && (target in mind_controller.affected))
		to_chat(user, "<span class='warning'>[target] уже находится под чьим-то контролем!</span>")
		return FALSE

	return TRUE

/decl/psionic_power/coercion/mind_control/proc/handle_mind_link(mob/user, duration, target)
	set waitfor = FALSE

	if(user.client)
		user.client.verbs += /client/proc/order_move

	do_after(user, duration, null, DO_SHOW_PROGRESS|DO_BOTH_CAN_TURN|DO_BOTH_CAN_MOVE)
	to_chat(user, "<span class='danger'>Разум [target] более не находится в вашем подчинении!</span>")

	var/datum/mind_control/mind_controller = user.mind_controller
	if(!mind_controller)
		mind_controller.affected -= target
		return

	if(user.client)
		user.client.verbs -= /client/proc/order_move
