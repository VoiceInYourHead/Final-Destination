/obj/machinery/disperser/autocannon
	icon = 'icons/obj/disperser.dmi'

/obj/machinery/disperser/autocannon/front
	name = "autocannon turret"
	desc = "An old-fashion ship autocannon tower.\
		<br>A sign on it reads: <i>STAY CLEAR! DO NOT BLOCK!</i>"
	icon_state = "gun"

/obj/machinery/disperser/autocannon/middle
	name = "autocannon breech end"
	desc = "An old-fashion ammo reciever that sends it to the autocannon tower. \
		<br>A sign on it reads: <i>EXPLOSIVE! DO NOT OVERHEAT!</i>"
	icon_state = "magazine"
	maximum_component_parts = list(/obj/item/stock_parts = 15)

/obj/machinery/disperser/autocannon/back
	name = "autocannon munition rack"
	desc = "An old-fashion ammo reciever. Munition then goes to autocannon breech end."
	icon_state = "ammo_loader"
	density = FALSE
	layer = BELOW_DOOR_LAYER //So the charges go above us.