/obj/machinery/computer/ship/ship_weapon/beam_cannon
	name = "ion beam emitter control"
	caldigit = 6
	coolinterval = 120 SECONDS
	gun_name = "Ion beam emitter"

	hull_damage = 75

	front_type = /obj/machinery/ship_weapon/front_part/beam_cannon
	middle_type = /obj/machinery/ship_weapon/middle_part/beam_cannon
	back_type = /obj/machinery/ship_weapon/back_part/beam_cannon
	munition_type = /obj/structure/ship_munition/ammobox/cell

	ammo_per_shot = 1000
	burst_size = 1

	fire_delay = 200

	shake_camera_force = 50

	destroy_event_flags = OVERMAP_WEAKNESS_EXPLOSIVE

	shield_modflag_counter = MODEFLAG_PHOTONIC

	ignore_blockage = TRUE

	pew_spread = 50

	fire_sound = 'sound/machines/superlaser_firing.ogg'
	prefire_sound = 'sound/machines/superlaser_prefire.ogg'

	far_fire_sound = 'sound/machines/superlaser_firing.ogg'
	far_prefire_sound = 'sound/machines/superlaser_prefire.ogg'

	overmap_icon = "ion_beam" // icons\effects\beam.dmi

	var/beam_time = 70
	var/beam_speed = 1

	var/beam_light_color = COLOR_RED_LIGHT
	var/beam_icon = "ion_beam" // icons\effects\beam.dmi

	var/beam_sound = 'sound/machines/ion_beam_hit.ogg'