/// Float. The atom's explosion resistance value. Used to calculate how much of an explosion is 'absorbed' and not passed on to tiles on the other side of the atom's turf. See `/proc/explosion_rec()`.
/atom/var/explosion_resistance = 0

/**
 * Retrieves the atom's explosion resistance. Generally, this is `explosion_resistance` for simulated atoms.
 */
/atom/proc/get_explosion_resistance()
	return explosion_resistance

/mob/living/get_explosion_resistance()
	if(density)
		return 40
	return 20

/obj/explosion_throw(severity, direction, scatter_multiplier = 1)
	if(anchored)
		return

	if(!istype(src.loc, /turf))
		return

	if(!direction)
		direction = pick(GLOB.alldirs)
	var/range = min(round(severity * 0.2, 1), 14)
	if(!direction)
		range = round( range/2 ,1)

	if(range < 1)
		return


	var/speed = max(range*2.5, 4)
	var/atom/target = get_ranged_target_turf(src, direction, range)

	if(range >= 2)
		var/scatter = range/4 * scatter_multiplier
		var/scatter_x = rand(-scatter,scatter)
		var/scatter_y = rand(-scatter,scatter)
		target = locate(target.x + round( scatter_x , 1),target.y + round( scatter_y , 1),target.z) //Locate an adjacent turf.

	//time for the explosion to destroy windows, walls, etc which might be in the way
	INVOKE_ASYNC(src, /atom/movable.proc/throw_at, target, range, speed, null, TRUE)

	return

/mob/explosion_throw(severity, direction, scatter_multiplier)
	if(anchored)
		return

	if(!istype(src.loc, /turf))
		return

	var/weight = 1
	var/range = round( severity/weight * 0.02 ,1)
	if(!direction)
		range = round( 2*range/3 ,1)
		direction = pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)

	if(range <= 0)
		return

	var/speed = max(range*1.5, 4)
	var/atom/target = get_ranged_target_turf(src, direction, range)

	var/spin = 0

	if(range > 1)
		spin = 1

	if(range >= 2)
		var/scatter = range/4
		var/scatter_x = rand(-scatter,scatter)
		var/scatter_y = rand(-scatter,scatter)
		target = locate(target.x + round( scatter_x , 1),target.y + round( scatter_y , 1),target.z) //Locate an adjacent turf.

	//time for the explosion to destroy windows, walls, etc which might be in the way
	INVOKE_ASYNC(src, /atom/movable.proc/throw_at, target, range, speed, null, spin)

	return

/obj/machinery/door/airlock/get_explosion_resistance()
	if(get_damage_resistance(DAMAGE_EXPLODE) == 0)
		return 1000000
	if(density)
		return health_current / get_damage_resistance(DAMAGE_EXPLODE)
	else
		return 20

/turf/unsimulated/get_explosion_resistance()
	return 1000000

/turf/unsimulated/floor/get_explosion_resistance()
	return 0

/turf/simulated/get_explosion_resistance()
	if(get_damage_resistance(DAMAGE_EXPLODE) == 0)
		return 1000000
	return health_current / get_damage_resistance(DAMAGE_EXPLODE)
