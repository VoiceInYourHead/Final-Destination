// SCG

// Automatic Rifles. High Speed, mid cal.
/obj/item/gun/projectile/automatic/scg // Я сам не ебу, но оно было помечено как автомат - Максимум.
	name = "assault rifle"
	desc = "A standard assault rifle in service with the SCG Fleet. Appreciated for its good velocity and not inferior caliber with blunt-nosed projectiles designed to be fired without risk of damaging thin bulkheads."
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "automat4"
	item_state = "automat4"
	w_class = ITEM_SIZE_HUGE
	force = 10
	caliber = CALIBER_RIFLE
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/rifle/fleet
	allowed_magazines = /obj/item/ammo_magazine/rifle/fleet
	one_hand_penalty = 6
	recoil_buildup = 2.4
	accuracy = -2
	bulk = GUN_BULK_RIFLE + 1
	wielded_item_state = "automat4"
	mag_insert_sound = 'sound/weapons/guns/interaction/ltrifle_magin.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/ltrifle_magout.ogg'
	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty, slightly increased move delay
	init_firemodes = list(
			BURST_3_ROUND,
			list(mode_name = "full auto",  mode_desc = "600 rounds per minute",   mode_type = /datum/firemode/automatic, fire_delay = 2)
	)

/obj/item/gun/projectile/automatic/scg/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "automat4"
	else
		icon_state = "automat4-empty"

/obj/item/gun/projectile/automatic/scg/army
	name = "battle rifle"
	desc = "The heavy rifle of the Sol Gov army, beloved by them for its high armor penetration rates. However, it's unlikely to fit comfortably on a bulletproof vest."
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "automat3"
	item_state = "automat3"
	w_class = ITEM_SIZE_HUGE
	force = 10
	caliber = CALIBER_RIFLE_MILITARY
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/rifle/army
	allowed_magazines = /obj/item/ammo_magazine/rifle/army
	one_hand_penalty = 10
	recoil_buildup = 3.5
	accuracy = -1
	bulk = GUN_BULK_RIFLE + 5
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
	icon_state = "smg5"
	item_state = "smg5"
	w_class = ITEM_SIZE_NORMAL
	caliber = CALIBER_PISTOL
	slot_flags = SLOT_BELT
	wielded_item_state = "smg5"
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/smg/scg
	allowed_magazines = /obj/item/ammo_magazine/smg/scg
	bulk = -1
	accuracy = 1
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
	icon_state = "smg6"
	item_state = "smg6"
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
	accuracy = 0
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

// ICСGN

/obj/item/gun/projectile/automatic/iccgn
	name = "automatic rifle"
	desc = "Heldan Assault Rifle (HAR), designed for fast, close and medium range assault combat."
	icon = 'icons/fd/guns/weapon_gkk_icon.dmi'
	icon_state = "gautomatic2"
	item_state = "gautomatic2"
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/rifle/iccgn
	allowed_magazines = /obj/item/ammo_magazine/rifle/iccgn
	accuracy = 0
	recoil_buildup = 3
	one_hand_penalty = 4
	caliber = CALIBER_RIFLE
	bulk = GUN_BULK_RIFLE + 1
	wielded_item_state = "gautomatic2"
	init_firemodes = list(
			list(mode_name = "semiauto",  mode_desc = "Fire as fast as you can pull the trigger", burst=1, fire_delay=0, move_delay=null, accuracy=0),
			list(mode_name = "full auto",  mode_desc = "400 rounds per minute",   mode_type = /datum/firemode/automatic, fire_delay = 4, one_hand_penalty=8, accuracy=-2)
		)

/obj/item/gun/projectile/automatic/iccgn/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "[item_state]"
	else
		icon_state = "[item_state]-empty"

/obj/item/gun/projectile/automatic/iccgn/precise
	name = "battle rifle"
	desc = "Drogan's Marksman Rifle - 213 (DMR - 213),  designed for long range warfare as opposed to the not-so-accurate Heldan Automatic Rifle.  "
	icon = 'icons/fd/guns/precise_gkk.dmi'
	icon_state = "gautomatic1"
	item_state = "gautomatic1"
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	caliber = CALIBER_RIFLE_MILITARY
	magazine_type = /obj/item/ammo_magazine/rifle/precise
	allowed_magazines = /obj/item/ammo_magazine/rifle/precise
	accuracy = 1
	recoil_buildup = 4
	one_hand_penalty = 7
	bulk = GUN_BULK_RIFLE + 2
	wielded_item_state = "gautomatic1"
	init_firemodes = list(
			list(mode_name="3-round bursts", mode_desc = "Short, controlled bursts", burst=3, fire_delay=4, move_delay=6, accuracy=0),
			list(mode_name = "semiauto",  mode_desc = "Fire as fast, as your gun give you to do it", burst=1, fire_delay=2, move_delay=4, accuracy= 1)
		)

/obj/item/gun/projectile/automatic/iccgn/precise/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "gautomatic1"
	if(!ammo_magazine || !LAZYLEN(ammo_magazine.stored_ammo))
		icon_state = "gautomatic1-empty"
		overlays += image(icon, "ammo_bad")
	else if(LAZYLEN(ammo_magazine.stored_ammo) <= 0.5 * ammo_magazine.max_ammo)
		overlays += image(icon, "ammo_warn")
		return
	else
		overlays += image(icon, "ammo_ok")
/obj/item/gun/projectile/automatic/iccgn/bolter
	name = "heavy battle rifle"
	desc = "Heavy battle rifle Barracuda-31, designed specifically for APCs, but converted to a more mobile state. Designed to destroy heavily armoured soldiers and lightly armoured vehicles, mechs. Just... run, if you see it. "
	icon = 'icons/fd/guns/weapon_gkk_icon.dmi'
	icon_state = "gsmg3"
	item_state = "gsmg3"
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	w_class = ITEM_SIZE_HUGE
	caliber = CALIBER_BOLTER
	magazine_type = /obj/item/ammo_magazine/rifle/bolter
	allowed_magazines = /obj/item/ammo_magazine/rifle/bolter
	accuracy = -3
	recoil_buildup = 20
	one_hand_penalty = 10
	screen_shake = 3
	bulk = GUN_BULK_RIFLE + 5
	wielded_item_state = "gsmg3"
	init_firemodes = list(
			list(mode_name="3-round bursts", mode_desc = "Short, controlled bursts", burst=3, fire_delay=4, move_delay=6, accuracy=-4),
			list(mode_name = "semiauto",  mode_desc = "Fire as fast, as your gun give you to do it", burst=1, fire_delay=2, move_delay=4, accuracy= -3)
		)

/obj/item/gun/projectile/automatic/iccgn/bolter/Fire(atom/target, mob/living/user, clickparams, pointblank=0, reflex=0)
	if(user.is_species(SPECIES_RESOMI))
		if(alert(user, "[src] too big for you and can LITERALLY KILL YOU, if you will shoot from it!",, "Nevermind", "*krieg suicide noices",) == "Nevermind")
			// https://i.redd.it/g3jch6re92v31.png
			return

	..()

	if(!src || !user || safety())
		to_chat(user, SPAN_NOTICE("You can't do that now"))
		return
	if(user.is_species(SPECIES_RESOMI))
		to_chat(user, SPAN_DANGER("The recoil of the [src] is way too much for you, Resomi"))
		var/recoil_dir = 0
		if(user.dir == 1 || user.dir == 4 )
			recoil_dir = user.dir*2
		else if(user.dir == (8 || 2))
			recoil_dir = user.dir/2
		user.adjustBruteLoss(60)
		user.Weaken(4)
		log_and_message_admins("is fucked by [src]'s obliterating recoil. Stupid xenos...")
		user.throw_at(get_step(user,recoil_dir), 5, 10)
	else
		if(!user.skill_check(SKILL_WEAPONS, SKILL_BASELINE))
			to_chat(user, SPAN_DANGER("Recoil so hurts..."))
			user.adjustBruteLoss(15)

/obj/item/gun/projectile/automatic/iccgn/smg
	name = "submachine gun"
	desc = "Saudov's submachine gun (SSG-12) made for pilots and crew of armoured vehicles. The small size combines well with rapid suppressive fire.  "
	icon_state = "gsmg4"
	item_state = "gsmg4"
	w_class = ITEM_SIZE_NORMAL
	caliber = CALIBER_PISTOL
	slot_flags = SLOT_BELT
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/smg/iccgn
	allowed_magazines = /obj/item/ammo_magazine/smg/iccgn
	one_hand_penalty = 4
	accuracy = 0
	wielded_item_state = "gsmg4"
	init_firemodes = list(
			SEMI_AUTO_NODELAY,
			BURST_3_ROUND,
			FULL_AUTO_600
		)
/*
Антиматериалка с обоймой	 -
Марксменка-гаранд 			 -
Штурмовая         			+
Точная штурмовая			+
СМГ							+
**БОЛТЕР**					+
Автомат шотган				+
*/
