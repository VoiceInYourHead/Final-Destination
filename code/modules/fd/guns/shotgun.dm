// FD

/obj/item/gun/projectile/shotgun/pump/scg
	name = "combat shotgun"
	desc = "A pump-action shotgun respected for its reliability and its capacity. However, not as fast firing as the Fleet's favorite."
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "shotgun3"
	item_state = "shotgun3"
	wielded_item_state = "shotgun3"
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 2)
	max_shells = 11
	ammo_type = /obj/item/ammo_casing/shotgun
	one_hand_penalty = 8

/obj/item/gun/projectile/automatic/shotgun/scg
	name = "assault shotgun"
	desc = "One of the Fleet's favorite guns. Fast shotgun without the need for painful reloading in combat. Insert, fire, forget."
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "shotgun4"
	item_state = "shotgun4"
	wielded_item_state = "shotgun4"
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/shotgun/scg
	allowed_magazines = /obj/item/ammo_magazine/shotgun/scg
	bulk = GUN_BULK_RIFLE
	accuracy = -1
	init_firemodes = list(
			BURST_3_ROUND,
			FULL_AUTO_400
		)

/obj/item/gun/projectile/automatic/shotgun/scg/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "shotgun4"
	else
		icon_state = "shotgun4-empty"

/obj/item/gun/projectile/automatic/shotgun/iccgn
	name = "shotgun"
	desc = "Volleygun (VG-23) not being able to boast of speed has the ability to clearly state the enemy with his shot in the face. Good ammunition with two firing modes and a unique cartridge."
	icon = 'icons/fd/guns/weapon_gkk_icon.dmi'
	icon_state = "gshotgun2"
	item_state = "gshotgun2"
	wielded_item_state = "gshotgun2"
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/shotgun/iccgn
	allowed_magazines = /obj/item/ammo_magazine/shotgun/iccgn
	bulk = GUN_BULK_RIFLE
	accuracy = 0
	one_hand_penalty=5
	init_firemodes = list(
			SEMI_AUTO_NODELAY,
			list(mode_name="2-beam bursts", mode_desc = "Short, controlled bursts", burst=2, fire_delay=null, move_delay=2)
		)

/obj/item/gun/projectile/automatic/shotgun/iccgn/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "gshotgun2"
	else
		icon_state = "gshotgun2-empty"
