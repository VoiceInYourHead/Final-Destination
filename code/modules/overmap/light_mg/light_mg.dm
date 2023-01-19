/obj/machinery/light_mg
	icon = 'icons/obj/disperser.dmi'

/obj/machinery/light_mg/front
	name = "LMG turret"
	desc = "An old-fashion ship autocannon tower.\
		<br>A sign on it reads: <i>STAY CLEAR! DO NOT BLOCK!</i>"
	icon_state = "gun"

/obj/machinery/light_mg/middle
	name = "LMG breech end"
	desc = "An old-fashion ammo reciever that sends it to the autocannon tower. \
		<br>A sign on it reads: <i>EXPLOSIVE! DO NOT OVERHEAT!</i>"
	icon_state = "magazine"
	maximum_component_parts = list(/obj/item/stock_parts = 15)

/obj/machinery/light_mg/back
	name = "LMG munition rack"
	desc = "An old-fashion ammo reciever. Munition then goes to autocannon breech end."
	icon_state = "ammo_loader"
	density = FALSE

////////////////////////////////CIRCUIT////////////////////////////////

/obj/item/stock_parts/circuitboard/light_mg
	name = T_BOARD("machine gun control")
	build_path = /obj/machinery/computer/ship/light_mg
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)

/obj/item/stock_parts/circuitboard/light_mgfront
	name = T_BOARD("machine gun turret")
	build_path = /obj/machinery/light_mg/front
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/manipulator/pico = 5
	)

/obj/item/stock_parts/circuitboard/light_mgmiddle
	name = T_BOARD("machine gun breech end")
	build_path = /obj/machinery/light_mg/middle
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/subspace/crystal = 10
	)

/obj/item/stock_parts/circuitboard/light_mgback
	name = T_BOARD("machine gun munition rack")
	build_path = /obj/machinery/light_mg/back
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/capacitor/super = 5
	)