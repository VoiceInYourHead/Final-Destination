/obj/item/stock_parts/circuitboard/harpoon
	name = T_BOARD("harpoon gun control")
	build_path = /obj/machinery/computer/ship/autocannon
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)

/obj/item/stock_parts/circuitboard/harpoonfront
	name = T_BOARD("harpoon gun barrel")
	build_path = /obj/machinery/autocannon/harpoon/front
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/manipulator/pico = 5
	)

/obj/item/stock_parts/circuitboard/harpoonmiddle
	name = T_BOARD("harpoon gun rail")
	build_path = /obj/machinery/autocannon/harpoon/middle
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/subspace/crystal = 10
	)

/obj/item/stock_parts/circuitboard/harpoonback
	name = T_BOARD("harpoon gun munition rack")
	build_path = /obj/machinery/autocannon/harpoon/back
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_COMBAT = 2)
	req_components = list (
		/obj/item/stock_parts/capacitor/super = 5
	)