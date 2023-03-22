/obj/effect/overmap/visitable/sector/exoplanet/urban
	name = "ecumenopolis"
	desc = "A world-wide unpowered city covers the entire planetary surface."
	color = "#615e4f"
	max_animal_count = 30
	planetary_area = /area/exoplanet/urban/outdoors
	rock_colors = list(COLOR_ASTEROID_ROCK, COLOR_GRAY80, COLOR_BROWN)
	plant_colors = list("#0e1e14","#1a3e38","#5a7467","#9eab88","#6e7248", "RANDOM") //сделать позже кучу красного и жёлтого неона
	grasscolors = list("#9c854b","#9c8d4b","#9c954b","#989c4b","#8f9c4b","#819c4b")
	map_generators = list(/datum/random_map/noise/exoplanet/urban)
	possible_themes = list(/datum/exoplanet_theme/ruined_city/ecumenopolis = 100)
	habitability_distribution = list(HABITABILITY_IDEAL = 25, HABITABILITY_OKAY = 75)
	ruin_tags_whitelist = RUIN_RAINWORLD
	ruin_tags_blacklist = null
	has_trees = FALSE
	daycycle = FALSE
	flora_diversity = 7
	lightlevel = 0.4
	var/i_hate_lightlevel = 0.4
	fauna_types = list(/mob/living/simple_animal/hostile/smart_beast/rain_world/carnivore_placeholder)
	megafauna_types = list(/mob/living/simple_animal/hostile/smart_beast/rain_world/carnivore_placeholder)
	repopulate_types = list(/mob/living/simple_animal/hostile/smart_beast/rain_world/carnivore_placeholder)

	var/rain_when_empty = TRUE
	var/rainy_day = FALSE
	var/current_time = 0
	var/raining = 0
	var/rain_time

	var/rain_interval_min = 250
	var/rain_interval_max = 600
	var/cycle_daytime_min = 2000
	var/cycle_daytime_max = 8000

	var/shelter_fail_prob = 5
	var/rainy_day_prob = 10

/obj/effect/overmap/visitable/sector/exoplanet/urban/generate_map()
	..()
	i_hate_lightlevel = 0.4

/obj/effect/overmap/visitable/sector/exoplanet/urban/generate_atmosphere()
	..()
	if(atmosphere)
		atmosphere.temperature = T20C + rand(10, 30)
		atmosphere.update_values()
	i_hate_lightlevel = 0.4

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
	i_hate_lightlevel = 0.4
	return

/obj/effect/overmap/visitable/sector/exoplanet/urban/New(nloc, max_x, max_y)
	..()
	i_hate_lightlevel = 0.4
	rain_time = world.time + cycle_daytime_max
	for (var/turf/unsimulated/T in block(locate(1,1,min(map_z)),locate(maxx,maxy,max(map_z))))
		if(!T.density && !istype(T.loc, /area/exoplanet/urban/indoors))
			T.set_light(i_hate_lightlevel, 0.1, 2)

/area/exoplanet/urban
	base_turf = /turf/unsimulated/floor/plating/rainworld
	ambience = list('sound/effects/wind/spooky0.ogg','sound/effects/wind/spooky1.ogg','sound/ambience/ominous1.ogg','sound/ambience/ominous2.ogg','sound/ambience/ominous1.ogg','sound/ambience/ominous3.ogg')
	icon = 'code/modules/overmap/exoplanets/planet_types/rain.dmi'
	req_access = list(access_cent_specops)

/area/exoplanet/urban/outdoors

/area/exoplanet/urban/indoors
	name = "indoors of ruined city"

/area/exoplanet/urban/indoors/shelter
	name = "shelter"
	requires_power = 0

/datum/random_map/noise/exoplanet/urban
	descriptor = "ecumenopolis"
	smoothing_iterations = 2
	land_type = /turf/unsimulated/floor/plating/rainworld
	water_type = /turf/unsimulated/floor/exoplanet/grass

	flora_prob = 20
	grass_prob = 50
	large_flora_prob = 10

/********************** PROPS **********************/

/obj/machinery/door/airlock/rainworld
	name = "Vault"
	desc = "It's made of some odd metal."
	use_power = POWER_USE_OFF
	airlock_type = "vault"
	icon = 'icons/obj/doors/vault/door.dmi'
	fill_file = 'icons/obj/doors/vault/fill_steel.dmi'
	color = "#8f8f8f"
	icon_state = "open"
	paintable = AIRLOCK_PAINTABLE|AIRLOCK_STRIPABLE
	req_access = list(access_cent_specops)
	explosion_resistance = 40
	secured_wires = 1
	autoclose = 0
	glass = 0

	var/delay = 1

/obj/machinery/door/airlock/rainworld/New()
	..()
	open(1)
	sleep(2)
	lock(1)

/obj/machinery/door/airlock/rainworld/arePowerSystemsOn()
	return (src.main_power_lost_until==0 || src.backup_power_lost_until==0)

/obj/machinery/door/airlock/rainworld/isAllPowerLoss()
	return 0

/obj/machinery/door/airlock/rainworld/close(var/forced=0)
	for(var/turf/turf in locs)
		for(var/mob/living/LM in turf)
			if(LM)
				var/moved = 0
				for(dir in shuffle(GLOB.cardinal.Copy()))
					var/dest = get_step(LM,dir)
					if(!(locate(/obj/machinery/door/airlock/rainworld) in dest))
						if(LM.Move(dest))
							moved = 1
							LM.visible_message("\The [LM] scurries away from the closing doors.")
							break
				if(!moved) // nowhere to go....
					LM.gib()
	return ..()

/turf/unsimulated/floor/plating/rainworld/Initialize()
	..()
	if(prob(20)) icon_state = pick("dmg3","dmg4")

/turf/unsimulated/floor/plating/rainworld/New()
	if(GLOB.using_map.use_overmap)
		var/obj/effect/overmap/visitable/sector/exoplanet/urban/E = map_sectors["[z]"]
		if(istype(E))
			if(E.atmosphere)
				initial_gas = E.atmosphere.gas.Copy()
				temperature = E.atmosphere.temperature
			else
				initial_gas = list()
				temperature = T0C
			//Must be done here, as light data is not fully carried over by ChangeTurf (but overlays are).
			if(istype(src.loc,/area/exoplanet/urban/outdoors))
				set_light(E.i_hate_lightlevel, 0.1, 2)
			if(E.planetary_area && istype(loc, world.area))
				ChangeArea(src, E.planetary_area)
	..()

/********************** WEATHER **********************/

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
				if(prob(10) && raining < 3)
					to_chat(M, SPAN_WARNING("You are hit by the waterdrop!"))
				if(raining == 1 && !rainy_day)
					shake_camera(M, 100, 0.1, 0.05)
				if(raining == 2)
					shake_camera(M, 100, 0.5, 0.05)
					if(prob(15))
						M.apply_damage(rand(2,10), BRUTE, pick(BP_ALL_LIMBS))
						if(prob(25))
							to_chat(M, SPAN_DANGER("You are hit by the heavy waterdrop!"))
				else if(raining == 3)
					shake_camera(M, 100, 1, 0.05)
					if(prob(30))
						M.apply_damage(rand(4,15), BRUTE, pick(BP_ALL_LIMBS))
						if(prob(25))
							to_chat(M, SPAN_DANGER("You are crushed by heavy waterdrop!"))
				else if(raining == 4)
					shake_camera(M, 100, 2, 0.05)
					if(prob(60))
						M.apply_damage(rand(6,20), BRUTE, pick(BP_ALL_LIMBS))
						if(prob(25))
							to_chat(M, SPAN_DANGER("You are crushed by heavy waterdrop!"))
			else if(M && (M.z in map_z) && raining > 2)
				shake_camera(M, 100, 0.1, 0.05)
		for(var/area/exoplanet/urban/indoors/A in world)
			for (var/turf/unsimulated/floor/T in get_area_turfs(A,/proc/is_not_space_turf))
				if(raining > 2 && !istype(T.loc,/area/exoplanet/urban/indoors/shelter) && !(/obj/machinery/door/airlock in A.contents) && !TurfBlockedNonWindow(T) && prob(1*raining))
					T.add_fluid(600, /datum/reagent/water)

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

	for(var/turf/T in rain_zone)
		if(T.density || istype(T.loc, /area/exoplanet/urban/indoors))
			rain_zone -= T

	for (var/turf/unsimulated/T in rain_zone)
		T.set_light(i_hate_lightlevel/1, 0.1, 2)

	rainy_day = 0

	sleep(rand(rain_interval_min,rain_interval_max))
	raining = 1
	for (var/turf/unsimulated/T in rain_zone)
		T.set_light(i_hate_lightlevel/2, 0.1, 2)
	for (var/mob/living/simple_animal/hostile/smart_beast/rain_world/M in GLOB.living_mob_list_)
		if (M && (M.z in map_z) && istype(M.loc.loc,/area/exoplanet/urban/outdoors))
			M.seek_shelter()

	sleep(rand(rain_interval_min/2,rain_interval_max/2))
	raining = 2
	for (var/turf/unsimulated/T in rain_zone)
		T.set_light(i_hate_lightlevel/3, 0.1, 2)

	sleep(rand(rain_interval_min,rain_interval_max))
	raining = 3
	for (var/turf/unsimulated/T in rain_zone)
		T.set_light(i_hate_lightlevel/4, 0.1, 2)
	spawn(rand(10,100)) toggle_shelters(1)

	sleep(rand(rain_interval_min/2,rain_interval_max/2))
	raining = 4
	for (var/turf/unsimulated/T in rain_zone)
		T.set_light(0)

	sleep(rand(rain_interval_min*3,rain_interval_max*3))
	if(prob(rainy_day_prob))
		raining = 1
		rainy_day = 1
	else
		raining = 0
	rain_time = world.time + rand(cycle_daytime_min, cycle_daytime_max)
	spawn(rand(10,100)) toggle_shelters(0)
	for (var/mob/living/simple_animal/hostile/smart_beast/rain_world/M in GLOB.living_mob_list_)
		if (M && (M.z in map_z) && istype(M.loc.loc,/area/exoplanet/urban/indoors/shelter))
			M.leave_shelter()

	sleep(rand(rain_interval_min/3,rain_interval_max/3))
	for (var/turf/unsimulated/T in rain_zone)
		T.set_light(i_hate_lightlevel/2, 0.1, 2)

	sleep(rand(rain_interval_min/5,rain_interval_max/5))
	for (var/turf/unsimulated/T in rain_zone)
		T.set_light(i_hate_lightlevel, 0.1, 2)

	return TRUE

/obj/effect/overmap/visitable/sector/exoplanet/urban/proc/toggle_shelters(var/rain)
	for(var/obj/machinery/door/airlock/rainworld/A in world)
		if(A && A.z == max(map_z))
			if(!rain)
				spawn(A.delay)A.unlock(1)
				spawn(A.delay+2) A.open(1)
				spawn(A.delay+2) A.lock(1)
			else if(!prob(shelter_fail_prob))
				spawn(A.delay)A.unlock(1)
				spawn(A.delay+2) A.close(1)
				spawn(A.delay+2) A.lock(1)

/********************** FAUNA **********************/

/mob/living/simple_animal/hostile/smart_beast/rain_world
	var/fleeing_for_shelter = FALSE
	var/grab_chance = 75
	var/release_chance = 20
	var/shift = 16
	var/atom/movable/jaws_grab = null
	var/captured_prey = FALSE
	var/forget_about_escaped_prey_timer = 0
	var/list/possible_shelters = list()
	var/turf/shelter
	randomize_tone = TRUE

/mob/living/simple_animal/hostile/smart_beast/rain_world/proc/seek_shelter(var/returning_with_catch = FALSE)
	if(stat == DEAD || !ai_holder)
		return FALSE

	var/datum/ai_holder/smart_animal/rain_world/rainworld_ai = ai_holder

	possible_shelters = list()

	for(var/turf/T in block( locate(1,1,src.z), locate(world.maxx,world.maxy,src.z) ) )
		if(!T.density && !TurfBlockedNonWindow(T) && istype(T.loc,/area/exoplanet/urban/indoors/shelter) && !(T in rainworld_ai.unreachable_path_tiles))
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
		return log_and_message_admins("эмм, а где шелтеры на z[z]...")

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
	rainworld_ai.cashed_shelter_path = list()
	rainworld_ai.add_on_distance = 0

	var/list/tiles_in_range = list()

	for(var/turf/T in block( locate(max(0,src.x-30),max(0,src.y-30),src.z), locate(min(200,src.x+20),min(200,src.y+20),src.z) ) )
		if(!T.density && !istype(T.loc,/area/exoplanet/urban/indoors))
			tiles_in_range += T

	var/turf/leave_destignation = pick(tiles_in_range)

	if(leave_destignation)
		ai_holder.set_follow(leave_destignation, 300, TRUE)
	else
		spawn(20) leave_shelter()

/mob/living/simple_animal/hostile/smart_beast/rain_world/hunger_checks()
	if(fleeing_for_shelter)
		return
	var/datum/ai_holder/smart_animal/rain_world/rainworld_ai = ai_holder
	if(!resting && !buckled && (ai_holder.stance == STANCE_MOVE || ai_holder.stance == STANCE_IDLE) && !fleeing_for_shelter && !jaws_grab)
		turns_since_scan++
		if(turns_since_scan > 4)
			turns_since_scan = 0
			if(rainworld_ai.bite_grab)
				for(var/mob/living/S in orange(ai_holder.vision_range,src))
					if(S.stat == DEAD && S != src && !fleeing_for_shelter && (jaws_grab || prob(10)))
						ai_holder.give_target(S,TRUE)
			find_and_eat_food()

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
		if(istype(mob_target,/mob/living/carbon))
			mob_target.resting = 1
		else
			mob_target.density = 0

	playsound(src, 'sound/effects/magnetclamp.ogg', 100, 1)
	jaws_grab = target
	captured_prey = TRUE

	visible_message(SPAN_DANGER("\The [src] slams it's jaws shut, chening [jaws_grab] in teeth!"))

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
		var/mob/living/carbon/mob_jaws_grab = jaws_grab
		if(istype(mob_jaws_grab,/mob/living/carbon))
			mob_jaws_grab.resting = 0
		else
			jaws_grab.density = 1
			jaws_grab.anchored = 0

	if(jaws_grab)
		visible_message(SPAN_WARNING("\The [src] reduces it's grasp pressure, releasing [jaws_grab] from jaws."))

	reset_position(jaws_grab)
	jaws_grab = null

/mob/living/simple_animal/hostile/smart_beast/rain_world/Destroy()
	if(jaws_grab)
		release_grab()

	..()

/mob/living/simple_animal/hostile/smart_beast/rain_world/attack_target(atom/A)
	if(jaws_grab)
		release_grab()
	..()

/mob/living/simple_animal/hostile/smart_beast/rain_world/Life()
	..()
	if(stat == DEAD)
		release_grab()

	if(jaws_grab)
		if(ai_holder.cooperative && pack_leader != src)
			if(pack_leader in view(ai_holder.vision_range,src))
				release_grab()
				if(prob(25))
					ISay(pick(say_list.say_stand_down))
		if(istype(jaws_grab,/mob/living))
			var/mob/living/mob_jaws_grab = jaws_grab
			mob_jaws_grab.stunned = 5
			mob_jaws_grab.anchored = 1
			if(istype(mob_jaws_grab,/mob/living/carbon))
				mob_jaws_grab.resting = 1
			else
				mob_jaws_grab.density = 0
		if((istype(jaws_grab,/obj/item) && prob(15)) && get_dist(jaws_grab,src) > 1)
			release_grab()
			return
		var/turf/new_victim_pos = get_step(src, src.dir)
		if(jaws_grab.loc != new_victim_pos && get_dist(src,jaws_grab.loc) <= 1)
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
					jaws_grab.pixel_y = shift+shift/4
				if(WEST)
					jaws_grab.pixel_x = shift
					jaws_grab.pixel_y = 0
				if(EAST)
					jaws_grab.pixel_x = -shift
					jaws_grab.pixel_y = 0
				else
					reset_position(jaws_grab)

	if(jaws_grab && !istype(src.loc.loc,/area/exoplanet/urban/indoors/shelter) && !fleeing_for_shelter && diet != DIET_HERBIVOROUS)
		forget_about_escaped_prey_timer = 0
		seek_shelter(returning_with_catch = TRUE)

	else if(jaws_grab && istype(src.loc.loc,/area/exoplanet/urban/indoors/shelter) && diet != DIET_HERBIVOROUS)
		forget_about_escaped_prey_timer = 0
		fleeing_for_shelter = FALSE
		eat_and_leave()

	else if(!jaws_grab && istype(src.loc.loc,/area/exoplanet/urban/indoors/shelter) && !fleeing_for_shelter)
		forget_about_escaped_prey_timer ++
		if(forget_about_escaped_prey_timer > 10)
			forget_about_escaped_prey_timer = 0
			leave_shelter()

	if(!jaws_grab && !istype(src.loc.loc,/area/exoplanet/urban/indoors/shelter) && fleeing_for_shelter && captured_prey)
		fleeing_for_shelter = FALSE
		captured_prey = FALSE
		ai_holder.leader = null

/mob/living/simple_animal/hostile/smart_beast/rain_world/proc/eat_and_leave()
	set waitfor = 0
	var/mob/living/victim = jaws_grab
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
		if(jaws_grab.loc != new_victim_pos && get_dist(src,jaws_grab.loc) <= 2)
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
					jaws_grab.pixel_y = shift+shift/4
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

	if(rainworld_ai.bite_grab && prob(grab_chance) && get_dist(src,A) <= 1 && !istype(A,/mob/living/exosuit))
		if(istype(A,/obj))
			var/obj/obj_target = A
			if(obj_target.w_class <= ITEM_SIZE_NORMAL)
				bite_grab(A)
				return TRUE
		if(istype(A,/mob/living))
			var/mob/living/living_target = A
			if(living_target.mob_size <= src.mob_size || living_target.stat == DEAD)
				bite_grab(A)
				return TRUE

	return FALSE

/mob/living/simple_animal/hostile/smart_beast/rain_world/examine(mob/user, distance)
	. = ..()
	if(jaws_grab)
		to_chat(user, "<span class='warning'>There is [jaws_grab] dangling in [src]'s mouth!</span>")
	if(distance <= 5 && fleeing_for_shelter)
		to_chat(user, "<span class='notice'>It appears to be too concerned to notice you.</span>")

/********************** FAUNA AI **********************/

/datum/ai_holder/smart_animal/rain_world
	var/turns_since_shelter_path_scan = 30
	var/list/unreachable_path_tiles = list()
	var/list/cashed_shelter_path = list()
	var/add_on_distance = 0
	var/bite_grab = TRUE
	hostile = TRUE
	destructive = TRUE
	mauling = TRUE
	can_breakthrough = TRUE
	violent_breakthrough = TRUE
	run_on_empty_levels = TRUE
	handle_corpse = TRUE
	threaten = FALSE

	init_speak_chance = 3

/datum/ai_holder/smart_animal/rain_world/give_target(new_target, urgent = FALSE)
	var/mob/living/simple_animal/hostile/smart_beast/rain_world/rainworld_holder = holder
	if(rainworld_holder.fleeing_for_shelter && prob(95))
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
		if (holder.IIsAlly(L) && L.stat != DEAD)
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
		if(turns_since_shelter_path_scan < 60)
			ai_log("get_path() : Too early for making new path to shelter. Exiting.", AI_LOG_DEBUG)
			if(cashed_shelter_path && cashed_shelter_path.len)
				path = cashed_shelter_path
				return path.len
			return
	turns_since_shelter_path_scan = 0
	forget_path()

	if(rainworld_holder.fleeing_for_shelter)
		max_distance = 300

	var/list/new_path = AStar(get_turf(holder.loc), target, astar_adjacent_proc, /turf/proc/Distance, min_target_dist = get_to, max_node_depth = max_distance, id = holder.IGetID(), exclude = obstacles)

	if (new_path && new_path.len)
		path = new_path
		if(rainworld_holder.fleeing_for_shelter && new_path && new_path.len)
			cashed_shelter_path = list()
			cashed_shelter_path += new_path
		ai_log("get_path() : Made new path.", AI_LOG_DEBUG)
		if (path_display)
			for(var/turf/T in path)
				T.overlays |= path_overlay
	else
		if(rainworld_holder.fleeing_for_shelter && !(target in unreachable_path_tiles))
			unreachable_path_tiles += target
			if(rainworld_holder.possible_shelters.len == 1)
				var/closest_shelter = unreachable_path_tiles[1]
				var/sdir = get_dir(closest_shelter, rainworld_holder.loc)
				if(sdir && closest_shelter)
					var/turf/current_turf = rainworld_holder.loc
					for(var/i = 1 to round(get_dist(closest_shelter, rainworld_holder.loc)/2+add_on_distance))
						current_turf = get_step(current_turf,sdir)
					if(current_turf.density)
						add_on_distance ++
						return 0
					leader = current_turf
			else
				rainworld_holder.possible_shelters -= target
				leader = pick(rainworld_holder.shelter_filter_closest(rainworld_holder.possible_shelters))
		ai_log("get_path() : Failed to make new path. Exiting.", AI_LOG_DEBUG)
		return 0

	ai_log("get_path() : Exiting.", AI_LOG_DEBUG)
	return path.len

/datum/ai_holder/smart_animal/rain_world/walk_path(atom/A, get_to = 1)
	var/mob/living/simple_animal/hostile/smart_beast/rain_world/rainworld_holder = holder
	ai_log("walk_path() : Entered.", AI_LOG_TRACE)

	if (use_astar)
		if (!path.len) // If we're missing a path, make a new one.
			ai_log("walk_path() : No path. Attempting to calculate path.", AI_LOG_DEBUG)
			calculate_path(A, get_to)

		if (!path.len) // If we still don't have one, then the target's probably somewhere inaccessible to us. Get as close as we can.
			ai_log("walk_path() : Failed to obtain path to target. Using get_step_to() instead.", AI_LOG_INFO)
			if (holder.IMove(get_step_to(holder, A)) == MOVEMENT_FAILED)
				ai_log("walk_path() : Failed to move, attempting breakthrough.", AI_LOG_INFO)
				if (!breakthrough(A) && failed_breakthroughs++ >= 5) // We failed to move, time to smash things.
					give_up_movement()
					failed_breakthroughs = 0
			return

		if (move_once() == FALSE) // Start walking the path.
			ai_log("walk_path() : Failed to step.", AI_LOG_TRACE)
			++failed_steps
			if ((failed_steps > 3 && !rainworld_holder.fleeing_for_shelter) || failed_steps > 100) // We're probably stuck.
				ai_log("walk_path() : Too many failed_steps.", AI_LOG_DEBUG)
				forget_path() // So lets try again with a new path.
				failed_steps = 0

	else
		ai_log("walk_path() : Going to IMove().", AI_LOG_TRACE)
		if (holder.IMove(get_step_to(holder, A)) == MOVEMENT_FAILED )
			ai_log("walk_path() : Failed to move, attempting breakthrough.", AI_LOG_INFO)
			if (!breakthrough(A) && failed_breakthroughs++ >= 5) // We failed to move, time to smash things.
				give_up_movement()
				failed_breakthroughs = 0

	ai_log("walk_path() : Exited.", AI_LOG_TRACE)


/datum/ai_holder/smart_animal/rain_world/give_up_movement()
	var/mob/living/simple_animal/hostile/smart_beast/rain_world/rainworld_holder = holder
	ai_log("give_up_movement() : Entering.", AI_LOG_DEBUG)
	if(rainworld_holder.fleeing_for_shelter && (stance == STANCE_MOVE || stance == STANCE_IDLE || stance == STANCE_FOLLOW))
		ai_log("give_up_movement() : НЕ СДАВАЙСЯ ПОКА МЫ БЕЖИМ ОТ ДОЖДЯ ПОЖАЛУЙСТА.", AI_LOG_DEBUG)
	else
		forget_path()
		destination = null
	ai_log("give_up_movement() : Exiting.", AI_LOG_DEBUG)

/********************** ACTUAL FAUNA **********************/

/datum/ai_holder/smart_animal/rain_world/carnivore_placeholder
	lose_target_timeout = 5 SECONDS
	init_base_wander_delay = 4
	follow_distance = 4
	vision_range = 9

/mob/living/simple_animal/hostile/smart_beast/rain_world/carnivore_placeholder
	name = "shantak"
	desc = "A fast, armoured predator accustomed to hiding and ambushing in urban jungles."
	faction = "lizard"
	icon_state = "shantak-alt"
	icon_living = "shantak-alt"
	icon_dead = "shantak-alt_dead"
	tame_difficulty = 8
	maxHealth = 125
	health = 125
	diet = DIET_CARNIVOROUS
	mob_bump_flag = HUMAN
	mob_push_flags = ~HEAVY
	mob_swap_flags = ~HEAVY
	mob_size = MOB_MEDIUM
	melee_attack_delay = 6
	speed = 2
	movement_cooldown = 3
	natural_weapon = /obj/item/natural_weapon/bite/strong
	natural_armor = list(
		melee = ARMOR_MELEE_KNIVES
		)
	ai_holder = /datum/ai_holder/smart_animal/rain_world/carnivore_placeholder
	say_list_type = /datum/say_list/smart/shantak
	flash_vulnerability = 0

	aggression_affects_hostility = FALSE
	hunger_affects_hostility = FALSE
	respect_stats = TRUE

	attack_sound = null
	movement_sound = null			// If set, will play this sound when it moves on its own will.
	turn_sound = null				// If set, plays the sound when the mob's dir changes in most cases.