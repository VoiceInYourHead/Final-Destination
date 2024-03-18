#include "small_away_areas.dm"

/*

/obj/effect/overmap/visitable/sector/QWERTY123
	name = "QWERTY123"
	desc = "QWERTY123"
	icon_state = "object"
	known = 0
	initial_generic_waypoints = list()

/datum/map_template/ruin/away_site/QWERTY123
	name = "QWERTY123"
	id = "awaysite_QWERTY123"
	description = "QWERTY123"
	suffixes = list("small_away/QWERTY123.dmm")
	spawn_cost = 0.5
	area_usage_test_exempted_root_areas = list()
	apc_test_exempt_areas = list()



useful things:
/obj/effect/shuttle_landmark/automatic

*/

/obj/effect/overmap/visitable/sector/dogfighting
	name = "The Battlefield"
	desc = "Sensors array have detected the remains of ships with critical damage."
	icon_state = "object"
	known = 1
	initial_generic_waypoints = list()

/datum/map_template/ruin/away_site/dogfighting
	name = "Battlefield"
	id = "awaysite_dogfighting"
	description = "This is Ships Battlefield."
	suffixes = list("small_away/dogfighting.dmm")
	spawn_cost = 0.5
	area_usage_test_exempted_root_areas = list()
	apc_test_exempt_areas = list()

// ICCG GUNSHIP CODE, yeah, in "small_away" directory, what do you do with that?

/obj/effect/overmap/visitable/ship/iccg_gunboat
	name = "GCCV - Novorossiysk"
	desc = "Sensors array have detected a ship broadcasting the codes 'GCCV - Novorossiysk', belonging to the Confederation."
	icon_state = "ship"
	color = "#741a30"
	known = 0
	initial_generic_waypoints = list()
	initial_restricted_waypoints = list(
		"Infiltrator" = list("nav_iccg_g_dock")
	)

/obj/effect/overmap/visitable/sector/ship/iccg_gunboat/New(nloc, max_x, max_y)
	desc = "Sensors array have detected a ship broadcasting the codes '[name]', belonging to the Confederation."
	..()

/datum/map_template/ruin/away_site/iccg_gunboat
	name = "ICCG Gunboat"
	id = "awaysite_iccg_gunboat"
	description = "This is Confederation Gunboat."
	suffixes = list("small_away/iccg_gunboat.dmm")
	spawn_cost = 99
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/iccg_gunboat_infiltrator, /datum/shuttle/autodock/overmap/iccg_gunboat_fedor)
	area_usage_test_exempted_root_areas = list()
	apc_test_exempt_areas = list()

/turf/simulated/wall/r_wall/black
	paint_color = COLOR_DARK_GRAY
	color = COLOR_DARK_GRAY

/turf/simulated/wall/r_wall/black/New(var/newloc)
	..(newloc, MATERIAL_PLASTEEL,MATERIAL_TITANIUM)

/turf/simulated/wall/r_wall/black/Initialize()
	. = ..()
	paint_color = color
	color = null //color is just for mapping
	if(prob(90))
		var/spacefacing = FALSE
		for(var/direction in GLOB.cardinal)
			var/turf/T = get_step(src, direction)
			var/area/A = get_area(T)
			if(A && (A.area_flags & AREA_FLAG_EXTERNAL))
				spacefacing = TRUE
				break
		if(spacefacing)
			var/bleach_factor = rand(10,50)
			paint_color = "[pick("#420d0d", COLOR_DARK_GRAY)]"
			paint_color = adjust_brightness(paint_color, bleach_factor)
	update_icon()

/obj/machinery/computer/shuttle_control/explore/iccg_gunboat_infiltrator //infiltrator
	name = "Filtrator control console"
	req_access = list(access_iccg)
	shuttle_tag = "Infiltrator"

/obj/effect/overmap/visitable/ship/landable/iccg_gunboat_infiltrator
	name = "PV - Filtrator"
	shuttle = "Infiltrator"
	fore_dir = WEST
	dir = WEST
	integrity_failure_cap = 20
	color = "#741a30"
	alpha = 100
	vessel_mass = 150
	vessel_size = SHIP_SIZE_TINY

/datum/shuttle/autodock/overmap/iccg_gunboat_infiltrator
	name = "Infiltrator"
	warmup_time = 5
	current_location = "nav_iccg_g_dock"
	range = 1
	shuttle_area = /area/map_template/small_away/iccg_gunboat/infiltrator
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_UNSKILLED
	ceiling_type = /turf/simulated/floor/shuttle_ceiling/torch

/obj/effect/shuttle_landmark/iccg_gunboat_infiltrator
	name = "Filtrator Hangar"
	landmark_tag = "nav_iccg_g_dock"
	base_area = /area/map_template/small_away/iccg_gunboat/hangar
	base_turf = /turf/simulated/floor/plating
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/machinery/computer/shuttle_control/explore/iccg_gunboat_fedor //fedor
	name = "Fedor control console"
	req_access = list(access_iccg)
	shuttle_tag = "Fedor"

/obj/effect/overmap/visitable/ship/landable/iccg_gunboat_fedor
	name = "PV - Fedor"
	shuttle = "Fedor"
	fore_dir = WEST
	dir = WEST
	integrity_failure_cap = 30
	color = "#ce0335"
	vessel_mass = 200
	vessel_size = SHIP_SIZE_TINY

/datum/shuttle/autodock/overmap/iccg_gunboat_fedor
	name = "Fedor"
	warmup_time = 5
	current_location = "nav_iccg_fedor_dock"
	range = 0
	shuttle_area = /area/map_template/small_away/iccg_gunboat/fedor
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_UNSKILLED
	ceiling_type = /turf/simulated/floor/shuttle_ceiling/torch

/obj/effect/shuttle_landmark/iccg_gunboat_fedor
	name = "Fedor Hangar"
	landmark_tag = "nav_iccg_fedor_dock"
	base_area = /area/map_template/small_away/iccg_gunboat/hangar/fedor
	base_turf = /turf/simulated/floor/plating
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/turf/simulated/wall/black
	paint_color = COLOR_DARK_GRAY

/turf/simulated/wall/black/New(var/newloc)
	..(newloc, MATERIAL_PLASTEEL)

/obj/item/reagent_containers/pill/keloderm
	name = "KeloDerm (30u)"
	desc = "Used to treat severe burn wounds."
	icon_state = "pill2"
/obj/item/reagent_containers/pill/keloderm/New()
	..()
	reagents.add_reagent(/datum/reagent/dermaline, 15)
	reagents.add_reagent(/datum/reagent/kelotane, 15)
	color = reagents.get_color()

/obj/item/storage/pill_bottle/keloderm
	name = "pill bottle (KeloDerm)"
	desc = "Contains pills used to treat severe burn wounds."

	startswith = list(/obj/item/reagent_containers/pill/keloderm = 21)
	wrapper_color = COLOR_ORANGE

/obj/item/reagent_containers/glass/beaker/large/cryomix/New()
	..()
	reagents.add_reagent(/datum/reagent/cryoxadone, 30)
	reagents.add_reagent(/datum/reagent/clonexadone, 30)
	reagents.add_reagent(/datum/reagent/peridaxon, 30)
	update_icon()

/obj/item/grenade/chem_grenade/large/potassium
	name = "potassium grenade"
	desc = "Used for emergency DESTROYING everything."
	path = 1
	stage = 2


/obj/item/grenade/chem_grenade/large/potassium/Initialize()
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/large/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/large/B2 = new(src)
	B1.reagents.add_reagent(/datum/reagent/potassium, 120)
	B2.reagents.add_reagent(/datum/reagent/water, 120)
	detonator = new/obj/item/device/assembly_holder/timer_igniter(src)
	beakers += B1
	beakers += B2
	icon_state = initial(icon_state) +"_locked"

/obj/machinery/atmospherics/unary/engine/away
	name = "rocket nozzle"
	desc = "Simple rocket nozzle, expelling gas at hypersonic velocities to propell the ship. This one works mainly with hot gas and does not waste extra energy."
	moles_per_burn = 1.0
	charge_per_burn = 8000
	boot_time = 25
/obj/machinery/atmospherics/unary/engine/away/check_blockage()
	return FALSE

/obj/structure/reagent_dispensers/fueltank/safe
	name = "fuel barrel"
	desc = "A barrel containing welding fuel."
	icon = 'icons/fd/marines/rebase_icons.dmi'
	icon_state = "weldtank_old"
	anchored = TRUE

/obj/structure/reagent_dispensers/fueltank/safe/explode()
	ex_act(1, null, get_turf(src))
	qdel(src)

/obj/structure/reagent_dispensers/fueltank/safe/napalm
	name = "napalm barrel"
	desc = "A barrel containing napalm."
	initial_reagent_types = list(/datum/reagent/napalm = 1)

/obj/item/reagent_containers/food/drinks/bottle/small/blackout
	name = "blackout stout"
	desc = "If you haven't heard of it, that means it worked."
	icon_state = "beer"
	center_of_mass = "x=16;y=12"

/obj/item/reagent_containers/food/drinks/bottle/small/blackout/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/ethanol/blackout_stout, 30)
