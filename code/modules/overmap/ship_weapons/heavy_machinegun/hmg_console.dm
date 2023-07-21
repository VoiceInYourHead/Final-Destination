/obj/machinery/computer/ship/ship_weapon/hmg
	name = "heavy machine gun control"
	caldigit = 2
	coolinterval = 8 SECONDS
	gun_name = "Heavy machine gun"

	front_type = /obj/machinery/ship_weapon/front_part/hmg
	middle_type = /obj/machinery/ship_weapon/middle_part/hmg
	back_type = /obj/machinery/ship_weapon/back_part/hmg
	munition_type = /obj/item/ammo_magazine/ammobox/hmg

	burst_size = 10
	fire_interval = 3

/obj/machinery/computer/ship/ship_weapon/hmg/telescreen	//little hacky but it's only used on one ship so it should be okay
	icon_state = "tele_hmg"
	density = FALSE
	machine_name = "HMG control telescreen"
	machine_desc = "A compact, slimmed-down version of the weapon control console."

/obj/machinery/computer/ship/ship_weapon/hmg/telescreen/on_update_icon()
	if(reason_broken & MACHINE_BROKEN_NO_PARTS || stat & NOPOWER || stat & BROKEN)
		icon_state = "tele_off"
		set_light(0)
	else
		icon_state = "tele_hmg"
		set_light(light_max_bright_on, light_inner_range_on, light_outer_range_on, 2, light_color)