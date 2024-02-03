/decl/psionic_faculty/metakinesis
	id = PSI_METAKINESIS
	name = "Metaplexy"
	associated_intent = I_GRAB
	armour_types = list("laser", "melee")

/decl/psionic_power/metakinesis
	faculty = PSI_METAKINESIS
	use_manifest = TRUE

/decl/psionic_power/metakinesis/element
	name =            "Manifest element"
	cost =            5
	cooldown =        50
	min_rank =        PSI_RANK_APPRENTICE
	use_description = "Нажмите по пустой руке на жёлтом интенте, чтобы воспользоваться одним из трёх стихийных элементов."
	admin_log = FALSE

/decl/psionic_power/metakinesis/element/invoke(var/mob/living/user, var/mob/living/target)
	if((target && user != target) || user.a_intent != I_GRAB)
		return FALSE
	. = ..()
	if(.)
		var/option = input(target, "Choose something!", "Element to use") in list("Electricity", "Fire", "Ice")
		if (!option)
			return
		if(option == "Electricity")
			return new /obj/item/psychic_power/psielectro(user, user)
		if(option == "Fire")
			return new /obj/item/psychic_power/psifire(user, user)
		if(option == "Ice")
			return
