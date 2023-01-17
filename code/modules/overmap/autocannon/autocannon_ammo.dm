/obj/structure/ship_munition/autocannon_ammobox
	name = "RP-AW 57mm ammo box"
	desc = "Ammo box that contains 57mm rocket-propelled anti-wall rounds."
	icon = 'icons/obj/disperser.dmi'
	icon_state = "ammocrate_autocannon1"
	atom_flags =  ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_CLIMBABLE
	var/ammo = 30
	var/ammo_type = /obj/item/projectile/bullet/autocannon

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
	var/round_devastation = 1
	var/round_heavy_impact = 1
	var/round_light_impact = 2

/obj/item/projectile/bullet/autocannon/on_hit(var/atom/target, var/blocked = 0)
	if(isturf(target))
		explosion(target, round_devastation, round_heavy_impact, round_light_impact)
	..()