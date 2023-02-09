/obj/structure/ship_munition/ammobox/particle_lance
	name = "4000 MW fusion gun cell"
	desc = "4000 megawatts military grade powercell, often used in giant ship-mounted particle beams."
	layer = 2.22
	ammo_count = 4000
	ammo_type = null
	color = COLOR_PURPLE

/obj/structure/ship_munition/ammobox/particle_lance/examine(mob/user)
	. = ..()
	to_chat(user, "There [(ammo_count == 1)? "is" : "are"] [ammo_count] MW charge left!")