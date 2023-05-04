/obj/item/missile_equipment/payload/explosive
	name = "explosive charge"
	desc = "An explosive charge. Detonates when the missile is triggered."
	icon_state = "explosive"
	hull_damage = 8

/obj/item/missile_equipment/payload/explosive/on_trigger(var/atom/triggerer)
	if(istype(triggerer, /obj/effect/shield))
		explosion(get_turf(src), 8, EX_ACT_DEVASTATING, turf_breaker = TRUE)
		var/obj/effect/shield/S = triggerer
		S.take_damage(10000, SHIELD_DAMTYPE_PHYSICAL)
	else
		explosion(get_turf(triggerer), 16, EX_ACT_DEVASTATING, turf_breaker = TRUE)

	..()