// SCG

// Automatic Rifles. High Speed, mid cal.
/obj/item/gun/projectile/automatic/scg // Я сам не ебу, но оно было помечено как автомат - Максимум.
	name = "assault rifle"
	desc = "A standard assault rifle in service with the SCG Fleet. Appreciated for its good velocity and not inferior caliber with blunt-nosed projectiles designed to be fired without risk of damaging thin bulkheads."
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "automat4-wielded"
	item_state = "automat4"
	w_class = ITEM_SIZE_HUGE
	force = 10
	caliber = CALIBER_RIFLE
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1)
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/rifle/fleet
	allowed_magazines = /obj/item/ammo_magazine/rifle/fleet
	one_hand_penalty = 8
	recoil_buildup = 2.4
	accuracy = 1
	bulk = GUN_BULK_RIFLE + 1
	wielded_item_state = "automat4"
	mag_insert_sound = 'sound/weapons/guns/interaction/ltrifle_magin.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/ltrifle_magout.ogg'
	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty, slightly increased move delay
	init_firemodes = list(
			SEMI_AUTO_NODELAY,
			BURST_3_ROUND,
			FULL_AUTO_600
		)

/obj/item/gun/projectile/automatic/scg/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "automat4"
	else
		icon_state = "automat4-empty"

/obj/item/gun/projectile/automatic/scg/army
	name = "automatic rifle"
	desc = "The heavy rifle of the Sol Gov army, beloved by them for its high armor penetration rates. However, it's unlikely to fit comfortably on a bulletproof vest."
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "automat3-wielded"
	item_state = "automat3"
	w_class = ITEM_SIZE_HUGE
	force = 10
	caliber = CALIBER_RIFLE_MILITARY
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1)
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/rifle/army
	allowed_magazines = /obj/item/ammo_magazine/rifle/army
	one_hand_penalty = 10
	recoil_buildup = 3.5
	accuracy = 1
	bulk = GUN_BULK_RIFLE + 4
	wielded_item_state = "automat3"
	mag_insert_sound = 'sound/weapons/guns/interaction/ltrifle_magin.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/ltrifle_magout.ogg'
	init_firemodes = list(
			list(mode_name = "semiauto",  mode_desc = "Semi auto, but with some kind of cooldown", burst=1, fire_delay=5, move_delay=3, one_hand_penalty=6),
			list(mode_name="3-round bursts", mode_desc = "Short, controlled bursts", burst=3, fire_delay=10, move_delay=5),
		)

/obj/item/gun/projectile/automatic/scg/army/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "automat3"
	else
		icon_state = "automat3-empty"

//      SMGS

/obj/item/gun/projectile/automatic/scg/smg
	name = "submachine gun"
	desc = "A submachine gun valued for its compactness, cheapness and lightness. However, it is unlikely to shoot you in the head.."
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	w_class = ITEM_SIZE_NORMAL
	caliber = CALIBER_PISTOL
	slot_flags = SLOT_BELT
	wielded_item_state = "smg5"
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/smg/scg
	allowed_magazines = /obj/item/ammo_magazine/smg/scg
	bulk = -1
	accuracy = 3
	one_hand_penalty = 3
	init_firemodes = list(
			BURST_3_ROUND,
			BURST_5_ROUND,
			FULL_AUTO_800
		)

/obj/item/gun/projectile/automatic/scg/smg/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "smg5"
	else
		icon_state = "smg5-empty"

/obj/item/gun/projectile/automatic/scg/smg/special
	name = "special ops smg"
	desc = "A new model of submachine gun, for short and medium ranges. Made to order by SolGov Special Operations units"
	icon = 'icons/fd/guns/bullupsmg_cpps.dmi'
	wielded_item_state = "smg6"
	w_class = ITEM_SIZE_LARGE
	force = 6
	caliber = CALIBER_PISTOL
	slot_flags = SLOT_BELT|SLOT_BACK
	recoil_buildup = 1.5
	magazine_type = /obj/item/ammo_magazine/smg/special/scg
	allowed_magazines = /obj/item/ammo_magazine/smg/special/scg
	fire_sound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	auto_eject = 1
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'
	bulk = -1
	accuracy = 2
	one_hand_penalty = 4
	init_firemodes = list(
			SEMI_AUTO_NODELAY,
			BURST_2_ROUND,
			FULL_AUTO_600
		)

/obj/item/gun/projectile/automatic/scg/smg/special/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "smg6"
	if(!ammo_magazine || !LAZYLEN(ammo_magazine.stored_ammo))
		icon_state = "smg6-empty"
		overlays += image(icon, "ammo_bad")
	else if(LAZYLEN(ammo_magazine.stored_ammo) <= 0.5 * ammo_magazine.max_ammo)
		overlays += image(icon, "ammo_warn")
		return
	else
		overlays += image(icon, "ammo_ok")
