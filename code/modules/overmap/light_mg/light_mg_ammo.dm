/obj/structure/ship_munition/ammobox/light_mg
	name = "HEAT 30mm ammo box"
	desc = "Ammo box that contains 30mm rocket-propelled HEAT rounds."
	icon = 'icons/obj/disperser.dmi'
	icon_state = "ammocrate_autocannon1"
	layer = 2.22
	atom_flags =  ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_CLIMBABLE
	ammo_count = 120
	ammo_type = /obj/item/projectile/bullet/lmg_ship

/obj/item/projectile/bullet/lmg_ship
	name ="autocannon bolt"
	icon_state= "bolter"
	damage = 150
	damage_flags = DAM_BULLET | DAM_SHARP | DAM_EDGE
	armor_penetration = 30
	muzzle_type = null
	fire_sound = null
	distance_falloff = 0.2
	life_span = 200
	var/bolt_devastation = 0
	var/bolt_heavy_impact = 1
	var/bolt_light_impact = 2

/obj/item/projectile/bullet/lmg_ship/on_hit(var/atom/target, var/blocked = 0)
	if(isturf(target))
		explosion(target, bolt_devastation, bolt_heavy_impact, bolt_light_impact)
	..()