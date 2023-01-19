/obj/structure/ship_munition/ammobox
	name = "ammo box"
	desc = "An ordinary ammo box."
	icon = 'icons/obj/disperser.dmi'
	icon_state = "ammocrate_autocannon1"
	atom_flags =  ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_CLIMBABLE
	var/ammo_count = 60
	var/ammo_type = /obj/item/projectile/bullet

/obj/structure/ship_munition/ammobox/attackby(obj/item/W as obj, mob/user as mob)
	if(isWrench(W))
		if(ammo_count > 0)
			to_chat(user, "You need [ammo_count] less rounds left in the box to do that!")
			return
		playsound(loc, 'sound/items/Ratchet.ogg', 50, 1)
		new /obj/item/stack/material/plasteel(get_turf(src))
		qdel(src)

/obj/structure/ship_munition/ammobox/ex_act(severity)
	if(severity < 3 && ammo_count > ammo_count/3)
		explosion(src, -1, 2, 3)
		QDEL_IN(src, 2)
	else if(severity < 3 && ammo_count > 0)
		explosion(src, -1, 1, 2)
		QDEL_IN(src, 2)
	..()

/obj/structure/ship_munition/ammobox/examine(mob/user)
	. = ..()
	to_chat(user, "There [(ammo_count == 1)? "is" : "are"] [ammo_count] round\s left!")

///////////////////////////AMMOBOX///////////////////////////

/obj/structure/ship_munition/ammobox/autocannon
	name = "RP-HE 67mm ammo box"
	desc = "Ammo box that contains 67mm rocket-propelled high explosive rounds."
	layer = 2.22
	ammo_count = 50
	ammo_type = /obj/item/projectile/bullet/autocannon

/obj/structure/ship_munition/ammobox/autocannon/anti_wall
	name = "RP-AW 67mm ammo box"
	desc = "Ammo box that contains 67mm rocket-propelled anti-wall rounds."
	ammo_count = 30
	ammo_type = /obj/item/projectile/bullet/autocannon/anti_wall
/*
/obj/structure/ship_munition/ammobox/autocannon/ap_he
	name = "RP-APHE 67mm ammo box"
	desc = "Ammo box that contains 67mm rocket-propelled armour-piercing high explosive rounds."
	ammo_count = 30
	ammo_type = /obj/item/projectile/bullet/autocannon/ap_he
*/
///////////////////////////BULLETS///////////////////////////

/obj/item/projectile/bullet/autocannon
	name ="autocannon bolt"
	icon_state= "bolter"
	damage = 400
	damage_flags = DAM_BULLET | DAM_SHARP | DAM_EDGE
	armor_penetration = 10
	muzzle_type = null
	fire_sound = null
	distance_falloff = 0.1
	life_span = 200
	var/bolt_devastation = -1
	var/bolt_heavy_impact = 2
	var/bolt_light_impact = 2

/obj/item/projectile/bullet/autocannon/on_hit(var/atom/target, var/blocked = 0)
	if(isturf(target))
		explosion(target, bolt_devastation, bolt_heavy_impact, bolt_light_impact)
	..()

/obj/item/projectile/bullet/autocannon/anti_wall
	armor_penetration = 80
	bolt_devastation = 1
	bolt_heavy_impact = 1
	bolt_light_impact = 2

/obj/item/projectile/bullet/autocannon/anti_wall/on_hit(var/atom/target, var/blocked = 0)
	if(isturf(target))
		explosion(target, bolt_devastation, bolt_heavy_impact, bolt_light_impact)
	..()

/*
/obj/item/projectile/bullet/autocannon/ap_he
	armor_penetration = 80
	bolt_devastation = -1
	bolt_heavy_impact = 2
	bolt_light_impact = 2

/obj/item/projectile/bullet/autocannon/ap_he/on_hit(var/atom/target, var/blocked = 0)
	if(isturf(target))
		explosion(target, bolt_devastation, bolt_heavy_impact, bolt_light_impact)
	..()
*/
///////////////////////////MUZZLE///////////////////////////

/obj/effect/projectile/bullet/muzzle/autocannon
	icon = 'icons/obj/disperser.dmi'
	icon_state = "muzzle_bullet"