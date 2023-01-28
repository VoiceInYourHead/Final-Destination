/obj/effect/overmap/visitable/sector/junkyard/default
	name = "junkyard"
	desc = "Big debris field."
	color = "#708eda"
	junk_area = /area/space/junkyard
	map_generators = list(/datum/random_map/noise/junkyard/default)
	fauna_types = list(/mob/living/simple_animal/hostile/carp, /mob/living/simple_animal/hostile/carp/shark)
	megafauna_types = list(/mob/living/simple_animal/hostile/carp/pike)

/obj/effect/overmap/visitable/sector/junkyard/default/generate_map()
	..()

/datum/random_map/noise/junkyard/default
	descriptor = "junkyard"
	smoothing_iterations = 2
	land_type = /turf/space

	fauna_prob = 2
