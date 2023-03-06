/obj/effect/overmap/visitable/sector/exoplanet/urban
	name = "ecumenopolis"
	desc = "A world-wide unpowered city covers the entire planetary surface."
	color = "#615e4f"
	planetary_area = /area/exoplanet/urban
	rock_colors = list(COLOR_ASTEROID_ROCK, COLOR_GRAY80, COLOR_BROWN)
	plant_colors = list("#0e1e14","#1a3e38","#5a7467","#9eab88","#6e7248", "RANDOM")
	map_generators = list(/datum/random_map/noise/exoplanet/urban)
	possible_themes = list(/datum/exoplanet_theme/ruined_city = 100)
	habitability_distribution = list(HABITABILITY_IDEAL = 70, HABITABILITY_OKAY = 20, HABITABILITY_BAD = 5)
	has_trees = TRUE
	daycycle = FALSE
	flora_diversity = 7
	lightlevel = 0.4
	fauna_types = list(/mob/living/simple_animal/hostile/smart_beast/yithian, /mob/living/simple_animal/hostile/smart_beast/tindalos, /mob/living/simple_animal/hostile/retaliate/jelly)
	megafauna_types = list(/mob/living/simple_animal/hostile/retaliate/parrot/space/megafauna, /mob/living/simple_animal/hostile/retaliate/goose/dire)
	repopulate_types = list(/mob/living/simple_animal/hostile/smart_beast/yithian, /mob/living/simple_animal/hostile/smart_beast/tindalos, /mob/living/simple_animal/hostile/retaliate/jelly)
	var/raining = 0
	var/rain_time
	var/current_time
	var/cycle_daytime_min = 2000
	var/cycle_daytime_max = 8000

/obj/effect/overmap/visitable/sector/exoplanet/urban/generate_map()
	..()

/obj/effect/overmap/visitable/sector/exoplanet/urban/generate_atmosphere()
	..()
	if(atmosphere)
		atmosphere.temperature = T20C + rand(10, 30)
		atmosphere.update_values()

/obj/effect/overmap/visitable/sector/exoplanet/urban/get_surface_color()
	return grass_color

/obj/effect/overmap/visitable/sector/exoplanet/urban/adapt_seed(var/datum/seed/S)
	..()
	var/carnivore_prob = rand(100)
	if(carnivore_prob < 60)
		S.set_trait(TRAIT_CARNIVOROUS,2)
		if(prob(75))
			S.get_trait(TRAIT_STINGS, 1)
	else if(carnivore_prob < 90)
		S.set_trait(TRAIT_CARNIVOROUS,1)
		if(prob(50))
			S.get_trait(TRAIT_STINGS)
	if(prob(30) || (S.get_trait(TRAIT_CARNIVOROUS) && prob(50)))
		S.set_trait(TRAIT_BIOLUM,1)
		S.set_trait(TRAIT_BIOLUM_COLOUR,get_random_colour(0,75,190))

	if(prob(30))
		S.set_trait(TRAIT_PARASITE,1)
	if(!S.get_trait(TRAIT_LARGE))
		var/vine_prob = rand(100)
		if(vine_prob < 30)
			S.set_trait(TRAIT_SPREAD,2)
		else if(vine_prob < 60)
			S.set_trait(TRAIT_SPREAD,1)

/obj/effect/overmap/visitable/sector/exoplanet/urban/generate_daycycle()
	return

/obj/effect/overmap/visitable/sector/exoplanet/urban/New(nloc, max_x, max_y)
	..()
	rain_time = world.time + cycle_daytime_max
	for (var/turf/unsimulated/floor/exoplanet/T in block(locate(1,1,min(map_z)),locate(maxx,maxy,max(map_z))))
		T.set_light(lightlevel, 0.1, 2)

/area/exoplanet/urban
	base_turf = /turf/unsimulated/floor/exoplanet/grass
	ambience = list('sound/effects/wind/wind_2_1.ogg','sound/effects/wind/wind_2_2.ogg','sound/effects/wind/wind_3_1.ogg','sound/effects/wind/wind_4_1.ogg','sound/ambience/eeriejungle2.ogg','sound/ambience/eeriejungle1.ogg')
	icon = 'code/modules/overmap/exoplanets/planet_types/rain.dmi'

/area/exoplanet/urban/indoors

/area/exoplanet/urban/play_ambience(var/mob/living/L)
	..()
	if(!L.ear_deaf && L.client && !L.client.ambience_playing)
		L.client.ambience_playing = TRUE
		L.playsound_local(get_turf(L),sound('sound/ambience/jungle.ogg', repeat = 1, wait = 0, volume = 25, channel = GLOB.ambience_sound_channel))

/datum/random_map/noise/exoplanet/urban
	descriptor = "ecumenopolis"
	smoothing_iterations = 2
	land_type = /turf/unsimulated/floor/exoplanet/grass
	water_type = /turf/unsimulated/floor/exoplanet/water/shallow

	flora_prob = 20
	grass_prob = 50
	large_flora_prob = 10

///////////////////////WEATHER///////////////////////

/obj/effect/overmap/visitable/sector/exoplanet/urban/Process(wait, tick)
	..()
	current_time = world.time
	planetary_area.icon_state = "rain[raining]"
	if(rain_time && world.time >= rain_time)
		rain_time = 0
		rain_world()
//	message_admins("raining > 0 [raining > 0]")
	if(raining > 0)
		for (var/mob/living/M in GLOB.living_mob_list_)
			if (M && (M.z in map_z) && istype(M.loc.loc,/area/exoplanet/urban))
				if(prob(30) && raining < 3)
					to_chat(M, SPAN_WARNING("You are hit by the waterdrop!"))
				if(raining == 1)
					shake_camera(M, 200, 0.1, 0.05)
				if(raining == 2)
					shake_camera(M, 200, 0.5, 0.05)
					if(prob(20))
						M.apply_damage(rand(2,10), BRUTE, pick(BP_ALL_LIMBS))
						if(prob(25))
							to_chat(M, SPAN_DANGER("You are hit by the heavy waterdrop!"))
				else if(raining == 3)
					shake_camera(M, 200, 1, 0.05)
					if(prob(40))
						M.apply_damage(rand(2,10), BRUTE, pick(BP_ALL_LIMBS))
						if(prob(25))
							to_chat(M, SPAN_DANGER("You are hit by the heavy waterdrop!"))
				else if(raining == 4)
					shake_camera(M, 200, 2, 0.05)
					if(prob(60))
						M.apply_damage(rand(2,10), BRUTE, pick(BP_ALL_LIMBS))
						if(prob(25))
							to_chat(M, SPAN_DANGER("You are hit by the heavy waterdrop!"))
			else if(M && (M.z in map_z) && raining > 2)
				shake_camera(M, 200, 0.1, 0.05)

/obj/effect/overmap/visitable/sector/exoplanet/urban/proc/rain_world()
	set waitfor = 0
	for (var/mob/M in GLOB.player_list)
		if (M && M.z in map_z)
			to_chat(M, SPAN_WARNING("The storm clouds are brewing."))

	var/rain_zone = block(locate(1,1,min(map_z)),locate(maxx,maxy,max(map_z)))

	for (var/turf/unsimulated/floor/exoplanet/T in rain_zone)
		T.set_light(0.3, 0.1, 2)

	sleep(rand(150,350))
	raining = 1
	for (var/turf/unsimulated/floor/exoplanet/T in rain_zone)
		T.set_light(0.2, 0.1, 2)

	sleep(rand(150,350))
	raining = 2
	for (var/turf/unsimulated/floor/exoplanet/T in rain_zone)
		T.set_light(0.1, 0.1, 2)

	sleep(rand(150,350))
	raining = 3
	for (var/turf/unsimulated/floor/exoplanet/T in rain_zone)
		T.set_light(0.05, 0.1, 2)

	sleep(rand(150,350))
	raining = 4
	for (var/turf/unsimulated/floor/exoplanet/T in rain_zone)
		T.set_light(0)

	sleep(rand(800,1500))
	raining = 0
	rain_time = world.time + rand(cycle_daytime_min, cycle_daytime_max)

	sleep(rand(150,250))
	for (var/turf/unsimulated/floor/exoplanet/T in rain_zone)
		T.set_light(0.2, 0.1, 2)

	sleep(rand(150,250))
	for (var/turf/unsimulated/floor/exoplanet/T in rain_zone)
		T.set_light(lightlevel, 0.1, 2)

///////////////////////FAUNA///////////////////////