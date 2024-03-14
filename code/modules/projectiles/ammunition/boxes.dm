/obj/item/ammo_magazine/speedloader
	name = "speed loader"
	desc = "A speed loader for revolvers."
	icon_state = "spdloader"
	caliber = CALIBER_PISTOL
	ammo_type = /obj/item/ammo_casing/pistol
	matter = list(MATERIAL_STEEL = 1260)
	max_ammo = 6
	multiple_sprites = 1

/obj/item/ammo_magazine/speedloader/rubber
	labels = list("rubber")
	ammo_type = /obj/item/ammo_casing/pistol/rubber

/obj/item/ammo_magazine/speedloader/magnum
	icon_state = "spdloader_small"
	caliber = CALIBER_PISTOL_MAGNUM
	ammo_type = /obj/item/ammo_casing/pistol/magnum
	matter = list(MATERIAL_STEEL = 1440)
	max_ammo = 6
	multiple_sprites = 1

/obj/item/ammo_magazine/speedloader/magnum/rubber
	ammo_type = /obj/item/ammo_casing/pistol/magnum/rubber

/obj/item/ammo_magazine/speedloader/rifle
	icon_state = "spdloader_small"
	caliber = CALIBER_RIFLE_RUSSIA
	ammo_type = /obj/item/ammo_casing/rifle/russia
	matter = list(MATERIAL_STEEL = 1440)
	max_ammo = 6
	multiple_sprites = 1

/obj/item/ammo_magazine/speedloader/small
	name = "speed loader"
	icon_state = "spdloader_small"
	caliber = CALIBER_PISTOL_SMALL
	ammo_type = /obj/item/ammo_casing/pistol/small
	matter = list(MATERIAL_STEEL = 1060)
	max_ammo = 6
	multiple_sprites = 1

/obj/item/ammo_magazine/speedloader/small/rubber
	ammo_type = /obj/item/ammo_casing/pistol/small/rubber

/obj/item/ammo_magazine/speedloader/pclip
	name = "magnum pistol stripper clip"
	desc = "A stripper clip for pistol magnum caliber weapons."
	icon_state = "pclip"
	caliber = CALIBER_PISTOL_MAGNUM
	ammo_type = /obj/item/ammo_casing/pistol/magnum
	matter = list(MATERIAL_STEEL = 1300)
	max_ammo = 5
	multiple_sprites = 1

/obj/item/ammo_magazine/speedloader/hpclip
	name = "holdout pistol stripper clip"
	desc = "A stripper clip for pistol holdout caliber weapons."
	icon_state = "hpclip"
	caliber = CALIBER_PISTOL_SMALL
	ammo_type = /obj/item/ammo_casing/pistol/small
	matter = list(MATERIAL_STEEL = 1800)
	max_ammo = 10
	multiple_sprites = TRUE

/obj/item/ammo_magazine/speedloader/clip
	name = "rifle stripper clip"
	desc = "A stripper clip for rifle caliber weapons."
	icon_state = "clip"
	caliber = CALIBER_RIFLE
	ammo_type = /obj/item/ammo_casing/rifle
	matter = list(MATERIAL_STEEL = 1800)
	max_ammo = 5
	multiple_sprites = 1

/obj/item/ammo_magazine/shotholder
	name = "shotgun slug holder"
	desc = "A convenient pouch that holds 12 gauge shells."
	icon_state = "shotholder"
	caliber = CALIBER_SHOTGUN
	ammo_type = /obj/item/ammo_casing/shotgun
	matter = list(MATERIAL_STEEL = 1440)
	max_ammo = 4
	multiple_sprites = 1
	var/marking_color
	var/marking_icon = "shotholder-marking"

/obj/item/ammo_magazine/shotholder/on_update_icon()
	..()
	overlays.Cut()
	if(marking_color)
		var/image/I = image(icon, marking_icon)
		I.color = marking_color
		overlays += I

/obj/item/ammo_magazine/shotholder/attack_hand(mob/user)
	if((user.a_intent == I_HURT) && (stored_ammo.len))
		var/obj/item/ammo_casing/C = stored_ammo[stored_ammo.len]
		stored_ammo-=C
		user.put_in_hands(C)
		user.visible_message("\The [user] removes \a [C] from [src].", "<span class='notice'>You remove \a [C] from [src].</span>")
		update_icon()
	else
		..()

/obj/item/ammo_magazine/shotholder/shell
	name = "shotgun shell holder"
	ammo_type = /obj/item/ammo_casing/shotgun/pellet
	marking_color = COLOR_RED_GRAY

/obj/item/ammo_magazine/shotholder/flechette
	name = "flechette shell holder"
	ammo_type = /obj/item/ammo_casing/shotgun/flechette
	marking_color = COLOR_BLUE

/obj/item/ammo_magazine/shotholder/beanbag
	name = "beanbag shell holder"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	matter = list(MATERIAL_STEEL = 720)
	marking_color = COLOR_PAKISTAN_GREEN

/obj/item/ammo_magazine/shotholder/flash
	name = "illumination shell holder"
	ammo_type = /obj/item/ammo_casing/shotgun/flash
	matter = list(MATERIAL_STEEL = 360, MATERIAL_GLASS = 360)
	marking_color = COLOR_PALE_YELLOW

/obj/item/ammo_magazine/shotholder/stun
	name = "stun shell holder"
	ammo_type = /obj/item/ammo_casing/shotgun/stunshell
	matter = list(MATERIAL_STEEL = 1440, MATERIAL_GLASS = 2880)
	marking_color = COLOR_MUZZLE_FLASH

/obj/item/ammo_magazine/shotholder/empty
	name = "shotgun ammunition holder"
	matter = list(MATERIAL_STEEL = 250)
	initial_ammo = 0

/obj/item/ammo_magazine/shotholder/large
	name = "shotgun slug holder"
	desc = "A convenient pouch that holds 12 gauge shells."
	icon_state = "shotholder_big"
	matter = list(MATERIAL_STEEL = 2800)
	ammo_type = /obj/item/ammo_casing/shotgun
	max_ammo = 10
	marking_icon = "shotholder_big-marking"

/obj/item/ammo_magazine/shotholder/large/shell
	name = "shotgun shell holder"
	ammo_type = /obj/item/ammo_casing/shotgun/pellet
	marking_color = COLOR_RED_GRAY

/obj/item/ammo_magazine/shotholder/large/empty
	name = "shotgun ammunition holder"
	matter = list(MATERIAL_STEEL = 450)
	initial_ammo = 0

/obj/item/ammo_magazine/box/shotgun
	name = "shell box"
	icon_state = "slbox"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = CALIBER_SHOTGUN
	matter = list(MATERIAL_STEEL = 4950)
	ammo_type = /obj/item/ammo_casing/shotgun
	multiple_sprites = 1
	max_ammo = 21
	w_class = ITEM_SIZE_LARGE

/obj/item/ammo_magazine/box/shotgun/shell
	name = "shell box"
	icon_state = "gbox"
	ammo_type = /obj/item/ammo_casing/shotgun/pellet

/obj/item/ammo_magazine/machine_pistol
	name = "stick magazine"
	icon_state = "machine_pistol"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol
	matter = list(MATERIAL_STEEL = 1200)
	caliber = CALIBER_PISTOL
	max_ammo = 16
	multiple_sprites = 1

/obj/item/ammo_magazine/machine_pistol/empty
	initial_ammo = 0

/obj/item/ammo_magazine/smg_top
	name = "top mounted magazine"
	icon_state = "smg_top"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol/small
	matter = list(MATERIAL_STEEL = 1200)
	caliber = CALIBER_PISTOL_SMALL
	max_ammo = 20
	multiple_sprites = 1

/obj/item/ammo_magazine/smg_top/empty
	initial_ammo = 0

/obj/item/ammo_magazine/smg_top/rubber
	labels = list("rubber")
	ammo_type = /obj/item/ammo_casing/pistol/small/rubber

/obj/item/ammo_magazine/smg_top/practice
	labels = list("practice")
	ammo_type = /obj/item/ammo_casing/pistol/small/practice

/obj/item/ammo_magazine/smg
	name = "box magazine"
	icon_state = "smg"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = CALIBER_PISTOL
	matter = list(MATERIAL_STEEL = 1500)
	ammo_type = /obj/item/ammo_casing/pistol
	max_ammo = 20
	multiple_sprites = 1

/obj/item/ammo_magazine/smg/empty
	initial_ammo = 0

/obj/item/ammo_magazine/smg/iccgn
	name = "magazine"
	icon = 'icons/fd/guns/weapon_gkk_icon.dmi'
	icon_state = "gsmg3M"
	max_ammo = 45
	multiple_sprites = 0

/obj/item/ammo_magazine/pistol
	name = "pistol magazine"
	icon_state = "pistol_mag"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = CALIBER_PISTOL
	matter = list(MATERIAL_STEEL = 750)
	ammo_type = /obj/item/ammo_casing/pistol
	max_ammo = 10
	multiple_sprites = 1

/obj/item/ammo_magazine/pistol/empty
	initial_ammo = 0

/obj/item/ammo_magazine/pistol/rubber
	labels = list("rubber")
	ammo_type = /obj/item/ammo_casing/pistol/rubber

/obj/item/ammo_magazine/pistol/double
	name = "doublestack pistol magazine"
	icon_state = "pistol_mag"
	matter = list(MATERIAL_STEEL = 1050)
	max_ammo = 15

/obj/item/ammo_magazine/pistol/double/rubber
	labels = list("rubber")
	ammo_type = /obj/item/ammo_casing/pistol/rubber

/obj/item/ammo_magazine/pistol/double/practice
	labels = list("practice")
	ammo_type = /obj/item/ammo_casing/pistol/practice

/obj/item/ammo_magazine/pistol/small
	icon_state = "holdout"
	matter = list(MATERIAL_STEEL = 480)
	caliber = CALIBER_PISTOL_SMALL
	ammo_type = /obj/item/ammo_casing/pistol/small
	max_ammo = 8

/obj/item/ammo_magazine/pistol/small/empty
	initial_ammo = 0

/obj/item/ammo_magazine/magnum
	name = "magazine"
	icon_state = "magnum"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = CALIBER_PISTOL_MAGNUM
	matter = list(MATERIAL_STEEL = 1680)
	ammo_type = /obj/item/ammo_casing/pistol/magnum
	max_ammo = 7
	multiple_sprites = 1

/obj/item/ammo_magazine/magnum/empty
	initial_ammo = 0

/obj/item/ammo_magazine/box/magnum
	name = "ammunition box"
	icon_state = "mbox"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = CALIBER_PISTOL_MAGNUM
	matter = list(MATERIAL_STEEL = 3250)
	ammo_type = /obj/item/ammo_casing/pistol/magnum
	max_ammo = 30

/obj/item/ammo_magazine/box/smallpistol
	name = "ammunition box"
	icon_state = "smallpistol"
	origin_tech = list(TECH_COMBAT = 2)
	matter = list(MATERIAL_STEEL = 1800)
	caliber = CALIBER_PISTOL_SMALL
	ammo_type = /obj/item/ammo_casing/pistol/small
	max_ammo = 30

/obj/item/ammo_magazine/box/pistol
	name = "ammunition box"
	icon_state = "smallpistol"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = CALIBER_PISTOL
	matter = list(MATERIAL_STEEL = 2550)
	ammo_type = /obj/item/ammo_casing/pistol
	max_ammo = 30

/obj/item/ammo_magazine/box/pistol/empty
	initial_ammo = 0

/obj/item/ammo_magazine/pistol/throwback
	name = "pistol magazine"
	caliber = CALIBER_PISTOL_ANTIQUE
	ammo_type = /obj/item/ammo_casing/pistol/throwback

/obj/item/ammo_magazine/box/emp/pistol
	name = "EMP ammunition box"
	icon_state = "empbox"
	desc = "A box containing loose rounds of standard EMP ammo."
	labels = list("haywire")
	ammo_type = /obj/item/ammo_casing/pistol/emp
	caliber = CALIBER_PISTOL
	max_ammo = 30

/obj/item/ammo_magazine/box/emp/smallpistol
	name = "EMP ammunition box"
	icon_state = "empbox"
	desc = "A box containing loose rounds of small EMP ammo."
	labels = list("haywire")
	ammo_type = /obj/item/ammo_casing/pistol/small/emp
	caliber = CALIBER_PISTOL_SMALL
	max_ammo = 35

/obj/item/ammo_magazine/proto_smg
	name = "submachine gun magazine"
	icon_state = CALIBER_PISTOL_FLECHETTE
	origin_tech = list(TECH_COMBAT = 4)
	mag_type = MAGAZINE
	caliber = CALIBER_PISTOL_FLECHETTE
	matter = list(MATERIAL_STEEL = 2000)
	ammo_type = /obj/item/ammo_casing/flechette
	max_ammo = 40
	multiple_sprites = 1

/obj/item/ammo_magazine/gyrojet
	name = "microrocket magazine"
	icon_state = "gyrojet"
	mag_type = MAGAZINE
	caliber = CALIBER_GYROJET
	ammo_type = /obj/item/ammo_casing/gyrojet
	multiple_sprites = 1
	max_ammo = 4

/obj/item/ammo_magazine/gyrojet/empty
	initial_ammo = 0

/obj/item/ammo_magazine/box/machinegun
	name = "magazine box"
	icon_state = "machinegun"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = CALIBER_RIFLE
	matter = list(MATERIAL_STEEL = 4500)
	ammo_type = /obj/item/ammo_casing/rifle
	max_ammo = 80
	multiple_sprites = 1

/obj/item/ammo_magazine/box/machinegun/empty
	initial_ammo = 0

/obj/item/ammo_magazine/rifle
	name = "assault rifle magazine"
	icon_state = "assault_rifle"
	mag_type = MAGAZINE
	caliber = CALIBER_RIFLE
	matter = list(MATERIAL_STEEL = 1800)
	ammo_type = /obj/item/ammo_casing/rifle
	max_ammo = 40
	multiple_sprites = 1

/obj/item/ammo_magazine/mil_rifle
	name = "assault rifle magazine"
	icon_state = "bullup"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = CALIBER_RIFLE_MILITARY
	matter = list(MATERIAL_STEEL = 1800)
	ammo_type = /obj/item/ammo_casing/rifle/military
	max_ammo = 30 //if we lived in a world where normal mags had 30 rounds, this would be a 20 round mag
	multiple_sprites = 1

/obj/item/ammo_magazine/mil_rifle/empty
	initial_ammo = 0

/obj/item/ammo_magazine/mil_rifle/practice
	labels = list("practice")
	ammo_type = /obj/item/ammo_casing/rifle/military/practice

/obj/item/ammo_magazine/caps
	name = "speed loader"
	desc = "A cheap plastic speed loader for some kind of revolver."
	icon_state = "T38"
	caliber = CALIBER_CAPS
	ammo_type = /obj/item/ammo_casing/cap
	matter = list(MATERIAL_STEEL = 600)
	max_ammo = 7
	multiple_sprites = 1

/obj/item/ammo_magazine/iclipr
	name = "internal rifle magazine"
	desc = "An internal clip for rifle caliber weapons."
	icon_state = "iclipr"
	caliber = CALIBER_RIFLE
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/rifle
	matter = list(MATERIAL_STEEL = 1500)
	max_ammo = 8
	multiple_sprites = TRUE

/obj/item/ammo_magazine/box/rifle
	name = "ammunition crate"
	desc = "ammunition crate for rifle caliber weapons."
	icon_state = "rbox"
	origin_tech = list(TECH_COMBAT = 2)
	w_class = ITEM_SIZE_HUGE
	caliber = CALIBER_RIFLE
	matter = list(MATERIAL_STEEL = 10100)
	slowdown_general = 0.2
	ammo_type = /obj/item/ammo_casing/rifle
	max_ammo = 240

/obj/item/ammo_magazine/box/rifle/military
	name = "7mmR rounds crate"
	icon_state = "rbox_m"
	caliber = CALIBER_RIFLE_MILITARY
	ammo_type = /obj/item/ammo_casing/rifle/military

/obj/item/ammo_magazine/box/rifle/military
	name = "12.7 rounds crate"
	icon_state = "rbox_r"
	caliber = CALIBER_RIFLE_RUSSIA
	ammo_type = /obj/item/ammo_casing/rifle/russia

/obj/item/ammo_magazine/box/attack_self(mob/user)
	if(!stored_ammo.len)
		to_chat(user, "<span class='notice'>[src] is already empty!</span>")
		return
	if(alert("Do you really want to empty this container? All this amount of bullets will fall to the ground.",,"Im think, im not.","Yeah, let's fuck with it!") == "Im think, im not.")
		return
	if(stored_ammo.len > 30)
		if(alert("I'll give you a second chance to think, are you SURE you want ALL [stored_ammo.len] these bullets on the floor?",,"I've changed my mind, I don't want to.","Let me put all these bullets on the floor already!") == "I've changed my mind, I don't want to.")
			return
	to_chat(user, "<span class='notice'>You empty [src].</span>")
	for(var/obj/item/ammo_casing/C in stored_ammo)
		C.forceMove(user.loc)
		C.set_dir(pick(GLOB.alldirs))
	stored_ammo.Cut()
	update_icon()

// FD

//  Rifles

/obj/item/ammo_magazine/rifle/fleet
	name = "assault rifle magazine"
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "automat4M"
	matter = list(MATERIAL_STEEL = 1800)
	mag_type = MAGAZINE
	caliber = CALIBER_RIFLE
	ammo_type = /obj/item/ammo_casing/rifle/fleet
	max_ammo = 40

/obj/item/ammo_magazine/rifle/army
	name = "battle rifle magazine"
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	matter = list(MATERIAL_STEEL = 3600)
	icon_state = "automat3M"
	mag_type = MAGAZINE
	caliber = CALIBER_RIFLE_MILITARY
	ammo_type = /obj/item/ammo_casing/rifle/army
	max_ammo = 20

/obj/item/ammo_magazine/rifle/iccgn
	name = "assault rifle magazine"
	icon = 'icons/fd/guns/weapon_gkk_icon.dmi'
	icon_state = "gautomatic2M"
	mag_type = MAGAZINE
	caliber = CALIBER_RIFLE
	ammo_type = /obj/item/ammo_casing/rifle/iccgn
	matter = list(MATERIAL_STEEL = 1800)
	max_ammo = 30

/obj/item/ammo_magazine/rifle/precise
	name = "assault rifle magazine"
	icon = 'icons/fd/guns/weapon_gkk_icon.dmi'
	icon_state = "gautomatic1M"
	mag_type = MAGAZINE
	matter = list(MATERIAL_STEEL = 1800)
	caliber = CALIBER_RIFLE_MILITARY
	ammo_type =  /obj/item/ammo_casing/rifle/accurate
	max_ammo = 30

/obj/item/ammo_magazine/rifle/bolter
	name = "heavy battle rifle magazine"
	desc = "A magazine for some kind of gun. This one - Armour-Piercing Discarding Sabot(APDS)"
	labels = list("APDS")
	icon = 'icons/fd/guns/weapon_gkk_icon.dmi'
	icon_state = "gsmg3M"
	mag_type = MAGAZINE
	caliber =  CALIBER_BOLTER
	ammo_type = /obj/item/ammo_casing/rifle/bolter
	max_ammo = 24


/obj/item/ammo_magazine/rifle/bolter/explosive
	desc = "A magazine for some kind of gun."
	labels = null
	ammo_type = /obj/item/ammo_casing/rifle/bolter/explosive

// Pistols

/obj/item/ammo_magazine/pistol/scg
	name = "magnum magazine"
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "pistol7M"
	mag_type = MAGAZINE
	caliber = CALIBER_PISTOL_MAGNUM
	matter = list(MATERIAL_STEEL = 1680)
	ammo_type = /obj/item/ammo_casing/pistol/magnum
	max_ammo = 7

/obj/item/ammo_magazine/pistol/scg/rubber
	labels = list("rubber")
	ammo_type = /obj/item/ammo_casing/pistol/magnum/rubber

/obj/item/ammo_magazine/pistol/assasin
	name = "pistol magazine"
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "pistol6M"
	mag_type = MAGAZINE
	caliber = CALIBER_PISTOL_FLECHETTE
	matter = list(MATERIAL_STEEL = 1050)
	ammo_type = /obj/item/ammo_casing/pistol/assasin
	max_ammo = 12

/obj/item/ammo_magazine/pistol/assasin/rubber
	labels = list("rubber")
	ammo_type = /obj/item/ammo_casing/pistol/assasin/rubber


/obj/item/ammo_magazine/pistol/iccgn
	name = "pistol magazine"
	icon = 'icons/fd/guns/weapon_gkk_icon.dmi'
	icon_state = "gpistol8M"
	mag_type = MAGAZINE
	caliber = CALIBER_PISTOL_MAGNUM
	matter = list(MATERIAL_STEEL = 1680)
	ammo_type = /obj/item/ammo_casing/pistol/iccgn
	max_ammo = 15

/obj/item/ammo_magazine/pistol/iccgn/rubber
	labels = list("rubber")
	ammo_type = /obj/item/ammo_casing/pistol/iccgn


/obj/item/ammo_magazine/pistol/automatic
	name = "automatic pistol magazine"
	icon = 'icons/fd/guns/weapon_gkk_icon.dmi'
	icon_state = "gpistol9M"
	mag_type = MAGAZINE
	matter = list(MATERIAL_STEEL = 2000)
	ammo_type = /obj/item/ammo_casing/pistol/automatic
	max_ammo = 45

/obj/item/ammo_magazine/pistol/automatic/rubber
	labels = list("rubber")
	ammo_type = /obj/item/ammo_casing/pistol/automatic/rubber

// SMGs

/obj/item/ammo_magazine/smg/scg
	name = "magazine"
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "smg5M"
	mag_type = MAGAZINE
	caliber = CALIBER_PISTOL
	matter = list(MATERIAL_STEEL = 1500)
	ammo_type = /obj/item/ammo_casing/pistol
	max_ammo = 35

/obj/item/ammo_magazine/smg/scg/rubber
	labels = list("rubber")
	ammo_type = /obj/item/ammo_casing/pistol/rubber

/obj/item/ammo_magazine/smg/special/scg
	name = "magazine"
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "smg6M"
	mag_type = MAGAZINE
	caliber = CALIBER_PISTOL
	matter = list(MATERIAL_STEEL = 1500)
	ammo_type = /obj/item/ammo_casing/pistol
	max_ammo = 20

/obj/item/ammo_magazine/smg/special/scg/rubber
	labels = list("rubber")
	ammo_type = /obj/item/ammo_casing/pistol/rubber

// Other stuff

/obj/item/ammo_magazine/shotgun/scg
	name = "shotgun drum"
	labels = list("slugs")
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "shotgun4M"
	mag_type = MAGAZINE
	caliber = CALIBER_SHOTGUN
	ammo_type = /obj/item/ammo_casing/shotgun
	matter = list(MATERIAL_STEEL = 3180) // 8 slugs + Drum
	max_ammo = 8

/obj/item/ammo_magazine/shotgun/scg/shell
	labels = list("shells")
	ammo_type = /obj/item/ammo_casing/shotgun/pellet
	matter = list(MATERIAL_STEEL = 3180)

/obj/item/ammo_magazine/shotgun/scg/beanbag
	labels = list("beanbags")
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	matter = list(MATERIAL_STEEL = 1790)

/obj/item/ammo_magazine/shotgun/scg/empty
	matter = list(MATERIAL_STEEL = 350)
	initial_ammo = 0

/obj/item/ammo_magazine/shotgun/iccgn
	name = "shotgun drum"
	labels = list("slugs")
	icon = 'icons/fd/guns/weapon_gkk_icon.dmi'
	icon_state = "gshotgun2M"
	mag_type = MAGAZINE
	caliber = CALIBER_SHOTGUN
	ammo_type = /obj/item/ammo_casing/shotgun
	matter = list(MATERIAL_STEEL = 5600)
	max_ammo = 15

/obj/item/ammo_magazine/shotgun/iccgn/beanbag
	labels = list("beanbag")
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	matter = list(MATERIAL_STEEL = 2790)

/obj/item/ammo_magazine/shotgun/iccgn/magnum
	desc = "When you need to oblitirate enemy"
	labels = list("magnum")
	ammo_type = /obj/item/ammo_casing/magnum/shotgun
	matter = list(MATERIAL_STEEL = 5600)

/obj/item/ammo_magazine/shotgun/iccgn/empty
	matter = list(MATERIAL_STEEL = 350)
	initial_ammo = 0

/obj/item/ammo_magazine/sniper/scg
	name = "magazine"
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "sniperrifle2M"
	mag_type = MAGAZINE
	caliber = CALIBER_RIFLE_MILITARY
	ammo_type = /obj/item/ammo_casing/rifle/military/marksman
	matter = list(MATERIAL_STEEL = 3550)
	max_ammo = 15

/obj/item/ammo_magazine/sniper/iccgn
	name = "magazine"
	icon = 'icons/fd/guns/weapon_gkk_icon.dmi'
	icon_state = "gsniperrifle4M"
	mag_type = MAGAZINE
	caliber = CALIBER_RIFLE_MILITARY
	ammo_type = /obj/item/ammo_casing/scg/shell
	matter = list(MATERIAL_STEEL = 3550)
	max_ammo = 7

/obj/item/ammo_magazine/speedloader/dmr
	name = "marksman stripper clip"
	desc = "A stripper clip for rifle caliber weapons."
	icon_state = "iclipr"
	caliber = CALIBER_RIFLE_MILITARY
	ammo_type = /obj/item/ammo_casing/rifle/dmr
	max_ammo = 8
	multiple_sprites = 1

/obj/item/ammo_magazine/speedloader/dmr/apds
	labels = list("APDS")
	ammo_type = /obj/item/ammo_casing/rifle/dmr/apds
	max_ammo = 4

/obj/item/ammo_magazine/speedloader/dmr/haywire
	labels = list("haywire")
	ammo_type = /obj/item/ammo_casing/rifle/dmr/haywire
	max_ammo = 4
