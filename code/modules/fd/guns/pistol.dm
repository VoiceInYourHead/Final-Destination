// SCG

/obj/item/gun/projectile/pistol/scg
	name = "magnum pistol"
	desc = "A heavy pistol, popularly called the 'Head Breaker' for its high firepower. Unfortunately, this firepower had to be sacrificed at the expense of speed and ammunition.."
	icon = 'icons/fd/guns/magnum_cpps.dmi'
	icon_state = "pistol7"
	item_state = "pistol7"
	magazine_type = /obj/item/ammo_magazine/pistol/scg
	allowed_magazines = /obj/item/ammo_magazine/pistol/scg
	caliber = CALIBER_PISTOL_MAGNUM
	force = 9
	fire_delay = 12
	bulk = 4
	accuracy = 1
	one_hand_penalty = 4
	ammo_indicator = TRUE

/obj/item/gun/projectile/pistol/scg/assasin
	name = "silenced pistol"
	desc = "A gun made specifically for SolGov Special Operations units. It has a built-in silencer."
	icon = 'icons/fd/guns/weapon_cpss_icon.dmi'
	icon_state = "pistol6"
	item_state = "pistol6"
	magazine_type = /obj/item/ammo_magazine/pistol/assasin
	allowed_magazines = /obj/item/ammo_magazine/pistol/assasin
	caliber = CALIBER_PISTOL
	force = 9
	silenced = 1
	fire_delay = 4
	accuracy = 2
	one_hand_penalty = 2
