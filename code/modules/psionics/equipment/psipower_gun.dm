/obj/item/gun/energy/psigun
	name = "psychokinetic gun"
	desc = "Result of Demiurgy and Hyloforia combinated factors."
	icon = 'icons/obj/psychic_powers.dmi'
	icon_state = "gun"
	fire_sound = 'sound/weapons/Taser.ogg'
	fire_sound_text = "energy blast"

	var/maintain_cost = 10
	var/mob/living/owner

	max_shots = 20 //Determines the capacity of the weapon's power cell. Specifying a cell_type overrides this value.
	projectile_type = /obj/item/projectile/psi

	self_recharge = 1	//if set, the weapon will recharge itself

/obj/item/gun/energy/psigun/New(var/mob/living/_owner)
	owner = _owner
	if(!istype(owner))
		qdel(src)
		return
	START_PROCESSING(SSprocessing, src)
	..()

/obj/item/gun/energy/psigun/Destroy()
	if(istype(owner) && owner.psi)
		LAZYREMOVE(owner.psi.manifested_items, src)
		UNSETEMPTY(owner.psi.manifested_items)
	STOP_PROCESSING(SSprocessing, src)
	. = ..()

/obj/item/gun/energy/psigun/get_storage_cost()
	return ITEM_SIZE_NO_CONTAINER

/obj/item/gun/energy/psigun/attack(var/mob/living/M, var/mob/living/user, var/target_zone)
	if(M.do_psionics_check(max(force, maintain_cost), user))
		to_chat(user, "<span class='danger'>\The [src] flickers violently out of phase!</span>")
		return 1
	. = ..()

/obj/item/gun/energy/psigun/afterattack(var/atom/target, var/mob/living/user, var/proximity)
	if(target.do_psionics_check(max(force, maintain_cost), user))
		to_chat(user, "<span class='danger'>\The [src] flickers violently out of phase!</span>")
		return
	. = ..(target, user, proximity)

/obj/item/gun/energy/psigun/special_check(var/mob/user)

	if(!istype(user, /mob/living))
		return 0
	if(!user.IsAdvancedToolUser())
		return 0

	var/mob/living/M = user
	if(!safety() && world.time > last_safety_check + 5 MINUTES && !user.skill_check(SKILL_WEAPONS, SKILL_BASIC))
		if(prob(30))
			toggle_safety()
			return 1
	if(MUTATION_HULK in M.mutations)
		to_chat(M, "<span class='danger'>Your fingers are much too large for the trigger guard!</span>")
		return 0
	if(M.psi)
		var/hilo_rank = M.psi.get_rank(PSI_ENERGISTICS)
		if(hilo_rank <= PSI_RANK_LATENT)
			to_chat(M, "<span class='danger'>јга, ты научилс€ делать пистолет! “олько как ты теперь будешь выпускать из него пули?</span>")
			return 0
	if((MUTATION_CLUMSY in M.mutations) && prob(40)) //Clumsy handling
		var/obj/P = consume_next_projectile()
		if(P)
			if(process_projectile(P, user, user, pick(BP_L_FOOT, BP_R_FOOT)))
				handle_post_fire(user, user)
				user.visible_message(
					"<span class='danger'>\The [user] shoots \himself in the foot with \the [src]!</span>",
					"<span class='danger'>You shoot yourself in the foot with \the [src]!</span>"
					)
				M.unequip_item()
		else
			handle_click_empty(user)
		return 0
	return 1

/obj/item/gun/energy/psigun/dropped()
	..()
	qdel(src)

/obj/item/gun/energy/psigun/Process()
	if(istype(owner))
		owner.psi.spend_power(maintain_cost)
	if(!owner || owner.do_psionics_check(maintain_cost, owner) || loc != owner || (owner.l_hand != src && owner.r_hand != src))
		if(istype(loc,/mob/living))
			var/mob/living/carbon/human/host = loc
			if(istype(host))
				for(var/obj/item/organ/external/organ in host.organs)
					for(var/obj/item/O in organ.implants)
						if(O == src)
							organ.implants -= src
			host.pinned -= src
			host.embedded -= src
			host.drop_from_inventory(src)
		else
			STOP_PROCESSING(SSprocessing, src)

	..()