proc/lerp(a, b, t)
	return a+(b-a)*t

proc/Pow(f, p)
	return f**p

/mob/living/simple_animal/hostile/scavenger
	name = "Scavenger"

	icon_state = "green_bot"
	icon = 'icons/32x48.dmi'

	ai_holder = /datum/ai_holder/scavenger

	movement_cooldown = 6
	taser_kill = 0
	ranged = 1

	response_help  = "hugs"
	response_disarm = "shoves aside"
	response_harm   = "kicks"

	say_list = /datum/say_list/meat

/datum/ai_holder/scavenger
	var/sympathy
	var/energy
	var/bravery
	var/aggression
	var/dominance
	var/nervousness

	intelligence_level = AI_SMART
	retaliate = TRUE				// The majority of smart mobs will fight back.
	use_astar = TRUE
	hostile = FALSE
	destructive = FALSE
	mauling = FALSE
	can_breakthrough = FALSE
	violent_breakthrough = FALSE

	cooperative = FALSE

	threaten = TRUE

	can_flee = TRUE
	flee_when_dying = TRUE
	flee_when_outmatched = TRUE

	returns_home = FALSE
	home_low_priority = TRUE

	conserve_ammo = TRUE

	wander = TRUE					// If true, the mob will randomly move in the four cardinal directions when idle.
	respect_alpha = TRUE
	alpha_vision_threshold = FAKE_INVIS_ALPHA_THRESHOLD

	base_wander_delay = 4

//	path_display = TRUE
//	stance_coloring = TRUE
//	debug_ai = AI_LOG_DEBUG

/datum/ai_holder/scavenger/proc/random_val()
	return rand(0.01,1)

/datum/ai_holder/scavenger/proc/setup_temper()
	. = ..()

	var/mob/living/simple_animal/hostile/scavenger/scav_ai_holder = holder

	sympathy = random_val()
	energy = random_val()
	bravery = random_val()

	nervousness = lerp(random_val(), lerp(energy,1-bravery,0.5), Pow(random_val(),0.25))
	aggression = lerp(random_val(), energy+bravery/2*(1-sympathy), Pow(random_val(),0.25))
	dominance = lerp(random_val(), energy+bravery+aggression/3, Pow(random_val(),0.25))

/datum/ai_holder/scavenger/New()
	..()
	setup_temper()

/datum/ai_holder/scavenger/on_engagement(atom/A)
	var/run_if_this_close = round(vision_range * (1-aggression))
	if(get_dist(holder, A) < run_if_this_close)
		holder.IMove(get_step_away(holder, A, run_if_this_close))
		holder.face_atom(A)

/datum/ai_holder/scavenger/handle_wander_movement()
	ai_log("handle_wander_movement() : Entered.", AI_LOG_TRACE)
	if (isturf(holder.loc) && can_act())
		wander_delay--
		if (wander_delay <= 0)
			if (!wander_when_pulled && (holder.pulledby || holder.grabbed_by.len))
				ai_log("handle_wander_movement() : Being pulled and cannot wander. Exiting.", AI_LOG_DEBUG)
				return

			var/list/wander_turf_candidates = block(locate(holder.x+3,holder.y+3,holder.z),locate(holder.x-3,holder.y-3,holder.z))
			var/turf/moving_to = pick(wander_turf_candidates)
			give_destination(moving_to, combat = FALSE)
			holder.face_atom(moving_to)
			wander_delay = base_wander_delay
	ai_log("handle_wander_movement() : Exited.", AI_LOG_TRACE)

/datum/ai_holder/scavenger/flee_from_target()
	ai_log("flee_from_target() : Entering.", AI_LOG_DEBUG)

	if (!target || !should_flee() || !can_attack(target)) // can_attack() is used since it checks the same things we would need to anyways.
		ai_log("flee_from_target() : Lost target to flee from.", AI_LOG_INFO)
		lose_target()
		set_stance(STANCE_IDLE)
		ai_log("flee_from_target() : Exiting.", AI_LOG_DEBUG)
		return

	ai_log("flee_from_target() : Stepping away.", AI_LOG_TRACE)
	step_away(holder, target, vision_range*=nervousness)
	if(get_dist(holder, target) < vision_range)
		holder.face_atom(target)
	ai_log("flee_from_target() : Exiting.", AI_LOG_DEBUG)