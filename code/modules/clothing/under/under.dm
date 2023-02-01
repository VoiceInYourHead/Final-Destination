/obj/item/clothing/under/thermal
	name = "thermal suit"
	desc = "Gray thermal suit. Nothing interesting."
	icon = 'icons/obj/clothing/obj_under.dmi'
	item_icons = list(slot_w_uniform_str = 'icons/mob/onmob/onmob_under.dmi')
	icon_state = "gray_camo"
	item_state = "gray_camo"
	item_flags = ITEM_FLAG_THICKMATERIAL
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	cold_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	min_cold_protection_temperature = T0C - 75
	max_heat_protection_temperature = T0C + 50
	var/max_cooling = 1.2					// in degrees per second - probably don't need to mess with heat capacity here
	var/thermostat = T0C + 10


/obj/item/clothing/under/thermal/Process()
	var/mob/living/carbon/human/H = loc
	var/temp_adj = min(H.bodytemperature - thermostat, max_cooling)

	if (temp_adj < 0.5)    //only cools, doesn't heat, also we don't need extreme precision esli     if (temp_adj > 0.5) to greet
		return

	H.bodytemperature -= temp_adj

/obj/item/clothing/under/thermal/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/clothing/under/thermal/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/under/thermal/proc/is_in_slot()
	var/mob/living/carbon/human/H = loc
	if(!istype(H))
		return 0
	if(!is_in_slot())
		return
	return (H.w_uniform == src)

/obj/item/clothing/under/thermal/heat
	name = "fitting thermal suit"
	desc = "Stylish fitting skrellian thermal suit. This one is black."
	icon_state = "thermoskr_1"
	item_state = "thermoskr_1"
	min_cold_protection_temperature = T0C - 25
	max_heat_protection_temperature = T0C + 100
	max_cooling = 1					// in degrees per second - probably don't need to mess with heat capacity here
	thermostat = T0C + 45

/obj/item/clothing/under/thermal/heat/white
	desc = "Stylish fitting skrellian thermal suit. This one is white."
	icon_state = "thermoskr_2"
	item_state = "thermoskr_2"

/obj/item/clothing/under/thermal/heat/Process()
	var/mob/living/carbon/human/H = loc
	var/temp_adj = min(H.bodytemperature - thermostat, max_cooling)

	if (temp_adj > 0.5)    //only cools, doesn't heat, also we don't need extreme precision esli     if (temp_adj > 0.5) to greet
		return

	H.bodytemperature -= temp_adj

/obj/item/clothing/under/thermal/heat/unati
	name = "black thermal suit"
	desc = "Unati thermal suit. This one is black."
	icon_state = "thermouna_1"
	item_state = "thermouna_1"
	species_restricted = list(SPECIES_UNATHI)
	sprite_sheets = list(
		SPECIES_UNATHI = 'icons/mob/onmob/onmob_under.dmi',
		)

/obj/item/clothing/under/thermal/heat/unati/white
	name = "white thermal suit"
	desc = "Unati thermal suit. This one is white."
	icon_state = "thermouna_2"
	item_state = "thermouna_2"
