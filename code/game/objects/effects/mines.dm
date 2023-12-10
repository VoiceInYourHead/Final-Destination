/obj/effect/mine
	name = "Mine"
	desc = "I Better stay away from that thing."
	density = TRUE
	anchored = TRUE
	layer = OBJ_LAYER
	icon = 'icons/obj/weapons/other.dmi'
	icon_state = "uglymine"
	var/triggerproc = "explode" //name of the proc thats called when the mine is triggered
	var/triggered = 0


/obj/effect/mine/Initialize()
	. = ..()
	icon_state = "uglyminearmed"


/obj/effect/mine/Crossed(AM as mob|obj)
	Bumped(AM)

/obj/effect/mine/Bumped(mob/M as mob|obj)

	if(triggered) return

	if(istype(M, /mob/living/carbon/human))
		for(var/mob/O in viewers(world.view, src.loc))
			to_chat(O, "<span class='warning'>\The [M] triggered the [icon2html(src, O)] [src]</span>")
		triggered = 1
		call(src,triggerproc)(M)

/obj/effect/mine/proc/triggerrad(obj)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
	s.set_up(3, 1, src)
	s.start()
	obj:radiation += 50
	randmutb(obj)
	domutcheck(obj,null)
	spawn(0)
		qdel(src)

/obj/effect/mine/proc/triggerstun(obj)
	if(ismob(obj))
		var/mob/M = obj
		M.Stun(30)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
	s.set_up(3, 1, src)
	s.start()
	spawn(0)
		qdel(src)

/obj/effect/mine/proc/triggern2o(obj)
	//example: n2o triggerproc
	//note: im lazy

	for (var/turf/simulated/floor/target in range(1,src))
		if(!target.blocks_air)
			target.assume_gas(GAS_N2O, 30)

	spawn(0)
		qdel(src)

/obj/effect/mine/proc/triggerphoron(obj)
	for (var/turf/simulated/floor/target in range(1,src))
		if(!target.blocks_air)
			target.assume_gas(GAS_PHORON, 30)

			target.hotspot_expose(1000, CELL_VOLUME)

	spawn(0)
		qdel(src)

/obj/effect/mine/proc/triggerkick(obj)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
	s.set_up(3, 1, src)
	s.start()
	qdel(obj:client)
	spawn(0)
		qdel(src)

/obj/effect/mine/proc/explode(obj)
	cell_explosion(loc, 50, 10)
	spawn(0)
		qdel(src)

/obj/effect/mine/dnascramble
	name = "Radiation Mine"
	icon_state = "uglymine"
	triggerproc = "triggerrad"

/obj/effect/mine/phoron
	name = "Phoron Mine"
	icon_state = "uglymine"
	triggerproc = "triggerphoron"

/obj/effect/mine/kick
	name = "Kick Mine"
	icon_state = "uglymine"
	triggerproc = "triggerkick"

/obj/effect/mine/n2o
	name = "N2O Mine"
	icon_state = "uglymine"
	triggerproc = "triggern2o"

/obj/effect/mine/stun
	name = "Stun Mine"
	icon_state = "uglymine"
	triggerproc = "triggerstun"

//THE landmine.
/obj/structure/landmine
	name = "landmine"
	desc = "An anti-personnel mine."
	icon = 'icons/obj/weapons/other.dmi'
	icon_state = "uglyminearmed"
	anchored = TRUE
	var/triggerproc = "explode" //name of the proc thats called when the mine is triggered
	var/activated = 1
	var/triggered = 0

/obj/structure/landmine/Crossed(AM as mob|obj)
	Bumped(AM)

/obj/structure/landmine/Bumped(mob/M as mob|obj)

	if(triggered) return

	if(istype(M, /mob/living/carbon/human))
		for(var/mob/O in viewers(world.view, src.loc))
		triggered = 1
		call(src,triggerproc)(M)

/obj/structure/landmine/attackby(var/obj/W, var/mob/user)
	if(isMultitool(W))
		user.visible_message("<span class='warning'>[user] starts to carefully disarm the [src].", "You begin to carefully disarm the [src].")
		if(do_after(user, 80,src))
			if(!src) return
			user.visible_message("<span class='warning'>[user] has disarmed the [src] and it falls apart.", "You have disarmed the [src] and it falls apart!")
			var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
			s.set_up(3, 1, src)
			s.start()
			qdel(src)
			return

	else
		to_chat(user, "<span class='warning'>You don't seem to be able to do anything to the mine.")
	return

/obj/structure/landmine/proc/explode(obj)
	cell_explosion(loc, 50, 10)
	spawn(0)
		qdel(src)
