/obj/structure/ship_munition/ammobox/hmg
	name = "44mm ammo box"
	desc = "Ammo box that contains 44mm rounds."
	icon = 'icons/obj/disperser.dmi'
	icon_state = "ammocrate_autocannon1"
	layer = 2.22
	ammo_count = 120
	ammo_type = /obj/item/projectile/bullet/hmg_ship

/obj/item/projectile/bullet/hmg_ship
	name = "heavy machine gun bullet"
	icon_state = "bullet"
	damage = 150
	damage_flags = DAM_BULLET | DAM_SHARP | DAM_EDGE
	armor_penetration = 30
	muzzle_type = null
	fire_sound = null
	distance_falloff = 0.1
	life_span = 200
	var/bolt_devastation = 0
	var/bolt_heavy_impact = 1
	var/bolt_light_impact = 2

/obj/item/projectile/bullet/hmg_ship/on_hit(var/atom/target, var/blocked = 0)
	explosion(get_turf(target), bolt_devastation, bolt_heavy_impact, bolt_light_impact, adminlog = 0)
	..()