/obj/machinery/autocannon/harpoon
	icon = 'icons/obj/disperser.dmi'

/obj/machinery/autocannon/harpoon/front
	name = "harpoon gun barrel"
	desc = "An old-fashion ship autocannon tower.\
		<br>A sign on it reads: <i>STAY CLEAR! DO NOT BLOCK!</i>"
	icon_state = "gun"

/obj/machinery/autocannon/harpoon/middle
	name = "harpoon gun rail"
	desc = "An old-fashion ammo reciever that sends it to the autocannon tower. \
		<br>A sign on it reads: <i>EXPLOSIVE! DO NOT OVERHEAT!</i>"
	icon_state = "magazine"
	maximum_component_parts = list(/obj/item/stock_parts = 15)

/obj/machinery/autocannon/harpoon/back
	name = "harpoon gun munition rack"
	desc = "An old-fashion ammo reciever. Munition then goes to autocannon breech end."
	icon_state = "ammo_loader"
	density = FALSE
//	layer = BELOW_DOOR_LAYER //So the charges go above us.