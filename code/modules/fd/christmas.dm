/obj/structure/sign/xmas_lights
	name = "colored lights"
	desc = "Bunch of christmas lights."
	icon = 'icons/infinity/christmas_1.dmi'
	icon_state = "xmaslights_off"
	var/on = FALSE

/obj/structure/sign/xmas_lights/attack_hand(mob/user as mob)
	if(do_after(user, 20) && !on)
		on = TRUE
		update_icon()
		set_light(0.2, 1, 2, l_color = "#c58822")
		return
	else
		if(do_after(user, 20))
			on = FALSE
			update_icon()
			set_light(0, 0, 0, l_color = "#ffffff")
			update_light()
			return

/obj/structure/sign/xmas_lights/update_icon()
	if(on)
		icon_state = "xmaslights"
	if(!on)
		icon_state = "xmaslights_off"

/obj/item/stack/xmas_lights
	name = "colored lights"
	desc = "Bunch of christmas lights."
	icon = 'icons/infinity/christmas_1.dmi'
	icon_state = "xmaslights_item"
	max_amount = 10

/obj/item/stack/xmas_lights/afterattack(atom/target, mob/user as mob, proximity)
	if(istype(target,/turf))
		if(do_after(user, 30) && amount >= 1)
			new /obj/structure/sign/xmas_lights(user.loc)
			amount -= 1
			if(amount <= 0)
				qdel(src)

/obj/structure/fd/pot
	name = "empty pot"
	desc = "Just an empty pot."
	icon = 'icons/infinity/christmas_1.dmi'
	icon_state = "pot"
	var/has_tree = FALSE
	var/has_lights = FALSE
	var/on = FALSE
	layer = ABOVE_HUMAN_LAYER
	anchored = FALSE
	density = FALSE

/obj/structure/fd/pot/update_icon()
	if(has_tree)
		icon_state = "plant"
	if(has_lights && has_tree && !on)
		icon_state = "plant-xmas-off"
	if(on && has_lights && has_tree)
		icon_state = "plant-xmas"

/obj/structure/fd/pot/MouseDrop(obj/I)
	if(istype(I, /obj/structure/flora/tree/pine) && !I.anchored)
		qdel(I)
		has_tree = TRUE
		density = TRUE
		update_icon()

/obj/structure/fd/pot/attack_hand(mob/user as mob)
	if(has_tree)
		if(do_after(user, 20) && !on)
			on = TRUE
			update_icon()
			set_light(0.4, 2, 3, l_color = "#c58822")
			return
		else
			if(do_after(user, 20))
				on = FALSE
				update_icon()
				set_light(0, 0, 0, l_color = "#ffffff")
				update_light()
				return

/obj/structure/fd/pot/attackby(obj/item/stack/W, mob/user)
	if(has_lights)
		return
	if(istype(W,/obj/item/stack/xmas_lights) && has_tree)
		if(do_after(user, 50) && W.amount >= 5)
			W.amount -= 5
			has_lights = TRUE
			update_icon()
			if(W.amount <= 0)
				qdel(W)