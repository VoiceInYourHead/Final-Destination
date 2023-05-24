/obj/structure/ship_munition/ammobox/hmg
	name = "44mm ammo box"
	desc = "Ammo box that contains 44mm rounds."
	icon_state = "crate_closed_ammo"
	ammo_count = 120
	ammo_type = /obj/item/projectile/bullet/hmg_ship

/obj/structure/ship_munition/ammobox/hmg/high_explosive
	name = "44mm HE ammo box"
	desc = "Ammo box that contains 44mm high explosive rounds."
	ammo_type = /obj/item/projectile/bullet/hmg_ship/high_explosive

/obj/item/projectile/bullet/hmg_ship
	name = "heavy machine gun bullet"
	icon_state = "bullet"
	damage = 250
	damage_flags = DAM_BULLET | DAM_SHARP | DAM_EDGE
	armor_penetration = 30
	muzzle_type = null
	fire_sound = null
	distance_falloff = 0.1
	life_span = 200
	var/explosion_radius = 5
	var/explosion_max_power = EX_ACT_HEAVY

/obj/item/projectile/bullet/hmg_ship/high_explosive/Bump(atom/A as mob|obj|turf|area, forced=0)
	var/backwards = turn(dir, 180)
	var/exploded = FALSE
	if(!exploded)
		explosion(get_step(get_turf(A), backwards), explosion_radius, explosion_max_power, adminlog = 0, turf_breaker = TRUE)
		exploded = TRUE
	..()