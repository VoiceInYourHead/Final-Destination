// Destroys missiles that are traveling on the overmap
/obj/item/missile_equipment/payload
	name = "missile payload"
	desc = "dangerous equipment!!"
	var/hull_damage = 10

/obj/item/missile_equipment/payload/on_missile_activated(var/obj/effect/overmap/projectile/P)
	P.set_dangerous(TRUE)
	P.set_enter_zs(TRUE)

/obj/item/missile_equipment/payload/on_trigger()
	qdel(loc)