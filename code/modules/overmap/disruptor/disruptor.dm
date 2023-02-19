/obj/machinery/disruptor
	icon = 'icons/obj/disperser.dmi'
	density = TRUE
	anchored = TRUE
	construct_state = /decl/machine_construction/default/panel_closed

/obj/machinery/disruptor/examine(mob/user)
	. = ..()
	if(panel_open)
		to_chat(user, "The maintenance panel is open.")

/obj/machinery/disruptor/attackby(obj/item/I, mob/user)
	if(isWrench(I))
		if(panel_open)
			user.visible_message("<span class='notice'>\The [user] rotates \the [src] with \the [I].</span>", "<span class='notice'>You rotate \the [src] with \the [I].</span>")
			set_dir(turn(dir, 90))
			playsound(src, 'sound/items/jaws_pry.ogg', 50, 1)
		else
			to_chat(user,"<span class='notice'>The maintenance panel must be screwed open for this!</span>")
	else
		return ..()

/obj/machinery/disruptor/front_part
	name = "disruptor muzzle"
	desc = "A disruptor muzzle.\
		<br>A sign on it reads: <i>STAY CLEAR! DO NOT BLOCK!</i>"
	icon_state = "gun"

/obj/machinery/disruptor/middle_part
	name = "disruptor barrel"
	desc = "A gas tube that propels munitions to the disruptor muzzle. \
		<br>A sign on it reads: <i>EXPLOSIVE! DO NOT OVERHEAT!</i>"
	icon_state = "magazine"
	maximum_component_parts = list(/obj/item/stock_parts = 15)

/obj/machinery/disruptor/back_part
	name = "disruptor breech end"
	desc = "An ammo reciever. Munition then goes to disruptor barrel."
	icon_state = "ammo_loader"
	density = FALSE
//	layer = BELOW_DOOR_LAYER //So the charges go above us.

////////////////////////////////CIRCUIT////////////////////////////////

/obj/item/stock_parts/circuitboard/disruptor
	name = T_BOARD("disruptor control")
	build_path = /obj/machinery/computer/ship/disruptor
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)

/obj/item/stock_parts/circuitboard/disruptorfront
	name = T_BOARD("disruptor muzzle")
	build_path = /obj/machinery/disruptor/front_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/manipulator/pico = 5
	)

/obj/item/stock_parts/circuitboard/disruptormiddle
	name = T_BOARD("disruptor barrel")
	build_path = /obj/machinery/disruptor/middle_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/subspace/crystal = 10
	)

/obj/item/stock_parts/circuitboard/disruptorback
	name = T_BOARD("disruptor breech end")
	build_path = /obj/machinery/disruptor/back_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/capacitor/super = 5
	)