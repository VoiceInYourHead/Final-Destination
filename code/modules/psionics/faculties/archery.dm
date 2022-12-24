/decl/psionic_faculty/archery
	id = PSI_ARCHERY
	name = "Psi-Archery"
	associated_intent = I_GRAB
	armour_types = list("bullet", "melee")

/decl/psionic_power/archery
	faculty = PSI_ARCHERY
	use_manifest = TRUE

/decl/psionic_power/archery/psibow
	name =            "Psibow"
	cost =            20
	cooldown =        40
	min_rank =        PSI_RANK_APPRENTICE
	use_description = "Click on or otherwise activate an empty hand while on grab intent to manifest a psychokinetic bow with arrow. The power of the bow will vary based on your mastery of the faculty."
	admin_log = FALSE

/decl/psionic_power/archery/psibow/invoke(var/mob/living/user, var/mob/living/target)
	if((target && user != target) || user.a_intent != I_GRAB)
		return FALSE
	. = ..()
	if(.)
		switch(user.psi.get_rank(faculty))
			if(PSI_RANK_GRANDMASTER)
				return new /obj/item/gun/launcher/crossbow/psibow/master/grand/paramount(user, user)
			if(PSI_RANK_MASTER)
				return new /obj/item/gun/launcher/crossbow/psibow/master/grand(user, user)
			if(PSI_RANK_OPERANT)
				return new /obj/item/gun/launcher/crossbow/psibow/master(user, user)
			else
				return new /obj/item/gun/launcher/crossbow/psibow(user, user)