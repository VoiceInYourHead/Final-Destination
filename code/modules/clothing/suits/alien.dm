//Unathi clothing.

/obj/item/clothing/suit/unathi/robe
	name = "roughspun robes"
	desc = "A traditional Unathi garment."
	icon_state = "robe-unathi"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS

/obj/item/clothing/suit/unathi/mantle
	name = "hide mantle"
	desc = "A rather grisly selection of cured hides and skin, sewn together to form a ragged mantle."
	icon_state = "mantle-unathi"
	body_parts_covered = UPPER_TORSO

//Misc Xeno clothing.

/obj/item/clothing/suit/xeno/furs
	name = "heavy furs"
	desc = "A traditional Zhan-Khazan garment."
	icon_state = "zhan_furs"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS

/obj/item/clothing/head/xeno/scarf
	name = "headscarf"
	desc = "A scarf of coarse fabric. Seems to have ear-holes."
	icon_state = "zhan_scarf"
	body_parts_covered = HEAD|FACE

/obj/item/clothing/shoes/sandal/xeno/caligae
	name = "caligae"
	desc = "A pair of sandals modelled after the ancient Roman caligae."
	icon_state = "caligae"
	item_state = "caligae"
	body_parts_covered = FEET|LEGS

/obj/item/clothing/shoes/sandal/xeno/caligae/white
	desc = "A pair of sandals modelled after the ancient Roman caligae. This one has a white covering."
	icon_state = "whitecaligae"
	item_state = "whitecaligae"

/obj/item/clothing/shoes/sandal/xeno/caligae/grey
	desc = "A pair of sandals modelled after the ancient Roman caligae. This one has a grey covering."
	icon_state = "greycaligae"
	item_state = "greycaligae"

/obj/item/clothing/shoes/sandal/xeno/caligae/black
	desc = "A pair of sandals modelled after the ancient Roman caligae. This one has a black covering."
	icon_state = "blackcaligae"
	item_state = "blackcaligae"


//Voxclothing

/obj/item/clothing/suit/armor/vox
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	species_restricted = list(SPECIES_VOX)
	icon = 'icons/obj/clothing/species/vox/obj_suit_vox.dmi'
	item_flags = 0
	flags_inv = 0

/obj/item/clothing/suit/armor/vox/vox_scrap
	name = "rusted metal armor"
	desc = "A hodgepodge of various pieces of metal scrapped together into a rudimentary vox-shaped piece of armor."
	allowed = list(/obj/item/gun, /obj/item/tank)
	armor = list(
		melee = ARMOR_MELEE_VERY_HIGH,
		bullet = ARMOR_BALLISTIC_PISTOL,
		laser = ARMOR_LASER_MINOR,
		bomb = ARMOR_BOMB_PADDED) //Higher melee armor versus lower everything else.
	icon_state = "vox-scrap"
	species_restricted = list(SPECIES_VOX, SPECIES_VOX_ARMALIS)
	siemens_coefficient = 1 //Its literally metal

/obj/item/clothing/suit/armor/vox/bombsuit
	name = "vox bombsuit"
	desc = "A massive chitinous exoskeleton, in the vox society, is used by engineers to work with radiation and explosion protection."
	icon_state = "vox-bombsuit"
	item_state = "vox-bombsuit"
	w_class = ITEM_SIZE_HUGE//bulky item
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	armor = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_RESISTANT,
		laser = ARMOR_LASER_HANDGUNS,
		energy = ARMOR_ENERGY_MINOR,
		bomb = ARMOR_BOMB_MINOR,
		bio = ARMOR_BIO_RESISTANT,
		rad = ARMOR_RAD_SHIELDED
		)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS|HEAD
	heat_protection = UPPER_TORSO|LOWER_TORSO
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.2

/obj/item/clothing/suit/armor/vox/quill_armor
	name = "quill mantle"
	desc = "A blue mantle, complemented by fragments of armor made of heavy-duty chitin. Such armor is worn only by high-ranking Quills that bring death to the opponents of their empire."
	icon_state = "vox-mantle"
	item_state = "vox-mantle"
	armor = list(
		melee = ARMOR_MELEE_KNIVES,
		bullet = ARMOR_BALLISTIC_MINOR,
		laser = ARMOR_LASER_SMALL,
		energy = ARMOR_ENERGY_SMALL,
		bomb = ARMOR_BOMB_MINOR
		)
	siemens_coefficient = 0
/obj/item/clothing/suit/armor/vox/quill_armor
	name = "quill armour"
	desc = "Chitinous durable armor, able to protect against many types of damage. Such armor is worn only by high-ranking Quills that bring death to the opponents of their empire."
	icon_state = "vox-mantle"
	item_state = "vox-mantle"
	armor = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_RESISTANT,
		laser = ARMOR_LASER_MAJOR,
		energy = ARMOR_ENERGY_SMALL,
		bomb = ARMOR_BOMB_PADDED
		)
	siemens_coefficient = 0

/obj/item/clothing/suit/armor/vox/guard
	name = "guard shell"
	desc = "A heavy shell that perfectly protects against the adversities of any nature, be it a hail of bullets, lasers or even bombs. Wearing such chitinous armor, members of the honor guard become mobile fortresses that withstand the onslaught alone.."
	icon_state = "vox-guard"
	item_state = "vox-guard"
	armor = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_RIFLE,
		laser = ARMOR_LASER_MAJOR,
		energy = ARMOR_ENERGY_SMALL,
		bomb = ARMOR_BOMB_PADDED
		)
	w_class = ITEM_SIZE_HUGE//bulky item
	gas_transfer_coefficient = 0.90
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	siemens_coefficient = 0.2

/obj/item/clothing/suit/storage/vox
	name = "vox cloak"
	desc = "A whitish raincoat used in everyday life just like human labcoats. They are worn and appreciated by many vox for their comfort, however, most often such robes are ranked among the bio-techniques of vox fleets."
	icon_state = "vox-labcoat"
	item_state = "vox_labcoat"
	body_parts_covered = UPPER_TORSO|ARMS
	allowed = list(/obj/item/device/scanner/gas,/obj/item/stack/medical,/obj/item/reagent_containers/dropper,/obj/item/reagent_containers/syringe,/obj/item/reagent_containers/hypospray,/obj/item/device/scanner/health,/obj/item/device/flashlight/pen,/obj/item/reagent_containers/glass/bottle,/obj/item/reagent_containers/glass/beaker,/obj/item/reagent_containers/pill,/obj/item/storage/pill_bottle,/obj/item/paper)
	armor = list(
		bio = ARMOR_BIO_RESISTANT
		)
	valid_accessory_slots = list(ACCESSORY_SLOT_ARMBAND, ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_RANK)
	restricted_accessory_slots = list(ACCESSORY_SLOT_ARMBAND)
