/obj/item/stock_parts/circuitboard/autocannon
	name = T_BOARD("autocannon control")
	build_path = /obj/machinery/computer/ship/autocannon
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)

/obj/item/stock_parts/circuitboard/autocannonfront
	name = T_BOARD("autocannon turret")
	build_path = /obj/machinery/disperser/autocannon/front
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/manipulator/pico = 5
	)

/obj/item/stock_parts/circuitboard/autocannonmiddle
	name = T_BOARD("autocannon breech end")
	build_path = /obj/machinery/disperser/autocannon/middle
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/subspace/crystal = 10
	)

/obj/item/stock_parts/circuitboard/autocannonback
	name = T_BOARD("autocannon munition rack")
	build_path = /obj/machinery/disperser/autocannon/back
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/capacitor/super = 5
	)