// SCG

/obj/item/gun/energy/laser/lasgun
	name = "Lasgun"
	desc = "Lasgun series D-99 designed specifically for the Fleet. Known for its devastating power, almost unique for lasers."
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "lascar"
	item_state = "lasgun"
	slot_flags = SLOT_BACK
	w_class = ITEM_SIZE_HUGE
	accuracy = 1
	force = 10
	one_hand_penalty = 4
	battery_changable = TRUE
	cell_type = /obj/item/cell/guncell/lasgun
	battery_type = /obj/item/cell/guncell/lasgun
	bulk = GUN_BULK_RIFLE + 2
	projectile_type = /obj/item/projectile/bullet/lasbolt/lasgun
	wielded_item_state = "lasgun-wielded"
	init_firemodes = list(
			list(mode_name="3-round bursts", mode_desc = "Short, controlled bursts", burst=3, fire_delay=2, move_delay=4, accuracy=0, charge_cost=200 ),
			list(mode_name = "semiauto",  mode_desc = "Fire as fast, as your gun give you to do it", burst=1, fire_delay=2, move_delay=2, accuracy=1, charge_cost=200 ),
			list(mode_name = "overcharge", mode_desc = "Powerful shoot", 	burst=1, fire_delay=4, movedelay=6,
																			accuracy=0, charge_cost=800, projectile_type = /obj/item/projectile/bullet/lasbolt/overcharge)
		)

/obj/item/gun/energy/laser/lasgun/on_update_icon()
	..()
	if(!power_supply)
		icon_state = "lascar-e"

/obj/item/gun/energy/laser/laspistol
	name = "Laspistol"
	desc = "Unlike its big brother, the Laspistol series D-99 was made for Fleet Officers and as an auxiliary weapon in case the shit hit the fan.."
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "laspistolciv"
	item_state = "laser"
	slot_flags = SLOT_BACK
	w_class = ITEM_SIZE_NORMAL
	accuracy = 1
	force = 4
	one_hand_penalty = 4
	slot_flags = SLOT_HOLSTER|SLOT_BELT
	battery_changable = TRUE
	cell_type = /obj/item/cell/guncell/lasgun
	battery_type = /obj/item/cell/guncell/lasgun
	bulk = GUN_BULK_RIFLE - 3
	projectile_type = /obj/item/projectile/bullet/lasbolt
	wielded_item_state = "laser"
	init_firemodes = list(
			list(mode_name = "semiauto",  mode_desc = "Fire as fast, as your gun give you to do it", burst=1, fire_delay=2, move_delay=2, charge_cost=100, accuracy=1),
			list(mode_name = "overcharge", mode_desc = "Powerful shoot",    burst=1, fire_delay=4, movedelay=6,
																			accuracy=0, charge_cost=500, projectile_type = /obj/item/projectile/bullet/lasbolt/lasgun)
		)

/obj/item/gun/energy/laser/laspistol/on_update_icon()
	..()
	if(!power_supply)
		icon_state = "laspistolciv-e"

// Cells

/obj/item/cell/guncell/lasgun
	name = "Lasgun power pack"
	desc = "Unified power pack for D-99 series Lasguns and Laspistols. According to Fleet Veterans, this battery can be used as explosives. Don't try"
	icon = 'icons/obj/power.dmi'
	icon_state = "lgpp"
	w_class = ITEM_SIZE_SMALL
	charge = 4000
	maxcharge = 4000
