/obj/effect/overmap/visitable/sector/exoplanet/underwater
	name = "water exoplanet"
	desc = "Planet covered with water."
	color = "#708eda"
	planetary_area = /area/exoplanet/water
	rock_colors = list(COLOR_ASTEROID_ROCK, COLOR_GRAY80, COLOR_BROWN)
	plant_colors = list("#0e1e14","#1a3e38","#5a7467","#9eab88","#6e7248", "RANDOM")
	map_generators = list(/datum/random_map/noise/exoplanet/water)
	habitability_distribution = list(HABITABILITY_IDEAL = 70, HABITABILITY_OKAY = 20, HABITABILITY_BAD = 5)
	has_trees = FALSE
	flora_diversity = 3
	fauna_types = list(/mob/living/simple_animal/hostile/aquatic/shark, /mob/living/simple_animal/hostile/retaliate/jelly)
	megafauna_types = list(/mob/living/simple_animal/hostile/aquatic/deathsquid)

/obj/effect/overmap/visitable/sector/exoplanet/underwater/generate_map()
	if(prob(40))
		lightlevel = rand(7,10)/10	//give a chance of twilight jungle
	..()

/obj/effect/overmap/visitable/sector/exoplanet/underwater/generate_atmosphere()
	..()
	if(atmosphere)
		atmosphere.temperature = T20C + rand(10, 30)
		atmosphere.update_values()

/obj/effect/overmap/visitable/sector/exoplanet/underwater/adapt_seed(var/datum/seed/S)
	..()
	var/carnivore_prob = rand(100)
	if(carnivore_prob < 30)
		S.set_trait(TRAIT_CARNIVOROUS,2)
		if(prob(75))
			S.get_trait(TRAIT_STINGS, 1)
	else if(carnivore_prob < 60)
		S.set_trait(TRAIT_CARNIVOROUS,1)
		if(prob(50))
			S.get_trait(TRAIT_STINGS)
	if(prob(15) || (S.get_trait(TRAIT_CARNIVOROUS) && prob(40)))
		S.set_trait(TRAIT_BIOLUM,1)
		S.set_trait(TRAIT_BIOLUM_COLOUR,get_random_colour(0,75,190))

	if(prob(30))
		S.set_trait(TRAIT_PARASITE,1)
	if(!S.get_trait(TRAIT_LARGE))
		var/vine_prob = rand(100)
		if(vine_prob < 15)
			S.set_trait(TRAIT_SPREAD,2)
		else if(vine_prob < 30)
			S.set_trait(TRAIT_SPREAD,1)

/area/exoplanet/water
	base_turf = /turf/simulated/ocean
	ambience = list('sound/effects/wind/wind_2_1.ogg','sound/effects/wind/wind_2_2.ogg','sound/effects/wind/wind_3_1.ogg','sound/effects/wind/wind_4_1.ogg','sound/ambience/eeriejungle2.ogg','sound/ambience/eeriejungle1.ogg')

/area/exoplanet/water/play_ambience(var/mob/living/L)
	..()
	if(!L.ear_deaf && L.client && !L.client.ambience_playing)
		L.client.ambience_playing = TRUE
		L.playsound_local(get_turf(L),sound('sound/ambience/jungle.ogg', repeat = 1, wait = 0, volume = 25, channel = GLOB.ambience_sound_channel))

/datum/random_map/noise/exoplanet/water
	descriptor = "water exoplanet"
	smoothing_iterations = 2
	land_type = /turf/simulated/ocean

	flora_prob = 0.1
	large_flora_prob = 0
	fauna_prob = 0
