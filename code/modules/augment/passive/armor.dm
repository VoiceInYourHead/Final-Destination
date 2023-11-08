/obj/item/organ/internal/augment/armor
	name = "subdermal armor"
	augment_slots = AUGMENT_ARMOR
	icon_state = "armor-chest"
	desc = "A flexible composite mesh designed to prevent tearing and puncturing of underlying tissue."
	augment_flags = AUGMENT_MECHANICAL | AUGMENT_BIOLOGICAL | AUGMENT_SCANNABLE | AUGMENT_INSPECTABLE
	var/brute_mult = 0.8
	var/burn_mult = 1

/obj/item/organ/internal/augment/armor/bionic
	icon = 'icons/fd/items/device_eris.dmi'
	icon_state = "implant_health"
	augment_flags = AUGMENT_BIOLOGICAL | AUGMENT_SCANNABLE | AUGMENT_INSPECTABLE

