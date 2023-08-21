/obj/item/rig_module/actuators /// While on, will dampen the fall from any height and scale power usage accordingly. Enables the user to also jump up 1 z-level.
	name = "agility enhancement actuators"
	desc = "A set of electromechanical actuators that drastically increase a hardsuit's mobility. They allow the suit to be able to absorb impacts from long falls and leap incredible distances."
	icon_state = "actuators"

	interface_name = "leg actuators"
	interface_desc = "Allows you to fall from heights without taking damage and quickly jump up a level if there is something above you."

	use_power_cost = 50 KILOWATTS
	module_cooldown = 10 SECONDS
	toggleable = TRUE
	selectable = TRUE
	usable = FALSE
	/// Combat versions are able to lunge at mobs and grab them.
	var/combatType = TRUE
	/// Leaping radius. Inclusive. Applies to diagonal distances.
	var/leapDistance = 4
	engage_string = "Toggle Powered Lunge"
	activate_string = "Engage Mobility Enhancement"
	deactivate_string = "Disable Mobility Enhancement"


/obj/item/rig_module/actuators/engage(atom/target, mob/user)
	if (!..())
		return FALSE

	if (!target)
		return TRUE

	var/mob/living/carbon/human/H = holder.wearer

	if (!isturf(H.loc))
		to_chat(H, SPAN_WARNING("You cannot leap out of your current location!"))
		return FALSE

	var/turf/T = get_turf(target)

	if (!T || T.density)
		to_chat(H, SPAN_WARNING("You cannot leap at solid walls!"))
		return FALSE

	var/dist = max(get_dist(T, get_turf(H)), 0) /// The target the user has selected

	if (dist)
		for (var/A in T)
			var/atom/aA = A
			if (combatType && ismob(aA)) /// Combat versions of this module allow you to leap at mobs
				continue

			if (aA.density)
				to_chat(H, SPAN_WARNING("You cannot leap at a location with solid objects on it!"))
				return FALSE

	if (T.z != H.z || dist > leapDistance)
		to_chat(H, SPAN_WARNING("You cannot leap at such a distant object!"))
		return FALSE

	if (dist)
		H.visible_message(SPAN_WARNING("\The [H]'s suit whirrs aggressively, launching them towards \the [target]!"),
			SPAN_WARNING("Your suit whirrs aggressively, launching you towards \the [target]!"),
			SPAN_WARNING("You hear an electric <i>whirr</i> followed by a weighty thump!"))
		H.face_atom(T)
		H.throw_at(T, leapDistance, 0.5, H, FALSE)
		return TRUE