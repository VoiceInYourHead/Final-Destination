// Nuclear, for specific uses and admin shittery.
/obj/structure/missile/locked/nuke
	name = "SNDM-M missile"
	overmap_name = "tactical missile"
	desc = "A weapon designed to squash insurrections and, in proper configurations, crack planets. If you're the target? Start praying."

	equipment = list(
		/obj/item/missile_equipment/thruster,
		/obj/item/missile_equipment/autoarm,
		/obj/item/missile_equipment/payload/nuclear
	)

// Nuclear, for specific uses and admin shittery.
/obj/structure/missile/locked/nuke/doomsday
	name = "missile of DOOM"
	overmap_name = "doomsday missile"
	desc = "Start praying."

	equipment = list(
		/obj/item/missile_equipment/thruster,
		/obj/item/missile_equipment/autoarm,
		/obj/item/missile_equipment/payload/nuclear/doomsday
	)