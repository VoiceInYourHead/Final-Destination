/obj/machinery/computer/ship/jammer
	name = "jammers console"
	icon_keyboard = "atmos_key"
	icon_screen = "comm_monitor"
	light_color = "#77fff8"
	silicon_restriction = STATUS_UPDATE
	machine_name = "jammers console"
	machine_desc = "Used to activate, monitor, and configure a spaceship's sensor jammers. Higher range means higher temperature; dangerously high temperatures may fry the delicate equipment."
	var/obj/machinery/sensors_jammer/jammer
	var/obj/effect/overmap/jammer/J

/obj/machinery/computer/ship/jammer/attempt_hook_up(obj/effect/overmap/visitable/sector)
	if(!(. = ..()))
		return
	find_jammer()

/obj/machinery/computer/ship/jammer/proc/find_jammer()
	if(!linked)
		return
	for(var/obj/machinery/sensors_jammer/S in SSmachines.machinery)
		if(linked.check_ownership(S))
			jammer = S
			break

/obj/machinery/computer/ship/jammer/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	if(!linked)
		display_reconnect_dialog(user, "jammer")
		return

	var/data[0]

	data["viewing"] = viewing_overmap(user)
	var/mob/living/silicon/silicon = user
	data["viewing_silicon"] = ismachinerestricted(silicon)
	if(jammer)
		data["on"] = jammer.use_power
		data["range"] = jammer.range
		data["health"] = jammer.health
		data["max_health"] = jammer.max_health
		data["heat"] = jammer.heat
		data["critical_heat"] = jammer.critical_heat
		if(jammer.health == 0)
			data["status"] = "DESTROYED"
		else if(!jammer.powered())
			data["status"] = "NO POWER"
		else if(!jammer.in_vacuum())
			data["status"] = "VACUUM SEAL BROKEN"
		else
			data["status"] = "OK"
	else
		data["status"] = "MISSING"
		data["range"] = "N/A"
		data["on"] = 0

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "jammer.tmpl", "[linked.name] Jammer Control", 420, 530, src)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/computer/ship/jammer/OnTopic(var/mob/user, var/list/href_list, state)
	if(..())
		return TOPIC_HANDLED

	if (!linked)
		return TOPIC_NOACTION

	if (href_list["viewing"])
		if(user)
			viewing_overmap(user) ? unlook(user) : look(user)
		return TOPIC_REFRESH

	if (href_list["link"])
		find_jammer()
		return TOPIC_REFRESH

	if(jammer)
		if (href_list["range"])
			var/nrange = input("Set new jammer range", "Jammer range", jammer.range) as num|null
			if(!CanInteract(user,state))
				return TOPIC_NOACTION
			if (nrange)
				jammer.set_range(clamp(nrange, 1, world.view))
			return TOPIC_REFRESH
		if (href_list["toggle"])
			jammer.toggle()
			return TOPIC_REFRESH

/obj/effect/overmap/jammer
	name = "gravity disturbance"
	icon = 'icons/effects/effects.dmi'
	icon_state = "malf-scanline"
	color = "#ffffff"
	known = 0
	var/obj/machinery/computer/ship/jammer/linked_console = null

/obj/effect/overmap/jammer/Process()
	..()
	if(!linked_console)
		linked_console.J = null
		qdel(src)

/obj/machinery/computer/ship/jammer/Process()
	..()
	if(!linked)
		return
	if(jammer && jammer.use_power && jammer.powered())
		if(!J)
			J = new /obj/effect/overmap/jammer(linked.loc)
			J.linked_console = src
		var/jammer_range = round(jammer.range*1.5)
		J.set_light(-1, jammer_range, jammer_range+3, 2, "#ffffff")
		if(J.loc != linked.loc)
			J.forceMove(linked.loc)
	else if(J)
		J.set_light(0)
		qdel(J)

/obj/machinery/sensors_jammer
	name = "jammer suite"
	desc = "Long range gravity disturber with various other systems, used to confuse any gravity scanners that will try to trace something in area. Can only run in vacuum to protect delicate quantum BS elements."
	icon = 'icons/fd/structures/computer.dmi'
	icon_state = "cs_server"
	anchored = TRUE
	density = TRUE
	var/max_health = 150
	var/health = 150
	var/critical_heat = 80 // sparks and takes damage when active & above this heat
	var/heat_reduction = 1 // mitigates this much heat per tick
	var/heat = 0
	var/range = 1
	idle_power_usage = 7500

/obj/machinery/sensors_jammer/attackby(obj/item/W, mob/user)
	var/damage = max_health - health
	if(damage && isWelder(W))

		var/obj/item/weldingtool/WT = W

		if(!WT.isOn())
			return

		if(WT.remove_fuel(0,user))
			to_chat(user, "<span class='notice'>You start repairing the damage to [src].</span>")
			playsound(src, 'sound/items/Welder.ogg', 100, 1)
			if(do_after(user, max(5, damage / 5), src) && WT && WT.isOn())
				to_chat(user, "<span class='notice'>You finish repairing the damage to [src].</span>")
				take_damage(-damage)
		else
			to_chat(user, "<span class='notice'>You need more welding fuel to complete this task.</span>")
			return
		return
	..()

/obj/machinery/sensors_jammer/proc/in_vacuum()
	var/turf/T=get_turf(src)
	if(istype(T))
		var/datum/gas_mixture/environment = T.return_air()
		if(environment && environment.return_pressure() > MINIMUM_PRESSURE_DIFFERENCE_TO_SUSPEND)
			return 0
	return 1

/obj/machinery/sensors_jammer/on_update_icon()
	if(use_power)
		icon_state = "cs_server"
	else
		icon_state = "cs_server_off"

/obj/machinery/sensors_jammer/examine(mob/user)
	. = ..()
	if(health <= 0)
		to_chat(user, "\The [src] is wrecked.")
	else if(health < max_health * 0.25)
		to_chat(user, "<span class='danger'>\The [src] looks like it's about to break!</span>")
	else if(health < max_health * 0.5)
		to_chat(user, "<span class='danger'>\The [src] looks seriously damaged!</span>")
	else if(health < max_health * 0.75)
		to_chat(user, "\The [src] shows signs of damage!")

/obj/machinery/sensors_jammer/bullet_act(var/obj/item/projectile/Proj)
	take_damage(Proj.get_structure_damage())
	..()

/obj/machinery/sensors_jammer/proc/toggle()
	if(!use_power && (health == 0 || !in_vacuum()))
		return // No turning on if broken or misplaced.
	if(!use_power) //need some juice to kickstart
		use_power_oneoff(idle_power_usage*5)
	update_use_power(!use_power)
	queue_icon_update()

/obj/machinery/sensors_jammer/Process()
	if(use_power) //can't run in non-vacuum
		if(!in_vacuum())
			toggle()
		if(heat > critical_heat)
			src.visible_message("<span class='danger'>\The [src] violently spews out sparks!</span>")
			var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
			s.set_up(3, 1, src)
			s.start()

			take_damage(rand(10,50))
			toggle()
		heat += idle_power_usage/150000

	if (heat > 0)
		heat = max(0, heat - heat_reduction)

/obj/machinery/sensors_jammer/power_change()
	. = ..()
	if(use_power && !powered())
		toggle()

/obj/machinery/sensors_jammer/proc/set_range(nrange)
	range = nrange
	change_power_consumption(1500 * (range**2), POWER_USE_IDLE) //Exponential increase, also affects speed of overheating

/obj/machinery/sensors_jammer/emp_act(severity)
	if(!use_power)
		return
	take_damage(20/severity)
	toggle()

/obj/machinery/sensors_jammer/proc/take_damage(value)
	health = min(max(health - value, 0),max_health)
	if(use_power && health == 0)
		toggle()