/obj/effect/overmap/visitable/sector/exoplanet/urban
	name = "ecumenopolis"
	desc = "A world-wide unpowered city covers the entire planetary surface."
	color = "#615e4f"
	max_animal_count = 30
	planetary_area = /area/exoplanet/urban/outdoors
	rock_colors = list(COLOR_ASTEROID_ROCK, COLOR_GRAY80, COLOR_BROWN)
	plant_colors = list("#0e1e14","#1a3e38","#5a7467","#9eab88","#6e7248", "RANDOM")
	map_generators = list(/datum/random_map/noise/exoplanet/urban)
	possible_themes = list(/datum/exoplanet_theme/ruined_city = 100)
	habitability_distribution = list(HABITABILITY_IDEAL = 70, HABITABILITY_OKAY = 20, HABITABILITY_BAD = 5)
	has_trees = TRUE
	daycycle = FALSE
	flora_diversity = 7
	lightlevel = 0.4
	fauna_types = list(/mob/living/simple_animal/hostile/smart_beast/rain_world/placeholder)
	megafauna_types = list(/mob/living/simple_animal/hostile/smart_beast/rain_world/placeholder)
	repopulate_types = list(/mob/living/simple_animal/hostile/smart_beast/rain_world/placeholder)
	var/raining = 0
	var/rain_time
	var/current_time
	var/cycle_daytime_min = 2000
	var/cycle_daytime_max = 8000
	var/rain_when_empty = TRUE

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
	base_turf = /turf/unsimulated/floor/plating
	ambience = list('sound/effects/wind/wind_2_1.ogg','sound/effects/wind/wind_2_2.ogg','sound/effects/wind/wind_3_1.ogg','sound/effects/wind/wind_4_1.ogg','sound/ambience/eeriejungle2.ogg','sound/ambience/eeriejungle1.ogg')
	icon = 'code/modules/overmap/exoplanets/planet_types/rain.dmi'

/area/exoplanet/urban/play_ambience(var/mob/living/L)
	..()
	if(!L.ear_deaf && L.client && !L.client.ambience_playing)
		L.client.ambience_playing = TRUE
		L.playsound_local(get_turf(L),sound('sound/ambience/jungle.ogg', repeat = 1, wait = 0, volume = 25, channel = GLOB.ambience_sound_channel))

/area/exoplanet/urban/outdoors

/area/exoplanet/urban/indoors

/datum/random_map/noise/exoplanet/urban
	descriptor = "ecumenopolis"
	smoothing_iterations = 2
	land_type = /turf/unsimulated/floor/exoplanet/grass
	water_type = /turf/unsimulated/floor/exoplanet/water/shallow

	flora_prob = 20
	grass_prob = 50
	large_flora_prob = 10

///////////////////////WEATHER///////////////////////

/obj/effect/overmap/visitable/sector/exoplanet/urban/handle_repopulation()
	if(raining > 1)
		return
	..()

/obj/effect/overmap/visitable/sector/exoplanet/urban/Process(wait, tick)
	..()
	current_time = world.time
	planetary_area.icon_state = "rain[raining]"
	if(rain_time && world.time >= rain_time)
		rain_time = 0
		rain_world()
	if(raining > 0)
		for (var/mob/living/M in GLOB.living_mob_list_)
			if (M && (M.z in map_z) && istype(M.loc.loc,/area/exoplanet/urban/outdoors))
				if(prob(30) && raining < 3)
					to_chat(M, SPAN_WARNING("You are hit by the waterdrop!"))
				if(raining == 1)
					shake_camera(M, 200, 0.1, 0.05)
				if(raining == 2)
					shake_camera(M, 200, 0.5, 0.05)
					if(prob(15))
						M.apply_damage(rand(2,10), BRUTE, pick(BP_ALL_LIMBS))
						if(prob(25))
							to_chat(M, SPAN_DANGER("You are hit by the heavy waterdrop!"))
				else if(raining == 3)
					shake_camera(M, 200, 1, 0.05)
					if(prob(30))
						M.apply_damage(rand(4,15), BRUTE, pick(BP_ALL_LIMBS))
						if(prob(25))
							to_chat(M, SPAN_DANGER("You are crushed by heavy waterdrop!"))
				else if(raining == 4)
					shake_camera(M, 200, 2, 0.05)
					if(prob(60))
						M.apply_damage(rand(6,20), BRUTE, pick(BP_ALL_LIMBS))
						if(prob(25))
							to_chat(M, SPAN_DANGER("You are crushed by heavy waterdrop!"))
			else if(M && (M.z in map_z) && raining > 2)
				shake_camera(M, 200, 0.1, 0.05)

/obj/effect/overmap/visitable/sector/exoplanet/urban/proc/rain_world()
	set waitfor = 0

	if(!SSpresence.population(max(map_z)) && !rain_when_empty)
		rain_time = world.time + rand(cycle_daytime_min, cycle_daytime_max)
		return FALSE

	for (var/mob/M in GLOB.player_list)
		if (M && M.z in map_z)
			to_chat(M, SPAN_WARNING("The storm clouds are brewing."))

	for (var/mob/living/simple_animal/hostile/smart_beast/rain_world/M in GLOB.living_mob_list_)
		if (M && (M.z in map_z) && istype(M.loc.loc,/area/exoplanet/urban/outdoors))
			M.seek_shelter()

	var/rain_zone = block(locate(1,1,min(map_z)),locate(maxx,maxy,max(map_z)))

	for (var/turf/unsimulated/floor/exoplanet/T in rain_zone)
		T.set_light(0.3, 0.1, 2)

	sleep(rand(250,450))
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
	if(prob(10))
		raining = 1
	rain_time = world.time + rand(cycle_daytime_min, cycle_daytime_max)

	sleep(rand(150,250))
	for (var/turf/unsimulated/floor/exoplanet/T in rain_zone)
		T.set_light(0.2, 0.1, 2)
	for (var/mob/living/simple_animal/hostile/smart_beast/rain_world/M in GLOB.living_mob_list_)
		if (M && (M.z in map_z) && istype(M.loc.loc,/area/exoplanet/urban/indoors))
			M.leave_shelter()

	sleep(rand(150,250))
	for (var/turf/unsimulated/floor/exoplanet/T in rain_zone)
		T.set_light(lightlevel, 0.1, 2)

	return TRUE

///////////////////////FAUNA///////////////////////

/mob/living/simple_animal/hostile/smart_beast/rain_world
	var/fleeing_for_shelter = FALSE
	var/grab_chance = 75
	var/release_chance = 20
	var/shift = 16
	var/atom/movable/jaws_grab = null
	var/captured_prey = FALSE
	var/list/possible_shelters = list()
	var/turf/shelter
	hunger_affects_hostility = FALSE
	randomize_tone = TRUE

/mob/living/simple_animal/hostile/smart_beast/rain_world/proc/seek_shelter(var/returning_with_catch = FALSE)
	if(stat == DEAD || !ai_holder)
		return FALSE

	var/datum/ai_holder/smart_animal/rain_world/rainworld_ai = ai_holder

	possible_shelters = list()

	for(var/turf/T in block( locate(1,1,src.z), locate(world.maxx,world.maxy,src.z) ) )
		if(!T.density && !TurfBlockedNonWindow(T) && istype(T.loc,/area/exoplanet/urban/indoors) && !(T in rainworld_ai.unreachable_path_tiles))
			possible_shelters += T

	if(possible_shelters.len)
		shelter = pick(shelter_filter_closest(possible_shelters))

		proceed_to_shelter(returning_with_catch)

		return TRUE

	return FALSE

/mob/living/simple_animal/hostile/smart_beast/rain_world/proc/proceed_to_shelter(var/returning_with_catch = FALSE)
	if(returning_with_catch)
		captured_prey = TRUE
	if(shelter)
		if(ai_holder.leader && !fleeing_for_shelter)
			if(!istype(ai_holder.leader, /mob/living))
				fleeing_for_shelter = TRUE
				ai_holder.set_follow(shelter,walk_straight_to = TRUE)
		else if(!ai_holder.leader && !fleeing_for_shelter)
			fleeing_for_shelter = TRUE
			ai_holder.set_follow(shelter,walk_straight_to = TRUE)
	else
		return log_and_message_admins("эмм, а где шелтеры на Z[z]...")

/mob/living/simple_animal/hostile/smart_beast/rain_world/proc/shelter_filter_closest(list/targets)
	var/lowest_distance = 1e6 //fakely far
	var/list/closest_targets = list()
	for (var/possible_target in targets)
		var/atom/A = possible_target
		var/current_distance = get_dist(src, A)
		if (current_distance < lowest_distance)
			closest_targets.Cut()
			lowest_distance = current_distance
			closest_targets += A
		else if (current_distance == lowest_distance)
			closest_targets += A
	return closest_targets

/mob/living/simple_animal/hostile/smart_beast/rain_world/proc/leave_shelter()
	if(stat == DEAD || !ai_holder || istype(ai_holder.leader, /mob/living))
		return

	var/datum/ai_holder/smart_animal/rain_world/rainworld_ai = ai_holder

	fleeing_for_shelter = FALSE
	captured_prey = FALSE

	rainworld_ai.turns_since_shelter_path_scan = 30
	rainworld_ai.unreachable_path_tiles = list()
//	rainworld_ai.cashed_shelter_path = list()

	var/list/tiles_in_range = list()

	for(var/turf/T in block( locate(max(0,src.x-10),max(0,src.y-10),src.z), locate(min(200,src.x+10),min(200,src.y+10),src.z) ) )
		if(!T.density && !istype(T.loc,/area/exoplanet/urban/indoors))
			tiles_in_range += T

	var/turf/leave_destignation = pick(tiles_in_range)

	if(leave_destignation)
		ai_holder.set_follow(leave_destignation, 100, TRUE)
	else
		spawn(20) leave_shelter()

/mob/living/simple_animal/hostile/smart_beast/rain_world/hunger_checks()
	if(fleeing_for_shelter)
		return
	var/datum/ai_holder/smart_animal/rain_world/rainworld_ai = ai_holder
	if(!resting && !buckled && (rainworld_ai.stance == STANCE_MOVE || rainworld_ai.stance == STANCE_IDLE) && !fleeing_for_shelter)
		turns_since_scan++
		if(turns_since_scan > 1)
			turns_since_scan = 0
			find_food()

/mob/living/simple_animal/hostile/smart_beast/rain_world/proc/bite_grab(atom/movable/target)
	if(!target)
		return FALSE
	if(jaws_grab)
		release_grab()

	if(istype(target,/mob/living))
		var/mob/living/mob_target = target
		if(mob_target.buckled)
			mob_target.buckled.user_unbuckle_mob(src)
		mob_target.stunned = 5
		mob_target.anchored = 1
		mob_target.resting = 1

	playsound(src, 'sound/effects/magnetclamp.ogg', 100, 1)
	jaws_grab = target
	captured_prey = TRUE

	ai_holder.set_stance(STANCE_IDLE)

	var/adir = get_dir(src, target)
	switch(adir)
		if(NORTH)
			animate(target, pixel_x = 0, pixel_y =-shift, 5, 1, LINEAR_EASING)
		if(SOUTH)
			animate(target, pixel_x = 0, pixel_y = shift+4, 5, 1, LINEAR_EASING)
		if(WEST)
			animate(target, pixel_x = shift, pixel_y = 0, 5, 1, LINEAR_EASING)
		if(EAST)
			animate(target, pixel_x =-shift, pixel_y = 0, 5, 1, LINEAR_EASING)
		else
			reset_position(target)

	if(prob(release_chance))
		spawn(rand(20,60)) release_grab()

/mob/living/simple_animal/hostile/smart_beast/rain_world/proc/release_grab()
	if(istype(jaws_grab,/mob/living))
		var/mob/living/mob_jaws_grab = jaws_grab
		mob_jaws_grab.anchored = 0
	reset_position(jaws_grab)
	jaws_grab = null

/mob/living/simple_animal/hostile/smart_beast/rain_world/Destroy()
	if(jaws_grab)
		release_grab()

	. = ..()

/mob/living/simple_animal/hostile/smart_beast/rain_world/Life()
	if(stat == DEAD)
		release_grab()
	..()

	if(jaws_grab)
		if(istype(jaws_grab,/mob/living))
			var/mob/living/mob_jaws_grab = jaws_grab
			mob_jaws_grab.stunned = 5
			mob_jaws_grab.anchored = 1
			mob_jaws_grab.resting = 1
		if((istype(jaws_grab,/obj/item) && prob(15)) || ai_holder.stance == STANCE_FIGHT || ai_holder.stance == STANCE_FLEE || get_dist(jaws_grab,src) > 1)
			release_grab()
			return
		var/turf/new_victim_pos = get_step(src, src.dir)
		if(jaws_grab.loc != new_victim_pos)
			if(!new_victim_pos.density && !TurfBlockedNonWindow(new_victim_pos))
				jaws_grab.forceMove(new_victim_pos)
			else
				jaws_grab.forceMove(src.loc)

			var/adir = get_dir(src, jaws_grab)
			switch(adir)
				if(NORTH)
					jaws_grab.pixel_x = 0
					jaws_grab.pixel_y = -shift
				if(SOUTH)
					jaws_grab.pixel_x = 0
					jaws_grab.pixel_y = shift+4
				if(WEST)
					jaws_grab.pixel_x = shift
					jaws_grab.pixel_y = 0
				if(EAST)
					jaws_grab.pixel_x = -shift
					jaws_grab.pixel_y = 0
				else
					reset_position(jaws_grab)

	if(jaws_grab && !istype(src.loc.loc,/area/exoplanet/urban/indoors) && !fleeing_for_shelter && diet != DIET_HERBIVOROUS)
		seek_shelter(returning_with_catch = TRUE)

	if(jaws_grab && istype(src.loc.loc,/area/exoplanet/urban/indoors) && diet != DIET_HERBIVOROUS)
		fleeing_for_shelter = FALSE
		eat_and_leave(jaws_grab)

	if(!jaws_grab && !istype(src.loc.loc,/area/exoplanet/urban/indoors) && fleeing_for_shelter && captured_prey)
		fleeing_for_shelter = FALSE
		captured_prey = FALSE
		ai_holder.leader = null

/mob/living/simple_animal/hostile/smart_beast/rain_world/proc/eat_and_leave(var/mob/living/victim)
	set waitfor = 0
	if(!victim)
		leave_shelter()
		return
	release_grab()
	if(victim.stat == DEAD && victim != src)
		if(consume(victim))
			leave_shelter()
	else if(victim != ai_holder.target)
		ai_holder.give_target(victim,TRUE)

/mob/living/simple_animal/hostile/smart_beast/rain_world/Move(NewLoc,Dir)
	..()

	if(jaws_grab)
		var/turf/new_victim_pos = get_step(src, src.dir)
		if(jaws_grab.loc != new_victim_pos)
			if(!new_victim_pos.density && !TurfBlockedNonWindow(new_victim_pos))
				jaws_grab.forceMove(new_victim_pos)
			else
				jaws_grab.forceMove(src.loc)

			var/adir = get_dir(src, jaws_grab)
			switch(adir)
				if(NORTH)
					jaws_grab.pixel_x = 0
					jaws_grab.pixel_y = -shift
				if(SOUTH)
					jaws_grab.pixel_x = 0
					jaws_grab.pixel_y = shift+4
				if(WEST)
					jaws_grab.pixel_x = shift
					jaws_grab.pixel_y = 0
				if(EAST)
					jaws_grab.pixel_x = -shift
					jaws_grab.pixel_y = 0
				else
					reset_position(jaws_grab)

/mob/living/simple_animal/hostile/smart_beast/rain_world/proc/reset_position(var/atom/movable/victim)
	if(!victim)
		return FALSE

	animate(victim, pixel_x = 0, pixel_y = 0, 4, 1, LINEAR_EASING)

/mob/living/simple_animal/hostile/smart_beast/rain_world/apply_melee_effects(atom/movable/A)
	if(!A || !ai_holder)
		return FALSE

	var/datum/ai_holder/smart_animal/rain_world/rainworld_ai = ai_holder

	if(istype(A,/obj))
		var/obj/obj_target = A
		if(rainworld_ai.bite_grab && prob(grab_chance) && get_dist(src,A) <= 1 && !istype(A,/mob/living/exosuit) && !(obj_target.w_class > ITEM_SIZE_NORMAL))
			bite_grab(A)
			return TRUE
		else
			return FALSE

	if(rainworld_ai.bite_grab && prob(grab_chance) && get_dist(src,A) <= 1 && !istype(A,/mob/living/exosuit))
		bite_grab(A)
		return TRUE

	return FALSE

///////////////////////FAUNA AI///////////////////////

/datum/ai_holder/smart_animal/rain_world
	var/turns_since_shelter_path_scan = 30
	var/list/unreachable_path_tiles = list()
	var/list/cashed_shelter_path = list()
	var/bite_grab = TRUE
	hostile = TRUE
	destructive = TRUE
	mauling = TRUE
	can_breakthrough = TRUE
	violent_breakthrough = TRUE
	run_on_empty_levels = TRUE
	threaten = FALSE

/datum/ai_holder/smart_animal/rain_world/give_target(new_target, urgent = FALSE)
	var/mob/living/simple_animal/hostile/smart_beast/rain_world/rainworld_holder = holder
	if(rainworld_holder.fleeing_for_shelter && prob(90))
		return FALSE //хуёвое время что бы бить ебальники, ведь всех нас сейчас РАЗЪЕБЁТ ДОЖДЁМ
	..()

/datum/ai_holder/smart_animal/rain_world/handle_wander_movement()
	var/mob/living/simple_animal/hostile/smart_beast/rain_world/rainworld_holder = holder
	if(rainworld_holder.fleeing_for_shelter)
		return
	..()

/datum/ai_holder/smart_animal/rain_world/can_attack(atom/movable/the_target, vision_required = TRUE)
	var/mob/living/simple_animal/hostile/smart_beast/rain_world/rainworld_holder = holder
	if (the_target == rainworld_holder.jaws_grab)
		return FALSE

	if (!can_see_target(the_target) && vision_required)
		return FALSE

	if (isliving(the_target))
		var/mob/living/L = the_target
		if (ishuman(L) || issilicon(L))
//			if (L.key && !L.client)	// SSD players get a pass
//				return FALSE

			if (L.status_flags & NOTARGET)
				return FALSE
		if (L.stat)
			if (L.stat == DEAD && !handle_corpse) // Leave dead things alone
				return FALSE
			if (L.stat == UNCONSCIOUS)	// Do we have mauling? Yes? Then maul people who are sleeping but not SSD
				if (mauling)
					return TRUE
				else
					return FALSE
		if (holder.IIsAlly(L))
			return FALSE
		return TRUE

	if (istype(the_target, /mob/living/exosuit))
		var/mob/living/exosuit/M = the_target
		for (var/mob/pilot in M.pilots)
			return can_attack(pilot)
		return destructive // Empty mechs are 'neutral'.

	if (istype(the_target, /obj/machinery/porta_turret))
		var/obj/machinery/porta_turret/P = the_target
		if (P.stat & BROKEN)
			return FALSE // Already dead.
		if (!(P.assess_living(holder)))
			return FALSE // Don't shoot allied turrets.
		if (!P.raised && !P.raising)
			return FALSE // Turrets won't get hurt if they're still in their cover.
		return TRUE

	return TRUE

/datum/ai_holder/smart_animal/rain_world/get_path(turf/target,var/get_to = 1, max_distance = world.view*6)
	var/mob/living/simple_animal/hostile/smart_beast/rain_world/rainworld_holder = holder
	ai_log("get_path() : Entering.",AI_LOG_DEBUG)
	if(rainworld_holder.fleeing_for_shelter)
		turns_since_shelter_path_scan ++
		if(turns_since_shelter_path_scan < 30)
			ai_log("get_path() : Too early for making new path to shelter. Exiting.", AI_LOG_DEBUG)
			if(cashed_shelter_path)
				if(cashed_shelter_path.len)
					path = cashed_shelter_path
					return path.len
			return
	turns_since_shelter_path_scan = 0
	forget_path()

//	if(rainworld_holder.fleeing_for_shelter)
//		max_distance = 300

	var/list/new_path = AStar(get_turf(holder.loc), target, astar_adjacent_proc, /turf/proc/Distance, min_target_dist = get_to, max_node_depth = max_distance, id = holder.IGetID(), exclude = obstacles)

	if (new_path && new_path.len)
		path = new_path
		if(rainworld_holder.fleeing_for_shelter && new_path && new_path.len)
			cashed_shelter_path = new_path
		ai_log("get_path() : Made new path.", AI_LOG_DEBUG)
		if (path_display)
			for(var/turf/T in path)
				T.overlays |= path_overlay
	else
		if(rainworld_holder.fleeing_for_shelter)
			unreachable_path_tiles += target
			rainworld_holder.possible_shelters -= target
			if(rainworld_holder.possible_shelters.len)
				leader = pick(rainworld_holder.shelter_filter_closest(rainworld_holder.possible_shelters))
			else
				return log_and_message_admins("эмм, а где шелтеры на Z[holder.z]...")
		ai_log("get_path() : Failed to make new path. Exiting.", AI_LOG_DEBUG)
		return 0

	ai_log("get_path() : Exiting.", AI_LOG_DEBUG)
	return path.len

///////////////////////ACTUAL FAUNA///////////////////////

/mob/living/simple_animal/hostile/smart_beast/rain_world/placeholder
	name = "samak"
	desc = "A fast, armoured predator accustomed to hiding and ambushing in cold terrain."
	faction = "samak"
	icon_state = "samak"
	icon_living = "samak"
	icon_dead = "samak_dead"
	init_tame_difficulty = 8
	maxHealth = 125
	health = 125
	speed = 2
	diet = DIET_OMNIVOROUS
	aggression_affects_hostility = FALSE
	mob_bump_flag = HUMAN
	mob_push_flags = ~HEAVY
	mob_swap_flags = ~HEAVY
	mob_size = MOB_MEDIUM
	melee_attack_delay = 8
	natural_weapon = /obj/item/natural_weapon/bite/strong
	cold_damage_per_tick = 0
	natural_armor = list(
		melee = ARMOR_MELEE_KNIVES
		)

	ai_holder = /datum/ai_holder/smart_animal/rain_world
	say_list_type = /datum/say_list/smart/samak