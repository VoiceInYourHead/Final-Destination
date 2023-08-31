/obj/effect/overmap/trading
	name = "station"
	desc = "A trading station."
	icon_state = "trading_station"
	scannable = TRUE
	known = TRUE
	plane = 4

	var/datum/trader/trader_merchant_datum

/obj/effect/overmap/trading/on_update_icon()
	return

/obj/effect/overmap/trading/ship
	name = "ship"
	desc = "A trading ship."
	icon_state = "trading_ship"
	known = FALSE
