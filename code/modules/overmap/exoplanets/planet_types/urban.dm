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
	flora_diversity = 7
	lightlevel = 0.1
	fauna_types = list(/mob/living/simple_animal/hostile/smart_beast/yithian, /mob/living/simple_animal/hostile/smart_beast/tindalos, /mob/living/simple_animal/hostile/retaliate/jelly)
	megafauna_types = list(/mob/living/simple_animal/hostile/retaliate/parrot/space/megafauna, /mob/living/simple_animal/hostile/retaliate/goose/dire)
	repopulate_types = list(/mob/living/simple_animal/hostile/smart_beast/yithian, /mob/living/simple_animal/hostile/smart_beast/tindalos, /mob/living/simple_animal/hostile/retaliate/jelly)
	var/raining = 0

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

/area/exoplanet/urban
	base_turf = /turf/unsimulated/floor/exoplanet/grass
	ambience = list('sound/effects/wind/wind_2_1.ogg','sound/effects/wind/wind_2_2.ogg','sound/effects/wind/wind_3_1.ogg','sound/effects/wind/wind_4_1.ogg','sound/ambience/eeriejungle2.ogg','sound/ambience/eeriejungle1.ogg')
	icon = 'code/modules/overmap/exoplanets/planet_types/rain.dmi'

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

/obj/effect/overmap/visitable/sector/exoplanet/urban/Process()
	..()
	if(raining && raining <= 5)
		planetary_area.icon_state = "rain[raining]"