/mob/living/exosuit/premade/combat
	name = "combat exosuit"
	desc = "A sleek, modern combat exosuit."

/mob/living/exosuit/premade/combat/Initialize()
	if(!arms)
		arms = new /obj/item/mech_component/manipulators/combat(src)
		arms.color = COLOR_GUNMETAL
	if(!legs)
		legs = new /obj/item/mech_component/propulsion/combat(src)
		legs.color = COLOR_GUNMETAL
	if(!head)
		head = new /obj/item/mech_component/sensors/combat(src)
		head.color = COLOR_GUNMETAL
	if(!body)
		body = new /obj/item/mech_component/chassis/combat(src)
		body.color = COLOR_GUNMETAL

	. = ..()

/mob/living/exosuit/premade/combat/spawn_mech_equipment()
	..()
	install_system(new /obj/item/mech_equipment/mounted_system/taser(src), HARDPOINT_LEFT_HAND)
	install_system(new /obj/item/mech_equipment/mounted_system/taser/ion(src), HARDPOINT_RIGHT_HAND)
	install_system(new /obj/item/mech_equipment/flash(src), HARDPOINT_LEFT_SHOULDER)
	install_system(new /obj/item/mech_equipment/light(src), HARDPOINT_RIGHT_SHOULDER)

/mob/living/exosuit/premade/combat/military
	decal = "cammo1"

/mob/living/exosuit/premade/combat/military/alpine
	decal = "cammo2"

/mob/living/exosuit/premade/combat/military/Initialize()
	. = ..()
	for(var/obj/thing in list(arms,legs,head,body))
		thing.color = COLOR_WHITE

/*************************** AEGIS MECHA ***************************/

/obj/item/mech_component/chassis/powerloader/combat
	name = "lightweight combat exosuit chassis"
	pilot_coverage = 100
	transparent_cabin = TRUE
	has_hardpoints = list(HARDPOINT_LEFT_SHOULDER, HARDPOINT_RIGHT_SHOULDER)

/obj/item/mech_component/chassis/powerloader/combat/prebuild()
	cell = new /obj/item/cell/hyper(src)
	cell.charge = cell.maxcharge

	. = ..()

	m_armour = new /obj/item/robot_parts/robot_component/armour/exosuit/combat(src)


/obj/item/mech_component/sensors/light/combat
	max_damage = 50

/obj/item/mech_component/sensors/light/combat/oni //so we can see horns atleast in some way
	icon_state = "light_head_special"

/obj/item/mech_component/sensors/light/combat/prebuild()
	..()
	software = new(src)
	software.installed_software = list(MECH_SOFTWARE_WEAPONS, MECH_SOFTWARE_UTILITY)


/mob/living/exosuit/premade/combat/aegis
	name = "Scout Combat Exosuit"
	desc = "A sleek, modern combat exosuit with PV Aegis markings."
	decal = "cammo2"

/mob/living/exosuit/premade/combat/aegis/Initialize()
	body = new /obj/item/mech_component/chassis/powerloader/combat(src)
	head = new /obj/item/mech_component/sensors/light/combat(src)
	. = ..()
	for(var/obj/thing in list(arms,legs,head,body))
		thing.color = COLOR_WHITE

/mob/living/exosuit/premade/combat/aegis/spawn_mech_equipment()
	install_system(new /obj/item/mech_equipment/mounted_system/taser/machinegun(src), HARDPOINT_RIGHT_HAND)
	install_system(new /obj/item/mech_equipment/mounted_system/melee/mechete(src), HARDPOINT_LEFT_HAND)
	install_system(new /obj/item/mech_equipment/camera(src), HARDPOINT_LEFT_SHOULDER)
	install_system(new /obj/item/mech_equipment/light(src), HARDPOINT_RIGHT_SHOULDER)
