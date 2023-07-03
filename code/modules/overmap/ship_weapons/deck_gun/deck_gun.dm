/obj/machinery/ship_weapon/front_part/deck_gun
	name = "deck gun turret"
	desc = "An old-fashion cannon turret.\
		<br>A sign on it reads: <i>STAY CLEAR! DO NOT BLOCK!</i>"
	icon = 'icons/fd/deck_gun_sprite.dmi'
	icon_state = "deck_turret_loaded"
	layer = 4.01

	dir = 1
	pixel_x = -63
	pixel_y = -48

/obj/machinery/ship_weapon/front_part/deck_gun/on_update_icon()
	..()
	if(reason_broken & MACHINE_BROKEN_NO_PARTS || stat & NOPOWER || stat & BROKEN)
		icon_state = "platform"
	else
		icon_state = "deck_turret_loaded"

	switch(dir)
		if(NORTH)
			pixel_x = -63
			pixel_y = -48
		if(SOUTH)
			pixel_x = -63
			pixel_y = -80
		if(EAST)
			pixel_x = -48
			pixel_y = -63
		if(WEST)
			pixel_x = -80
			pixel_y = -63
	..()

/obj/machinery/ship_weapon/front_part/deck_gun/Process()
	switch(dir)
		if(NORTH)
			pixel_x = -63
			pixel_y = -48
		if(SOUTH)
			pixel_x = -63
			pixel_y = -65
		if(EAST)
			pixel_x = -48
			pixel_y = -63
		if(WEST)
			pixel_x = -80
			pixel_y = -63
	..()

/obj/machinery/ship_weapon/middle_part/deck_gun
	name = "deck gun tower"
	desc = "An old-fashion gas tube that propels munitions to the deck gun muzzle. \
		<br>A sign on it reads: <i>EXPLOSIVE! DO NOT OVERHEAT!</i>"
	icon_state = "magazine"

/obj/machinery/ship_weapon/back_part/deck_gun
	name = "deck gun breech end"
	desc = "An old-fashion ammo reciever. Munition then goes to deck gun barrel."
	icon_state = "ammo_loader"
	density = FALSE

////////////////////////////////CIRCUIT////////////////////////////////

/obj/item/stock_parts/circuitboard/deck_gun
	name = T_BOARD("deck gun control")
	build_path = /obj/machinery/computer/ship/ship_weapon/deck_gun
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)

/obj/item/stock_parts/circuitboard/deck_gun_front
	name = T_BOARD("deck gun turret")
	build_path = /obj/machinery/ship_weapon/front_part/deck_gun
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 3, TECH_COMBAT = 4)
	req_components = list (
		/obj/item/stack/material/plasteel = 20
	)

/obj/item/stock_parts/circuitboard/deck_gun_middle
	name = T_BOARD("deck gun tower")
	build_path = /obj/machinery/ship_weapon/middle_part/deck_gun
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 3, TECH_COMBAT = 4)
	req_components = list (
		/obj/item/stack/material/plasteel = 30
	)

/obj/item/stock_parts/circuitboard/deck_gun_back
	name = T_BOARD("deck gun breech end")
	build_path = /obj/machinery/ship_weapon/back_part/deck_gun
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 4, TECH_COMBAT = 3)
	req_components = list (
		/obj/item/stock_parts/capacitor/super = 5,
		/obj/item/stock_parts/manipulator/pico = 5
	)
