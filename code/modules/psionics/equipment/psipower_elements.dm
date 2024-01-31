/obj/item/psychic_power/psielectro
	name = "orb of energy"
	force = 5
	edge = TRUE
	maintain_cost = 5
	icon_state = "electro"
	item_state = "electro"
	attack_cooldown = 10
	var/ranged = FALSE

/obj/item/psychic_power/psielectro/New(var/mob/living/user)
	if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) == PSI_RANK_GRANDMASTER)
		ranged = TRUE

	..()

/obj/item/psychic_power/psielectro/afterattack(atom/A as mob|obj|turf|area, var/mob/living/user as mob, proximity)
	if(!proximity && !ranged)
		return

	var/el_rank = user.psi.get_rank(PSI_METAKINESIS)

//MOBS

	if(istype(A, /mob/living))
		var/mob/living/target = A

		if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) <= PSI_RANK_OPERANT)
			user.visible_message("<span class='danger'>[user] направляет свору еле-заметных молний в тело [target]!</span>")
		if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) >= PSI_RANK_MASTER)
			user.visible_message("<span class='danger'>[user] поражает [target] мощным электрическим шквалом!</span>")
		if(target.psi && !target.psi.suppressed)
			var/el_rank_target = target.psi.get_rank(PSI_METAKINESIS)
			if(el_rank_target >= el_rank && prob(40))
				user.visible_message("<span class='danger'>[target] пропускает ток через себя, возвращая его [user] в виде молнии!</span>")
				user.electrocute_act(rand(el_rank_target * 2,el_rank_target * 5), target, 1, target.zone_sel.selecting)
				new /obj/effect/temporary(get_turf(user),3, 'icons/effects/effects.dmi', "electricity_constant")
				return TRUE
			if(el_rank_target >= PSI_RANK_GRANDMASTER)
				user.visible_message("<span class='danger'>[target] пропускает ток через себя, возвращая его [user] в виде молнии!</span>")
				user.electrocute_act(rand(el_rank_target * 4,el_rank_target * 6), target, 1, target.zone_sel.selecting)
				new /obj/effect/temporary(get_turf(user),3, 'icons/effects/effects.dmi', "electricity_constant")
				return TRUE
		target.electrocute_act(rand(el_rank * 2,el_rank * 5), user, 1, user.zone_sel.selecting)
		new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "electricity_constant")
		return TRUE

//LIGHT

	if(istype(A, /obj/machinery/light))
		var/obj/machinery/light/lighting = A
		if(lighting.on)
			if(istype(user) && user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) >= PSI_RANK_OPERANT)
				if(do_after(user, 30))
					if(proximity)
						user.visible_message("<span class='danger'>[user] прислоняет руку к источнику света, и уже через пару секунд он угасает!</span>")
						to_chat(user, "<span class='warning'>Вы прислоняете руку к рабочей лампе, высасывая из неё всё содержимое!</span>")
					else
						user.visible_message("<span class='danger'>[user] протягивает руку к [lighting], и затем, резким взмахом вырывает всю энергию, которая в нём хранилась!</span>")
						to_chat(user, "<span class='warning'>Вы с скрипом разбиваете источник света, вытягивая всё электричество, которое в нём было.</span>")
					lighting.broken(TRUE)
					user.psi.stamina = min(user.psi.max_stamina, user.psi.stamina + rand(5,10))
		else
			return

//CELLS

	var/obj/item/cell/charging_cell = A.get_cell()
	if(istype(charging_cell))
		if(proximity)
			user.visible_message("<span class='warning'>[user] прикладывает руку к [charging_cell], наполняя её энергией!</span>")
		else
			user.visible_message("<span class='warning'>[user] направляет руку к [charging_cell], посылая в неё поток молний!</span>")
		charging_cell.give(rand(el_rank * 3,el_rank * 6))
		new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
		return TRUE

//AIRLOCKS

	if(istype(A,/obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/D = A
		var/option = input(user, "Do something!", "What do you want to do?") in list("Open/Close", "Bolt/Unbolt", "Electrify")
		if (!option)
			return
		if(option == "Open/Close")
			if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) <= PSI_RANK_OPERANT)
				if(prob(30))
					to_chat("<span class='warning'>Вы несколько раз щёлкаете пальцами у [D.name], но ничего не происходит!</span>")
					user.visible_message("<span class='notice'>[user] несколько раз щёлкает пальцами у [D.name] в непонимании.</span>")
					return
			if(D && AIRLOCK_OPEN)
				D.open()
				user.visible_message("<span class='notice'>[user] щёлкает пальцами и [D.name] открывается.</span>")
				new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
				playsound(D.loc, "sparks", 50, 1)
			if(D && AIRLOCK_CLOSED)
				D.close()
				user.visible_message("<span class='notice'>[user] щёлкает пальцами и [D.name] закрывается.</span>")
				new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
				playsound(D.loc, "sparks", 50, 1)

		if(option == "Electrify")
			D.electrify(50, 0)
			if(proximity)
				user.visible_message("<span class='warning'>[user] прикладывает руку к панели [D.name], пропуская через неё поток тока.</span>")
			else
				user.visible_message("<span class='warning'>[user] посылает в [D.name] мощный поток электричества.</span>")
			new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
			playsound(D.loc, "sparks", 50, 1)

		if(option == "Bolt/Unbolt")
			if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) >= PSI_RANK_MASTER)
				D.toggle_lock()
				if(proximity)
					user.visible_message("<span class='notice'>[user] прислоняет обе руки к [D.name], приводя болты в движение.</span>")
				else
					user.visible_message("<span class='notice'>[user] сжимает руку в кулак, приводя болты [D.name] в движение.</span>")
				new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
				playsound(D.loc, "sparks", 50, 1)
			else
				user.visible_message("<span class='notice'>[user] прислоняет обе руки к [D.name], но ничего не происходит.</span>")
				to_chat("<span class='warning'>Вы прислоняете свои руки к [D.name], пытаясь пропустить поток через его внутренние механизмы, но ничего не получается!</span>")
				return

	..()