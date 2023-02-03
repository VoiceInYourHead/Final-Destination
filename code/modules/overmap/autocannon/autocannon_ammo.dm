/obj/structure/ship_munition/ammobox
	name = "ammo box"
	desc = "An ordinary ammo box."
	icon = 'icons/obj/disperser.dmi'
	icon_state = "ammocrate_autocannon1"
	atom_flags =  ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_CLIMBABLE
	var/can_explode = TRUE
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
	if(src && can_explode)
		if(severity < 3 && ammo_count > ammo_count/3)
			can_explode = FALSE
			explosion(loc, -1, 2, 3)
			qdel(src)
		else if(severity < 3 && ammo_count > 0)
			can_explode = FALSE
			explosion(loc, -1, 1, 2)
			qdel(src)
	return

/obj/structure/ship_munition/ammobox/examine(mob/user)
	. = ..()
	to_chat(user, "There [(ammo_count == 1)? "is" : "are"] [ammo_count] round\s left!")

///////////////////////////AMMOBOX///////////////////////////

/obj/structure/ship_munition/ammobox/autocannon
	name = "RP 67mm ammo box"
	desc = "Ammo box that contains 67mm rocket-propelled rounds."
	layer = 2.22
	ammo_count = 60
	ammo_type = /obj/item/projectile/bullet/autocannon

/obj/structure/ship_munition/ammobox/autocannon/high_explosive
	name = "RP-HE 67mm ammo box"
	icon_state = "ammocrate_autocannon_he"
	desc = "Ammo box that contains 67mm rocket-propelled high explosive rounds."
	ammo_count = 60
	ammo_type = /obj/item/projectile/bullet/autocannon/high_explosive

/obj/structure/ship_munition/ammobox/autocannon/armour_piercing
	name = "RP-APFSDS 67mm ammo box"
	icon_state = "ammocrate_autocannon_ap"
	desc = "Ammo box that contains 67mm rocket-propelled armour-piercing fin-stabilized discarding sabot."
	ammo_count = 60
	ammo_type = /obj/item/projectile/bullet/autocannon/armour_piercing

/obj/structure/ship_munition/ammobox/autocannon/anti_hull
	name = "RP-AH 67mm ammo box"
	icon_state = "ammocrate_autocannon_aw"
	desc = "Ammo box that contains 67mm rocket-propelled anti-hull rounds."
	ammo_count = 30
	ammo_type = /obj/item/projectile/bullet/autocannon/anti_hull

/obj/structure/ship_munition/ammobox/autocannon/aphe
	name = "RP-APHE 67mm ammo box"
	icon_state = "ammocrate_autocannon_aphe"
	desc = "Ammo box that contains 67mm rocket-propelled armour-piercing high explosive rounds."
	ammo_count = 30
	ammo_type = /obj/item/projectile/bullet/autocannon/aphe

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
	var/bolt_light_impact = 3


/obj/item/projectile/bullet/autocannon/high_explosive/on_hit(var/atom/target, var/blocked = 0)
	var/backwards = turn(dir, 180)
	explosion(get_step(target, backwards), bolt_devastation, bolt_heavy_impact, bolt_light_impact)
	..()

/obj/item/projectile/bullet/autocannon/armour_piercing
	damage = 200
	armor_penetration = 100
	penetrating = 30
	penetration_modifier = 1.1

/obj/item/projectile/bullet/autocannon/anti_hull
	armor_penetration = 80
	bolt_devastation = 1
	bolt_heavy_impact = 1
	bolt_light_impact = 2

/obj/item/projectile/bullet/autocannon/anti_hull/on_hit(var/atom/target, var/blocked = 0)
	explosion(target, bolt_devastation, bolt_heavy_impact, bolt_light_impact)
	..()


/obj/item/projectile/bullet/autocannon/aphe
	damage = 200
	armor_penetration = 100
	penetrating = 18
	penetration_modifier = 1.1
	bolt_devastation = -1
	bolt_heavy_impact = 2
	bolt_light_impact = 2
	var/delay = 3
	var/primed = 0

/obj/item/projectile/bullet/autocannon/aphe/on_hit(var/atom/target, var/blocked = 0)
	if(primed)
		return
	..()
	primed++
	sleep(delay)
	explosion(get_turf(src), bolt_devastation, bolt_heavy_impact, bolt_light_impact)
	qdel(src)

///////////////////////////MUZZLE///////////////////////////

/obj/effect/projectile/bullet/muzzle/autocannon
	icon = 'icons/obj/disperser.dmi'
	icon_state = "muzzle_bullet"