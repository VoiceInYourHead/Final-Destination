/datum/map_template/ruin/exoplanet/shelter
	name = "shelter"
	id = "shelter0"
	description = "A shelter for those who live on local ruined ecumenopolis."
	suffixes = list("shelters/shelter0.dmm")
	spawn_cost = 0.7
	template_flags = TEMPLATE_FLAG_CLEAR_CONTENTS | TEMPLATE_FLAG_NO_RUINS | TEMPLATE_FLAG_ALLOW_DUPLICATES
	ruin_tags = RUIN_RAINWORLD


/********************** PROPS **********************/

//obj/structure/grille/shelter
//	init_material = MATERIAL_ALIENALLOY

/obj/structure/grille/shelter/attackby(obj/item/W as obj, mob/user as mob)
	set_max_health(9999)

/obj/structure/grille/attack_hand(mob/user as mob)
	set_max_health(9999)

/obj/structure/grille/Initialize(mapload, var/new_material)
	..()
	set_max_health(9999)

/obj/structure/grille/shelter/ex_act()
	health_current = health_max
	return

/obj/structure/grille/shelter/no_fluid_pass/CanFluidPass(var/coming_from)
	return FALSE

/turf/simulated/wall/containment/rainworld/shelter
	paint_color = COLOR_GRAY20
	icon_state = "r_generic"

/obj/random/rain_world
	name = "random urban trash"
	desc = "This is a random trash item."
	icon = 'icons/obj/items.dmi'
	icon_state = "gift1"

/obj/random/rain_world/spawn_choices()
	return list(/obj/structure/rubble/house = 3,
				/obj/random/junk = 4,
				/obj/random/trash = 4,
				/obj/nothing = 6)

/obj/nothing/Initialize()
	..()
	qdel(src)

/turf/unsimulated/floor/plating/rainworld/fake_openspace
	name = "open space"
	color = "grey"
	density = 1

