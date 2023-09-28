/obj/item/missile_equipment/payload/explosive
	name = "explosive charge"
	desc = "An explosive charge. Detonates when the missile is triggered."
	icon_state = "explosive"
	hull_damage = 8

/obj/item/missile_equipment/payload/explosive/on_trigger(var/atom/triggerer)
	if(istype(triggerer, /obj/effect/shield))
		cell_explosion(get_turf(src), 500, 30)
	else
		cell_explosion(get_turf(triggerer), 500, 30)

	..()
