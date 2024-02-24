/turf/unsimulated/wall
	name = "wall"
	icon = 'icons/turf/walls.dmi'
	icon_state = "riveted"
	opacity = 1
	density = TRUE

/turf/unsimulated/wall/fakeglass
	name = "window"
	icon_state = "fakewindows"
	opacity = 0

/turf/unsimulated/wall/other
	icon_state = "r_wall"

/turf/unsimulated/wall/cult
	name = "cult wall"
	desc = "Hideous images dance beneath the surface."
	icon = 'icons/turf/wall_masks.dmi'
	icon_state = "cult"

/turf/unsimulated/wall/vehicle
	name = "vehicle interior wall"
	icon = 'icons/fd/halo_vehicles/vehicle_walls.dmi'
	icon_state = ""
	opacity = 1
	density = TRUE
	blocks_air = 1
	thermal_conductivity = WALL_HEAT_TRANSFER_COEFFICIENT
	heat_capacity = 312500 //a little over 5 cm thick , 312500 for 1 m by 2.5 m by 0.25 m plasteel wall
	atom_flags = ATOM_FLAG_CAN_BE_PAINTED


/turf/unsimulated/wall/vehicle/Initialize()
	if(GAME_STATE >= RUNLEVEL_GAME)
		fluid_update()
	. = ..()

/turf/unsimulated/wall/vehicle/New()
	..()
	if(istype(loc, /area/chapel))
		holy = 1
	levelupdate()

/turf/unsimulated/wall/vehicle/levelupdate()
	for(var/obj/O in src)
		O.hide(1)

/turf/unsimulated/wall/vehicle/protects_atom(var/atom/A)
	var/obj/O = A
	return (istype(O) && O.hides_under_flooring()) || ..()

/turf/unsimulated/wall/vehicle/triceratops
	name = "vehicle interior wall"
	icon_state = "wall"
