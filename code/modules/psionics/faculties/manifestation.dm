/decl/psionic_faculty/manifestation
	id = PSI_MANIFESTATION
	name = "Demiurgy"
	associated_intent = I_GRAB
	armour_types = list("bullet", "melee")

/decl/psionic_power/manifestation
	faculty = PSI_MANIFESTATION
	use_manifest = TRUE
	use_sound = null

/decl/psionic_power/manifestation/psiblade
	name =            "Manifest weapon"
	cost =            5
	cooldown =        50
	min_rank =        PSI_RANK_APPRENTICE
	use_description = "Нажмите по пустой руке на красном интенте, чтобы создать оружие из чистой псионической энергии."
	admin_log = FALSE


//I know, there is a lot of better ways to do this
/decl/psionic_power/manifestation/psiblade/invoke(var/mob/living/user, var/mob/living/target)
	if((target && user != target) || user.a_intent != I_HURT)
		return FALSE
	. = ..()
	if(.)
		switch(user.psi.get_rank(faculty))
			if(PSI_RANK_GRANDMASTER)
				var/option = input(target, "Choose something!", "Weapons to create") in list("Sword", "Club", "Battle Axe", "Spear", "Crossbow", "Pistol")
				if (!option)
					return
				if(user.psi.suppressed)
					return
				if(option == "Club")
					return new /obj/item/psychic_power/psiclub/master/grand/paramount(user, user)
				if(option == "Sword")
					return new /obj/item/psychic_power/psiblade/master/grand/paramount(user, user)
				if(option == "Battle Axe")
					return new /obj/item/psychic_power/psiaxe/master/grand/paramount(user, user)
				if(option == "Spear")
					return new /obj/item/psychic_power/psispear/master/grand/paramount(user, user)
				if(option == "Crossbow")
					return new /obj/item/gun/launcher/crossbow/psibow/master/grand/paramount(user, user)
				if(option == "Pistol")
					if(user.skill_check(SKILL_WEAPONS, SKILL_TRAINED) && user.skill_check(SKILL_CONSTRUCTION, SKILL_EXPERIENCED))
						return new /obj/item/gun/energy/psigun(user, user)
					else
						to_chat(user, SPAN_OCCULT("<b>Вы пытаетесь какое-то время собраться с мыслями, но совершенно не понимаете, как вам создать столь сложную конструкцию.</b>"))
						return FALSE
			if(PSI_RANK_MASTER)
				var/option = input(target, "Choose something!", "Weapons to create") in list("Sword", "Club", "Battle Axe", "Spear", "Crossbow")
				if (!option)
					return
				if(user.psi.suppressed)
					return
				if(option == "Club")
					return new /obj/item/psychic_power/psiclub/master/grand(user, user)
				if(option == "Sword")
					return new /obj/item/psychic_power/psiblade/master/grand(user, user)
				if(option == "Battle Axe")
					return new /obj/item/psychic_power/psiaxe/master(user, user)
				if(option == "Spear")
					return new /obj/item/psychic_power/psispear/master(user, user)
				if(option == "Crossbow")
					return new /obj/item/gun/launcher/crossbow/psibow/master(user, user)
			if(PSI_RANK_OPERANT)
				var/option = input(target, "Choose something!", "Weapons to create") in list("Blade", "Club", "Battle Axe", "Spear")
				if (!option)
					return
				if(user.psi.suppressed)
					return
				if(option == "Club")
					return new /obj/item/psychic_power/psiclub/master(user, user)
				if(option == "Blade")
					return new /obj/item/psychic_power/psiblade/master(user, user)
				if(option == "Battle Axe")
					return new /obj/item/psychic_power/psiaxe(user, user)
				if(option == "Spear")
					return new /obj/item/psychic_power/psispear(user, user)
			else
				var/option = input(target, "Choose something!", "Weapons to create") in list("Blade", "Club")
				if (!option)
					return
				if(user.psi.suppressed)
					return
				if(option == "Club")
					return new /obj/item/psychic_power/psiclub(user, user)
				if(option == "Blade")
					return new /obj/item/psychic_power/psiblade(user, user)

/decl/psionic_power/manifestation/tinker
	name =            "Manifest tool"
	cost =            5
	cooldown =        10
	min_rank =        PSI_RANK_APPRENTICE
	use_description = "Нажмите по пустой руке на зелёном интенте, чтобы создать ряд полезных инструментов."
	admin_log = FALSE
	var/list/images = list()

	var/list/items_medical = list()
	var/list/paths_medical = list(/obj/item/bonesetter/psi,
		/obj/item/circular_saw/psi,
		/obj/item/hemostat/psi,
		/obj/item/retractor/psi,
		/obj/item/scalpel/psi,
		/obj/item/surgicaldrill/psi)

	var/list/items_engineering = list()
	var/list/paths_engineering = list(/obj/item/crowbar/psi,
		/obj/item/screwdriver/psi,
		/obj/item/wirecutters/psi,
		/obj/item/wrench/psi)

/decl/psionic_power/manifestation/tinker/invoke(var/mob/living/user, var/mob/living/target)
	if((target && user != target) || user.a_intent != I_HELP)
		return FALSE

	var/fire_rank = user.psi.get_rank(PSI_METAKINESIS)
	var/demi_rank = user.psi.get_rank(PSI_MANIFESTATION)

	if(demi_rank >= PSI_RANK_MASTER)
		paths_medical += /obj/item/clothing/gloves/latex/psi
		paths_engineering += /obj/item/clothing/gloves/insulated/psi

	if(fire_rank >= PSI_RANK_LATENT && demi_rank >= PSI_RANK_OPERANT && user.skill_check(SKILL_CONSTRUCTION, SKILL_TRAINED))
		paths_engineering += /obj/item/weldingtool/experimental/psi

	if(demi_rank >= PSI_RANK_MASTER && user.skill_check(SKILL_ELECTRICAL, SKILL_BASIC) && user.skill_check(SKILL_DEVICES, SKILL_TRAINED))
		paths_engineering += /obj/item/device/multitool/psi

	. = ..()
	if(.)

		var/option = alert(target, "What toolkit you need?", "Choose something!", "Medical", "Engineering")
		if (!option)
			return

		if(user.psi.suppressed)
			return

		if(option == "Engineering")
			for(var/engietool in paths_engineering)
				var/obj/item/I = new engietool (src)
				items_engineering += I
				var/image/img = image(icon = I.icon, icon_state = I.item_state)
				img.name = I.name
				images[I] = img

		if(option == "Medical")
			for(var/medtool in paths_medical)
				var/obj/item/I = new medtool (src)
				items_medical += I
				var/image/img = image(icon = I.icon, icon_state = I.item_state)
				img.name = I.name
				images[I] = img

		var/obj/item = show_radial_menu(user, user, images, radius = 48, require_near = TRUE)
		if(item && !user.psi.suppressed)
			var/item_type = item.type
			. = new item_type(user)

		for(item in items_medical + items_engineering)
			qdel(item)

		images.Cut()
		items_medical.Cut()
		items_engineering.Cut()

		paths_medical -= /obj/item/clothing/gloves/latex/psi

		paths_engineering -= /obj/item/device/multitool/psi
		paths_engineering -= /obj/item/weldingtool/experimental/psi
		paths_engineering -= /obj/item/clothing/gloves/insulated/psi