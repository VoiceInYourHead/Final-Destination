
/obj/item/clothing/suit/storage/toggle/kimono
	name = "kimono"
	desc = "A traditional robe with remarkably long sleeves, mostly worn by women. <i>Sugoi.</i>"
	icon_state = "kimono"
	body_parts_covered = UPPER_TORSO|LEGS|ARMS
	cold_protection = UPPER_TORSO|LEGS|ARMS
	min_cold_protection_temperature = T0C - 20
	siemens_coefficient = 0.7
	var/kimonorolled = 0


/obj/item/clothing/suit/storage/toggle/kimono/var/sleeves_state
/obj/item/clothing/suit/storage/toggle/kimono/var/sleeves_suffix


/obj/item/clothing/suit/storage/toggle/kimono/proc/toggle_sleeves()
	set name = "Roll Up Sleeves"
	set category = "Object"
	set src in usr
	if(usr.incapacitated())
		return
	sleeves_state = !sleeves_state
	icon_state = "[custom_icon_state ? custom_icon_state : initial(icon_state)][sleeves_state ? sleeves_suffix : ""]"
	to_chat(usr, "You [sleeves_state ? "rolled down": "rolled up"] [src] sleeves.")
	update_clothing_icon()


/obj/item/clothing/suit/storage/toggle/kimono/Initialize()
	. = ..()
	if (sleeves_suffix)
		verbs |= /obj/item/clothing/suit/storage/toggle/kimono/proc/toggle_sleeves


/obj/item/clothing/suit/storage/toggle/kimono/sleeves_suffix = "_sleeves"
/obj/item/clothing/suit/storage/toggle/kimono/valid_accessory_slots = list(ACCESSORY_SLOT_UTILITY,ACCESSORY_SLOT_HOLSTER,ACCESSORY_SLOT_ARMBAND,ACCESSORY_SLOT_RANK,ACCESSORY_SLOT_DEPT,ACCESSORY_SLOT_DECOR,ACCESSORY_SLOT_MEDAL,ACCESSORY_SLOT_INSIGNIA)



/obj/item/clothing/suit/storage/toggle/kimono/inherit_custom_item_data(datum/custom_item/citem)
	. = ..()
	if (citem.additional_data["custom_icon_state"])
		custom_icon_state = citem.additional_data["custom_icon_state"]