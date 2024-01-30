/obj/item/psychic_power/psielectro
	name = "orb of energy"
	force = 5
	sharp = TRUE
	edge = TRUE
	maintain_cost = 5
	icon_state = "electro"
	item_state = "electro"
	attack_cooldown = 10

/obj/item/psychic_power/psielectro/afterattack(atom/A as mob|obj|turf|area, var/mob/living/carbon/user as mob, proximity)

//CELLS

	var/el_rank = user.psi.get_rank(PSI_METAKINESIS)

	var/obj/item/cell/charging_cell = A.get_cell()
	if(istype(charging_cell))
		user.visible_message("<span class='warning'>[user] сжимает [charging_cell] в руке, наполняя её энергией!</span>")
		charging_cell.give(rand(el_rank * 3,el_rank * 6))
		new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
		return TRUE

//MOBS

	if(istype(A, /mob/living))
		var/mob/living/target = A

		if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) <= PSI_RANK_OPERANT)
			user.visible_message("<span class='danger'>[user] направляет свору еле-заметных молний в тело [target]!</span>")
		if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) >= PSI_RANK_MASTER)
			user.visible_message("<span class='danger'>[user] поражает [target] мощным электрическим шквалом!</span>")
		target.electrocute_act(rand(el_rank * 2,el_rank * 5), user, 1, user.zone_sel.selecting)
		return TRUE

//AIRLOCKS

	if(istype(A,/obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/D = A
		var/option = input(user, "Do something!", "What do you want to do?") in list("Open/Close", "Bolt/Unbolt It", "Electrify")
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
			user.visible_message("<span class='warning'>[user] прикладывает руку к панели [D.name], пропуская через неё поток тока.</span>")
			new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
			playsound(D.loc, "sparks", 50, 1)

		if(option == "Bolt/Unbolt it")
			if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) >= PSI_RANK_MASTER)
				D.toggle_lock()
				user.visible_message("<span class='notice'>[user] прислоняет обе руки к [D.name], приводя болты в движение.</span>")
				new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
				playsound(D.loc, "sparks", 50, 1)
			else
				user.visible_message("<span class='notice'>[user] прислоняет обе руки к [D.name], но ничего не происходит.</span>")
				to_chat("<span class='warning'>Вы прислоняете свои руки к [D.name], пытаясь пропустить поток через его внутренние механизмы, но ничего не получается!</span>")
				return