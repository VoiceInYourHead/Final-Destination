/datum/junkyard_theme/robotic_guardians
	name = "Robotic Guardians"
/*	var/list/guardian_types = list(
		/mob/living/simple_animal/hostile/hivebot,
		/mob/living/simple_animal/hostile/hivebot/range,
		/mob/living/simple_animal/hostile/viscerator/hive
	)
	var/list/mega_guardian_types = list(
		/mob/living/simple_animal/hostile/hivebot/mega
	)*/

/*/datum/junkyard_theme/robotic_guardians/before_map_generation(obj/effect/overmap/visitable/sector/junkyard/E)
	E.fauna_types |= guardian_types
	E.megafauna_types |= mega_guardian_types*/

/datum/junkyard_theme/robotic_guardians/get_sensor_data()
	return "Movement without corresponding lifesigns detected on the surface."