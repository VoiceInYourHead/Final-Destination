#define MIND_CONTROL_ALLOW_MOVE 1
#define MIND_CONTROL_ALLOW_SAY 2

GLOBAL_LIST_INIT(diagonals, list(NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST))

/atom
	var/datum/mind_control/mind_controller

/atom/proc/set_control_mind(mob/living/victim, duration, flags)
	if(!victim)
		return FALSE

	if(!mind_controller)
		mind_controller = new(src)

	mind_controller.control_flags = flags

	mind_controller.affected |= victim
	mind_controller.affected[victim] = duration

/// Mind Control datum start

/datum/mind_control
	var/atom/parent

	var/control_flags
	var/list/affected = list()

	var/atom/target

/datum/mind_control/New(atom/owner)
	. = ..()
	parent = owner
	START_PROCESSING(SSfastprocess, src)

/datum/mind_control/Destroy()
	. = ..()
	STOP_PROCESSING(SSfastprocess, src)
	if(parent)
		parent.mind_controller = null

/datum/mind_control/Process()
	if(!parent || !LAZYLEN(affected))
		qdel(src)
		return

	var/list/slaves = affected.Copy()
	for(var/mob/living/slave in slaves)
		if(slave.stat == DEAD || affected[slave] <= 0)
			affected -= slave
			continue

		if(target)
			walk_towards_target(slave)

		affected[slave] -= 0.2 SECOND

		if(!(control_flags & MIND_CONTROL_ALLOW_SAY))
			slave.silent = max(slave.silent, 2)

		if(!(control_flags & MIND_CONTROL_ALLOW_MOVE))
			slave.stunned = max(slave.stunned, 2)

/datum/mind_control/proc/speak_through_affected(message)
	for(var/mob/living/slave in affected)
		var/old_silent = slave.silent
		slave.silent = 0
		slave.say(message)
		slave.silent = old_silent

/datum/mind_control/proc/walk_towards_target(mob/living/slave)
	if(slave == target)
		return

	if(slave.z != target.z)
		return

	slave.a_intent = I_HURT
	slave.update_hud()
	slave.resist()

	var/distance = get_dist(slave, target)
	if(distance < ismob(target) ? 0 : 1)
		return

	var/old_stun = slave.stunned
	slave.stunned = 0

	var/direction = get_dir(slave, target)
	if(direction in GLOB.diagonals)
		direction = turn(direction, pick(-45, 45))

	var/old_loc = slave.loc
	slave.SelfMove(direction)

	if(slave.loc == old_loc)
		var/turf/blocked_turf = get_step(slave, direction)
		var/list/possible_blockers = blocked_turf.contents + blocked_turf

		for(var/atom/thing as obj|mob|turf in possible_blockers)
			if(!thing.density)
				continue
			possible_blockers += thing

		slave.ClickOn(pick(possible_blockers))

	slave.stunned = old_stun
