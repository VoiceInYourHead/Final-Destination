/obj/structure/fd/campfire
	name = "campfire"
	desc = "A circle of stones surrounding a burning pile of wood. The fire is roaring and you can hear its crackle. You could probably stomp the fire out."
	icon = 'icons/fd/structures/manhattan/fires.dmi'
	icon_state = "campfire"
	density = FALSE
	var/lit = FALSE
	var/fuel = 60

/obj/structure/fd/campfire/Process()
	if(fuel > 0 && lit)
		fuel--
	if(fuel <= 0 && lit)
		lit = FALSE
		update_icon()
		STOP_PROCESSING(SSobj, src)

/obj/structure/fd/campfire/on_update_icon()
	if(lit)
		icon_state = "campfire_lit"
	if(!lit)
		icon_state = "campfire"
	return

/obj/structure/fd/campfire/attackby(var/obj/item/I, var/mob/living/user)
	if(istype(I,/obj/item/stack/material/wood))
		var/obj/item/stack/material/wood/sticks = I
		if(do_after(user, 10) && sticks.amount >= 1)
			sticks.amount -= 1
			fuel += 5
			if(sticks.amount <= 0)
				qdel(sticks)
	if(isflamesource(I) || is_hot(I))
		if(do_after(user, 30))
			lit = TRUE
			update_icon()
			START_PROCESSING(SSobj, src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/meat))
		if(do_after(src, 50))
			new /obj/item/reagent_containers/food/snacks/plainsteak(loc)
			qdel(I)

