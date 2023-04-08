/obj/machinery/particle_lance
	icon = 'icons/obj/disperser.dmi'
	density = TRUE
	anchored = TRUE
	construct_state = /decl/machine_construction/default/panel_closed

/obj/machinery/particle_lance/examine(mob/user)
	. = ..()
	if(panel_open)
		to_chat(user, "The maintenance panel is open.")

/obj/machinery/particle_lance/attackby(obj/item/I, mob/user)
	if(isWrench(I))
		if(panel_open)
			user.visible_message("<span class='notice'>\The [user] rotates \the [src] with \the [I].</span>", "<span class='notice'>You rotate \the [src] with \the [I].</span>")
			set_dir(turn(dir, 90))
			playsound(src, 'sound/items/jaws_pry.ogg', 50, 1)
		else
			to_chat(user,"<span class='notice'>The maintenance panel must be screwed open for this!</span>")
	else
		return ..()

/obj/machinery/particle_lance/front_part
	name = "particle lance muzzle"
	desc = "An particle beam muzzle."
	icon_state = "front"
	color = COLOR_PURPLE

/obj/machinery/particle_lance/middle_part
	name = "particle lance barrel"
	desc = "A gas tube that propels munitions to the particle beam muzzle."
	icon_state = "middle"
	color = COLOR_PURPLE
	maximum_component_parts = list(/obj/item/stock_parts = 15)

/obj/machinery/particle_lance/back_part
	name = "particle lance charger"
	desc = "An ammo reciever. Munition then goes to particle beam barrel."
	icon_state = "back"
	density = FALSE
	color = COLOR_PURPLE
//	layer = BELOW_DOOR_LAYER //So the charges go above us.

////////////////////////////////CIRCUIT////////////////////////////////

/obj/item/stock_parts/circuitboard/particle_lance
	name = T_BOARD("particle lance control")
	build_path = /obj/machinery/computer/ship/particle_lance
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)

/obj/item/stock_parts/circuitboard/particle_lancefront
	name = T_BOARD("particle lance muzzle")
	build_path = /obj/machinery/particle_lance/front_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 5, TECH_COMBAT = 6)
	req_components = list (
		/obj/item/stack/material/diamond = 10
	)

/obj/item/stock_parts/circuitboard/particle_lancemiddle
	name = T_BOARD("particle lance barrel")
	build_path = /obj/machinery/particle_lance/middle_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 5, TECH_COMBAT = 6)
	req_components = list (
		/obj/item/stock_parts/micro_laser/ultra = 10
	)

/obj/item/stock_parts/circuitboard/particle_lanceback
	name = T_BOARD("particle lance charger")
	build_path = /obj/machinery/particle_lance/back_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 5, TECH_COMBAT = 6)
	req_components = list (
		/obj/item/stock_parts/smes_coil/super_io = 5
	)
