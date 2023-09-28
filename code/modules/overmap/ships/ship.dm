var/const/OVERMAP_SPEED_CONSTANT = (1 SECOND)
#define SHIP_MOVE_RESOLUTION 0.00001
#define MOVING(speed) abs(speed) >= min_speed
#define SANITIZE_SPEED(speed) SIGN(speed) * clamp(abs(speed), 0, max_speed)
#define CHANGE_SPEED_BY(speed_var, v_diff) \
	v_diff = SANITIZE_SPEED(v_diff);\
	if(!MOVING(speed_var + v_diff)) \
		{speed_var = 0};\
	else \
		{speed_var = SANITIZE_SPEED((speed_var + v_diff)/(1 + speed_var*v_diff/(max_speed ** 2)))}
// Uses Lorentzian dynamics to avoid going too fast.

/obj/effect/overmap/visitable/ship
	name = "generic ship"
	desc = "Space faring vessel."
	icon_state = "ship"
	free_landing = TRUE
//	requires_contact = TRUE
	var/moving_state = "ship_moving"
	var/list/consoles

	var/vessel_mass = 10000             // tonnes, arbitrary number, affects acceleration provided by engines
	var/vessel_size = SHIP_SIZE_LARGE	// arbitrary number, affects how likely are we to evade meteors
	var/max_speed = 1/(1 SECOND)        // "speed of light" for the ship, in turfs/tick.
	var/min_speed = 1/(2 MINUTES)       // Below this, we round speed to 0 to avoid math errors.
	var/max_autopilot = 1 / (10 SECONDS) // The maximum speed any attached helm can try to autopilot at.

	var/list/speed = list(0,0)          // speed in x,y direction
	var/list/position = list(0,0)       // position within a tile.
	var/last_burn = 0                   // worldtime when ship last acceleated
	var/burn_delay = 1 SECOND           // how often ship can do burns

//	var/list/known_ships = list()		//List of ships known at roundstart - put types here.
//	var/base_sensor_visibility

	var/list/engines = list()
	var/engines_state = 0 //global on/off toggle for all engines
	var/thrust_limit = 1  //global thrust limit for all engines, 0..1
	var/halted = 0        //admin halt or other stop.
	var/skill_needed = SKILL_TRAINED  //piloting skill needed to steer it without going in random dir
	var/operator_skill

	var/integrity_failure_cap = 250		// max health
	var/integrity_failure = 0	// current health level

	var/announce_text = "ВНИМАНИЕ! ПОВРЕЖДЕНИЯ ВНУТРЕННИХ СИСТЕМ КОРАБЛЯ ДОСТИГЛИ КРИТИЧЕСКОЙ ОТМЕТКИ, НЕМЕДЛЕННО ПОКИНЬТЕ СУДНО! ПОВТОРЯЮ, НЕМЕДЛЕННО ПОКИНЬТЕ-"
	var/announcer_name = "Автоматический отчёт о техническом состоянии"

	var/do_repair_hull = TRUE
	var/repair_speed = 0.005 //per tick

	var/destroyed = FALSE

//	var/list/navigation_viewers // list of weakrefs to people viewing the overmap via this ship

/obj/effect/overmap/visitable/ship/Initialize()
	. = ..()
	glide_size = world.icon_size
	min_speed = round(min_speed, SHIP_MOVE_RESOLUTION)
	max_speed = round(max_speed, SHIP_MOVE_RESOLUTION)
	SSshuttle.ships += src
	START_PROCESSING(SSobj, src)
//	base_sensor_visibility = round((vessel_mass/SENSOR_COEFFICENT),1)

/obj/effect/overmap/visitable/ship/Destroy()
	STOP_PROCESSING(SSobj, src)
	SSshuttle.ships -= src
	..()
/*	for(var/thing in get_linked_machines_of_type(/obj/machinery/computer/ship))
		var/obj/machinery/computer/ship/machine = thing
		if(machine.linked == src)
			machine.linked = null
	. = ..()*/


/obj/effect/overmap/visitable/ship/relaymove(mob/user, direction, accel_limit)
	accelerate(direction, accel_limit)
	update_operator_skill(user)


/**
 * Updates `operator_skill` to match the current user's skill level, or to null if no user is provided.
 * Will skip observers to avoid allowing unintended external influences on flight.
 */
/obj/effect/overmap/visitable/ship/proc/update_operator_skill(mob/user)
	if (isobserver(user))
		return
	operator_skill = user?.get_skill_value(SKILL_PILOT)


/obj/effect/overmap/visitable/ship/proc/is_still()
	return !MOVING(speed[1]) && !MOVING(speed[2])

/obj/effect/overmap/visitable/ship/get_scan_data(mob/user)
	. = ..()
	if(!is_still())
		. += "<br>Heading: [get_heading_angle()], speed [get_speed() * 1000]"
	if(integrity_failure >= integrity_failure_cap)
		. += "<br><br>The [src] is wrecked beyond repair."
	else if(integrity_failure > integrity_failure_cap * 0.75)
		. += "<br><br>Gaps in hull of the [src] is bursting with flames, as it's structure integrity is critical!"
	else if(integrity_failure > integrity_failure_cap * 0.5)
		. += "<br><br>The [src] hull looks seriously damaged!"
	else if(integrity_failure > integrity_failure_cap * 0.25)
		. += "<br><br>The [src] shows signs of structural damage!"

//Projected acceleration based on information from engines
/obj/effect/overmap/visitable/ship/proc/get_acceleration()
	return round(get_total_thrust()/get_vessel_mass(), SHIP_MOVE_RESOLUTION)

//Does actual burn and returns the resulting acceleration
/obj/effect/overmap/visitable/ship/proc/get_burn_acceleration()
	return round(burn() / get_vessel_mass(), SHIP_MOVE_RESOLUTION)

/obj/effect/overmap/visitable/ship/proc/get_vessel_mass()
	. = vessel_mass
	for(var/obj/effect/overmap/visitable/ship/ship in src)
		. += ship.get_vessel_mass()

/obj/effect/overmap/visitable/ship/proc/get_speed()
	return round(sqrt(speed[1] ** 2 + speed[2] ** 2), SHIP_MOVE_RESOLUTION)

/obj/effect/overmap/visitable/ship/proc/get_heading()
	var/res = 0
	if(MOVING(speed[1]))
		if(speed[1] > 0)
			res |= EAST
		else
			res |= WEST
	if(MOVING(speed[2]))
		if(speed[2] > 0)
			res |= NORTH
		else
			res |= SOUTH
	return res

/obj/effect/overmap/visitable/ship/proc/get_heading_angle()
	var/res = 0
	if (MOVING(speed[1]) || MOVING(speed[2]))
		res = (round(Atan2(speed[1], -speed[2])) + 450)%360
	return res

/obj/effect/overmap/visitable/ship/proc/adjust_speed(n_x, n_y)
	CHANGE_SPEED_BY(speed[1], n_x)
	CHANGE_SPEED_BY(speed[2], n_y)
	for(var/zz in map_z)
		if(is_still())
			toggle_move_stars(zz)
		else
			toggle_move_stars(zz, fore_dir)
	update_icon()

/obj/effect/overmap/visitable/ship/proc/get_brake_path()
	if(!get_acceleration())
		return INFINITY
	if(is_still())
		return 0
	if(!burn_delay)
		return 0
	if(!get_speed())
		return 0
	var/num_burns = get_speed()/get_acceleration() + 2 //some padding in case acceleration drops form fuel usage
	var/burns_per_grid = 1/ (burn_delay * get_speed())
	return round(num_burns/burns_per_grid)

/obj/effect/overmap/visitable/ship/proc/decelerate(accel_limit)
	if ((!speed[1] && !speed[2]) || !can_burn())
		return
	last_burn = world.time
	var/delta = accel_limit ? min(get_burn_acceleration(), accel_limit) : get_burn_acceleration()
	var/mag = sqrt(speed[1] ** 2 + speed[2] ** 2)
	if (delta >= mag)
		adjust_speed(-speed[1], -speed[2])
	else
		adjust_speed(-(speed[1] * delta) / mag, -(speed[2] * delta) / mag)

/obj/effect/overmap/visitable/ship/proc/accelerate(direction, accel_limit)
	if (!direction || !can_burn())
		return
	last_burn = world.time
	var/delta = accel_limit ? min(get_burn_acceleration(), accel_limit) : get_burn_acceleration()
	var/dx = (direction & EAST) ? 1 : ((direction & WEST) ? -1 : 0)
	var/dy = (direction & NORTH) ? 1 : ((direction & SOUTH) ? -1 : 0)
	if (dx && dy)
		dx *= 0.5
		dy *= 0.5
	adjust_speed(delta * dx, delta * dy)

/obj/effect/overmap/visitable/ship/Process()
	if(destroyed)
		return
	if(integrity_failure >= integrity_failure_cap)
		go_boom()
		var/list/areas = get_areas()
		spawn(areas.len) go_boom_overmap()
		STOP_PROCESSING(SSobj, src)
		return
	if(integrity_failure > 0 && do_repair_hull)
		repair_hull(repair_speed)
	if(!halted && !is_still())
		var/list/deltas = list(0,0)
		for(var/i = 1 to 2)
			if(MOVING(speed[i]))
				position[i] += speed[i] * OVERMAP_SPEED_CONSTANT
				if(position[i] < 0)
					deltas[i] = Ceil(position[i])
				else if(position[i] > 0)
					deltas[i] = Floor(position[i])
				if(deltas[i] != 0)
					position[i] -= deltas[i]
					position[i] += (deltas[i] > 0) ? -1 : 1

		update_icon()
		var/turf/newloc = locate(x + deltas[1], y + deltas[2], z)
		if(newloc && loc != newloc)
			Move(newloc)
			handle_wraparound()
//	sensor_visibility = min(round(base_sensor_visibility + get_speed_sensor_increase(), 1), 100)

/obj/effect/overmap/visitable/ship/on_update_icon()
	pixel_x = position[1] * (world.icon_size/2)
	pixel_y = position[2] * (world.icon_size/2)
	if(!is_still())
		icon_state = moving_state
		dir = get_heading()
	else
		icon_state = initial(icon_state)
	for(var/obj/machinery/computer/ship/machine in consoles)
		if(machine.z in map_z)
			for(var/weakref/W in machine.viewers)
				var/mob/M = W.resolve()
				if(istype(M) && M.client)
					M.client.pixel_x = pixel_x
					M.client.pixel_y = pixel_y
	..()

/obj/effect/overmap/visitable/ship/proc/go_boom_overmap()
	adjust_speed(-speed[1], -speed[2])
	halted = 1
	icon_state = "[icon_state]_exploding"
	spawn(45) icon_state = "[icon_state]_exploded"

/obj/effect/overmap/visitable/ship/proc/go_boom()
	set waitfor = 0
	if(destroyed)
		return
	destroyed = TRUE
	GLOB.global_announcer.autosay(announce_text, "[announcer_name] " + "[name]'а")
	for(var/mob/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!T || !(T.z in map_z))
			continue
		shake_camera(M, 20)
		if(!isdeaf(M))
			sound_to(M, 'sound/ambience/matteralarm.ogg')
	sleep(40)
	var/list/boomareas = get_areas()
	boomareas -= locate(/area/space)
	var/explosions_amount = round(boomareas.len / 4)
	log_and_message_admins("[name] разъёбывается на ошмётки силой в [max(1,explosions_amount)] бабаха.")
	for(var/i = 1 to max(1, round(explosions_amount) ))
		sleep(rand(6,12))
		var/area/finalarea = pick(boomareas)
		var/turf/targetturf = pick_area_turf(finalarea.type, list(/proc/is_not_space_turf))
		cell_explosion(targetturf, rand(500,1000), 100)
		for(var/mob/M in GLOB.player_list)
			var/turf/T = get_turf(M)
			if(!T || !(T.z in map_z))
				continue
			shake_camera(M, 10)
			if(!isdeaf(M))
				sound_to(M, sound('sound/effects/explosionfar.ogg', volume=50))

/obj/effect/overmap/visitable/ship/proc/damage_hull(var/amount)
	integrity_failure += amount

/obj/effect/overmap/visitable/ship/proc/repair_hull(var/amount)
	integrity_failure = max(0, integrity_failure - amount)

/obj/effect/overmap/visitable/ship/proc/burn()
	for(var/datum/ship_engine/E in engines)
		. += E.burn()

/obj/effect/overmap/visitable/ship/proc/get_total_thrust()
	for(var/datum/ship_engine/E in engines)
		. += E.get_thrust()

/obj/effect/overmap/visitable/ship/proc/can_burn()
	if(halted)
		return 0
	if (world.time < last_burn + burn_delay)
		return 0
	for(var/datum/ship_engine/E in engines)
		. |= E.can_burn()

//deciseconds to next step
/obj/effect/overmap/visitable/ship/proc/ETA()
	. = INFINITY
	for(var/i = 1 to 2)
		if(MOVING(speed[i]))
			. = min(., ((speed[i] > 0 ? 1 : -1) - position[i]) / speed[i])
	. = max(Ceil(.),0)

/obj/effect/overmap/visitable/ship/proc/handle_wraparound()
	var/nx = x
	var/ny = y
	var/low_edge = 1
	var/high_edge = GLOB.using_map.overmap_size - 1

	if((dir & WEST) && x == low_edge)
		nx = high_edge
	else if((dir & EAST) && x == high_edge)
		nx = low_edge
	if((dir & SOUTH)  && y == low_edge)
		ny = high_edge
	else if((dir & NORTH) && y == high_edge)
		ny = low_edge
	if((x == nx) && (y == ny))
		return //we're not flying off anywhere

	var/turf/T = locate(nx,ny,z)
	if(T)
		forceMove(T)

/obj/effect/overmap/visitable/ship/proc/halt()
	adjust_speed(-speed[1], -speed[2])
	halted = 1

/obj/effect/overmap/visitable/ship/proc/unhalt()
	if(!SSshuttle.overmap_halted)
		halted = 0

/obj/effect/overmap/visitable/ship/Bump(var/atom/A)
	if(istype(A,/turf/unsimulated/map/edge))
		handle_wraparound()
	..()

/obj/effect/overmap/visitable/ship/proc/get_helm_skill()//delete this mover operator skill to overmap obj
	return operator_skill

/obj/effect/overmap/visitable/ship/populate_sector_objects()
	..()
	for(var/obj/machinery/computer/ship/S in SSmachines.machinery)
		S.attempt_hook_up(src)
	for(var/datum/ship_engine/E in ship_engines)
		if(check_ownership(E.holder))
			engines |= E

/obj/effect/overmap/visitable/ship/proc/get_landed_info()
	return "This ship cannot land."

/*/obj/effect/overmap/visitable/ship/get_scan_data(mob/user)
	. = ..()
	. += "<br>Mass: [vessel_mass] tons."
	if(!is_still())
		. += "<br>Heading: [get_heading_angle()], speed [get_speed() * 1000]"
	if(instant_contact)
		. += "<br>It is broadcasting a distress signal."

/obj/effect/overmap/visitable/ship/proc/get_speed_sensor_increase()
	return min(get_speed() * 1000, 50)*/ //Engines should never increase sensor visibility by more than 50.

#undef MOVING
#undef SANITIZE_SPEED
#undef CHANGE_SPEED_BY
