/obj/item/clothing/gloves/insulated/psi
	name = "psychokinetic gloves"

	var/maintain_cost = 2
	var/mob/living/carbon/human/owner
	color = "#0095ff"
	alpha = 110

/obj/item/clothing/gloves/insulated/psi/New(var/mob/living/_owner)
	owner = _owner
	if(!istype(owner))
		qdel(src)
		return
	START_PROCESSING(SSprocessing, src)
	..()

/obj/item/clothing/gloves/insulated/psi/Destroy()
	if(istype(owner) && owner.psi)
		LAZYREMOVE(owner.psi.manifested_items, src)
		UNSETEMPTY(owner.psi.manifested_items)
	STOP_PROCESSING(SSprocessing, src)
	. = ..()

/obj/item/clothing/gloves/insulated/psi/get_storage_cost()
	return ITEM_SIZE_NO_CONTAINER

/obj/item/clothing/gloves/insulated/psi/dropped()
	..()
	qdel(src)

/obj/item/clothing/gloves/insulated/psi/Process()
	if(istype(owner))
		owner.psi.spend_power(maintain_cost)
	if(!owner || owner.do_psionics_check(maintain_cost, owner) || loc != owner || (owner.l_hand != src && owner.r_hand != src && owner.gloves != src))
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

/obj/item/psychic_power/tinker
	name = "psychokinetic crowbar"
	icon_state = "tinker"
	item_state = "psiblade"
	force = 1
	var/list/emulation = list("Crowbar","Wrench","Screwdriver","Wirecutters")
	var/has_multitool = FALSE
	var/has_welder = FALSE
	var/emulating = "Crowbar"

/obj/item/psychic_power/tinker/iscrowbar()
	return emulating == "Crowbar"

/obj/item/psychic_power/tinker/iswrench()
	return emulating == "Wrench"

/obj/item/psychic_power/tinker/isscrewdriver()
	return emulating == "Screwdriver"

/obj/item/psychic_power/tinker/iswirecutter()
	return emulating == "Wirecutters"

/obj/item/psychic_power/tinker/ismultitool()
	return emulating == "Multitool"

/obj/item/psychic_power/tinker/iswelder()
	return emulating == "Welder"

/obj/item/psychic_power/tinker/attack_self()
	if(owner.psi)
		var/fire_rank = owner.psi.get_rank(PSI_METAKINESIS)
		var/demi_rank = owner.psi.get_rank(PSI_MANIFESTATION)
		if(fire_rank >= PSI_RANK_LATENT && demi_rank >= PSI_RANK_OPERANT && owner.skill_check(SKILL_CONSTRUCTION, SKILL_TRAINED) && !has_welder)
			emulation += "Welder"
			has_welder = TRUE
		if(demi_rank >= PSI_RANK_MASTER && owner.skill_check(SKILL_ELECTRICAL, SKILL_BASIC) && owner.skill_check(SKILL_DEVICES, SKILL_TRAINED) && !has_multitool)
			emulation += "Multitool"
			has_multitool = TRUE


	if(!owner || loc != owner)
		return

	var/choice = input("Select a tool to emulate.","Power") as null|anything in emulation
	if(!choice)
		return

	if(!owner || loc != owner)
		return

	if(choice == "Dismiss")
		sound_to(owner, 'sound/effects/psi/power_fail.ogg')
		owner.drop_from_inventory(src)
		return

	emulating = choice
	name = "psychokinetic [lowertext(emulating)]"
	to_chat(owner, "<span class='notice'>You begin emulating \a [lowertext(emulating)].</span>")
	sound_to(owner, 'sound/effects/psi/power_fabrication.ogg')
