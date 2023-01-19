/obj/machinery/computer/ship/autocannon/harpoon
	name = "harpoon cannon control"
	caldigit = 6 //number of digits that needs calibration
	coolinterval = 60 SECONDS //time to wait between safe shots in deciseconds
	console_html_name = "autocannon.tmpl"

	front = /obj/machinery/autocannon/harpoon/front
	middle = /obj/machinery/autocannon/harpoon/middle
	back = /obj/machinery/autocannon/harpoon/back
	munition = /obj/structure/ship_munition/ammobox/harpoon

	danger_zone = 0
	burst_size = 1
	gun_name = "harpoon cannon"
	fire_sound = 'sound/machines/autocannon_fire.ogg'
	overmap_icon = "n_beam" // icons\effects\beam.dmi
	play_emptymag_sound = 0