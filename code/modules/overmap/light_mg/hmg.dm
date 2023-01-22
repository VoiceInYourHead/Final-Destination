/obj/machinery/hmg
	icon = 'icons/obj/disperser.dmi'
	density = TRUE
	anchored = TRUE
	construct_state = /decl/machine_construction/default/panel_closed

/obj/machinery/hmg/front_part
	name = "HMG turret"
	desc = "An old-fashion ship autocannon tower.\
		<br>A sign on it reads: <i>STAY CLEAR! DO NOT BLOCK!</i>"
	icon_state = "gun"

/obj/machinery/hmg/middle_part
	name = "HMG breech end"
	desc = "An old-fashion ammo reciever that sends it to the autocannon tower. \
		<br>A sign on it reads: <i>EXPLOSIVE! DO NOT OVERHEAT!</i>"
	icon_state = "magazine"
	maximum_component_parts = list(/obj/item/stock_parts = 15)

/obj/machinery/hmg/back_part
	name = "HMG munition rack"
	desc = "An old-fashion ammo reciever. Munition then goes to autocannon breech end."
	icon_state = "ammo_loader"
	density = FALSE

////////////////////////////////CIRCUIT////////////////////////////////

/obj/item/stock_parts/circuitboard/heavymg
	name = T_BOARD("machine gun control")
	build_path = /obj/machinery/computer/ship/hmg
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)

/obj/item/stock_parts/circuitboard/heavymgfront
	name = T_BOARD("machine gun turret")
	build_path = /obj/machinery/hmg/front_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/manipulator/pico = 5
	)

/obj/item/stock_parts/circuitboard/heavymgmiddle
	name = T_BOARD("machine gun breech end")
	build_path = /obj/machinery/hmg/middle_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/subspace/crystal = 10
	)

/obj/item/stock_parts/circuitboard/heavymgback
	name = T_BOARD("machine gun munition rack")
	build_path = /obj/machinery/hmg/back_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/capacitor/super = 5
	)