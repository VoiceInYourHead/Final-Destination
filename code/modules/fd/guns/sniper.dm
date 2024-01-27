// SCG

/obj/item/gun/projectile/heavysniper/scg
	name = "multitask sniper rifle"
	desc = "A portable anti-armour rifle fitted with a scope, the HI PTR-7 Rifle was originally designed to be used against armoured exosuits. It is capable of punching through windows and non-reinforced walls with ease."
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "sniperrifle1"
	item_state = "sniperrifle1"
	w_class = ITEM_SIZE_HUGE
	force = 10
	slot_flags = SLOT_BACK
	caliber = CALIBER_ANTIMATERIAL
	screen_shake = 2 //extra kickback
	handle_casings = HOLD_CASINGS
	load_method = SINGLE_CASING
	max_shells = 3
	ammo_type = /obj/item/ammo_casing/scg/shell
	one_hand_penalty = 6
	accuracy = -2
	recoil_buildup = 75
	bulk = 8
	scoped_accuracy = 8
	scope_zoom = 2
	bolt_open = 0
	wielded_item_state = "sniperrifle1"
	load_sound = 'sound/weapons/guns/interaction/rifle_load.ogg'
	fire_delay = 12

/obj/item/gun/projectile/sniper/marksman
	name = "designated marksman rifle"
	desc = "The rugged garand is a old semi-automatic weapon popular on the frontier worlds."
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	item_state = null
	w_class = ITEM_SIZE_HUGE
	force = 10
	caliber = CALIBER_RIFLE_MILITARY
	origin_tech = list(TECH_COMBAT = 2)
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/sniper/scg
	allowed_magazines = /obj/item/ammo_magazine/sniper/scg
	accuracy = 0
	fire_delay = 6
	one_hand_penalty = 8
	scoped_accuracy = 6
	scope_zoom = 1.5
	bulk = GUN_BULK_RIFLE + 1
	wielded_item_state = "sniperrifle2"
	mag_insert_sound = 'sound/weapons/guns/interaction/ltrifle_magin.ogg'

/obj/item/gun/projectile/sniper/marksman/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "sniperrifle2"
	else
		icon_state = "sniperrifle2-empty"
