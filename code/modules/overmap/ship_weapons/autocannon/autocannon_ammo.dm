#define CALIBER_SHIP_AUTOCANNON    "105mmRP"

///////////////////////////AMMOBOX///////////////////////////

/obj/item/ammo_magazine/ammobox/autocannon
	name = "ammo box"
	desc = "Ammo box that contains solid 105mm rocket-propelled rounds."
	caliber = CALIBER_SHIP_AUTOCANNON
	max_ammo = 60
	ammo_type = /obj/item/ammo_casing/huge_caliber/autocannon

/obj/item/ammo_magazine/ammobox/autocannon/high_explosive
	name = "HE ammo box"
	icon_state = "ammocrate_autocannon_he"
	desc = "Ammo box that contains 105mm rocket-propelled high explosive rounds."
	ammo_type = /obj/item/ammo_casing/huge_caliber/autocannon/high_explosive

/obj/item/ammo_magazine/ammobox/autocannon/armour_piercing
	name = "APFSDS ammo box"
	icon_state = "ammocrate_autocannon_ap"
	desc = "Ammo box that contains 105mm rocket-propelled armour-piercing fin-stabilized discarding sabot."
	ammo_type = /obj/item/ammo_casing/huge_caliber/autocannon/armour_piercing

/obj/item/ammo_magazine/ammobox/autocannon/anti_hull
	name = "AH ammo box"
	icon_state = "ammocrate_autocannon_ah"
	desc = "Ammo box that contains 105mm rocket-propelled anti-hull rounds."
	ammo_type = /obj/item/ammo_casing/huge_caliber/autocannon/anti_hull

/obj/item/ammo_magazine/ammobox/autocannon/aphe
	name = "APHE ammo box"
	icon_state = "ammocrate_autocannon_aphe"
	desc = "Ammo box that contains 105mm rocket-propelled armour-piercing high explosive rounds."
	ammo_type = /obj/item/ammo_casing/huge_caliber/autocannon/aphe

///////////////////////////CASING///////////////////////////

/obj/item/ammo_casing/huge_caliber/autocannon
	name = "autocannon casing"
	desc = "A rocket-propelled autocannon round casing."
	caliber = CALIBER_SHIP_AUTOCANNON
	projectile_type = /obj/item/projectile/bullet/huge_caliber/autocannon

/obj/item/ammo_casing/huge_caliber/autocannon/high_explosive
	projectile_type = /obj/item/projectile/bullet/huge_caliber/autocannon/high_explosive

/obj/item/ammo_casing/huge_caliber/autocannon/anti_hull
	projectile_type = /obj/item/projectile/bullet/huge_caliber/autocannon/anti_hull

/obj/item/ammo_casing/huge_caliber/autocannon/armour_piercing
	projectile_type = /obj/item/projectile/bullet/huge_caliber/autocannon/armour_piercing

/obj/item/ammo_casing/huge_caliber/autocannon/aphe
	projectile_type = /obj/item/projectile/bullet/huge_caliber/autocannon/aphe

///////////////////////////BULLETS///////////////////////////

/obj/item/projectile/bullet/huge_caliber/autocannon
	name ="autocannon bolt"
	damage = 450
//	hull_damage = 1
	pew_spread = 10

/obj/item/projectile/bullet/huge_caliber/autocannon/high_explosive
	explosion_power = 300

/obj/item/projectile/bullet/huge_caliber/autocannon/anti_hull
	armor_penetration = 60
	explosion_power = 200
	proximity_detonation = FALSE

/obj/item/projectile/bullet/huge_caliber/autocannon/armour_piercing
	damage = 200
	armor_penetration = 100
	penetrating = 6
	penetration_modifier = 1.1

/obj/item/projectile/bullet/huge_caliber/autocannon/aphe
	damage = 100
	armor_penetration = 100
	penetrating = 2
	penetration_modifier = 1.1
	proximity_detonation = FALSE
	explosion_power = 200
	var/exploded_inwall = FALSE
	var/delay = 4

/obj/item/projectile/bullet/huge_caliber/autocannon/aphe/Bump(atom/A as mob|obj|turf|area, forced=0)
	..()
	if(exploded)
		return

	exploded = TRUE
	if(istype(A,/obj/effect/shield))
		cell_explosion(get_turf(A), explosion_power, explosion_falloff)
		qdel(src)
		return

	sleep(delay)

	if(src && !exploded_inwall)
		cell_explosion(get_turf(src), explosion_power, explosion_falloff)
		qdel(src)

/obj/item/projectile/bullet/huge_caliber/autocannon/aphe/Destroy()
	if(src && !exploded_inwall && !istype(loc,/atom/movable))
		exploded = TRUE
		exploded_inwall = TRUE
		cell_explosion(get_turf(src), explosion_power, explosion_falloff)
	..()
