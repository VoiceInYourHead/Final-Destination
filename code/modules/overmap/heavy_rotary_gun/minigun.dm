/obj/machinery/minigun
	icon = 'icons/obj/disperser.dmi'
	density = TRUE
	anchored = TRUE
	construct_state = /decl/machine_construction/default/panel_closed

/obj/machinery/minigun/examine(mob/user)
	. = ..()
	if(panel_open)
		to_chat(user, "The maintenance panel is open.")

/obj/machinery/minigun/attackby(obj/item/I, mob/user)
	if(isWrench(I))
		if(panel_open)
			user.visible_message("<span class='notice'>\The [user] rotates \the [src] with \the [I].</span>", "<span class='notice'>You rotate \the [src] with \the [I].</span>")
			set_dir(turn(dir, 90))
			playsound(src, 'sound/items/jaws_pry.ogg', 50, 1)
		else
			to_chat(user,"<span class='notice'>The maintenance panel must be screwed open for this!</span>")
	else
		return ..()

/obj/machinery/minigun/front_part
	name = "АК2057-Р rotary railgun cannon muzzle"
	desc = "An old-fashion minigun muzzle.\
		<br>A sign on it reads: <i>STAY CLEAR! DO NOT BLOCK!</i>"
	icon_state = "meme2"

/obj/machinery/minigun/middle_part
	name = "АК2057-Р rotary railgun cannon barrel"
	desc = "An old-fashion gas tube that propels munitions to rotary cannon muzzle. \
		<br>A sign on it reads: <i>EXPLOSIVE! DO NOT OVERHEAT!</i>"
	icon_state = "middle"
	maximum_component_parts = list(/obj/item/stock_parts = 15)

/obj/machinery/minigun/back_part
	name = "АК2057-Р rotary railgun cannon breech end"
	desc = "An old-fashion ammo reciever. Munition then goes to rotary cannon barrel."
	icon_state = "back"
	density = FALSE
//	layer = BELOW_DOOR_LAYER //So the charges go above us.

////////////////////////////////CIRCUIT////////////////////////////////

/obj/item/stock_parts/circuitboard/minigun
	name = T_BOARD("rotary railgun cannon control")
	build_path = /obj/machinery/computer/ship/minigun
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)

/obj/item/stock_parts/circuitboard/minigunfront
	name = T_BOARD("rotary railgun cannon muzzle")
	build_path = /obj/machinery/minigun/front_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 4, TECH_COMBAT = 4)
	req_components = list (
		/obj/item/stack/material/plasteel = 10
	)

/obj/item/stock_parts/circuitboard/minigunmiddle
	name = T_BOARD("rotary cannon barrel")
	build_path = /obj/machinery/minigun/middle_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 4, TECH_COMBAT = 4)
	req_components = list (
		/obj/item/stack/material/plasteel = 15
	)

/obj/item/stock_parts/circuitboard/minigunback
	name = T_BOARD("rotary cannon breech end")
	build_path = /obj/machinery/minigun/back_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 4, TECH_COMBAT = 4)
	req_components = list (
		/obj/item/stock_parts/capacitor/super = 3,
		/obj/item/stock_parts/manipulator/pico = 3
	)
