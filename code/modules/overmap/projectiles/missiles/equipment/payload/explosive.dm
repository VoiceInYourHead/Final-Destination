/obj/item/missile_equipment/payload/explosive
	name = "explosive charge"
	desc = "An explosive charge. Detonates when the missile is triggered."
	icon_state = "explosive"
	hull_damage = 8

/obj/item/missile_equipment/payload/explosive/on_trigger(var/atom/triggerer)
	if(istype(triggerer, /obj/effect/shield))
		explosion(get_turf(src), 16, EX_ACT_DEVASTATING, turf_breaker = TRUE)
	else
		explosion(get_turf(triggerer), 16, EX_ACT_DEVASTATING, turf_breaker = TRUE)

	..()