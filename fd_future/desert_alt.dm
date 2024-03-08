GLOBAL_LIST_EMPTY(cloud_turfs)

/obj/effect/overmap/visitable/sector/exoplanet/desert_good
	name = "deserted ruins"
	desc = "An old city, crumbled under the Ascent's invasion."
	color = "#a7a7a7"
	planetary_area = /area/exoplanet/desert_good
	rock_colors = list(COLOR_BEIGE, COLOR_PALE_YELLOW, COLOR_GRAY80, COLOR_BROWN)
	plant_colors = list("#efdd6f","#7b4a12","#e49135","#ba6222","#5c755e","#420d22")
	map_generators = list(/datum/random_map/noise/exoplanet/desert)
	surface_color = "#bdbaa8"
	water_color = null
	habitability_distribution = list(HABITABILITY_IDEAL = 70, HABITABILITY_OKAY = 20, HABITABILITY_BAD = 5)
	has_trees = FALSE
	flora_diversity = 4
	features_budget = 4
	possible_themes = list(/datum/exoplanet_theme/ruined_city)
	fauna_types = list(/mob/living/simple_animal/hostile/smart_beast/thinbug, /mob/living/simple_animal/hostile/smart_beast/tindalos, /mob/living/simple_animal/hostile/voxslug, /mob/living/simple_animal/hostile/retaliate/beast/antlion)
	megafauna_types = list(/mob/living/simple_animal/hostile/retaliate/beast/antlion/mega)
	repopulate_types = list(/mob/living/simple_animal/hostile/smart_beast/thinbug, /mob/living/simple_animal/hostile/smart_beast/tindalos, /mob/living/simple_animal/hostile/voxslug, /mob/living/simple_animal/hostile/retaliate/beast/antlion)

/obj/effect/overmap/visitable/sector/exoplanet/desert_good/generate_map()
	lightlevel = rand(0.3,0.5)/10
	..()

/obj/effect/overmap/visitable/sector/exoplanet/desert_good/generate_atmosphere()
	..()
	if(atmosphere)
		atmosphere.temperature = T0C + rand(0, 50)
		atmosphere.update_values()

/obj/effect/overmap/visitable/sector/exoplanet/desert_good/adapt_seed(var/datum/seed/S)
	..()
	if(prob(90))
		S.set_trait(TRAIT_REQUIRES_WATER,0)
	else
		S.set_trait(TRAIT_REQUIRES_WATER,1)
		S.set_trait(TRAIT_WATER_CONSUMPTION,1)
	if(prob(75))
		S.set_trait(TRAIT_STINGS,1)
	if(prob(75))
		S.set_trait(TRAIT_CARNIVOROUS,2)
	S.set_trait(TRAIT_SPREAD,0)

/datum/random_map/noise/exoplanet/desert_good/get_additional_spawns(var/value, var/turf/T)
	..()
	var/v = noise2value(value)
	if(v > 6 && prob(2))
		new/obj/effect/quicksand(T)

/area/exoplanet/desert_good
	ambience = list('sound/effects/wind/desert0.ogg','sound/effects/wind/desert1.ogg','sound/effects/wind/desert2.ogg','sound/effects/wind/desert3.ogg','sound/effects/wind/desert4.ogg','sound/effects/wind/desert5.ogg')
	base_turf = /turf/unsimulated/floor/exoplanet/desert/alt

/turf/unsimulated/floor/exoplanet/desert/alt
	color = "#bdbaa8"

/turf/unsimulated/floor/exoplanet/clouds
	icon = 'icons/turf/space.dmi'

	name = "\proper clouds"
	icon_state = "white"

	plane = SPACE_PLANE
	temperature = T20C
	thermal_conductivity = OPEN_HEAT_TRANSFER_COEFFICIENT
	turf_flags = TURF_DISALLOW_BLOB

	z_eventually_space = TRUE

/turf/unsimulated/floor/exoplanet/clouds/Initialize()
	. = ..()
	GLOB.cloud_turfs += src
	update_starlight()
	if(!HasBelow(z))
		return
	var/turf/below = GetBelow(src)

	if(istype(below, /turf/unsimulated/floor/exoplanet/clouds))
		return
	var/area/A = below.loc

	if(!below.density && (A.area_flags & AREA_FLAG_EXTERNAL))
		return

	return INITIALIZE_HINT_LATELOAD // oh no! we need to switch to being a different kind of turf!

/turf/unsimulated/floor/exoplanet/clouds/Destroy()
	// Cleanup cached z_eventually_space values above us.
	if (above)
		var/turf/T = src
		while ((T = GetAbove(T)))
			T.z_eventually_space = FALSE
	return ..()

/turf/unsimulated/floor/exoplanet/clouds/LateInitialize()
	if(GLOB.using_map.base_floor_area)
		var/area/new_area = locate(GLOB.using_map.base_floor_area) || new GLOB.using_map.base_floor_area
		ChangeArea(src, new_area)
	ChangeTurf(GLOB.using_map.base_floor_type)

// override for space turfs, since they should never hide anything
/turf/unsimulated/floor/exoplanet/clouds/levelupdate()
	for(var/obj/O in src)
		O.hide(0)

/turf/unsimulated/floor/exoplanet/clouds/proc/update_starlight()
	if(!config.starlight)
		return
	if(locate(/turf/simulated) in orange(src,3)) //Let's make sure not to break everything if people use a crazy setting.
		set_light(min(0.3*config.starlight, 1), 1, 5, l_color = "#f1ca91")
	else
		set_light(0)

/turf/unsimulated/floor/exoplanet/clouds/attackby(obj/item/C as obj, mob/user as mob)

	if(istype(C, /obj/item/stack/tile))
		var/obj/item/stack/tile/T = C
		if(T.use(1))
			playsound(src, 'sound/items/Deconstruct.ogg', 80, 1)
			ChangeTurf(/turf/simulated/floor, FALSE, FALSE, TRUE)
	else if (isCrowbar(C) || isWelder(C) || istype(C, /obj/item/gun/energy/plasmacutter))
		return

/turf/unsimulated/floor/exoplanet/clouds/is_open()
	return TRUE

/turf/unsimulated/floor/exoplanet/clouds/Crossed(atom/movable/mover, atom/forget)
	if(!isliving(mover) || istype(mover, /obj/effect))
		return ..()

	var/datum/thrownthing/flying = mover.throwing
	if(flying)
		if(flying.target_turf != src)
			return ..()

	for(var/obj/scaffolding in src)
		var/obj_layer = scaffolding.layer
		if(obj_layer == CATWALK_LAYER || obj_layer == LATTICE_LAYER)
			return ..()

	addtimer(CALLBACK(mover, /atom/movable/proc/fake_fall, src), 2)
	return ..()

/atom/movable/proc/fake_fall(turf/clouds)
	if(ishuman(src))
		var/mob/living/carbon/human/fallen = src
		spawn(1 SECONDS)
			fallen.emote("scream")
			playsound(clouds, get_sfx("fracture"), 25, TRUE)
			playsound(clouds, get_sfx("fracture"), 50, TRUE)
			playsound(clouds, get_sfx("fracture"), 75, TRUE)

	visible_message(SPAN_DANGER("\The [src] falls straight into [clouds]!"))
	qdel(src)

/turf/unsimulated/floor/exoplanet/clouds/is_solid_structure()
	return locate(/obj/structure/lattice, src) || locate(/obj/structure/catwalk, src) //counts as solid structure if it has a lattice or catwalk

/turf/unsimulated/floor/exoplanet/clouds/transit
	icon_state = "white"

/turf/unsimulated/floor/exoplanet/clouds/transit/attackby(obj/O as obj, mob/user as mob)
	return