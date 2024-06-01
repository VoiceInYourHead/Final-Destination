/mob/living
	var/datum/psi_complexus/psi

/mob/living/Login()
	. = ..()
	if(psi)
		psi.update(TRUE)
		if(!psi.suppressed)
			psi.show_auras()

/mob/living/Destroy()
	QDEL_NULL(psi)
	. = ..()

/mob/living/proc/set_psi_rank(var/faculty, var/rank, var/take_larger, var/defer_update, var/temporary)
	if(!src.zone_sel)
		to_chat(src, SPAN_NOTICE("You feel something strange brush against your mind... but your brain is not able to grasp it."))
		return
	if(!psi)
		psi = new(src)
	var/current_rank = psi.get_rank(faculty)
	if(current_rank != rank && (!take_larger || current_rank < rank))
		psi.set_rank(faculty, rank, defer_update, temporary)

/mob/living/proc/deflect_psionic_attack(var/attacker)
	var/blocked = 80 * get_blocked_ratio(null, PSIONIC)
	if(prob(blocked))
		if(attacker)
			to_chat(attacker, SPAN_WARNING("Your mental attack is deflected by \the [src]'s defenses!"))
			to_chat(src, SPAN_DANGER("\The [attacker] strikes out with a mental attack, but you deflect it!"))
		return TRUE
	return FALSE

/mob/living/proc/thanos()
	log_and_message_admins(SPAN_DANGER("- щёлкнул пальцами подумав про [key_name(src)]."))
	for(alpha, alpha >= 10, alpha -= 10)
		switch(alpha)
			if(255)
				alpha = 250
				to_chat(src, SPAN_DANGER("Ты чувствуешь как становишься тяжелее."))
			if(200)
				to_chat(src, SPAN_DANGER("Я... Слабею..."))
			if(150)
				to_chat(src, SPAN_DANGER("O нет..."))
			if(120)
				to_chat(src, SPAN_DANGER("<font size = 3> Почему я?"))
			if(90)
				to_chat(src, SPAN_DANGER("<font size = 4> Это и правда реально?"))
			if(50)
				to_chat(src, SPAN_DANGER("<font size = 5> Всё кончено..."))
			if(20)
				to_chat(src, SPAN_DANGER("<font size = 5> Ничего... He останется..."))
		sleep(1 SECONDS)
	if(alpha <= 10)
		to_chat(src, SPAN_DANGER("<font size = 5> Там будет только пустота..."))
		alpha = 0
		mouse_opacity = FALSE
		sleeping += 100000
		paralysis += 100000
		log_and_message_admins(SPAN_DANGER("- уничтожил [key_name(src)]. Низвёл до атомов."))
