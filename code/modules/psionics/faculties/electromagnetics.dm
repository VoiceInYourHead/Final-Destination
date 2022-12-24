/decl/psionic_faculty/electromagnetics
	id = PSI_ELECTROMAGNETICS
	name = "Electromagnetics"
	associated_intent = I_HURT
	armour_types = list("energy", "melee")

/decl/psionic_power/electromagnetics
	faculty = PSI_ELECTROMAGNETICS

/decl/psionic_power/electromagnetics/disrupt
	name =            "Disrupt"
	cost =            10
	cooldown =        60
	use_melee =       TRUE
	min_rank =        PSI_RANK_APPRENTICE
	use_description = "Target the head or eyes while on harm intent to use a melee attack that causes a localized electromagnetic pulse."

/decl/psionic_power/electromagnetics/disrupt/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_HEAD && user.zone_sel.selecting != BP_EYES)
		return FALSE
	if(istype(target, /turf))
		return FALSE
	. = ..()
	if(.)
		new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "blue_electricity_constant")
		target.visible_message("<span class='danger'>\The [user] releases a gout of crackling static and arcing lightning over \the [target]!</span>")
		empulse(target, 0, 1)
		return TRUE