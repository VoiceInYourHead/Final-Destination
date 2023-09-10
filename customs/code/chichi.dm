/obj/item/material/twohanded/spear/chichi
	icon_state = "spearresomi0"
	base_icon = "spearresomi"
	name = "spear"
	desc = "A deadly weapon, shaped and engraved with unic style of resomi culture in it."
	default_material = MATERIAL_ALUMINIUM

/obj/item/material/twohanded/spear/shatter(var/consumed)
	return

/obj/item/material/twohanded/spear/chichi/get_mob_overlay(var/mob/living/carbon/human/user, var/slot)
	if(istype(user) && (slot == slot_l_hand_str || slot == slot_r_hand_str))
		var/bodytype = user.species.get_bodytype(user)
		if(slot == slot_l_hand_str)
			if(bodytype == SPECIES_RESOMI)
				return overlay_image('icons/mob/species/resomi/spear_l.dmi',  item_state_slots[slot_l_hand_str], color, RESET_COLOR)
		else if(slot == slot_r_hand_str)
			if(bodytype == SPECIES_RESOMI)
				return overlay_image('icons/mob/species/resomi/spear_r.dmi', item_state_slots[slot_r_hand_str], color, RESET_COLOR)
	. = ..(user, slot)
