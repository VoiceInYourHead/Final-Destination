/obj/machinery/magnetic_accelerator
	name = "magnetic accelerator"
	desc = "A magnetic accelerator, built into the floor."
	icon = 'icons/atmos/heat.dmi'
	icon_state = "intact"
	color = "#404040"
	density = FALSE
	layer = ABOVE_TILE_LAYER
	anchored = TRUE
	base_type = /obj/machinery/magnetic_accelerator
	construct_state = /decl/machine_construction/default/panel_closed

	var/use_power = 20000
	var/modifier = 1.2
	var/cooldown = 80
	var/next_throw = 0

//	machine_name = "exosuit dock"
//	machine_desc = "An industrial recharger built into the floor. Exosuits standing on top of the dock will have their power cell recharged."

/obj/machinery/magnetic_accelerator/Crossed(atom/movable/A)
	. = ..()
	if(istype(A) && world.time > next_throw)
		try_accelerate(A)

/obj/machinery/magnetic_accelerator/Process()
	..()
	for(var/atom/movable/A in loc)
		if(istype(A) && world.time > next_throw)
			try_accelerate(A)

/obj/machinery/magnetic_accelerator/proc/try_accelerate(atom/movable/A)
	if(ismob(A) && !issilicon(A))
		return
	if(A.anchored)
		return
	if(stat & (BROKEN|NOPOWER))
		return
	use_power_oneoff(use_power)
	var/atom/target = get_edge_target_turf(src, dir)
	var/mod = modifier
	if(isnull(A.throwing))
		A.throw_at(target, 3, 0.5)
	else
		if(A.dir != src.dir)
			mod = 1
		A.throw_at(target, A.throwing.maxrange * mod, A.throwing.speed * mod, spin = FALSE)
		message_admins("[A.throwing.speed]")
	playsound(loc, 'sound/items/Deconstruct.ogg', 60*A.throwing.speed, 1)
	next_throw = world.time + cooldown