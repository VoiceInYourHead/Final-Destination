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
			to_chat(user, "You need [ammo_count] less [(ammo_count == 1)? "round" : "rounds"] left in the box to do that!")
			return
		playsound(loc, 'sound/items/Ratchet.ogg', 50, 1)
		new /obj/item/stack/material/plasteel(get_turf(src))
		qdel(src)

/obj/structure/ship_munition/ammobox/ex_act(severity)
	if(can_explode)
		if(severity < 3 && ammo_count > ammo_count/3)
			can_explode = FALSE
			explosion(get_turf(src), 7, EX_ACT_DEVASTATING)
			if(src)
				qdel(src)
		else if(severity < 3 && ammo_count > 0)
			can_explode = FALSE
			explosion(get_turf(src), 4, EX_ACT_DEVASTATING)
			if(src)
				qdel(src)
	return

/obj/structure/ship_munition/ammobox/examine(mob/user)
	. = ..()
	to_chat(user, "There [(ammo_count == 1)? "is" : "are"] [ammo_count] round\s left!")

///////////////////////////AMMOBOX///////////////////////////

/obj/structure/ship_munition/ammobox/autocannon
	name = "RP 76mm ammo box"
	desc = "Ammo box that contains solid 76mm rocket-propelled rounds."
	layer = 2.22
	ammo_count = 60
	ammo_type = /obj/item/projectile/bullet/autocannon

/obj/structure/ship_munition/ammobox/autocannon/high_explosive
	name = "RP-HE 76mm ammo box"
	icon_state = "ammocrate_autocannon_he"
	desc = "Ammo box that contains 76mm rocket-propelled high explosive rounds."
	ammo_count = 60
	ammo_type = /obj/item/projectile/bullet/autocannon/high_explosive

/obj/structure/ship_munition/ammobox/autocannon/armour_piercing
	name = "RP-APFSDS 76mm ammo box"
	icon_state = "ammocrate_autocannon_ap"
	desc = "Ammo box that contains 76mm rocket-propelled armour-piercing fin-stabilized discarding sabot."
	ammo_count = 60
	ammo_type = /obj/item/projectile/bullet/autocannon/armour_piercing

/obj/structure/ship_munition/ammobox/autocannon/anti_hull
	name = "RP-AH 76mm ammo box"
	icon_state = "ammocrate_autocannon_ah"
	desc = "Ammo box that contains 76mm rocket-propelled anti-hull rounds."
	ammo_count = 60
	ammo_type = /obj/item/projectile/bullet/autocannon/anti_hull

/obj/structure/ship_munition/ammobox/autocannon/aphe
	name = "RP-APHE 76mm ammo box"
	icon_state = "ammocrate_autocannon_aphe"
	desc = "Ammo box that contains 76mm rocket-propelled armour-piercing high explosive rounds."
	ammo_count = 60
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
	var/explosion_radius = 12
	var/explosion_max_power = EX_ACT_DEVASTATING


/obj/item/projectile/bullet/autocannon/high_explosive/on_hit(var/atom/target, var/blocked = 0)
	var/backwards = turn(dir, 180)
	explosion(get_step(target, backwards), explosion_radius, explosion_max_power)
	..()


/obj/item/projectile/bullet/autocannon/armour_piercing
	damage = 200
	armor_penetration = 100
	penetrating = 30
	penetration_modifier = 1.1


/obj/item/projectile/bullet/autocannon/anti_hull
	armor_penetration = 80
	explosion_radius = 9
	explosion_max_power = EX_ACT_DEVASTATING

/obj/item/projectile/bullet/autocannon/anti_hull/on_hit(var/atom/target, var/blocked = 0)
	explosion(target, explosion_radius, explosion_max_power, turf_breaker = TRUE)
	..()


/obj/item/projectile/bullet/autocannon/aphe
	damage = 200
	armor_penetration = 100
	penetrating = 18
	penetration_modifier = 1.1
	explosion_radius = 7
	explosion_max_power = EX_ACT_HEAVY
	var/delay = 3
	var/primed = 0
	var/loc_while_living = null

/obj/item/projectile/bullet/autocannon/aphe/on_hit(var/atom/target, var/blocked = 0)
	if(primed)
		return
	..()
	primed = 1
	sleep(delay)
	explosion(loc_while_living, explosion_radius, explosion_max_power)
	if(src)
		qdel(src)

/obj/item/projectile/bullet/autocannon/aphe/Process()
	if(src)
		loc_while_living = get_turf(src)
	..()

///////////////////////////MUZZLE///////////////////////////

/obj/effect/projectile/bullet/muzzle/autocannon
	icon = 'icons/obj/disperser.dmi'
	icon_state = "muzzle_bullet"