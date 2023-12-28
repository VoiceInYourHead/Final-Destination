/obj/item/stack/xmas_lights
	name = "colored lights"
	desc = "Bunch of christmas lights."
	icon = 'icons/infinity/christmas_1.dmi'
	icon_state = "xmaslights_item"
	max_amount = 10

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
		if(do_after(user, 20) && on)
			on = FALSE
			update_icon()
			set_light(0, 0, 0, l_color = "#ffffff")
			update_light()
		if(do_after(user, 20) && !on)
			on = TRUE
			update_icon()
			set_light(0.4, 2, 3, l_color = "#c58822")

/obj/structure/fd/pot/attackby(obj/item/stack/W, mob/user)
	if(istype(W,/obj/item/stack/xmas_lights) && has_tree)
		if(do_after(user, 50) && W.amount >= 5)
			W.amount -= 5
			has_lights = TRUE
			update_icon()
			if(W.amount <= 0)
				qdel(W)