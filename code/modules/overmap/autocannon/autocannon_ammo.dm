/obj/structure/ship_munition/autocannon_ammobox
	name = "RP-AW 57mm ammo box"
	desc = "Ammo box that contains 57mm rocket-propelled anti-wall rounds."
	icon = 'icons/obj/disperser.dmi'
	icon_state = "ammocrate_autocannon1"
	layer = 2.22
	atom_flags =  ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_CLIMBABLE
	var/ammo = 30
	var/ammo_type = /obj/item/projectile/bullet/autocannon

/obj/structure/ship_munition/autocannon_ammobox/attackby(obj/item/W as obj, mob/user as mob)
	if(isWrench(W))
		if(ammo > 0)
			to_chat(user, "You need [ammo] less rounds left in the box to do that!")
			return
		playsound(loc, 'sound/items/Ratchet.ogg', 50, 1)
		new /obj/item/stack/material/plasteel(get_turf(src))
		qdel(src)

/obj/structure/ship_munition/autocannon_ammobox/ex_act(severity)
	if(severity < 3 && ammo > ammo/3)
		explosion(src, -1, 2, 3)
		QDEL_IN(src, 2)
	else if(severity < 3 && ammo > 0)
		explosion(src, -1, 1, 2)
		QDEL_IN(src, 2)
	..()

/obj/structure/ship_munition/autocannon_ammobox/examine(mob/user)
	. = ..()
	to_chat(user, "There [(ammo == 1)? "is" : "are"] [ammo] round\s left!")

/obj/item/projectile/bullet/autocannon
	name ="autocannon bolt"
	icon_state= "bolter"
	damage = 200
	damage_flags = DAM_BULLET | DAM_SHARP | DAM_EDGE
	armor_penetration = 50
	muzzle_type = null
	fire_sound = null
	distance_falloff = 0.2
	life_span = 200
	var/bolt_devastation = 1
	var/bolt_heavy_impact = 1
	var/bolt_light_impact = 2

/obj/item/projectile/bullet/autocannon/on_hit(var/atom/target, var/blocked = 0)
	if(isturf(target))
		explosion(target, bolt_devastation, bolt_heavy_impact, bolt_light_impact)
	..()

/obj/effect/projectile/bullet/muzzle/autocannon
	icon = 'icons/obj/disperser.dmi'
	icon_state = "muzzle_bullet"