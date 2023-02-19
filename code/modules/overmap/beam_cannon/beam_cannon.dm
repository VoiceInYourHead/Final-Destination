/obj/machinery/beam_cannon
	icon = 'icons/obj/disperser.dmi'
	density = TRUE
	anchored = TRUE
	construct_state = /decl/machine_construction/default/panel_closed

/obj/machinery/beam_cannon/examine(mob/user)
	. = ..()
	if(panel_open)
		to_chat(user, "The maintenance panel is open.")

/obj/machinery/beam_cannon/attackby(obj/item/I, mob/user)
	if(isWrench(I))
		if(panel_open)
			user.visible_message("<span class='notice'>\The [user] rotates \the [src] with \the [I].</span>", "<span class='notice'>You rotate \the [src] with \the [I].</span>")
			set_dir(turn(dir, 90))
			playsound(src, 'sound/items/jaws_pry.ogg', 50, 1)
		else
			to_chat(user,"<span class='notice'>The maintenance panel must be screwed open for this!</span>")
	else
		return ..()

/obj/machinery/beam_cannon/front_part
	name = "ion beam emitter muzzle"
	desc = "An ion beam muzzle.\
		<br>A sign on it reads: <i>STAY CLEAR! DO NOT BLOCK!</i>"
	icon_state = "front"

/obj/machinery/beam_cannon/middle_part
	name = "ion beam emitter barrel"
	desc = "A gas tube that propels munitions to the ion beam muzzle. \
		<br>A sign on it reads: <i>EXPLOSIVE! DO NOT OVERHEAT!</i>"
	icon_state = "middle"
	maximum_component_parts = list(/obj/item/stock_parts = 15)

/obj/machinery/beam_cannon/back_part
	name = "ion beam emitter charger"
	desc = "An ammo reciever. Munition then goes to ion beam barrel."
	icon_state = "back"
	density = FALSE
//	layer = BELOW_DOOR_LAYER //So the charges go above us.

////////////////////////////////CIRCUIT////////////////////////////////

/obj/item/stock_parts/circuitboard/beam_cannon
	name = T_BOARD("ion beam emitter control")
	build_path = /obj/machinery/computer/ship/beam_cannon
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)

/obj/item/stock_parts/circuitboard/beam_cannonfront
	name = T_BOARD("ion beam emitter muzzle")
	build_path = /obj/machinery/beam_cannon/front_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/manipulator/pico = 5
	)

/obj/item/stock_parts/circuitboard/beam_cannonmiddle
	name = T_BOARD("ion beam emitter barrel")
	build_path = /obj/machinery/beam_cannon/middle_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/subspace/crystal = 10
	)

/obj/item/stock_parts/circuitboard/beam_cannonback
	name = T_BOARD("ion beam emitter charger")
	build_path = /obj/machinery/beam_cannon/back_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/capacitor/super = 5
	)