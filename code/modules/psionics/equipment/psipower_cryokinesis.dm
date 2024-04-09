/obj/item/cryokinesis
	name = "ice"
	icon = 'icons/obj/psychic_powers.dmi'
	icon_state = "cryo"

	var/delete_on_drop = 0 //should we delete this item, if it isn't in our inventory?
	var/uses = 5 //amount of time we can use this item before it shutters, similar to glass spear

/obj/item/cryokinesis/New()
	START_PROCESSING(SSprocessing, src)
	..()

/obj/item/cryokinesis/Process()
	if(uses <= 0)
		qdel(src)

/obj/item/cryokinesis/afterattack()
	uses -= 1

/obj/item/cryokinesis/dropped()
	..()
	if(delete_on_drop)
		qdel(src)

/obj/item/cryokinesis/get_storage_cost()
	return ITEM_SIZE_NO_CONTAINER

/obj/item/cryokinesis/fists
	name = "ice fists"
	icon_state = "fists"
	desc = "A pair of cold, icy, punching gloves"
	uses = 10
	delete_on_drop = 1
	force = 25
	attack_cooldown = 8

	base_parry_chance = 10
	have_stances = TRUE

	lunge_dist = 5
	fail_chance = 10
	melee_strikes = list(/datum/melee_strike/swipe_strike/blunt_swing/mixed_combo, /datum/melee_strike/circle_strike/blunt)

/obj/item/cryokinesis/fists/apply_hit_effect(mob/living/target, mob/living/user, var/hit_zone)
	if(user.psi)
		var/tele_rank = user.psi.get_rank(PSI_PSYCHOKINESIS)
		if(tele_rank >= PSI_RANK_OPERANT && !user.psi.suppressed)
			force = 45
	..()
