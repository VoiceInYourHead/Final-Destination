#define INVOKE_PSI_POWERS(holder, powers, target) \
	if(holder && holder.psi && holder.psi.can_use()) { \
		for(var/decl/psionic_power/power as anything in powers) { \
			var/obj/item/result = power.invoke(holder, target); \
			if(result) { \
				holder.psi.spend_power(power.cost); \
				power.handle_post_power(holder, target); \
				if(istype(result)) { \
					sound_to(holder, sound('sound/effects/psi/power_evoke.ogg')); \
					LAZYADD(holder.psi.manifested_items, result); \
					holder.put_in_hands(result); \
				} \
				if(power.suppress_parent_proc) { return 0 }; \
			} \
		} \
	}

/*
	Click code cleanup
	~Sayu
*/

// 1 decisecond click delay (above and beyond mob/next_move)
/mob/var/next_click = 0


/client/MouseDown(object,location,control,params)

	if (CH)
		if (!CH.MouseDown(object,location,control,params))
			return
	.=..()

/client/MouseUp(object,location,control,params)
	if (CH)
		if (!CH.MouseUp(object,location,control,params))
			return
	.=..()

/client/MouseDrag(over_object,src_location,over_location,src_control,over_control,params)
	if (CH)
		if (!CH.MouseDrag(over_object,src_location,over_location,src_control,over_control,params))
			return
	.=..()


/client/Click(var/atom/target, location, control, params)
	var/list/L = params2list(params) //convert params into a list
	var/dragged = L["drag"] //grab what mouse button they are dragging with, if any.
	if(dragged && !L[dragged]) //check to ensure they aren't using drag clicks to aimbot
		return //if they are dragging, and they clicked with a different mouse button, reject the click as it will always go the atom they are currently dragging, even if out of view and not under the mouse

	if (CH)
		if (!CH.Click(target, location, control, params))
			return


	if(!target.Click(location, control, params))
		usr.ClickOn(target, params)

/*
	Before anything else, defer these calls to a per-mobtype handler.  This allows us to
	remove istype() spaghetti code, but requires the addition of other handler procs to simplify it.

	Alternately, you could hardcode every mob's variation in a flat ClickOn() proc; however,
	that's a lot of code duplication and is hard to maintain.

	Note that this proc can be overridden, and is in the case of screen objects.
*/

/atom/DblClick(var/location, var/control, var/params)
	if(usr.client)
		if(usr.client.CH)
			usr.client.CH.OnDblClick(src, params)
			return

	if(src)
		usr.DblClickOn(src, params)

/atom/proc/allow_click_through(var/atom/A, var/params, var/mob/user)
	return FALSE

/turf/allow_click_through(var/atom/A, var/params, var/mob/user)
	return TRUE

/*
	Standard mob ClickOn()
	Handles exceptions: middle click, modified clicks, exosuit actions

	After that, mostly just check your state, check whether you're holding an item,
	check whether you're adjacent to the target, then pass off the click to whoever
	is recieving it.
	The most common are:
	* mob/UnarmedAttack(atom,adjacent) - used here only when adjacent, with no item in hand; in the case of humans, checks gloves
	* atom/attackby(item,usser) - used only when adjacent
	* item/afterattack(atom,user,adjacent,params) - used both ranged and adjacent
	* mob/RangedAttack(atom,params) - used only ranged, only used for tk and laser eyes but could be changed
*/
/mob/proc/ClickOn(var/atom/A, var/params)
	if(!canClick()) // in the year 2000...
		return

	if(world.time <= next_click) // Hard check, before anything else, to avoid crashing
		return

	next_click = world.time + 1

	var/list/modifiers = params2list(params)
	if(modifiers["shift"] && modifiers["ctrl"])
		CtrlShiftClickOn(A)
		return 1
	if(modifiers["ctrl"] && modifiers["alt"])
		CtrlAltClickOn(A)
		return 1
	if(modifiers["middle"])
		MiddleClickOn(A)
		return 1
	if(modifiers["shift"])
		ShiftClickOn(A)
		return 0
	if(modifiers["alt"]) // alt and alt-gr (rightalt)
		AltClickOn(A)
		return 1
	if(modifiers["ctrl"])
		CtrlClickOn(A)
		return 1

	if(stat || paralysis || stunned || weakened || sleeping)
		return

	// Do not allow player facing change in fixed chairs
	if(!istype(buckled) || buckled.buckle_movable)
		face_atom(A) // change direction to face what you clicked on

	if(restrained())
		setClickCooldown(10)
		RestrainedClickOn(A)
		return 1

	if(in_throw_mode)
		if(isturf(A) || isturf(A.loc))
			throw_item(A)
			trigger_aiming(TARGET_CAN_CLICK)
			return 1
		throw_mode_off()

	var/obj/item/W = get_active_hand()

	if(W == A) // Handle attack_self
		W.attack_self(src)
		trigger_aiming(TARGET_CAN_CLICK)
		if(hand)
			update_inv_l_hand(0)
		else
			update_inv_r_hand(0)
		return 1

	//Atoms on your person
	// A is your location but is not a turf; or is on you (backpack); or is on something on you (box in backpack); sdepth is needed here because contents depth does not equate inventory storage depth.
	var/sdepth = A.storage_depth(src)
	if((!isturf(A) && A == loc) || (sdepth != -1 && sdepth <= 1))
		if(W)
			var/resolved = W.resolve_attackby(A, src, params)
			if(!resolved && A && W)
				W.afterattack(A, src, 1, params) // 1 indicates adjacency
		else
			if(ismob(A)) // No instant mob attacking
				setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
			UnarmedAttack(A, 1)

		trigger_aiming(TARGET_CAN_CLICK)
		return 1

	if(!loc.allow_click_through(A, params, src)) // This is going to stop you from telekinesing from inside a closet, but I don't shed many tears for that
		return

	//Atoms on turfs (not on your person)
	// A is a turf or is on a turf, or in something on a turf (pen in a box); but not something in something on a turf (pen in a box in a backpack)
	sdepth = A.storage_depth_turf()
	if(isturf(A) || isturf(A.loc) || (sdepth != -1 && sdepth <= 1))
		if(A.Adjacent(src)) // see adjacent.dm
			if(W)
				// Return 1 in attackby() to prevent afterattack() effects (when safely moving items for example)
				var/resolved = W.resolve_attackby(A,src, params)
				if(!resolved && A && W)
					W.afterattack(A, src, 1, params) // 1: clicking something Adjacent
			else
				if(ismob(A)) // No instant mob attacking
					setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
				UnarmedAttack(A, 1)

			trigger_aiming(TARGET_CAN_CLICK)
			return
		else // non-adjacent click
			if(W)
				W.afterattack(A, src, 0, params) // 0: not Adjacent
			else
				RangedAttack(A, params)

			trigger_aiming(TARGET_CAN_CLICK)
	return 1

/mob/proc/setClickCooldown(var/timeout)
	next_move = max(world.time + timeout, next_move)

/mob/proc/canClick()
	if(config.no_click_cooldown || next_move <= world.time)
		return 1
	return 0

// Default behavior: ignore double clicks, the second click that makes the doubleclick call already calls for a normal click
/mob/proc/DblClickOn(var/atom/A, var/params)
	return

/*
	Translates into attack_hand, etc.

	Note: proximity_flag here is used to distinguish between normal usage (flag=1),
	and usage when clicking on things telekinetically (flag=0).  This proc will
	not be called at ranged except with telekinesis.

	proximity_flag is not currently passed to attack_hand, and is instead used
	in human click code to allow glove touches only at melee range.
*/
/mob/proc/UnarmedAttack(var/atom/A, var/proximity_flag)
	return

/mob/living/UnarmedAttack(var/atom/A, var/proximity_flag)

	if(GAME_STATE < RUNLEVEL_GAME)
		to_chat(src, "You cannot attack people before the game has started.")
		return 0

	if(stat)
		return 0


	if(psi)
		if(a_intent == I_HURT)
			INVOKE_PSI_POWERS(src, psi.get_melee_powers(SSpsi.faculties_by_name_suka["Cryokinesis"]), A)
			INVOKE_PSI_POWERS(src, psi.get_melee_powers(SSpsi.faculties_by_name_suka["Electronics"]), A)
			INVOKE_PSI_POWERS(src, psi.get_melee_powers(SSpsi.faculties_by_name_suka["Energistics"]), A)
		if(a_intent == I_GRAB)
			INVOKE_PSI_POWERS(src, psi.get_melee_powers(SSpsi.faculties_by_name_suka["Psychokinesis"]), A)
			INVOKE_PSI_POWERS(src, psi.get_melee_powers(SSpsi.faculties_by_name_suka["Manifestation"]), A)
			INVOKE_PSI_POWERS(src, psi.get_melee_powers(SSpsi.faculties_by_name_suka["Psi-Archery"]), A)
		if(a_intent == I_DISARM)
			INVOKE_PSI_POWERS(src, psi.get_melee_powers(SSpsi.faculties_by_name_suka["Consciousness"]), A)
			INVOKE_PSI_POWERS(src, psi.get_melee_powers(SSpsi.faculties_by_name_suka["Coercion"]), A)
		if(a_intent == I_HELP)
			INVOKE_PSI_POWERS(src, psi.get_melee_powers(SSpsi.faculties_by_name_suka["Redaction"]), A)
	return 1

/*
	Ranged unarmed attack:

	This currently is just a default for all mobs, involving
	laser eyes and telekinesis.  You could easily add exceptions
	for things like ranged glove touches, spitting alien acid/neurotoxin,
	animals lunging, etc.
*/
/mob/proc/RangedAttack(var/atom/A, var/params)
	if(!mutations.len)
		return FALSE

	if((MUTATION_LASER in mutations) && a_intent == I_HURT)
		LaserEyes(A) // moved into a proc below
		return TRUE

/mob/living/RangedAttack(var/atom/A, var/params)
	if(psi)
		if(a_intent == I_HURT)
			INVOKE_PSI_POWERS(src, psi.get_ranged_powers(SSpsi.faculties_by_name_suka["Energistics"]), A)
			INVOKE_PSI_POWERS(src, psi.get_ranged_powers(SSpsi.faculties_by_name_suka["Psychoballistics"]), A)
		if(a_intent == I_GRAB)
			INVOKE_PSI_POWERS(src, psi.get_ranged_powers(SSpsi.faculties_by_name_suka["Psychokinesis"]), A)
		if(a_intent == I_DISARM)
			INVOKE_PSI_POWERS(src, psi.get_ranged_powers(SSpsi.faculties_by_name_suka["Coercion"]), A)
			INVOKE_PSI_POWERS(src, psi.get_ranged_powers(SSpsi.faculties_by_name_suka["Consciousness"]), A)
	..()

/mob/living/proc/check_psi_grab(var/obj/item/grab/grab)
	if(psi && ismob(grab.affecting))
		if(a_intent == I_DISARM)
			INVOKE_PSI_POWERS(src, psi.get_grab_powers(SSpsi.faculties_by_name_suka["Consciousness"]), grab.affecting)
		if(a_intent == I_HELP)
			INVOKE_PSI_POWERS(src, psi.get_grab_powers(SSpsi.faculties_by_name_suka["Redaction"]), grab.affecting)

/*
	Restrained ClickOn

	Used when you are handcuffed and click things.
	Not currently used by anything but could easily be.
*/
/mob/proc/RestrainedClickOn(var/atom/A)
	return

/*
	Middle click
	Only used for swapping hands
*/
/mob/proc/MiddleClickOn(var/atom/A)
	swap_hand()
	return

// In case of use break glass
/*
/atom/proc/MiddleClick(var/mob/M as mob)
	return
*/

/*
	Shift click
	For most mobs, examine.
	This is overridden in ai.dm
*/
/mob/proc/ShiftClickOn(var/atom/A)
	A.ShiftClick(src)
	return
/atom/proc/ShiftClick(var/mob/user)
	if(user.client && user.client.eye == user)
		user.examinate(src)
	return

/*
	Ctrl click
	For most objects, pull
*/
/mob/proc/CtrlClickOn(var/atom/A)
	return A.CtrlClick(src)

/atom/proc/CtrlClick(var/mob/user)
	return FALSE

/atom/movable/CtrlClick(var/mob/user)
	if(Adjacent(user))
		user.start_pulling(src)
		return TRUE
	. = ..()

/*
	Alt click
	Unused except for AI
*/
/mob/proc/AltClickOn(var/atom/A)
	var/datum/extension/on_click/alt = get_extension(A, /datum/extension/on_click/alt)
	if(alt && alt.on_click(src))
		return
	A.AltClick(src)

/atom/proc/AltClick(var/mob/user)
	var/turf/T = get_turf(src)
	if(T && user.TurfAdjacent(T))
		if(user.listed_turf == T)
			user.listed_turf = null
		else
			user.listed_turf = T
			user.client.statpanel = "Turf"
	return 1

/mob/proc/TurfAdjacent(var/turf/T)
	return T.AdjacentQuick(src)

/mob/observer/ghost/TurfAdjacent(var/turf/T)
	if(!isturf(loc) || !client)
		return FALSE
	return z == T.z && (get_dist(loc, T) <= client.view)

/*
	Control+Shift click
	Unused except for AI
*/
/mob/proc/CtrlShiftClickOn(var/atom/A)
	A.CtrlShiftClick(src)
	return

/atom/proc/CtrlShiftClick(var/mob/user)
	return

/*
	Control+Alt click
*/
/mob/proc/CtrlAltClickOn(var/atom/A)
	if(A.CtrlAltClick(src))
		return
	pointed(A)

/atom/proc/CtrlAltClick(var/mob/user)
	return

/*
	Misc helpers

	Laser Eyes: as the name implies, handles this since nothing else does currently
	face_atom: turns the mob towards what you clicked on
*/
/mob/proc/LaserEyes(atom/A)
	return

/mob/living/LaserEyes(atom/A)
	setClickCooldown(DEFAULT_QUICK_COOLDOWN)
	var/turf/T = get_turf(src)

	var/obj/item/projectile/beam/LE = new (T)
	LE.icon = 'icons/effects/genetics.dmi'
	LE.icon_state = "eyelasers"
	playsound(usr.loc, 'sound/weapons/taser2.ogg', 75, 1)
	LE.launch(A)
/mob/living/carbon/human/LaserEyes()
	if(nutrition>0)
		..()
		adjust_nutrition(-(rand(1,5)))
		handle_regular_hud_updates()
	else
		to_chat(src, SPAN_WARNING("You're out of energy! You need food!"))

// Simple helper to face what you clicked on, in case it should be needed in more than one place
/mob/proc/face_atom(var/atom/A)
	if(!A || !x || !y || !A.x || !A.y) return
	var/dx = A.x - x
	var/dy = A.y - y
	if(!dx && !dy) return

	var/direction
	if(abs(dx) < abs(dy))
		if(dy > 0)	direction = NORTH
		else		direction = SOUTH
	else
		if(dx > 0)	direction = EAST
		else		direction = WEST
	if(direction != dir)
		facedir(direction)

GLOBAL_LIST_INIT(click_catchers, create_click_catcher())

/obj/screen/click_catcher
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "click_catcher"
	plane = CLICKCATCHER_PLANE
	mouse_opacity = 2
	screen_loc = "CENTER-7,CENTER-7"

/obj/screen/click_catcher/Destroy()
	SHOULD_CALL_PARENT(FALSE)
	return QDEL_HINT_LETMELIVE

/proc/create_click_catcher()
	. = list()
	for(var/i = 0, i<15, i++)
		for(var/j = 0, j<15, j++)
			var/obj/screen/click_catcher/CC = new()
			CC.screen_loc = "NORTH-[i],EAST-[j]"
			. += CC

/obj/screen/click_catcher/Click(location, control, params)
	var/list/modifiers = params2list(params)
	if(modifiers["middle"] && istype(usr, /mob/living/carbon))
		var/mob/living/carbon/C = usr
		C.swap_hand()
	else
		var/turf/T = screen_loc2turf(screen_loc, get_turf(usr))
		if(T)
			// T.Click(location, control, params)
			usr.client.Click(T, location, control, params)

	. = 1

/obj/screen/click_catcher/proc/resolve(var/mob/user)
	var/turf/T = screen_loc2turf(screen_loc, get_turf(user))
	return T