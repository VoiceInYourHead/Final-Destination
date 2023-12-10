/* Two-handed Weapons
 * Contains:
 * 		Twohanded
 *		Fireaxe
 *		Double-Bladed Energy Swords
 */

/*##################################################################
##################### TWO HANDED WEAPONS BE HERE~ -Agouri :3 ########
####################################################################*/

//Rewrote TwoHanded weapons stuff and put it all here. Just copypasta fireaxe to make new ones ~Carn
//This rewrite means we don't have two variables for EVERY item which are used only by a few weapons.
//It also tidies stuff up elsewhere.

/*
 * Twohanded
 */
/obj/item/material/twohanded
	w_class = ITEM_SIZE_HUGE
	slot_flags = SLOT_BACK
	var/wielded = 0
	var/force_wielded = 0
	var/force_unwielded
	var/wieldsound = null
	var/unwieldsound = null
	var/base_icon
	var/base_name
	var/unwielded_force_divisor = 0.25
	var/wielded_parry_bonus = 20

/obj/item/material/twohanded/update_twohanding()
	var/mob/living/M = loc
	if(istype(M) && M.can_wield_item(src) && is_held_twohanded(M))
		wielded = 1
		force = force_wielded
	else
		wielded = 0
		force = force_unwielded
	update_icon()
	..()

/obj/item/material/twohanded/update_force()
	..()
	base_name = name
	force_unwielded = round(force*unwielded_force_divisor)
	force_wielded = force
	force = force_unwielded


/obj/item/material/twohanded/New()
	..()
	update_icon()

/obj/item/material/twohanded/get_parry_chance(mob/user)
	. = ..()
	if(wielded)
		. += wielded_parry_bonus

/obj/item/material/twohanded/on_update_icon()
	..()
	icon_state = "[base_icon][wielded]"
	item_state_slots[slot_l_hand_str] = icon_state
	item_state_slots[slot_r_hand_str] = icon_state
	item_state_slots[slot_back_str] = base_icon

/*
 * Fireaxe
 */
/obj/item/material/twohanded/fireaxe  // DEM AXES MAN, marker -Agouri
	icon = 'icons/obj/weapons/melee_physical.dmi'
	icon_state = "fireaxe0"
	base_icon = "fireaxe"
	name = "fire axe"
	desc = "Truly, the weapon of a madman. Who would think to fight fire with an axe?"

	max_force = 60	//for wielded
	force_multiplier = 0.6
	unwielded_force_divisor = 0.3
	attack_cooldown_modifier = 6
	sharp = TRUE
	edge = TRUE
	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")
	applies_material_colour = 0
	worth_multiplier = 31
	base_parry_chance = 15
	fail_chance = 60
	have_stances = TRUE
	melee_strikes = list(/datum/melee_strike/swipe_strike/polearm_slash, /datum/melee_strike/swipe_strike/polearm_wide)

/obj/item/material/twohanded/fireaxe/afterattack(atom/A as mob|obj|turf|area, mob/user as mob, proximity)
	if(!proximity) return
	..()
	if(A && wielded)
		if(istype(A,/obj/structure/window))
			var/obj/structure/window/W = A
			W.shatter()
		else if(istype(A,/obj/structure/grille))
			qdel(A)
		else if(istype(A,/obj/effect/vine))
			var/obj/effect/vine/P = A
			P.die_off()

/obj/item/material/twohanded/fireaxe/ishatchet()
	return TRUE

/obj/item/material/twohanded/sledgehammer	// Someone thinks that crossbows and summer go well together.
	icon = 'icons/obj/weapons/melee_physical.dmi'
	icon_state = "breacher0"
	base_icon = "breacher"
	name = "sledgehammer"
	desc = "A huge sledgehammer that can punch through walls and is especially good at pork chops. Holding it in your hands, you get obsessive thoughts."

	max_force = 70			//for wielded
	w_class = ITEM_SIZE_LARGE
	force_multiplier = 1.4
	throwforce = 15
	hitsound = 'sound/weapons/genhit3.ogg'
	unwielded_force_divisor = 0.3
	attack_cooldown_modifier = 9
	default_material = MATERIAL_TITANIUM
	sharp = FALSE
	edge = FALSE
	attack_verb = list("attacked", "smited", "cleaved", "whacked", "slammed")
	applies_material_colour = 0
	worth_multiplier = 34
	base_parry_chance = 5
	slowdown_general = 0.1
	wielded_parry_bonus = 20
	fail_chance = 50

	unbreakable = TRUE		// go ahead, try it
	have_stances = FALSE
	//melee_strikes = list(/datum/melee_strike/precise_strike, /datum/melee_strike/blunt_strike)

/obj/item/material/twohanded/sledgehammer/shatter()
	return

/obj/item/material/twohanded/sledgehammer/afterattack(atom/A as mob|obj|turf|area, mob/user as mob, proximity)
	if(!proximity) return
	..()
	if(A && wielded)
		if(istype(A,/obj/structure/window)) //windows
			var/obj/structure/window/W = A
			W.shatter()

		else if(istype(A,/obj/structure/grille))
			qdel(A)

		else if(istype(A,/obj/machinery/suit_storage_unit)) //suit storage unit
			var/obj/machinery/suit_storage_unit/S = A
			if(prob(10) && !S.isopen)
				to_chat(user, "<span class='danger'>You critically damaged and made \the [A] open up.</span>")
				user.do_attack_animation(src)
				playsound(src, 'sound/weapons/smash.ogg', 50, 0)
				S.islocked = FALSE
				S.isopen = TRUE
				S.update_icon()
			else if(!S.isopen)
				to_chat(user, "<span class='danger'>You hit \the [A], but it doesn't give in.</span>")
				user.do_attack_animation(src)
				playsound(src, 'sound/weapons/smash.ogg', 50, 0)

		else if(istype(A,/obj/machinery/door/airlock)) //airlocks
			if(prob(40))
				var/obj/machinery/door/airlock/S = A
				to_chat(user, "<span class='danger'>You critically damaged \the [A]!</span>")
				user.do_attack_animation(src)
				if(S.health <= 0)
					S.health = 0
				else
					S.health /= 4

		else if(istype(A,/obj/machinery/door/firedoor)) //firedoor
			var/obj/machinery/door/firedoor/S = A
			if(prob(40) && S.density)
				to_chat(user, "<span class='danger'>You smash through \the [A]!</span>")
				qdel(A)

		else if(istype(A,/obj/structure/wall_frame) && !istype(A,/obj/structure/wall_frame/invincible)) //wallframe
			qdel(A)

		else if(istype(A,/turf/simulated/wall) && !istype(A,/turf/simulated/wall/r_wall/invincible)) //walls
			if(prob(30))
				to_chat(user, "<span class='danger'>You smash through \the [A]!</span>")
				user.do_attack_animation(src)
				A.health_current /= 4
				//A.kill_health()
				//A.dismantle_wall()

//spears, bay edition
/obj/item/material/twohanded/spear
	icon = 'icons/obj/weapons/melee_physical.dmi'
	icon_state = "spearglass0"
	base_icon = "spearglass"
	name = "spear"
	desc = "A haphazardly-constructed yet still deadly weapon of ancient design."
	max_force = 20	//for wielded
	applies_material_colour = 0
	force_multiplier = 0.33 // 12/19 with hardness 60 (steel) or 10/16 with hardness 50 (glass)
	unwielded_force_divisor = 0.20
	thrown_force_multiplier = 1.5 // 20 when thrown with weight 15 (glass)
	throw_speed = 6
	sharp = TRUE
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "poked", "jabbed", "torn", "gored")
	default_material = MATERIAL_GLASS
	does_spin = FALSE
	worth_multiplier = 7
	base_parry_chance = 30
	lunge_dist = 4
	lunge_delay = 10 SECONDS
	fail_chance = 60
	have_stances = TRUE
	melee_strikes = list(/datum/melee_strike/swipe_strike/polearm_mixed,/datum/melee_strike/swipe_strike/polearm_slash, /datum/melee_strike/swipe_strike/polearm_wide)

/obj/item/material/twohanded/spear/shatter(var/consumed)
	if(!consumed)
		new /obj/item/stack/material/rods(get_turf(src), 1)
		new /obj/item/stack/cable_coil(get_turf(src), 3)
	..()

/obj/item/material/twohanded/baseballbat
	name = "bat"
	desc = "HOME RUN!"
	icon = 'icons/obj/weapons/melee_physical.dmi'
	icon_state = "metalbat0"
	base_icon = "metalbat"
	item_state = "metalbat"
	w_class = ITEM_SIZE_LARGE
	throwforce = 7
	attack_verb = list("smashed", "beaten", "slammed", "smacked", "struck", "battered", "bonked")
	hitsound = 'sound/weapons/genhit3.ogg'
	default_material = MATERIAL_MAPLE
	max_force = 40	//for wielded
	force_multiplier = 1.1           // 22 when wielded with weight 20 (steel)
	unwielded_force_divisor = 0.7 // 15 when unwielded based on above.
	attack_cooldown_modifier = 1
	melee_accuracy_bonus = -10
	base_parry_chance = 30
	lunge_dist = 2
	lunge_delay = 10 SECONDS
	fail_chance = 40
	have_stances = TRUE
	melee_strikes = list(/datum/melee_strike/swipe_strike/blunt_swing/mixed_combo,/datum/melee_strike/swipe_strike/blunt_swing/wide)

//Predefined materials go here.
/obj/item/material/twohanded/baseballbat/metal/New(var/newloc)
	..(newloc,MATERIAL_ALUMINIUM)

/obj/item/material/twohanded/baseballbat/uranium/New(var/newloc)
	..(newloc,MATERIAL_URANIUM)

/obj/item/material/twohanded/baseballbat/gold/New(var/newloc)
	..(newloc,MATERIAL_GOLD)

/obj/item/material/twohanded/baseballbat/platinum/New(var/newloc)
	..(newloc,MATERIAL_PLATINUM)

/obj/item/material/twohanded/baseballbat/diamond/New(var/newloc)
	..(newloc,MATERIAL_DIAMOND)
