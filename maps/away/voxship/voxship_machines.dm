/obj/machinery/computer/ship/sensors/vox
	construct_state = /decl/machine_construction/default/panel_closed/computer/no_deconstruct
	base_type = /obj/machinery/computer/ship/sensors
	print_language = LANGUAGE_VOX

/obj/machinery/atmospherics/unary/engine/vox/check_blockage()
	return FALSE

/obj/machinery/power/smes/buildable/preset/voxship/ship
	uncreated_component_parts = list(
		/obj/item/stock_parts/smes_coil/super_capacity = 1,
		/obj/item/stock_parts/smes_coil/super_io = 3
	)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

/obj/machinery/power/port_gen/pacman/super/potato/reactor/vox
	power_gen = 9000