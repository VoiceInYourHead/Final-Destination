/obj/machinery/harpoon_cannon
	icon = 'icons/obj/disperser.dmi'

/obj/machinery/harpoon_cannon/front_part
	name = "harpoon gun barrel"
	desc = "An old-fashion ship autocannon tower.\
		<br>A sign on it reads: <i>STAY CLEAR! DO NOT BLOCK!</i>"
	icon_state = "front"

/obj/machinery/harpoon_cannon/middle_part
	name = "harpoon gun rail"
	desc = "An old-fashion ammo reciever that sends it to the autocannon tower. \
		<br>A sign on it reads: <i>EXPLOSIVE! DO NOT OVERHEAT!</i>"
	icon_state = "middle"
	maximum_component_parts = list(/obj/item/stock_parts = 15)

/obj/machinery/harpoon_cannon/back_part
	name = "harpoon gun munition rack"
	desc = "An old-fashion ammo reciever. Munition then goes to autocannon breech end."
	icon_state = "back"
	density = FALSE
//	layer = BELOW_DOOR_LAYER //So the charges go above us.

////////////////////////////////CIRCUIT////////////////////////////////

/obj/item/stock_parts/circuitboard/harpoon
	name = T_BOARD("harpoon gun control")
	build_path = /obj/machinery/computer/ship/harpoon_gun
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)

/obj/item/stock_parts/circuitboard/harpoonfront
	name = T_BOARD("harpoon gun barrel")
	build_path = /obj/machinery/harpoon_cannon/front_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/manipulator/pico = 5
	)

/obj/item/stock_parts/circuitboard/harpoonmiddle
	name = T_BOARD("harpoon gun rail")
	build_path = /obj/machinery/harpoon_cannon/middle_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/subspace/crystal = 10
	)

/obj/item/stock_parts/circuitboard/harpoonback
	name = T_BOARD("harpoon gun munition rack")
	build_path = /obj/machinery/harpoon_cannon/back_part
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/capacitor/super = 5
	)