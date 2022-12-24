/decl/psionic_faculty/manifestation
	id = PSI_MANIFESTATION
	name = "Manifestation"
	associated_intent = I_GRAB
	armour_types = list("melee")

/decl/psionic_power/manifestation
	faculty = PSI_MANIFESTATION
	use_manifest = TRUE
	use_sound = null

/decl/psionic_power/manifestation/psiblade
	name =            "Psiblade"
	cost =            10
	cooldown =        30
	min_rank =        PSI_RANK_APPRENTICE
	use_description = "Click on or otherwise activate an empty hand while on harm intent to manifest a psychokinetic cutting blade. The power the blade will vary based on your mastery of the faculty."
	admin_log = FALSE

/decl/psionic_power/manifestation/psiblade/invoke(var/mob/living/user, var/mob/living/target)
	if((target && user != target) || user.a_intent != I_HURT)
		return FALSE
	. = ..()
	if(.)
		switch(user.psi.get_rank(faculty))
			if(PSI_RANK_GRANDMASTER)
				return new /obj/item/psychic_power/psiblade/master/grand/paramount(user, user)
			if(PSI_RANK_MASTER)
				return new /obj/item/psychic_power/psiblade/master/grand(user, user)
			if(PSI_RANK_OPERANT)
				return new /obj/item/psychic_power/psiblade/master(user, user)
			else
				return new /obj/item/psychic_power/psiblade(user, user)

/decl/psionic_power/manifestation/tinker
	name =            "Tinker"
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
		return new /obj/item/psychic_power/tinker(user)