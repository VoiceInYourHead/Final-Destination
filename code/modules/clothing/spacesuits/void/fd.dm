// Боевые маги Кудесника

/obj/item/clothing/head/helmet/space/void/battlewizards
	name = "military green voidsuit helmet"
	desc = "An advanced helmet designed for work in special operations."
	icon_state = "rig0-battlemags"
	item_state = "rig0-battlemags"
	armor = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_RESISTANT,
		laser = ARMOR_LASER_MAJOR,
		energy = ARMOR_ENERGY_MINOR,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_SMALL
		)
	siemens_coefficient = 0.3
	species_restricted = list(SPECIES_HUMAN,SPECIES_IPC,SPECIES_SHELL)
	light_overlay = "explorer_light"

/obj/item/clothing/head/helmet/space/void/battlewizards/captain
	desc = "An advanced helmet designed for work in special operations. This one have more unique style."
	icon_state = "rig0-battlemagscaptain"
	item_state = "rig0-battlemagscaptain"

/obj/item/clothing/suit/space/void/battlewizards
	icon_state = "rig-battlemags"
	name = "military green voidsuit"
	desc = "An advanced suit that protects against injuries during special operations."
	item_state_slots = list(
		slot_l_hand_str = "syndicate-green-dark",
		slot_r_hand_str = "syndicate-green-dark",
	)
	w_class = ITEM_SIZE_LARGE //normally voidsuits are bulky but the merc voidsuit is 'advanced' or something
	armor = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_RESISTANT,
		laser = ARMOR_LASER_MAJOR,
		energy = ARMOR_ENERGY_MINOR,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_SMALL
		)
	allowed = list(/obj/item/device/flashlight,/obj/item/tank,/obj/item/device/suit_cooling_unit,/obj/item/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/melee/energy/sword,/obj/item/handcuffs)
	siemens_coefficient = 0.3
	species_restricted = list(SPECIES_HUMAN,SPECIES_IPC,SPECIES_SHELL)

/obj/item/clothing/suit/space/void/battlewizards/Initialize()
	. = ..()
	slowdown_per_slot[slot_wear_suit] = 1

/obj/item/clothing/suit/space/void/battlewizards/captain
	desc = "An advanced suit that protects against injuries during special operations. This one have cool jacket."
	icon_state = "rig-battlemagscaptain"

/obj/item/clothing/suit/space/void/battlewizards/prepared
	helmet = /obj/item/clothing/head/helmet/space/void/battlewizards
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen

/obj/item/clothing/suit/space/void/battlewizards/captain/prepared
	helmet = /obj/item/clothing/head/helmet/space/void/battlewizards/captain
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen

//Ретро-войдсьют
/obj/item/clothing/suit/space/void/retro
	name = "retro voidsuit"
	desc = "A voidsuit designed to replicate older designs with newer technology."
	icon_state = "rig-retro"
	armor = list(
		melee = ARMOR_MELEE_KNIVES,
		energy = ARMOR_ENERGY_RESISTANT,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_MINOR
	)
	allowed = list(/obj/item/gun,/obj/item/device/flashlight,/obj/item/tank,/obj/item/device/suit_cooling_unit)

/obj/item/clothing/head/helmet/space/void/retro
	name = "retro voidsuit helmet"
	desc = "A voidsuit helmet designed to replicate older designs with newer technology."
	icon_state = "rig0-retro"
	armor = list(
		melee = ARMOR_MELEE_KNIVES,
		energy = ARMOR_ENERGY_RESISTANT,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_MINOR
	)
	light_overlay = "helmet_light_alt"

/obj/item/clothing/suit/space/void/retro/prepared
	helmet = /obj/item/clothing/head/helmet/space/void/retro
	boots = /obj/item/clothing/shoes/magboots

//Костюм R&D Corp
/obj/item/clothing/head/helmet/space/void/mining/rockanddrill
	name = "mining voidsuit helmet"
	desc = "A scuffed voidsuit helmet with yellow visor and internal communication system."
	icon_state = "rig0-rockanddrill"
	item_state = "rig0-rockanddrill"
	item_state_slots = list(
		slot_l_hand_str = "mining_helm",
		slot_r_hand_str = "mining_helm",
		)
	armor = list(
		melee = ARMOR_MELEE_KNIVES,
		bullet = ARMOR_BALLISTIC_MINOR,
		laser = ARMOR_LASER_MINOR,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_SMALL
		)
	light_overlay = "helmet_light_dual_alt"
	max_pressure_protection = ENG_VOIDSUIT_MAX_PRESSURE

/obj/item/clothing/suit/space/void/mining/rockanddrill
	icon_state = "rig-rockanddrill"
	name = "lightweight mining voidsuit"
	desc = "Simple protective gear to work in the void."
	item_state_slots = list(
		slot_l_hand_str = "mining_voidsuit",
		slot_r_hand_str = "mining_voidsuit",
	)
	armor = list(
		melee = ARMOR_MELEE_KNIVES,
		bullet = ARMOR_BALLISTIC_MINOR,
		laser = ARMOR_LASER_MINOR,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_SMALL
		)
	max_pressure_protection = ENG_VOIDSUIT_MAX_PRESSURE
	allowed = list(/obj/item/device/flashlight,/obj/item/tank,/obj/item/stack/flag,/obj/item/device/suit_cooling_unit,/obj/item/storage/ore,/obj/item/device/t_scanner,/obj/item/pickaxe, /obj/item/rcd,/obj/item/rpd)

/obj/item/clothing/suit/space/void/mining/rockanddrill/prepared
	helmet = /obj/item/clothing/head/helmet/space/void/mining/rockanddrill

// Мусорщики Свободного Торгового Союза

/obj/item/clothing/head/helmet/space/void/ftu_salvager
	name = "old-ass voidsuit helmet"
	desc = "Old space helmet model, designed for work in dangerous environment, where you can got hit with different things"
	icon_state = "rig0-ftu"
	item_state = "rig0-ftu"
	armor = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_RESISTANT,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_BIO_SHIELDED
		)
	siemens_coefficient = 0.3
	species_restricted = list(SPECIES_HUMAN,SPECIES_IPC,SPECIES_SHELL)
	light_overlay = "explorer_light"

/obj/item/clothing/suit/space/void/ftu_salvager
	icon_state = "rig-ftu"
	name = "old-ass green voidsuit"
	desc = "Old space suit model, designed for work in dangerous environment, where you can got hit with different things"
	item_state_slots = list(
		slot_l_hand_str = "syndicate-green-dark",
		slot_r_hand_str = "syndicate-green-dark",
	)
	w_class = ITEM_SIZE_LARGE //normally voidsuits are bulky but the merc voidsuit is 'advanced' or something
	armor = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_RESISTANT,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_BIO_SHIELDED
		)
	allowed = list(/obj/item/device/flashlight,/obj/item/tank,/obj/item/device/suit_cooling_unit,/obj/item/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/melee/energy/sword,/obj/item/handcuffs)
	siemens_coefficient = 0.3
	species_restricted = list(SPECIES_HUMAN,SPECIES_IPC,SPECIES_SHELL)

/obj/item/clothing/suit/space/void/battlewizards/Initialize()
	. = ..()
	slowdown_per_slot[slot_wear_suit] = 1

/obj/item/clothing/suit/space/void/ftu_salvager/prepared
	helmet = /obj/item/clothing/head/helmet/space/void/ftu_salvager
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen