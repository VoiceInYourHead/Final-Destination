/*
				/
				"REACTIVE" ARMOR UNITS FOR EXPLOSION PROTECTION (actually absorbing)
				/
*/
#define ARMORED_RESIST 30
/obj/structure/armor
	name = "absorbing armor"
	icon = 'maps/away/gccv_ulyanovsk/ulyanovsk.dmi'
	icon_state = "armor_empty"
	anchored = TRUE
	density = TRUE
	layer = BELOW_OBJ_LAYER
	health_max = 400
	explosion_resistance = 15
	/// Our armor has outer layer?
	var/armored = 0
	/// How much cover against projectiles.
	var/cover = 25

/obj/structure/armor/Initialize()
	set_extension(src, /datum/extension/penetration/simple, 100)
	. = ..()

/obj/structure/armor/full
	icon_state = "armor"
	cover = 99
	health_max = 800
	armored = 1
	explosion_resistance = 15 * ARMORED_RESIST

/obj/structure/armor/get_explosion_resistance()
	if(armored)
		return health_current * explosion_resistance
	else
		return initial(explosion_resistance)

/obj/structure/armor/examine(mob/user)
	. = ..()
	if(armored)
		to_chat(user, "<span class='notice'>There is an outer layer of armor on the [src].</span>")
	else
		to_chat(user, "<span class='notice'>The outer layer of the [src] is empty.</span>")

/obj/structure/armor/bullet_act(var/obj/item/projectile/Proj)
	if(Proj.original != src && !prob(cover))
		if(prob(50))
			return PROJECTILE_CONTINUE
		else return
	. = ..()

/obj/structure/armor/handle_death_change(new_death_state)
	..()
	if (new_death_state)
		dismantle()

/obj/structure/armor/CanFluidPass(var/coming_from)
	return TRUE

/obj/structure/armor/proc/reset_armor()
	anchored = TRUE
	cover = initial(cover)
	revive_health()
	icon_state = initial(icon_state)
	if(armored)
		add_armor()

/obj/structure/armor/attackby(obj/item/W, mob/user)
	if (user.a_intent == I_HURT)
		..()
		return

	if(isWrench(W))
		if(!armored)
			playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
			to_chat(user, "<span class='notice'>Now disassembling the armor...</span>")
			if(do_after(user, 80,src))
				to_chat(user, "<span class='notice'>You dissasembled the armor!</span>")
				dismantle()
		else
			to_chat(user, "<span class='notice'>You must first remove the armor before disassemble.</span>")
		return

	if(istype(W, /obj/item/gun/energy/plasmacutter) || istype(W, /obj/item/psychic_power/psiblade/master/grand/paramount))
		if(istype(W, /obj/item/gun/energy/plasmacutter))
			var/obj/item/gun/energy/plasmacutter/cutter = W
			if(!cutter.slice(user))
				return
		playsound(src.loc, 'sound/items/Welder.ogg', 100, 1)
		to_chat(user, "<span class='notice'>Now slicing apart the armor...</span>")
		if(do_after(user,armored ? 40: 20,src))
			to_chat(user, "<span class='notice'>You slice apart the armor!</span>")
			if(armored)
				new /obj/item/stack/material/plasteel(get_turf(user), 2)
			dismantle()
		return

	if(isCrowbar(W) && armored)
		playsound(src.loc, 'sound/items/Crowbar.ogg', 100, 1)
		to_chat(user, "<span class='notice'>Now removing the outer layer of armor...</span>")
		if(do_after(user, 40,src))
			to_chat(user, "<span class='notice'>You removed the outer layer of armor!</span>")
			remove_armor()
		return

	if(istype(W, /obj/item/stack/material/plasteel))
		if(!armored)
			if(!reinforce(W, user))
				return ..()

	if(isWelder(W))
		Start
		var/obj/item/weldingtool/F = W
		if(istype(W, /obj/item/weldingtool) && !F.isOn())
			return
		if(!health_damaged())
			to_chat(user, "<span class='warning'>\The [src] does not need repairs.</span>")
			return
		playsound(src.loc, 'sound/items/Welder.ogg', 50, 1)
		if(do_after(user, 20, src))
			if(!health_damaged())
				return
			user.visible_message("<span class='notice'>\The [user] repairs some damage to \the [src].</span>", "<span class='notice'>You repair some damage to \the [src].</span>")
			restore_health(health_max / 4)
			goto Start
		return

	..()

/obj/structure/armor/proc/reinforce(obj/item/stack/material/plasteel/S, mob/user)
	if(armored)
		to_chat(user, "<span class='notice'>\The [src] is already have outer armor.</span>")
		return 0

	if(S.get_amount() < 2)
		to_chat(user, "<span class='notice'>There isn't enough material here to add armor.</span>")
		return 0

	to_chat(user, "<span class='notice'>Now adding the outer layer of armor...</span>")
	if (!do_after(user, 40,src) || !S.use(2))
		return 1
	to_chat(user, "<span class='notice'>You added armor!</span>")

	add_armor()
	return 1

/obj/structure/armor/proc/add_armor()
	cover = 99
	armored = 1
	health_max = 800
	explosion_resistance += ARMORED_RESIST
	icon_state = "armor"
	if(health_current == initial(health_max))
		revive_health()

/obj/structure/armor/proc/remove_armor()
	cover = 25
	armored = 0
	health_max = 400
	explosion_resistance -= ARMORED_RESIST
	icon_state = "armor_empty"
	if(health_current > health_max)
		health_current = health_max

/obj/structure/armor/proc/dismantle()
	new /obj/item/stack/material/plasteel(get_turf(src), 2)
	qdel(src)

/obj/structure/armor/CanPass()
	return 0

/material/plasteel/generate_recipes(reinforce_material)
	. = ..()
	. += new/datum/stack_recipe/armor(src)

/datum/stack_recipe/armor
	title = "Absorbing Armor Frame"
	result_type = /obj/structure/armor
	req_amount = 4
	time = 80
	on_floor = 1
	difficulty = 2
