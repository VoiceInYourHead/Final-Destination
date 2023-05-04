/obj/machinery/computer/ship/ship_weapon/harpoon_gun
	name = "harpoon gun control"
	caldigit = 5
	coolinterval = 45 SECONDS
	gun_name = "Harpoon gun"

	front_type = /obj/machinery/ship_weapon/front_part/harpoon_cannon
	middle_type = /obj/machinery/ship_weapon/middle_part/harpoon_cannon
	back_type = /obj/machinery/ship_weapon/back_part/harpoon_cannon
	munition_type = /obj/structure/ship_munition/ammobox/harpoon_cannon

	burst_size = 1
	fire_interval = 0

	shoot_range = 2

	canhit_missiles = FALSE
	canhit_planets = FALSE

	fire_sound = 'sound/machines/autocannon_fire.ogg'
	overmap_icon = "n_beam" // icons\effects\beam.dmi

	play_emptymag_sound = 0