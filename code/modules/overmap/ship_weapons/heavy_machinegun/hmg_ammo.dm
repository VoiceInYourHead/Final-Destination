#define CALIBER_SHIP_HMG "57mm"

/obj/item/ammo_magazine/ammobox/hmg
	name = "ammo box"
	desc = "Ammo box that contains 57mm rounds."
	icon_state = "crate_closed_ammo"
	caliber = CALIBER_SHIP_HMG
	max_ammo = 120
	ammo_type = /obj/item/ammo_casing/huge_caliber/hmg

/obj/item/ammo_magazine/ammobox/hmg/high_explosive
	name = "HE ammo box"
	desc = "Ammo box that contains 57mm high explosive rounds."
	ammo_type = /obj/item/ammo_casing/huge_caliber/hmg/high_explosive

/obj/item/ammo_casing/huge_caliber/hmg
	name = "heavy machine gun casing"
	desc = "A heavy machine gun round casing."
	caliber = CALIBER_SHIP_HMG
	projectile_type = /obj/item/projectile/bullet/huge_caliber/hmg_ship

/obj/item/ammo_casing/huge_caliber/hmg/high_explosive
	projectile_type = /obj/item/projectile/bullet/huge_caliber/hmg_ship/high_explosive

/obj/item/projectile/bullet/huge_caliber/hmg_ship
	name = "heavy machine gun bullet"
	icon_state = "bullet"
	damage = 150
	armor_penetration = 30
//	hull_damage = 0.2
	pew_spread = 20

/obj/item/projectile/bullet/huge_caliber/hmg_ship/high_explosive
	explosion_power = 100
	explosion_falloff = 50
