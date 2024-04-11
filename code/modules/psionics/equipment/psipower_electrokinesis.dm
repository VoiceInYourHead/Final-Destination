/obj/item/psychic_power/electric_whip
	name = "electric whip"
	force = 10
	maintain_cost = 4
	icon_state = "electrowhip"
	attack_cooldown = 10

	var/cooldown = 0
	base_parry_chance = 10

/obj/item/psychic_power/electric_whip/Process()
	if(cooldown > 0)
		cooldown--

	. = ..()

/obj/item/psychic_power/electric_whip/afterattack(atom/A as mob|obj|turf|area, var/mob/living/user as mob)
	var/el_rank = user.psi.get_rank(PSI_METAKINESIS)

	if(istype(A, /mob/living))
		var/mob/living/target = A

		if(get_dist(user, target) > 4)
			return FALSE

		if(cooldown > 0)
			to_chat(user, "<span class='warning'>Ты не можешь использовать плеть настолько часто!</span>")
			return

		if(get_dist(user, target) >= 2)

			if(target == user)
				to_chat(user, "<span class='warning'>Вы не можете зарядить самого себя!</span>")
				return
			if(target.psi && !target.psi.suppressed)
				var/el_rank_target = target.psi.get_rank(PSI_METAKINESIS)
				if(el_rank_target >= el_rank && prob(50))
					user.visible_message("<span class='danger'>[target] пропускает ток через себя, возвращая его [user] в виде молнии!</span>")
					user.electrocute_act(rand(el_rank_target * 2, el_rank_target * 5), target, 1, target.zone_sel.selecting)
					new /obj/effect/temporary(get_turf(user),3, 'icons/effects/effects.dmi', "electricity_constant")
					return TRUE
			cooldown += 2
			target.electrocute_act(rand(el_rank * 2, el_rank * 5), user, 1, user.zone_sel.selecting)
			new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "electricity_constant")
			return TRUE

/obj/item/psychic_power/electric_whip/apply_hit_effect(mob/living/target, mob/living/user, var/hit_zone)
	var/el_rank = user.psi.get_rank(PSI_METAKINESIS)

	if(target.psi && !target.psi.suppressed)
		var/el_rank_target = target.psi.get_rank(PSI_METAKINESIS)
		if(el_rank_target >= el_rank && prob(50))
			user.visible_message("<span class='danger'>[target] пропускает ток через себя, возвращая его [user] в виде молнии!</span>")
			user.electrocute_act(rand(el_rank_target * 2, el_rank_target * 5), target, 1, target.zone_sel.selecting)
			new /obj/effect/temporary(get_turf(user),3, 'icons/effects/effects.dmi', "electricity_constant")
			..()
	cooldown += 2
	target.electrocute_act(rand(el_rank * 2, el_rank * 5), user, 1, user.zone_sel.selecting)
	new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "electricity_constant")
	..()
