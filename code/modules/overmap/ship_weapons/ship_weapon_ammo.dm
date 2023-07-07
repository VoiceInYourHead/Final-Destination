/obj/structure/ship_munition/ammobox
	name = "ammo box"
	desc = "An ordinary ammo box."
	icon = 'icons/obj/disperser.dmi'
	icon_state = "ammocrate_autocannon1"
	atom_flags =  ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_CLIMBABLE
	layer = 2.22
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
			explosion(get_turf(src), 6, EX_ACT_DEVASTATING)
			if(src)
				qdel(src)
		else if(severity < 3 && ammo_count > 0)
			can_explode = FALSE
			explosion(get_turf(src), 3, EX_ACT_DEVASTATING)
			if(src)
				qdel(src)
	return

/obj/structure/ship_munition/ammobox/examine(mob/user)
	. = ..()
	to_chat(user, "There [(ammo_count == 1)? "is" : "are"] [ammo_count] round\s left!")

///////////////////////////MUZZLE///////////////////////////

/obj/effect/projectile/bullet/muzzle/ship_weapon
	icon = 'icons/obj/disperser.dmi'
	icon_state = "muzzle_bullet"
	anchored = TRUE