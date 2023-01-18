/obj/machinery/autocannon
	icon = 'icons/obj/disperser.dmi'
	density = TRUE
	anchored = TRUE
	construct_state = /decl/machine_construction/default/panel_closed

/obj/machinery/autocannon/examine(mob/user)
	. = ..()
	if(panel_open)
		to_chat(user, "The maintenance panel is open.")

/obj/machinery/autocannon/attackby(obj/item/I, mob/user)
	if(isWrench(I))
		if(panel_open)
			user.visible_message("<span class='notice'>\The [user] rotates \the [src] with \the [I].</span>", "<span class='notice'>You rotate \the [src] with \the [I].</span>")
			set_dir(turn(dir, 90))
			playsound(src, 'sound/items/jaws_pry.ogg', 50, 1)
		else
			to_chat(user,"<span class='notice'>The maintenance panel must be screwed open for this!</span>")
	else
		return ..()

/obj/machinery/autocannon/front
	name = "autocannon turret"
	desc = "An old-fashion ship autocannon tower.\
		<br>A sign on it reads: <i>STAY CLEAR! DO NOT BLOCK!</i>"
	icon_state = "gun"

/obj/machinery/autocannon/middle
	name = "autocannon breech end"
	desc = "An old-fashion ammo reciever that sends it to the autocannon tower. \
		<br>A sign on it reads: <i>EXPLOSIVE! DO NOT OVERHEAT!</i>"
	icon_state = "magazine"
	maximum_component_parts = list(/obj/item/stock_parts = 15)

/obj/machinery/autocannon/back
	name = "autocannon munition rack"
	desc = "An old-fashion ammo reciever. Munition then goes to autocannon breech end."
	icon_state = "ammo_loader"
	density = FALSE
//	layer = BELOW_DOOR_LAYER //So the charges go above us.