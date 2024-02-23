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
