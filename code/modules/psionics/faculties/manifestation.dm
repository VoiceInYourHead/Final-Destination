/decl/psionic_faculty/manifestation
	id = PSI_MANIFESTATION
	name = "Manifestation"
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
	use_description = "Click on or otherwise activate an empty hand while on harm intent to manifest a psychokinetic cutting blade. The power the blade will vary based on your mastery of the faculty."
	admin_log = FALSE


//I know, there is a lot of better ways
/decl/psionic_power/manifestation/psiblade/invoke(var/mob/living/user, var/mob/living/target)
	if((target && user != target) || user.a_intent != I_HURT)
		return FALSE
	. = ..()
	if(.)
		switch(user.psi.get_rank(faculty))
			if(PSI_RANK_GRANDMASTER)
				var/option = input(target, "Choose something!", "Weapons to create") in list("Blade", "Club", "Battle Axe", "Spear", "Crossbow")
				if (!option)
					return
				if(option == "Club")
					return new /obj/item/psychic_power/psiclub/master/grand/paramount(user, user)
				if(option == "Blade")
					return new /obj/item/psychic_power/psiblade/master/grand/paramount(user, user)
				if(option == "Battle Axe")
					return new /obj/item/psychic_power/psiaxe/master/grand/paramount(user, user)
				if(option == "Spear")
					return new /obj/item/psychic_power/psispear/master/grand/paramount(user, user)
				if(option == "Crossbow")
					return new /obj/item/gun/launcher/crossbow/psibow/master/grand/paramount(user, user)
			if(PSI_RANK_MASTER)
				var/option = input(target, "Choose something!", "Weapons to create") in list("Blade", "Club", "Battle Axe", "Spear", "Crossbow")
				if (!option)
					return
				if(option == "Club")
					return new /obj/item/psychic_power/psiclub/master/grand(user, user)
				if(option == "Blade")
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
				if(option == "Club")
					return new /obj/item/psychic_power/psiclub(user, user)
				if(option == "Blade")
					return new /obj/item/psychic_power/psiblade(user, user)

/decl/psionic_power/manifestation/tinker
	name =            "Manifest tool"
	cost =            5
	cooldown =        10
	min_rank =        PSI_RANK_APPRENTICE
	use_description = "Click on or otherwise activate an empty hand while on help intent to manifest a psychokinetic tool. Use it in-hand to switch between tool types."
	admin_log = FALSE

/decl/psionic_power/manifestation/tinker/invoke(var/mob/living/user, var/mob/living/target)
	if((target && user != target) || user.a_intent != I_HELP)
		return FALSE
	. = ..()
	if(.)
		var/option = alert(target, "What tookit you need?", "Choose something!", "Medical", "Engineering")
		if (!option)
			return
		if(option == "Engineering")
			return new /obj/item/psychic_power/tinker(user)
		if(option == "Medical")
			var/option_second = input(target, "What exactly do you want?", "Choose something!") in list("Saw", "Scalpel", "Bone Setter", "Retractor", "Hemostat", "Drill")
			if (!option_second)
				return
			if(option_second == "Scalpel")
				return new /obj/item/scalpel/psi(user)
			if(option_second == "Saw")
				return new /obj/item/circular_saw/psi(user)
			if(option_second == "Bone Setter")
				return new /obj/item/bonesetter/psi(user)
			if(option_second == "Retractor")
				return new /obj/item/retractor/psi(user)
			if(option_second == "Hemostat")
				return new /obj/item/hemostat/psi(user)
			if(option_second == "Drill")
				return new /obj/item/surgicaldrill/psi(user)