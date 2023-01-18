/obj/structure/ship_munition/ammobox/harpoon
	name = "giant harpoon storage box"
	desc = "Box that contains 500mm rocket-propelled anti-ship harpoons."
	icon = 'icons/obj/disperser.dmi'
	icon_state = "ammocrate_autocannon1"
	layer = 2.22
	atom_flags =  ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_CLIMBABLE
	ammo = 3
	ammo_type = null

/obj/structure/ship_munition/ammobox/harpoon/ex_act(severity)
	return