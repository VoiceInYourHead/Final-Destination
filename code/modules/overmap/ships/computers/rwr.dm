/obj/machinery/computer/ship/rwr
	name = "AN/ALG-1984 Grav Warning Reciver Console"
	machine_name = "AN/ALG-1984 Grav Warning Reciver Console"
	machine_desc = "Консоль радио-технической разведки, предназначенная для предупреждения о пусках противокорабельных ракет или подобных излучений."

	icon_keyboard = "teleport_key"
	icon_screen = "teleport"
	light_color = "#77fff8"
	extra_view = 4

	var/annonced_n = 0

	var/datum/gravitional_signal/main = null

	var/datum/gravitional_signal/second = null

/datum/gravitional_signal
	var/obj/effect/overmap/signal_out
	var/signal_level
	var/anonced = FALSE

/obj/machinery/computer/ship/rwr/attempt_hook_up(obj/effect/overmap/visitable/ship/sector)
	if(!(. = ..()))
		return
	connect_rwr()

/obj/machinery/computer/ship/rwr/proc/connect_rwr()
	if (!linked)
		return

	for(var/obj/machinery/computer/ship/rwr/S in SSmachines.machinery)
		if(linked.check_ownership(S))
			linked.rwr_console = S
			break

/obj/machinery/computer/ship/rwr/Process()
	..()

	if (!main || !linked)
		return

	if ( !main.anonced && get_turf(main.signal_out))
		if ( main.signal_level == 3 )

			var/bearing = round(90 - Atan2(main.signal_out.x - linked.x, main.signal_out.y - linked.y),30)

			playsound(loc, "sound/machines/sensors/contact_lost.ogg", 50, 1)

			GLOB.global_announcer.autosay("РАКЕТА! НА. [bearing].", name, "Command")

			main.anonced = TRUE
		if( main.signal_level == 2 )
			var/bearing = round(90 - Atan2(main.signal_out.x - linked.x, main.signal_out.y - linked.y),30)

			playsound(loc, "sound/machines/sensors/newcontact.ogg", 50, 1)

			GLOB.global_announcer.autosay("ЗАХВАТ. НА. [bearing].", name, "Command")

			main.anonced = TRUE
		if( main.signal_level == 1 )
			GLOB.global_announcer.autosay("ПОИСК.", name, "Command")
			main.anonced = TRUE

/obj/machinery/computer/ship/rwr/proc/analyze_warn(var/obj/effect/overmap/sender, var/warn_type)

	var/datum/gravitional_signal/new_signal = new /datum/gravitional_signal()
	new_signal.signal_out = sender
	new_signal.signal_level = warn_type

	if (!linked)
		return

	main = new_signal
