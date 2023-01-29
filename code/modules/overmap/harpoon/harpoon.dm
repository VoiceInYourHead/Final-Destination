/obj/machinery/harpoon_cannon
	icon = 'icons/obj/disperser.dmi'
	density = TRUE
	anchored = TRUE
	construct_state = /decl/machine_construction/default/panel_closed

/obj/machinery/harpoon_cannon/examine(mob/user)
	. = ..()
	if(panel_open)
		to_chat(user, "The maintenance panel is open.")

/obj/machinery/harpoon_cannon/attackby(obj/item/I, mob/user)
	if(isWrench(I))
		if(panel_open)
			user.visible_message("<span class='notice'>\The [user] rotates \the [src] with \the [I].</span>", "<span class='notice'>You rotate \the [src] with \the [I].</span>")
			set_dir(turn(dir, 90))
			playsound(src, 'sound/items/jaws_pry.ogg', 50, 1)
		else
			to_chat(user,"<span class='notice'>The maintenance panel must be screwed open for this!</span>")
	else
		return ..()

/obj/machinery/harpoon_cannon/front_part
	name = "harpoon cannon muzzle"
	desc = "An old-fashion harpoon cannon muzzle.\
		<br>A sign on it reads: <i>STAY CLEAR! DO NOT BLOCK!</i>"
	icon_state = "front"

/obj/machinery/harpoon_cannon/middle_part
	name = "harpoon cannon rail"
	desc = "An old-fashion gas tube that propels munitions to the cannon muzzle. \
		<br>A sign on it reads: <i>EXPLOSIVE! DO NOT OVERHEAT!</i>"
	icon_state = "middle"
	maximum_component_parts = list(/obj/item/stock_parts = 15)

/obj/machinery/harpoon_cannon/back_part
	name = "harpoon cannon munition rack"
	desc = "An old-fashion ammo reciever. Munition then goes to cannon rail."
	icon_state = "back"
	density = FALSE
//	layer = BELOW_DOOR_LAYER //So the charges go above us.

////////////////////////////////CIRCUIT////////////////////////////////

/obj/item/stock_parts/circuitboard/harpoon
	name = T_BOARD("harpoon cannon control")
	build_path = /obj/machinery/computer/ship/harpoon_gun
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)

/obj/item/stock_parts/circuitboard/harpoonfront
	name = T_BOARD("harpoon cannon muzzle")
	build_path = /obj/machinery/harpoon_cannon/front_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/manipulator/pico = 5
	)

/obj/item/stock_parts/circuitboard/harpoonmiddle
	name = T_BOARD("harpoon cannon rail")
	build_path = /obj/machinery/harpoon_cannon/middle_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/subspace/crystal = 10
	)

/obj/item/stock_parts/circuitboard/harpoonback
	name = T_BOARD("harpoon cannon munition rack")
	build_path = /obj/machinery/harpoon_cannon/back_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/capacitor/super = 5
	)