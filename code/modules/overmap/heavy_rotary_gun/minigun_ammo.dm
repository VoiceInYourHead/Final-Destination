/obj/structure/ship_munition/ammobox/minigun
	name = "57mm HE ammo box"
	desc = "Ammo box that contains 57mm HE rounds."
	icon = 'icons/obj/disperser.dmi'
	icon_state = "ammocrate_autocannon1"
	layer = 2.22
	ammo_count = 1200
	ammo_type = /obj/item/projectile/bullet/minigun

/obj/item/projectile/bullet/minigun
	name = "minigun bullet"
	icon_state = "bullet"
	damage = 200
	damage_flags = DAM_BULLET | DAM_SHARP | DAM_EDGE
	armor_penetration = 30
	muzzle_type = null
	fire_sound = null
	distance_falloff = 0.1
	life_span = 200
	var/bolt_devastation = -1
	var/bolt_heavy_impact = -1
	var/bolt_light_impact = 2

/obj/item/projectile/bullet/minigun/on_hit(var/atom/target, var/blocked = 0)
	var/backwards = turn(dir, 180)
	explosion(get_step(target, backwards), bolt_devastation, bolt_heavy_impact, bolt_light_impact, adminlog = 0)
	..()