/datum/map_template/ruin/exoplanet/build
	name = "Ruined Bulding 1"
	id = "build1"
	description = "Just small ruins."
	suffixes = list("small_ruins/build_ruin.dmm")
	spawn_cost = 0.1
	template_flags = TEMPLATE_FLAG_NO_RUINS | TEMPLATE_FLAG_CLEAR_CONTENTS// | TEMPLATE_FLAG_ALLOW_DUPLICATES
	ruin_tags = RUIN_WRECK

/datum/map_template/ruin/exoplanet/build/build2
	name = "Ruined Garage 2"
	id = "build2"
	suffixes = list("small_ruins/build_ruin2.dmm")

/datum/map_template/ruin/exoplanet/build/build3
	name = "Ruined Temple 3"
	id = "build3"
	suffixes = list("small_ruins/build_ruin3.dmm")

/datum/map_template/ruin/exoplanet/build/build4
	name = "Ruined Voxship 4"
	id = "build4"
	suffixes = list("small_ruins/build_ruin4.dmm")
	spawn_cost = 0.2

/datum/map_template/ruin/exoplanet/build/build5
	name = "Ruined Rad Wastes 5"
	id = "build5"
	suffixes = list("small_ruins/build_ruin5.dmm")

/datum/map_template/ruin/exoplanet/build/build6
	name = "Ruined Ascent Shuttle 6"
	id = "build6"
	suffixes = list("small_ruins/build_ruin6.dmm")
	ruin_tags = RUIN_ALIEN

/datum/map_template/ruin/exoplanet/build/build7
	name = "Ruined Monolothic Ring 7"
	id = "build7"
	suffixes = list("small_ruins/build_ruin7.dmm")
	ruin_tags = RUIN_ALIEN





//      A R E A S     //

/area/map_template/build
	name = "\improper Building"
	icon_state = "hallC1"
	icon = 'icons/turf/areas.dmi'
/area/map_template/build/build2
	name = "\improper Garage"
/area/map_template/build/build3
	name = "\improper Sandstone Temple"
/area/map_template/build/build4
	name = "\improper VX-421-M"
/area/map_template/build/build5
	name = "\improper Radioactive Wastes"
/area/map_template/build/build6
	name = "\improper ASC-792-F"
/area/map_template/build/build7
	name = "\improper Monolithic Ring"
/area/map_template/build/build8



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

/obj/effect/landmark/corpse/betrayed_engineer
	name = "Peter Napp"
	corpse_outfits = list(/decl/hierarchy/outfit/betrayed_engineer)
	spawn_flags = ~CORPSE_SPAWNER_RANDOM_NAME

/decl/hierarchy/outfit/betrayed_engineer
	name = "Betrayed Engineer"
	uniform = /obj/item/clothing/under/solgov/utility/expeditionary/engineering
	suit = /obj/item/clothing/suit/storage/solgov/service/expeditionary/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	head = /obj/item/clothing/head/solgov/service/expedition
	pda_type = /obj/item/modular_computer/pda/engineering

// PAPERS??? //

/obj/item/paper/rad_wastes
	name = "Last Note"
	language = LANGUAGE_HUMAN_EURO
	age = 1
	info = "I am so sorry for what I have done, but how can they punish people with such methods?<br>How could an officer even allow this?<br>I hope that justice will prevail and Alex Peterson will be punished for his actions.<br>Former Engineer, Expl. Peter Napp."
