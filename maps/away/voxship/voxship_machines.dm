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
	name = "nuclear reactor"
	desc = "ICRER-2-V, an industrial-yet-compact nuclear fusion reactor powered by sheets of uranium and liquid coolant. Rated for 540 KW maximum safe output on a full coolant tank for one hour. Exceeding this is likely to result in nuclear detonation and is not recommended. Modificated by Voxs"
	icon_state = "potato"
	max_safe_output = 5
	max_power_output = 8
	temperature_gain = 70
	max_temperature = 500
	rad_power = 8
	coolant_use = 0.2
	coolant_volume = 360
	power_gen = 90000
	coolant_reagent = /datum/reagent/coolant
	machine_name = "\improper ICRER-2-V nuclear generator"
	machine_desc = "A standard nuclear generator that produces a respectable amount of power by processing uranium and industrial coolant. Rated for 540 kW max safe output. Modificated by Voxs"
