/*
			Claymores for warcrimes and other things.
			Yeah, code theft from CM
*/

/obj/item/device/claymore
	name = "claymore"
	desc = "It's a mine. Set the face towards the enemy and activate. Do not stand in front."
	icon = 'maps/away/gccv_ulyanovsk/ulyanovsk.dmi'
	icon_state = "mine"
	w_class = ITEM_SIZE_SMALL
	var/active = FALSE
	var/iff_signal = FACTION_INDIE_CONFED
	var/triggered = FALSE
	var/hard_iff_lock = FALSE
	var/obj/effect/mine_tripwire/tripwire

	var/map_deployed = FALSE

/obj/item/device/claymore/Initialize()
	. = ..()
	if(map_deployed)
		deploy_mine()

/obj/item/device/claymore/Destroy()
	QDEL_NULL(tripwire)
	. = ..()

/obj/item/device/claymore/ex_act()
	prime() //We don't care about how strong the explosion was.

/obj/item/device/claymore/emp_act()
	. = ..()
	prime() //Same here. Don't care about the effect strength.


//checks for things that would prevent us from placing the mine.
/obj/item/device/claymore/proc/check_for_obstacles(mob/living/user)
	if(locate(/obj/item/device/claymore) in get_turf(src))
		to_chat(user, SPAN_WARNING("There already is a mine at this position!"))
		return TRUE
	if(user.loc && user.loc.density)
		to_chat(user, SPAN_WARNING("You can't plant a mine here."))
		return TRUE


//Arming
/obj/item/device/claymore/attack_self(mob/living/user)
	if(check_for_obstacles(user))
		return

	if(active)
		return

	user.visible_message(SPAN_NOTICE("[user] starts deploying [src]."), SPAN_NOTICE("You start deploying [src]."))
	if(!do_after(user, 40, src))
		user.visible_message(SPAN_NOTICE("[user] stops deploying [src]."), SPAN_NOTICE("You stop deploying \the [src]."))
		return

	if(active)
		return

	if(check_for_obstacles(user))
		return

	user.visible_message(SPAN_NOTICE("[user] finishes deploying [src]."), SPAN_NOTICE("You finish deploying [src]."))

	deploy_mine(user)

/obj/item/device/claymore/proc/deploy_mine(mob/user)
	if(!hard_iff_lock && user)
		iff_signal = user.faction

	anchored = TRUE
	playsound(loc, 'sound/weapons/TargetOff.ogg', 25, 1)
	if(user)
		user.drop_from_inventory(src, user.loc)
		dir = user.dir //The direction it is planted in is the direction the user faces at that time
	activate_sensors()
	alpha = 200
	icon_state = initial(icon_state) + "_active"
	update_icon()


//Disarming
/obj/item/device/claymore/attackby(obj/item/W, mob/user)
	if(isMultitool(W))
		if(active)
			if(user.faction == iff_signal)
				user.visible_message(SPAN_NOTICE("[user] starts disarming [src]."), SPAN_NOTICE("You start disarming [src]."))
			else
				user.visible_message(SPAN_NOTICE("[user] starts fiddling with \the [src], trying to disarm it."), SPAN_NOTICE("You start disarming [src], but you don't know its IFF data. This might end badly..."))
			if(!do_after(user, 30, src))
				user.visible_message(SPAN_WARNING("[user] stops disarming [src]."), SPAN_WARNING("You stop disarming [src]."))
				return
			if(user.faction != iff_signal) //ow!
				if(prob(75))
					triggered = TRUE
					if(tripwire)
						var/direction = GLOB.reverse_dir[src.dir]
						var/step_direction = get_step(src, direction)
						step(tripwire, step_direction)
					prime()
			if(!active)//someone beat us to it
				return
			user.visible_message(SPAN_NOTICE("[user] finishes disarming [src]."), SPAN_NOTICE("You finish disarming [src]."))
			disarm()

	else
		return ..()

/obj/item/device/claymore/proc/disarm()
	anchored = FALSE
	active = FALSE
	triggered = FALSE
	alpha = 255
	icon_state = initial(icon_state)
	update_icon()
	QDEL_NULL(tripwire)

/obj/item/device/claymore/proc/activate_sensors()
	active = TRUE
	set_tripwire()


/obj/item/device/claymore/proc/set_tripwire()
	var/tripwire_loc = get_turf(get_step(loc, dir))
	tripwire = new(tripwire_loc)
	tripwire.linked_claymore = src
	active = TRUE


//Mine can also be triggered if you "cross right in front of it" (same tile)
/obj/item/device/claymore/Crossed(atom/A)
	..()
	if(isliving(A))
		var/mob/living/L = A
		if(L.stat == DEAD)//so dragged corpses don't trigger mines.
			return
		else
			try_to_prime(A)


/obj/item/device/claymore/proc/try_to_prime(mob/living/L)
	if(!active || triggered)
		return
	if(!istype(L))
		return
	if(L.stat == DEAD)
		return
	if(L.faction == iff_signal)
		return
	L.visible_message(SPAN_DANGER("[icon2html(src, viewers(src))] The [name] clicks as [L] moves in front of it."), SPAN_DANGER("[icon2html(src, L)] The [name] clicks as you move in front of it."), SPAN_DANGER("You hear a click."))

	triggered = TRUE
	playsound(loc, 'sound/weapons/TargetOn.ogg', 25, 1)
	prime()



//Note : May not be actual explosion depending on linked method
/obj/item/device/claymore/proc/prime()
	cell_explosion(loc, 100, 50, EXPLOSION_FALLOFF_SHAPE_LINEAR, dir, TRUE, null)
	qdel(src)


/obj/effect/mine_tripwire
	name = "claymore tripwire"
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_UNCLICKABLE
	invisibility = 101
	unacidable = TRUE //You never know
	var/obj/item/device/claymore/linked_claymore

/obj/effect/mine_tripwire/Destroy()
	if(linked_claymore)
		if(linked_claymore.tripwire == src)
			linked_claymore.tripwire = null
		linked_claymore = null
	. = ..()

//immune to explosions.
/obj/effect/mine_tripwire/ex_act(severity)
	return

/obj/effect/mine_tripwire/Crossed(atom/movable/AM)
	if(!linked_claymore)
		qdel(src)
		return

	if(linked_claymore.triggered) //Mine is already set to go off
		return

	if(linked_claymore)
		linked_claymore.try_to_prime(AM)


/obj/item/device/claymore/deployed
	map_deployed = TRUE

/obj/item/storage/box/claymore
	name = "landmine packet"
	desc = "This is a packet for mines. Small enough to keep in your pocket, but can't contain anything other than mines."
	icon = 'maps/away/gccv_ulyanovsk/ulyanovsk.dmi'
	icon_state = "mine_packet"
	w_class = ITEM_SIZE_SMALL
	can_hold = list(/obj/item/device/claymore)
	max_storage_space = ITEM_SIZE_SMALL * 5
	max_w_class = ITEM_SIZE_SMALL
	startswith = list(/obj/item/device/claymore = 5)
