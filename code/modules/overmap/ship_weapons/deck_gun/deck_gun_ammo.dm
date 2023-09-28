#define CALIBER_SHIP_DECK_GUN "140mmRP"

/obj/item/ammo_magazine/ammobox/deck_gun
	name = "ammo box"
	desc = "Ammo box that contains 140mm rocket-propelled rounds."
	icon_state = "crate_closed_ammo"
	caliber = CALIBER_SHIP_DECK_GUN
	max_ammo = 15
	ammo_type = /obj/item/ammo_casing/huge_caliber/deck_gun

/obj/item/ammo_magazine/ammobox/deck_gun/high_explosive
	name = "HE ammo box"
	desc = "Ammo box that contains 140mm rocket-propelled high explosive rounds."
	ammo_type = /obj/item/ammo_casing/huge_caliber/deck_gun/high_explosive

/obj/item/ammo_casing/huge_caliber/deck_gun
	name = "cannon casing"
	desc = "A deck gun round casing."
	caliber = CALIBER_SHIP_DECK_GUN
	projectile_type = /obj/item/projectile/bullet/huge_caliber/deck_gun

/obj/item/ammo_casing/huge_caliber/deck_gun/high_explosive
	projectile_type = /obj/item/projectile/bullet/huge_caliber/deck_gun/high_explosive

/obj/item/projectile/bullet/huge_caliber/deck_gun
	name = "cannon bolt"
	damage = 250
	armor_penetration = 30
	shoot_range = 5 // how far will we go on the overmap
//	hull_damage = 0.2
	projectile_size = 2
	pew_spread = 20

/obj/item/projectile/bullet/huge_caliber/deck_gun/high_explosive
	explosion_power = 400
