///////////////////////////AMMOBOX///////////////////////////

/obj/structure/ship_munition/ammobox/autocannon
	name = "RP 105mm ammo box"
	desc = "Ammo box that contains solid 105mm rocket-propelled rounds."
	ammo_count = 60
	ammo_type = /obj/item/projectile/bullet/autocannon

/obj/structure/ship_munition/ammobox/autocannon/high_explosive
	name = "RP-HE 105mm ammo box"
	icon_state = "ammocrate_autocannon_he"
	desc = "Ammo box that contains 105mm rocket-propelled high explosive rounds."
	ammo_type = /obj/item/projectile/bullet/autocannon/high_explosive

/obj/structure/ship_munition/ammobox/autocannon/armour_piercing
	name = "RP-APFSDS 105mm ammo box"
	icon_state = "ammocrate_autocannon_ap"
	desc = "Ammo box that contains 105mm rocket-propelled armour-piercing fin-stabilized discarding sabot."
	ammo_type = /obj/item/projectile/bullet/autocannon/armour_piercing

/obj/structure/ship_munition/ammobox/autocannon/anti_hull
	name = "RP-AH 105mm ammo box"
	icon_state = "ammocrate_autocannon_ah"
	desc = "Ammo box that contains 105mm rocket-propelled anti-hull rounds."
	ammo_type = /obj/item/projectile/bullet/autocannon/anti_hull

/obj/structure/ship_munition/ammobox/autocannon/aphe
	name = "RP-APHE 105mm ammo box"
	icon_state = "ammocrate_autocannon_aphe"
	desc = "Ammo box that contains 105mm rocket-propelled armour-piercing high explosive rounds."
	ammo_type = /obj/item/projectile/bullet/autocannon/aphe

///////////////////////////BULLETS///////////////////////////

/obj/item/projectile/bullet/autocannon
	name ="autocannon bolt"
	icon_state= "bolter"
	damage = 450
	damage_flags = DAM_BULLET | DAM_SHARP | DAM_EDGE
	armor_penetration = 10
	muzzle_type = null
	fire_sound = null
	distance_falloff = 0.1
	life_span = 250
	var/explosion_radius = 8
	var/explosion_max_power = EX_ACT_DEVASTATING

	var/exploded = FALSE


/obj/item/projectile/bullet/autocannon/high_explosive/Bump(atom/A as mob|obj|turf|area, forced=0)
	var/backwards = turn(dir, 180)
	if(!exploded)
		exploded = TRUE
		explosion(get_step(get_turf(A), backwards), explosion_radius, explosion_max_power)
		qdel(src)


/obj/item/projectile/bullet/autocannon/anti_hull
	armor_penetration = 60
	explosion_radius = 7
	explosion_max_power = EX_ACT_DEVASTATING

/obj/item/projectile/bullet/autocannon/anti_hull/Bump(atom/A as mob|obj|turf|area, forced=0)
	if(!exploded)
		exploded = TRUE
		explosion(get_turf(A), explosion_radius, explosion_max_power, turf_breaker = TRUE)
		qdel(src)


/obj/item/projectile/bullet/autocannon/armour_piercing
	damage = 200
	armor_penetration = 100
	penetrating = 6
	penetration_modifier = 1.1


/obj/item/projectile/bullet/autocannon/aphe
	damage = 200
	armor_penetration = 100
	penetrating = 2
	penetration_modifier = 1.1
	explosion_radius = 7
	explosion_max_power = EX_ACT_HEAVY
	var/delay = 4

/obj/item/projectile/bullet/autocannon/aphe/Bump(atom/A as mob|obj|turf|area, forced=0)
	if(istype(A,/obj/effect/shield))
		explosion(get_turf(A), explosion_radius, explosion_max_power)
		qdel(src)
		return

	if(exploded)
		return

	exploded = TRUE
	sleep(delay)

	if(src)
		explosion(get_turf(src), explosion_radius, explosion_max_power)
		qdel(src)

/obj/item/projectile/bullet/autocannon/aphe/Destroy()
	if(src && !exploded)
		explosion(get_turf(src), explosion_radius, explosion_max_power)
