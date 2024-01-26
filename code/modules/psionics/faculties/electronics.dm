/decl/psionic_faculty/electronics
	id = PSI_ELECTRONICS
	name = "Electronics"
	associated_intent = I_HURT
	armour_types = list("energy", "melee")

/decl/psionic_power/electronics
	faculty = PSI_ELECTRONICS

/decl/psionic_power/electronics/spark
	name =            "Spark"
	cost =            5
	cooldown =        5
	use_melee =       TRUE
	min_rank =        PSI_RANK_APPRENTICE
	use_description = "Нажмите по любому неживому объекту на красном интенте, чтобы создать искры, способные поджечь что-либо."

/decl/psionic_power/electronics/spark/invoke(var/mob/living/user, var/mob/living/target)
	if(isnull(target) || istype(target)) return FALSE
	. = ..()

	if(.)
		if(istype(target,/obj/item/clothing/mask/smokable/cigarette))
			var/obj/item/clothing/mask/smokable/cigarette/S = target
			S.light("[user] щёлкает пальцами, зажигая [S.name].")
			playsound(S.loc, "sparks", 50, 1)

		else
			var/datum/effect/effect/system/spark_spread/sparks = new ()
			sparks.set_up(3, 0, get_turf(target))
			sparks.start()
		return TRUE

/decl/psionic_power/electronics/sneaky
	name =            "Sneaky Hands"
	cost =            30
	cooldown =        40
	use_melee =       TRUE
	min_rank =        PSI_RANK_OPERANT
	use_description = "Выберите левую кисть на красном интенте и нажмите по двери чтобы открыть её. Если вы уже освоились с навыком, то также сможете опускать и поднимать болты с двери, нажав на неё правой кистью."

/decl/psionic_power/electronics/sneaky/invoke(var/mob/living/user, var/mob/living/target)
	if(isnull(target) || istype(target)) return FALSE
	. = ..()

	var/el_rank = user.psi.get_rank(PSI_ELECTRONICS)

	if(.)
		if(istype(target,/obj/machinery/door/airlock) && user.zone_sel.selecting == BP_L_HAND)
			var/obj/machinery/door/airlock/D = target
			D.open("[user] щёлкает пальцами и [D.name] открывается.")
			new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "electricity_constant")
			playsound(D.loc, "sparks", 50, 1)

		if(el_rank >= PSI_RANK_MASTER && user.zone_sel.selecting == BP_R_HAND)
			if(istype(target,/obj/machinery/door/airlock))
				var/obj/machinery/door/airlock/D = target
				D.toggle_lock("[user] щёлкает пальцами, и болты на [D.name] опускаются.")
				new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "electricity_constant")
				playsound(D.loc, "sparks", 50, 1)

		return TRUE

/decl/psionic_power/electronics/electrocute
	name =            "Electrocute"
	cost =            20
	cooldown =        80
	use_melee =       TRUE
	min_rank =        PSI_RANK_APPRENTICE
	use_description = "Выберите верхнюю или нижнюю часть тела на красном интенте и нажмите по цели, чтобы ударить её током."

/decl/psionic_power/electronics/electrocute/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_CHEST && user.zone_sel.selecting != BP_GROIN)
		return FALSE
	if(istype(target, /turf))
		return FALSE
	. = ..()
	if(.)
		user.visible_message("<span class='danger'>[user] направляет свору молний в тело [target]!</span>")
		var/el_rank = user.psi.get_rank(PSI_ELECTRONICS)
		if(istype(target))
			target.electrocute_act(rand(el_rank * 2,el_rank * 5), user, 1, user.zone_sel.selecting)
			return TRUE
		else if(isatom(target))
			var/obj/item/cell/charging_cell = target.get_cell()
			if(istype(charging_cell))
				charging_cell.give(rand(el_rank * 3,el_rank * 6))
			new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "electricity_constant")
			return TRUE
