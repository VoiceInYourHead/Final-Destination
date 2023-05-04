/obj/machinery/computer/ship/ship_weapon/disruptor
	name = "disruptor control"
	coolinterval = 16 SECONDS
	gun_name = "Disruptor"

	hull_damage = 0

	front_type = /obj/machinery/ship_weapon/front_part/disruptor
	middle_type = /obj/machinery/ship_weapon/middle_part/disruptor
	back_type = /obj/machinery/ship_weapon/back_part/disruptor
	munition_type = /obj/structure/ship_munition/ammobox/cell

	ammo_per_shot = 150
	burst_size = 4
	fire_interval = 4
	pew_spread = 40

	prefire_sound = 'sound/machines/charge.ogg'
	fire_delay = 4

	shake_camera_force = 0

	shield_modflag_counter = MODEFLAG_EM

	fire_sound = 'sound/machines/shoot.ogg'
	far_fire_sound = 'sound/machines/shoot.ogg'

	muzzle_flash = /obj/effect/projectile/bullet/muzzle/ship_weapon/disruptor
	overmap_icon = "bullet"

	play_emptymag_sound = 0

/obj/machinery/computer/ship/ship_weapon/disruptor/get_ammo_type()
	return /obj/item/projectile/bullet/disruptor