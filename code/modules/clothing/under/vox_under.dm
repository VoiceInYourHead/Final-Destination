/obj/item/clothing/under/vox
	has_sensor = 0
	icon = 'icons/obj/clothing/species/vox/obj_uniform_vox.dmi'
	species_restricted = list(SPECIES_VOX, SPECIES_VOX_ARMALIS)

/obj/item/clothing/under/vox/vox_robes
	name = "alien combat robe"
	desc = "Weird and flowing!"
	icon_state = "vox-casual-2"
	item_state = "vox-casual-2"
	armor = list(
		melee = ARMOR_MELEE_SMALL,
		bullet = ARMOR_BALLISTIC_MINOR,
		laser = ARMOR_LASER_MINOR
		)

/obj/item/clothing/under/vox/eng
	name = "alien uniform"
	desc = "Strange and very soft clothes...is it moving?"
	icon_state = "vox-uniform"
	item_state = "vox-uniform"
	armor = list(
		melee = ARMOR_MELEE_SMALL,
		bullet = ARMOR_BALLISTIC_PISTOL
		)

/obj/item/clothing/under/vox/lead
	name = "alien uniform"
	desc = "Strange and very soft clothes...is it moving?"
	icon_state = "vox-armorplate"
	item_state = "vox-armorplate"
	armor = list(
		melee = ARMOR_MELEE_SMALL,
		bullet = ARMOR_BALLISTIC_PISTOL,
		laser = ARMOR_LASER_HANDGUNS
		)

/obj/item/clothing/under/vox/vox_casual
	name = "alien medical clothing"
	desc = "This doesn't look very comfortable."
	icon_state = "vox-casual-1"
	item_state = "vox-casual-1"
	armor = list(
		melee = ARMOR_MELEE_MINOR,
		bio = ARMOR_BIO_RESISTANT
		)
