/obj/item/clothing/head/helmet/vox
	species_restricted = list(SPECIES_VOX)
	icon = 'icons/obj/clothing/species/vox/obj_head_vox.dmi'
	item_flags = 0
	flags_inv = 0
	sprite_sheets = list(
		SPECIES_VOX = 'icons/mob/species/vox/onmob_head_vox.dmi')

/obj/item/clothing/head/helmet/vox/quill_crown
	name = "quill crown"
	icon_state = "vox-crown"
	item_state = "vox-crown"
	armor = list(
		melee = ARMOR_MELEE_VERY_HIGH,
		bullet = ARMOR_BALLISTIC_RIFLE,
		laser = ARMOR_LASER_HANDGUNS,
		energy = ARMOR_ENERGY_RESISTANT,
		bomb = ARMOR_BOMB_PADDED
		)

/obj/item/clothing/head/helmet/vox/guard
	name = "guard helmet"
	item_state = "vox-guard"
	icon_state = "vox-guard"
	armor = list(
		melee = ARMOR_MELEE_VERY_HIGH,
		bullet = ARMOR_BALLISTIC_RIFLE,
		laser = ARMOR_LASER_HANDGUNS,
		energy = ARMOR_ENERGY_RESISTANT,
		bomb = ARMOR_BOMB_PADDED
		)
/obj/item/clothing/head/helmet/vox/jaw
	name = "chitin jaw"
	icon_state = "vox-jaws"
	item_state = "vox-jaws"
	armor = list(
		melee = ARMOR_MELEE_MINOR,
		bio = ARMOR_BIO_RESISTANT
		)
