/// Float. The atom's explosion resistance value. Used to calculate how much of an explosion is 'absorbed' and not passed on to tiles on the other side of the atom's turf. See `/proc/explosion_rec()`.
/atom/var/explosion_resistance = 0

/**
 * Retrieves the atom's explosion resistance. Generally, this is `explosion_resistance` for simulated atoms.
 */
/atom/proc/get_explosion_resistance()
	if(simulated)
		return explosion_resistance
	return explosion_resistance

/turf/get_explosion_resistance()
	. = ..()
	for(var/obj/O in src)
		. += O.get_explosion_resistance()

/turf/space/explosion_resistance = 2

/turf/simulated/floor/get_explosion_resistance()
	. = ..()
	if(is_below_sound_pressure(src))
		. *= 1.5

/turf/simulated/wall/get_explosion_resistance()
	return 5 // Standardized health results in explosion_resistance being used to reduce overall damage taken, instead of changing explosion severity. 5 was the original default, so 5 is always returned here.

/turf/simulated/explosion_resistance = 1

/turf/simulated/floor/explosion_resistance = 1

/turf/simulated/mineral/explosion_resistance = 2

/turf/simulated/shuttle/wall/explosion_resistance = 10

/turf/simulated/wall/explosion_resistance = 10

/turf/unsimulated/floor/explosion_resistance = 1

/obj/machinery/door/get_explosion_resistance()
	if(!density)
		return 0
	else
		return ..()
