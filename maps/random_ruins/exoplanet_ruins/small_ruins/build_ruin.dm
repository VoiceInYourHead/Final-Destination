/datum/map_template/ruin/exoplanet/build
	name = "Ruined Bulding 1"
	id = "build1"
	description = "Just small ruins."
	suffixes = list("small_ruins/build_ruin.dmm")
	spawn_cost = 0.1
	template_flags = TEMPLATE_FLAG_NO_RUINS | TEMPLATE_FLAG_CLEAR_CONTENTS// | TEMPLATE_FLAG_ALLOW_DUPLICATES
	ruin_tags = RUIN_WRECK

/datum/map_template/ruin/exoplanet/build/build2
	name = "Ruined Bulding 2"
	id = "build2"
	suffixes = list("small_ruins/build_ruin2.dmm")

/datum/map_template/ruin/exoplanet/build/build3
	name = "Ruined Bulding 3"
	id = "build3"
	suffixes = list("small_ruins/build_ruin3.dmm")





//      A R E A S     //

/area/map_template/build
	name = "\improper Building"
	icon_state = "hallC1"
	icon = 'icons/turf/areas.dmi'
/area/map_template/build/build2
/area/map_template/build/build3



// Other Code????    //

/obj/structure/mob_spawner
	name = "hive"
	desc = "A structure with many holes in it.."
	icon = 'icons/effects/effects.dmi'
	icon_state = "hive"
	anchored = TRUE
	var/number_to_spawn = 5
	var/spent = FALSE
	var/detect_range = 5
	var/thing_to_spawn = /mob/living/simple_animal/hostile/leech

/obj/structure/mob_spawner/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/mob_spawner/Process()
	if(!spent && (locate(/mob/living/carbon/human) in orange(detect_range, src)))
		burst()

/obj/structure/mob_spawner/proc/burst()
	for(var/i in 1 to number_to_spawn)
		new thing_to_spawn(get_turf(src))
	visible_message(SPAN_MFAUNA("A swarm of animals burst out from \the [src]!"))
	spent = TRUE
	STOP_PROCESSING(SSobj, src)
