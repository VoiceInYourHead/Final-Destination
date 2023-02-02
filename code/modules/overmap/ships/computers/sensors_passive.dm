/obj/machinery/computer/ship/sensors_passive
	name = "passive sensors console"
	icon_keyboard = "teleport_key"
	icon_screen = "teleport"
	light_color = "#77fff8"
	extra_view = 4
	silicon_restriction = STATUS_UPDATE
	machine_name = "passive sensors console"
	machine_desc = "Used to activate, monitor, and configure a spaceship's passive sensors. Higher range means higher temperature; dangerously high temperatures may fry the delicate equipment."
	var/print_language = LANGUAGE_HUMAN_EURO
	var/weakref/sensor_ref
	var/list/last_scan
	var/tmp/muted = FALSE
	var/working_sound = 'sound/machines/sensors/dradis.ogg'
	var/datum/sound_token/sound_token
	var/sound_id

/obj/machinery/computer/ship/sensors_passive/proc/get_sensors()
	var/obj/machinery/shipsensors_passive/sensors = sensor_ref?.resolve()
	if(!istype(sensors) || QDELETED(sensors))
		sensor_ref = null
	return sensors

/obj/machinery/computer/ship/sensors_passive/attempt_hook_up(obj/effect/overmap/visitable/ship/sector)
	if(!(. = ..()))
		return
	find_sensors()

/obj/machinery/computer/ship/sensors_passive/proc/find_sensors()
	if(!linked)
		return
	for(var/obj/machinery/shipsensors_passive/S in SSmachines.machinery)
		if(linked.check_ownership(S))
			sensor_ref = weakref(S)
			break

/obj/machinery/computer/ship/sensors_passive/proc/update_sound()
	if(!working_sound)
		return
	if(!sound_id)
		sound_id = "[type]_[sequential_id(/obj/machinery/computer/ship/sensors_passive)]"

	var/obj/machinery/shipsensors_passive/sensors = get_sensors()
	if(linked && sensors?.use_power && !(sensors.stat & NOPOWER))
		var/volume = 10
		if(!sound_token)
			sound_token = GLOB.sound_player.PlayLoopingSound(src, sound_id, working_sound, volume = volume, range = 10)
		sound_token.SetVolume(volume)
	else if(sound_token)
		QDEL_NULL(sound_token)

/obj/machinery/computer/ship/sensors_passive/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	if(!linked)
		display_reconnect_dialog(user, "sensors")
		return

	var/data[0]

	var/obj/machinery/shipsensors_passive/sensors = get_sensors()
	data["viewing"] = viewing_overmap(user)
	data["muted"] = muted
	if(sensors)
		data["on"] = sensors.use_power
		data["range"] = sensors.range
		data["heat"] = sensors.heat
		data["health"] = sensors.health
		data["max_health"] = sensors.max_health
		data["critical_heat"] = sensors.critical_heat
		if(sensors.health == 0)
			data["status"] = "DESTROYED"
		else if(!sensors.powered())
			data["status"] = "NO POWER"
		else
			data["status"] = "OK"
		var/list/contacts = list()

		var/list/potential_contacts = list()

		for(var/obj/effect/overmap/nearby in view(7,linked))
			if(nearby.requires_contact) // Some ships require.
				continue
			potential_contacts |= nearby

		// Effects that require contact are only added to the contacts if they have been identified.
		// Allows for coord tracking out of range of the player's view.
		for(var/obj/effect/overmap/visitable/identified_contact in contact_datums)
			potential_contacts |= identified_contact

		for(var/obj/effect/overmap/O in potential_contacts)
			if(linked == O)
				continue
			if(!O.scannable)
				continue
			var/bearing = round(90 - Atan2(O.x - linked.x, O.y - linked.y),5)
			if(bearing < 0)
				bearing += 360
			contacts.Add(list(list("name"=O.name, "color"= O.color, "ref"="\ref[O]", "bearing"=bearing)))
		if(contacts.len)
			data["contacts"] = contacts
		data["last_scan"] = last_scan
	else
		data["status"] = "MISSING"
		data["range"] = "N/A"
		data["on"] = 0

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "shipsensors.tmpl", "[linked.name] Passive Sensors Control", 420, 530, nref = src)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/computer/ship/sensors_passive/OnTopic(var/mob/user, var/list/href_list, state)
	if(..())
		return TOPIC_HANDLED

	if (!linked)
		return TOPIC_NOACTION

	if (href_list["viewing"])
		if(user && !isAI(user))
			viewing_overmap(user) ? unlook(user) : look(user)
		return TOPIC_REFRESH

	if (href_list["link"])
		find_sensors()
		return TOPIC_REFRESH

	if (href_list["mute"])
		muted = !muted
		return TOPIC_REFRESH

	var/obj/machinery/shipsensors_passive/sensors = get_sensors()
	if(sensors)
		if (href_list["range"])
			var/nrange = input("Set new sensors range", "Sensor range", sensors.range) as num|null
			if(!CanInteract(user,state))
				return TOPIC_NOACTION
			if (nrange)
				sensors.set_range(clamp(nrange, 1, 5))
			return TOPIC_REFRESH
		if (href_list["toggle"])
			sensors.toggle()
			return TOPIC_REFRESH

	if (href_list["scan"])
		var/obj/effect/overmap/O = locate(href_list["scan"])
		if(istype(O) && !QDELETED(O))
			if((O in view(5,linked))|| (O in contact_datums))
				playsound(loc, "sound/effects/ping.ogg", 50, 1)
				LAZYSET(last_scan, "location", "[O.x],[O.y]")
				LAZYSET(last_scan, "name", "[O]")
				to_chat(user, SPAN_NOTICE("Successfully scanned [O]."))
				return TOPIC_HANDLED

		to_chat(user, SPAN_WARNING("Could not get a scan!"))
		return TOPIC_HANDLED

	if (href_list["print"])
		playsound(loc, "sound/machines/dotprinter.ogg", 30, 1)
		new/obj/item/paper/(get_turf(src), last_scan["data"], "paper (Sensor Scan - [last_scan["name"]])", L = print_language)
		return TOPIC_HANDLED

/obj/machinery/shipsensors_passive
	name = "passive sensors suite"
	desc = "Long range gravity scanner with various other sensors, used to detect irregularities in surrounding space. Can only run in vacuum to protect delicate quantum BS elements."
	icon = 'icons/fd/structures/computer.dmi'
	icon_state = "cs_server"
	anchored = TRUE
	density = TRUE
	var/critical_heat = 70 // sparks and takes damage when active & above this heat
	var/heat_reduction = 1.5 // mitigates this much heat per tick
	var/heat = 0
	var/range = 1
	var/sensor_strength //used for detecting ships via contacts
	idle_power_usage = 3000
	var/health = 500
	var/max_health = 500

/obj/machinery/shipsensors_passive/attackby(obj/item/W, mob/user)
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

/obj/machinery/shipsensors_passive/examine(mob/user)
	. = ..()
	if(health <= 0)
		to_chat(user, "\The [src] is wrecked.")
	else if(health < max_health * 0.25)
		to_chat(user, "<span class='danger'>\The [src] looks like it's about to break!</span>")
	else if(health < max_health * 0.5)
		to_chat(user, "<span class='danger'>\The [src] looks seriously damaged!</span>")
	else if(health < max_health * 0.75)
		to_chat(user, "\The [src] shows signs of damage!")

/obj/machinery/shipsensors_passive/bullet_act(var/obj/item/projectile/Proj)
	take_damage(Proj.get_structure_damage())
	..()

/obj/machinery/shipsensors_passive/on_update_icon()
	if(use_power)
		icon_state = "cs_server"
	else
		icon_state = "cs_server_off"

/obj/machinery/shipsensors_passive/proc/toggle()
	if(!use_power && (health == 0))
		return // No turning on if broken or misplaced.
	if(!use_power) //need some juice to kickstart
		use_power_oneoff(idle_power_usage*5)
	update_use_power(!use_power)
	queue_icon_update()

/obj/machinery/shipsensors_passive/Process()
	if(use_power) //can't run in non-vacuum
		toggle()
		if(heat > critical_heat)
			src.visible_message("<span class='danger'>\The [src] violently spews out sparks!</span>")
			var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
			s.set_up(3, 1, src)
			s.start()
			take_damage(rand(10,50))
			toggle()
		heat += idle_power_usage/15000

	if (heat > 0)
		heat = max(0, heat - heat_reduction)

/obj/machinery/shipsensors_passive/power_change()
	. = ..()
	if(use_power && (stat & NOPOWER))
		toggle()

/obj/machinery/shipsensors_passive/proc/set_range(nrange)
	range = nrange
	change_power_consumption(1500 * (range**2), POWER_USE_IDLE) //Exponential increase, also affects speed of overheating

/obj/machinery/shipsensors_passive/emp_act(severity)
	if(!use_power)
		return
	take_damage(20/severity)
	toggle()
	..()

/obj/machinery/shipsensors_passive/proc/take_damage(value)
	health = min(max(health - value, 0),max_health)
	if(use_power && health == 0)
		toggle()

/obj/machinery/shipsensors_passive/RefreshParts()
	..()
	sensor_strength = clamp(total_component_rating_of_type(/obj/item/stock_parts/manipulator), 0, 5)

//PRESETS

/obj/machinery/shipsensors_passive/weak
	heat_reduction = 0.2
	desc = "Miniturized gravity scanner with various other sensors, used to detect irregularities in surrounding space. Can only run in vacuum to protect delicate quantum BS elements."