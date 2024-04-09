/// This is a module reactor

/obj/machinery/power/port_gen/pacman/super/module
	name = "industrial nuclear reactor"
	desc = {"ICRER-6, an industrial nuclear fusion reactor powered by sheets of uranium and liquid coolant. \
			This modification has an expanded funnel for fuel and a coolant tank, thanks to the removal of excess lead sheets inside the reactor, sacrificing protection from radiation. \
			Rated for 360 KW maximum safe output on a full coolant tank for one hour. Exceeding this is likely to result in nuclear detonation and is not recommended."}
	icon = 'maps/away/gccv_ulyanovsk/ulyanovsk.dmi'
	icon_state = "potato"
	power_gen = 20000
	max_safe_output = 4
	max_power_output = 8
	temperature_gain = 80
	max_temperature = 450
	rad_power = 10
	time_per_sheet = 500
	atom_flags = ATOM_FLAG_OPEN_CONTAINER
	anchored = TRUE
	machine_name = "\improper ICRER-6 nuclear generator"
	machine_desc = "A nuclear generator that produces a respectable amount of power by processing uranium and industrial coolant. Rated for 360 kW max safe output."
	/// List of our enchancers
	var/list/enchancers = list()
	/// How far we detect modules
	var/range = 1
	/// Volume of coolant inside
	var/coolant_volume = 500
	/// Coolant usage
	var/coolant_use = 0.15
	/// Our coolant
	var/coolant_reagent = /datum/reagent/coolant

/obj/machinery/power/port_gen/pacman/super/module/New()
	create_reagents(coolant_volume)
	..()

/obj/machinery/power/port_gen/pacman/super/module/examine(mob/user)
	. = ..()
	to_chat(user, "Auxilary tank shows [reagents.total_volume]u of liquid in it.")

/obj/machinery/power/port_gen/pacman/super/module/UseFuel()
	if(reagents.has_reagent(coolant_reagent))
		temperature_gain -= 50
		if(temperature_gain < 10)
			temperature_gain = 10
		reagents.remove_any(coolant_use)
	else
		temperature_gain = initial(temperature_gain)
	..()

/obj/machinery/power/port_gen/pacman/super/module/on_update_icon()
	if(..())
		return 1
	if(power_output > max_safe_output)
		icon_state = "potatodanger"

/obj/machinery/power/port_gen/pacman/super/module/explode()
	var/rads = rad_power*10 + (sheets + sheet_left)
	SSradiation.radiate(src, (max(30, rads)))
	for(var/obj/machinery/reactor_enchancer/enchancer in enchancers)
		if(!enchancer)
			return
		enchancer.reactor = null
		enchancer.improved = FALSE
	cell_explosion(src.loc, rad_power * 4, 15)
	qdel(src)

/obj/machinery/power/port_gen/pacman/super/module/Initialize()
	. = ..()
	enchancer_found()

/obj/machinery/power/port_gen/pacman/super/module/Process()
	..()

/obj/machinery/power/port_gen/pacman/super/module/Destroy()
	for(var/obj/machinery/reactor_enchancer/enchancer in enchancers)
		if(!enchancer)
			return
		enchancer.reactor = null
		enchancer.improved = FALSE
	. = ..()

/obj/machinery/power/port_gen/pacman/super/module/attackby(var/obj/item/O, var/mob/user)
	if(istype(O, /obj/item/device/multitool))
		enchancer_found()
		to_chat(user, "Connecting [src] with modules...")
	..()

/obj/machinery/power/port_gen/pacman/super/module/proc/enchancer_found()
	for(var/obj/machinery/reactor_enchancer/enchancer in orange(range,src))
		if(!enchancer)
			return
		if(!enchancer.reactor)
			enchancer.reactor = src
			enchancers += enchancer
		if(enchancer.reactor != src)
			return
		enchancer.improve()

/// ENCHANCER

/obj/machinery/reactor_enchancer
	name = "ICRER-6 Efficiency Improver"
	desc = "An improvement for the reactor that increases its performance when located directly near the reactor."
	icon = 'maps/away/gccv_ulyanovsk/ulyanovsk.dmi'
	icon_state = "ench"
	idle_power_usage = 1000
	power_channel = ENVIRON
	density = FALSE
	anchored = TRUE
	construct_state = /decl/machine_construction/default/panel_closed
	maximum_component_parts = list(/obj/item/stock_parts = 15)
	base_type = /obj/machinery/reactor_enchancer
	/// Reactor that is connected to enchancer
	var/obj/machinery/power/port_gen/pacman/super/module/reactor
	/// Modifier for enchancing reactor
	var/modifier = 1
	/// We upgraded reactor?
	var/improved = FALSE

/obj/machinery/reactor_enchancer/proc/IsBroken()
	return (stat & (BROKEN|EMPED|MACHINE_BROKEN_NO_PARTS))

/obj/machinery/reactor_enchancer/proc/NoPower()
	return (stat & NOPOWER)

/obj/machinery/reactor_enchancer/proc/IsActive()
	if(IsBroken() || NoPower() || stat == MAINT)
		return
	return TRUE

/obj/machinery/reactor_enchancer/attackby(var/obj/item/O, var/mob/user, var/obj/machinery/power/port_gen/pacman/super/module/R)
	if(reactor)
		to_chat(user, "Can't interact with [src] while \the [reactor] is assembled.")
		return
	..()

/obj/machinery/reactor_enchancer/proc/improve() //improve reactor proc
	if(!IsActive())
		return
	if(reactor && improved) //check if we already improved this reactor
		return
	upgrade()
	improved = TRUE

/obj/machinery/reactor_enchancer/proc/upgrade(var/unimprove)
	if(reactor.power_gen >= 60000)
		if(unimprove)
			reactor.power_gen -= 5000
			return
		reactor.power_gen += 5000
	if(unimprove)
		reactor.power_gen -= 15000
		return
	reactor.power_gen += 15000

/obj/machinery/reactor_enchancer/Destroy()
	upgrade(TRUE)
	. = ..()

/// MODULES

/obj/machinery/reactor_enchancer/radiation
	name = "ICRER-6 Radiation Module"
	icon_state = "ench_rad"

/obj/machinery/reactor_enchancer/radiation/upgrade(unimprove)
	if(unimprove)
		reactor.rad_power -= 5
		return
	reactor.rad_power += 5

/obj/machinery/reactor_enchancer/range
	name = "ICRER-6 Range Module"
	icon_state = "ench_range"

/obj/machinery/reactor_enchancer/range/upgrade(unimprove)
	if(unimprove)
		reactor.range -= 1
		return
	if(reactor.range >= 4)
		return
	reactor.range += 1

/obj/machinery/reactor_enchancer/fuel_efficiency
	name = "ICRER-6 Fuel Efficiency Module"
	icon_state = "ench_fuel"

/obj/machinery/reactor_enchancer/fuel_efficiency/upgrade(unimprove)
	if(unimprove)
		reactor.time_per_sheet -= 30
		return
	reactor.time_per_sheet += 30

/obj/machinery/reactor_enchancer/coolant_tank
	name = "ICRER-6 Coolant Tank Module"
	icon_state = "ench_coolant"

/obj/machinery/reactor_enchancer/coolant_tank/upgrade(unimprove)
	if(unimprove)
		reactor.reagents.maximum_volume -= 30
		return
	reactor.reagents.maximum_volume += 30

/// CIRCUIT

/obj/item/stock_parts/circuitboard/pacman/super/module
	name = T_BOARD("ICRER-6 nuclear generator")
	icon = 'maps/away/gccv_ulyanovsk/ulyanovsk.dmi'
	icon_state = "reactor_board"
	build_path = /obj/machinery/power/port_gen/pacman/super/module
	origin_tech = list(TECH_DATA = 4, TECH_POWER = 5, TECH_ENGINEERING = 5)

/obj/item/stock_parts/circuitboard/pacman/super/module/enchancer
	name = T_BOARD("ICRER-6 Efficiency Improver")
	icon = 'maps/away/gccv_ulyanovsk/ulyanovsk.dmi'
	icon_state = "enchancer_board"
	build_path = /obj/machinery/reactor_enchancer
	origin_tech = list(TECH_DATA = 5, TECH_POWER = 6, TECH_ENGINEERING = 3)
	req_components = list(
		/obj/item/stock_parts/matter_bin/super = 3,
		/obj/item/stock_parts/micro_laser = 3,
		/obj/item/stack/cable_coil = 60,
		/obj/item/stock_parts/scanning_module = 1)
	additional_spawn_components = list(
		/obj/item/stock_parts/console_screen = 1,
		/obj/item/stock_parts/keyboard = 1,
		/obj/item/stock_parts/power/apc/buildable = 1
	)
