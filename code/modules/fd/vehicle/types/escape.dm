/obj/vehicles/large/escape
	name = "Suspicious Truck"
	desc = "A large transport vehicle, made specifically for the harsh environment."

	icon = 'icons/fd/halo_vehicles/train_combined.dmi'
	icon_state = "train"
	anchored = 1

	bound_height = 96
	bound_width = 192

	comp_prof = /datum/component_profile/exploration

	occupants = list(1,1)
	exposed_positions = list("driver" = 0,"passenger" = 20)

	vehicle_size = ITEM_SIZE_VEHICLE_LARGE
	capacity_flag = ITEM_SIZE_VEHICLE_LARGE

	vehicle_view_modifier = 1.5

	acceleration = 2
	min_speed = 7
	max_speed = 1

	interior_template = /datum/map_template/escape
	size_x = 13
	size_y = 35

	serial_number = "escape"
	key_type = /obj/item/key/car/escape

/datum/map_template/escape
	name = "Suspicious Truck"
	mappaths = list("maps/interiors/escape.dmm")

/obj/vehicles/large/escape/on_death()
	. = ..()
