/mob/living/exosuit/premade/oni
	name = "combat exosuit"
	desc = "A sleek, light weighted combat exosuit."

/mob/living/exosuit/premade/oni/Initialize()
	if(!arms)
		arms = new /obj/item/mech_component/manipulators/light/oni(src)
	if(!legs)
		legs = new /obj/item/mech_component/propulsion/light(src)
		legs.color = COLOR_GUNMETAL
	if(!head)
		head = new /obj/item/mech_component/sensors/light/combat/oni(src)
	if(!body)
		body = new /obj/item/mech_component/chassis/combat/horned(src)
		body.color = COLOR_GUNMETAL

	. = ..()

/mob/living/exosuit/premade/oni/spawn_mech_equipment()
	..()
	install_system(new /obj/item/mech_equipment/mounted_system/taser/machinegun(src), HARDPOINT_LEFT_HAND)
	install_system(new /obj/item/mech_equipment/mounted_system/melee/mechete(src), HARDPOINT_RIGHT_HAND)
	install_system(new /obj/item/mech_equipment/ionjets(src), HARDPOINT_BACK)
	install_system(new /obj/item/mech_equipment/shields(src), HARDPOINT_RIGHT_SHOULDER)