#define DIET_OMNIVOROUS  1
#define DIET_CARNIVOROUS 2
#define DIET_HERBIVOROUS 4

/mob/living/simple_animal/proc/name_species(newname as text)
	set name = "Name Alien Species"
	set category = "IC"
	set src in view()

	if(!GLOB.using_map.use_overmap)
		return
	if(!CanInteract(usr, GLOB.conscious_state))
		return
	if (isghost(usr))
		return

	for(var/obj/effect/overmap/visitable/sector/exoplanet/E)
		if(src in E.animals)
			newname = sanitizeName(newname, allow_numbers = TRUE, force_first_letter_uppercase = FALSE)
			if(newname && CanInteract(usr, GLOB.conscious_state))
				if(E.rename_species(type, newname))
					to_chat(usr,"<span class='notice'>This species will be known from now on as '[newname]'.</span>")
				else
					to_chat(usr,"<span class='warning'>This species has already been named!</span>")
			return

/datum/ai_holder/smart_animal
	var/init_sympathy
	var/init_energy
	var/init_bravery
	var/init_aggression
	var/init_dominance
	var/init_nervousness
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

	threaten = TRUE
	var/init_threaten_delay = 100			// 100 is min
	var/init_threaten_timeout = 1000
	var/init_speak_chance = 1				// If the mob's saylist is empty, nothing will happen.

	cooperative = FALSE
	var/init_call_distance = 7

	can_flee = TRUE
	flee_when_dying = TRUE
	flee_when_outmatched = TRUE
	var/init_outmatched_threshold = 100

	var/init_follow_distance = 6			// 6 is min

	returns_home = FALSE
	home_low_priority = TRUE
	var/init_max_home_distance = 3			// How far the mob can go away from its home before being told to go_home().

	wander = TRUE					// If true, the mob will randomly move in the four cardinal directions when idle.
	var/init_base_wander_delay = 5
	wander_when_pulled = TRUE

	var/init_vision_range = 7
	respect_alpha = TRUE
	alpha_vision_threshold = FAKE_INVIS_ALPHA_THRESHOLD
	var/init_lose_target_timeout = 55		// 50 is min

//	path_display = TRUE
//	stance_coloring = TRUE
//	debug_ai = AI_LOG_DEBUG

/mob/living/simple_animal/hostile/smart_beast
	var/mob/living/simple_animal/hostile/smart_beast/pack_leader
	var/list/beastmasters = list()
	var/list/current_pack_members = list()
	var/hunger = 0
	var/eating = null
	var/tameable = 1
	var/tame_difficulty = 0
	var/init_tame_difficulty = 3
	var/diet = DIET_OMNIVOROUS
	var/hostility_threshold = 150
	var/hunger_threshold = 100
	var/turns_since_scan = 0
	var/turns_since_pack_attach = 0
	var/hunger_affects_hostility = TRUE
	var/aggression_affects_hostility = TRUE
	var/respect_hunger = TRUE
	var/respect_stats = TRUE
	var/randomize_tone = FALSE
	var/nomad = FALSE
	var/obj/movement_target
	var/mob/living/owner
	taser_kill = 0
	name = "Mr. Beast"

	ai_holder = /datum/ai_holder/smart_animal

	response_help  = "pets"
	response_disarm = "shoves aside"
	response_harm   = "kicks"
	can_escape = TRUE

//	var/init_movement_cooldown = 8 //6 is min
	movement_cooldown = 6
	movement_sound = null			// If set, will play this sound when it moves on its own will.
	turn_sound = null				// If set, plays the sound when the mob's dir changes in most cases.

/mob/living/simple_animal/hostile/smart_beast/proc/scale(factor)
	if (factor)
		var/matrix/M = matrix()
		M.Scale(factor)
		src.transform = M

/datum/ai_holder/smart_animal/proc/setup_temper()
	. = ..()

	var/mob/living/simple_animal/hostile/smart_beast/smart_holder = holder

	sympathy = rand(1,100)
	energy = rand(1,100)
	bravery = rand(1,100)
	aggression = rand(1,100)
	dominance = rand(1,100)
	nervousness = rand(1,100)

	init_sympathy = sympathy
	init_energy = energy
	init_bravery = bravery
	init_aggression = aggression
	init_dominance = dominance
	init_nervousness = nervousness

	if(smart_holder.respect_hunger)
		smart_holder.hunger = clamp( rand(0,750) - dominance * 5 , 0, 500)

	calculate_temper()

/datum/ai_holder/smart_animal/proc/calculate_temper()
	sympathy = init_sympathy
	energy = init_energy
	bravery = init_bravery
	aggression = round( clamp( init_aggression * (energy/50) / (sympathy/20) + (bravery/2) , 1, 200) )
	dominance = round( clamp( init_dominance * (bravery/50) + (aggression/2) - (nervousness/2) , 1, 200) )
	nervousness = round( clamp( init_nervousness / (bravery/30) + (energy/2) , 1, 200) )

/datum/ai_holder/smart_animal/proc/calculate_stats()
	var/mob/living/simple_animal/hostile/smart_beast/smart_holder = holder

/////////////////////////////SYMPATHY/////////////////////////////
	threaten_timeout = round( init_threaten_timeout / sympathy )
	speak_chance = round( init_speak_chance + sympathy / 20 ) 			// If the mob's saylist is empty, nothing will happen.
	follow_distance = round( init_follow_distance - sympathy / 25 )
	if(sympathy>80) wander_when_pulled = FALSE

/////////////////////////////ENERGY///////////////////////////////
	lose_target_timeout = round( init_lose_target_timeout - energy / 2 )
//	smart_holder.movement_cooldown = round( smart_holder.init_movement_cooldown - energy / 20 )	// Lower is faster.

/////////////////////////////BRAVERY//////////////////////////////
	max_home_distance = round( init_max_home_distance + bravery / 20 )			// How far the mob can go away from its home before being told to go_home().
	dying_threshold = 1 - bravery / 100
	outmatched_threshold = init_outmatched_threshold + bravery
	if(bravery<40) home_low_priority = FALSE

////////////////////////////AGGRESSION////////////////////////////
	smart_holder.hostility_threshold = smart_holder.hostility_threshold
	smart_holder.pry_time = smart_holder.pry_time
	if(aggression>80)  can_breakthrough = TRUE
	if(aggression>120) mauling = TRUE
	if(aggression>160) violent_breakthrough = TRUE
	if(aggression>190) destructive = TRUE

/////////////////////////////DOMINANCE////////////////////////////
	call_distance = round( init_call_distance + dominance / 10 )
	smart_holder.scale(0.90 + dominance/750)

////////////////////////////NERVOUSNESS///////////////////////////
	vision_range = round( 5 + nervousness / 40 )
	alpha_vision_threshold = round( 220 - nervousness )
	base_wander_delay = round(max( 1,init_base_wander_delay - nervousness / 25 ))	// Note that a tick happens every half a second.
	threaten_delay = round( init_threaten_delay - nervousness / 1.05 )

/datum/ai_holder/smart_animal/should_wander()
	return (stance == STANCE_IDLE) && wander

/datum/ai_holder/smart_animal/handle_wander_movement()
	var/mob/living/simple_animal/hostile/smart_beast/smart_holder = holder
	if(smart_holder.eating)
		return
	..()

/datum/ai_holder/smart_animal/lose_ally(mob/living/AM)
	..()
	var/mob/living/simple_animal/hostile/smart_beast/smart_holder = holder
	if(smart_holder.owner)
		if(AM == smart_holder.owner)
			smart_holder.owner = null
	if(AM.key)
		if(AM.key in smart_holder.beastmasters)
			smart_holder.beastmasters[AM.key] = round( smart_holder.beastmasters[AM.key] / 2 )
	if(leader == AM)
		set_follow(null)
	return

/datum/ai_holder/smart_animal/New(new_holder)
	..()
	var/mob/living/simple_animal/hostile/smart_beast/smart_holder = new_holder
	setup_temper()
	if(smart_holder.respect_stats)
		calculate_stats()
/*
/mob/living/simple_animal/hostile/smart_beast/examine(mob/user)
	. = ..()
	var/datum/ai_holder/smart_animal/smart_ai_holder = ai_holder
	to_chat(user, "Aggression = [smart_ai_holder.aggression] \
		<br>Bravery = [smart_ai_holder.bravery] \
		<br>Dominance = [smart_ai_holder.dominance] \
		<br>Energy = [smart_ai_holder.energy] \
		<br>Nervousness = [smart_ai_holder.nervousness] \
		<br>Sympathy = [smart_ai_holder.sympathy]")
*/
/mob/living/simple_animal/hostile/smart_beast/proc/find_pack_leader()
	var/list/pack_leader_candidates = list()
	var/list/pack_leaders = list()

	for(var/mob/living/simple_animal/hostile/smart_beast/leader_candidate in range(15,src))
		var/datum/ai_holder/smart_animal/candidate_ai_holder
		if(istype(leader_candidate, src.type) && leader_candidate.stat != DEAD)
			candidate_ai_holder = leader_candidate.ai_holder
			pack_leader_candidates += candidate_ai_holder.dominance

	if(!pack_leader_candidates.len)
		return

	var/most_dominant_value = max(pack_leader_candidates)

	for(var/mob/living/simple_animal/hostile/smart_beast/leader_candidate in range(15,src))
		var/datum/ai_holder/smart_animal/candidate_ai_holder = leader_candidate.ai_holder
		if(candidate_ai_holder.dominance == most_dominant_value && leader_candidate.stat != DEAD)
			pack_leaders += leader_candidate

	if(!pack_leaders.len)
		return

	return pick(pack_leaders)

/mob/living/simple_animal/hostile/smart_beast/proc/attach_to_pack()
	var/datum/ai_holder/smart_animal/smart_ai_holder = ai_holder
	pack_leader = find_pack_leader()
	if(!ai_holder.cooperative || !pack_leader)
		return
	if(!pack_leader.ai_holder.cooperative)
		return

	if(pack_leader != src)
		smart_ai_holder.set_follow(null)
		spawn(10) smart_ai_holder.set_follow(pack_leader)

	if(!(src in pack_leader.current_pack_members))
		pack_leader.current_pack_members += src

	current_pack_members = pack_leader.current_pack_members

	if(!(pack_leader in current_pack_members))
		current_pack_members += pack_leader

	for(var/mob/living/simple_animal/hostile/smart_beast/member in pack_leader.current_pack_members)
		if(!(src in member.current_pack_members))
			member.current_pack_members += src
		if(src.pack_leader != member.pack_leader)
			member.pack_leader = find_pack_leader()

	for(var/mob/living/simple_animal/hostile/smart_beast/member in range(15,src))
		if(istype(member, src.type))
			if(!(src in member.current_pack_members))
				member.current_pack_members += src
			if(!(member in src.current_pack_members))
				src.current_pack_members += member
			if(src.pack_leader != member.pack_leader)
				member.pack_leader = find_pack_leader()

	if(current_pack_members.len <= 1) // ты еблан? ты как СТАЮ в ОДИНОЧКУ создавать собрался, инфузория?
		current_pack_members = list()
		pack_leader = null
		return

/mob/living/simple_animal/hostile/smart_beast/IIsAlly(mob/living/L)
	if(hunger > hunger_threshold*8 && diet != DIET_HERBIVOROUS && !ai_holder.cooperative && prob(10))
		return 0 // Принуждён к каннибализму
	. = ..()
	if (!.) // Outside the faction and friends, try to see if they're share one pack.
		return L in current_pack_members

//mob/living/simple_animal/hostile/smart_beast/New(new_holder)
/mob/living/simple_animal/hostile/smart_beast/Initialize()
	..()
	var/datum/ai_holder/smart_animal/smart_ai_holder = ai_holder
	if(smart_ai_holder.cooperative)
		spawn(10) attach_to_pack()
	var/tone = rand(190,255)
	if(randomize_tone)
		color = rgb(tone,tone,tone)

/mob/living/simple_animal/hostile/smart_beast/death(gibbed, deathmessage, show_dead_message)
	..(gibbed, deathmessage, show_dead_message)
	var/datum/ai_holder/smart_animal/smart_ai_holder = ai_holder
	if(current_pack_members)
		for(var/mob/living/simple_animal/hostile/smart_beast/pack_member in current_pack_members)
			var/datum/ai_holder/smart_animal/member_ai_holder = pack_member.ai_holder
			pack_member.current_pack_members -= src
			if(member_ai_holder.leader == pack_leader)
				member_ai_holder.set_follow(null)
			if(pack_member.pack_leader == src)
				pack_member.pack_leader = null
			current_pack_members = list()
	if(pack_leader)
		smart_ai_holder.set_follow(null)
		pack_leader = null

/datum/ai_holder/smart_animal/request_help()
	var/mob/living/simple_animal/hostile/smart_beast/smart_holder = holder
	if (!cooperative || world.time < next_sent_help_request  || world.time < next_received_help_request)
		return

	for (var/mob/living/L in smart_holder.current_pack_members)
		if (L == smart_holder) // Lets not call ourselves.
			continue
		if (smart_holder.z != L.z) // On seperate z-level.
			continue
		if (get_dist(L, smart_holder) > call_distance) // Too far to 'hear' the call for help.
			continue

		if (L.ai_holder)
			ai_log("request_help() : Asking [L] (AI) for help.", AI_LOG_DEBUG)
			L.ai_holder.help_requested(smart_holder)
	..()

/mob/living/simple_animal/hostile/smart_beast/proc/death_checks()
	var/datum/ai_holder/smart_animal/smart_ai_holder = ai_holder

	if(stat == DEAD)
		if(current_pack_members)
			for(var/mob/living/simple_animal/hostile/smart_beast/pack_member in current_pack_members)
				var/datum/ai_holder/smart_animal/member_ai_holder = pack_member.ai_holder
				pack_member.current_pack_members -= src
				if(member_ai_holder.leader == pack_leader)
					member_ai_holder.set_follow(null)
				if(pack_member.pack_leader == src)
					pack_member.pack_leader = null
				current_pack_members = list()
		if(pack_leader)
			smart_ai_holder.set_follow(null)
			pack_leader = null

/mob/living/simple_animal/hostile/smart_beast/proc/hostility_checks()
	var/datum/ai_holder/smart_animal/smart_ai_holder = ai_holder
	var/hostility = get_tension() + smart_ai_holder.aggression

	if(smart_ai_holder.hostile)
		if(aggression_affects_hostility && hunger_affects_hostility)
			if(hunger < hunger_threshold*2 && hostility < hostility_threshold)	//stop hunting when satiated and not threated
				smart_ai_holder.hostile = FALSE
		else if(aggression_affects_hostility)
			if(hostility < hostility_threshold)									//stop hunting when not threated
				smart_ai_holder.hostile = FALSE
		else if(hunger_affects_hostility)
			if(hunger < hunger_threshold*2)										//stop hunting when satiated
				smart_ai_holder.hostile = FALSE
	else
		if (((hunger > hunger_threshold*5 && hunger_affects_hostility) || (hostility >= hostility_threshold && aggression_affects_hostility)) && diet != DIET_HERBIVOROUS)
			smart_ai_holder.hostile = TRUE
		else if (((hunger > hunger_threshold*8 && hunger_affects_hostility) || (hostility >= hostility_threshold && aggression_affects_hostility)) && diet == DIET_HERBIVOROUS)
			smart_ai_holder.hostile = TRUE

/mob/living/simple_animal/hostile/smart_beast/proc/hunger_checks()
	var/datum/ai_holder/smart_animal/smart_ai_holder = ai_holder
	if(!eating && (diet == DIET_CARNIVOROUS || diet == DIET_OMNIVOROUS))
		for(var/mob/living/simple_animal/S in range(src,1))
			if(S.stat == DEAD && S != src && (smart_ai_holder.stance == STANCE_MOVE || smart_ai_holder.stance == STANCE_IDLE))
				consume(S)
	if(!resting && !buckled && (smart_ai_holder.stance == STANCE_MOVE || smart_ai_holder.stance == STANCE_IDLE))
		turns_since_scan++
		if(turns_since_scan > 1)
			turns_since_scan = 0
			find_and_eat_food()

/mob/living/simple_animal/hostile/smart_beast/proc/consume(var/mob/living/S, var/consume_delay = 50)
	var/d = get_dir(src.loc, S.loc)
	if (d == WEST || d == SOUTHWEST)
		set_dir(WEST)
	else if (d == EAST || d == NORTHEAST)
		set_dir(EAST)
	else if (d == SOUTH || d == SOUTHEAST)
		set_dir(SOUTH)
	else if (d == NORTH || d == NORTHWEST)
		set_dir(NORTH)
	else
		set_dir(SOUTH)
	eating = 1
	visible_message("[src] starts to consume \the body of [S]!")
	sleep(consume_delay/2)
	if(!S || !(S in range(src,1)) || stat == DEAD)
		eating = 0
		return FALSE
	sleep(consume_delay/2)
	if(!S || !(S in range(src,1)) || stat == DEAD)
		eating = 0
		return FALSE
	visible_message("[src] consumes \the body of [S]!")
	var/turf/T = get_turf(S)
	if(istype(S,/mob/living/carbon/human))
		var/obj/item/remains/human/H = new(T)
		H.desc += " These look like they belong to \a [S.name]."
	else
		var/obj/item/remains/xeno/X = new(T)
		X.desc += " These look like they belong to \a [S.name]."
	hunger = max(0, hunger - S.maxHealth*5)
	health = min(maxHealth, health + S.maxHealth/3)
	if(prob(15))
		qdel(S)
	else
		S.gib()
	eating = 0

	return TRUE

/mob/living/simple_animal/hostile/smart_beast/proc/find_and_eat_food()
	var/datum/ai_holder/smart_animal/smart_ai_holder = ai_holder

	if((movement_target) && !(isturf(movement_target.loc) || ishuman(movement_target.loc) ))
		movement_target = null

	if( !movement_target || !(movement_target.loc in oview(src, smart_ai_holder.vision_range)) )
		movement_target = null
		var/range = smart_ai_holder.vision_range + 3

		if(diet == DIET_CARNIVOROUS)
			for(var/obj/item/reagent_containers/food/snacks/meat/S in oview(src, range))
				if(isturf(S.loc) || ishuman(S.loc))
					movement_target = S
					break

		if(diet == DIET_HERBIVOROUS)
			for(var/obj/machinery/portable_atmospherics/hydroponics/H in oview(src, range))
				if(H.harvest)
					movement_target = H
					break

			for(var/obj/item/reagent_containers/food/snacks/grown/S in oview(src, range))
				if(isturf(S.loc) || ishuman(S.loc))
					movement_target = S
					break

		if(diet == DIET_OMNIVOROUS)
			for(var/obj/machinery/portable_atmospherics/hydroponics/H in oview(src, range))
				if(H.harvest)
					movement_target = H
					break

			for(var/obj/item/reagent_containers/food/snacks/S in oview(src, range))
				if(isturf(S.loc) || ishuman(S.loc))
					movement_target = S
					break

	if(!movement_target)
		return

	if(ishuman(movement_target.loc) && hunger > hunger_threshold && !(movement_target.loc in friends))
		visible_emote("stares at the [movement_target] that [movement_target.loc] has with eyes full of rage!")
		if(hunger_affects_hostility)
			smart_ai_holder.hostile = TRUE
		smart_ai_holder.give_target(movement_target.loc, urgent = TRUE)
		return

	if(movement_target && hunger > hunger_threshold && stat != DEAD && (ai_holder.stance == STANCE_MOVE || ai_holder.stance == STANCE_IDLE))
		eating = 1
		for(var/i = 1 to smart_ai_holder.vision_range)
			if(movement_target.fingerprintslast && tameable && !owner)
				sleep(max( movement_cooldown, round(smart_ai_holder.nervousness / 10) ))
			else
				sleep(movement_cooldown)
			step_to(src,movement_target,1)
			if(get_dist(src, movement_target) <= 1)
				break

		if(movement_target && (ai_holder.stance == STANCE_MOVE || ai_holder.stance == STANCE_IDLE))		//Not redundant due to sleeps, Item can be gone in 6 decisecomds
			var/D = get_dir(src.loc, movement_target.loc)
			if (D == WEST || D == SOUTHWEST)
				set_dir(WEST)
			else if (D == EAST || D == NORTHEAST)
				set_dir(EAST)
			else if (D == SOUTH || D == SOUTHEAST)
				set_dir(SOUTH)
			else if (D == NORTH || D == NORTHWEST)
				set_dir(NORTH)
			else
				set_dir(SOUTH)

			if(get_dist(src, movement_target) <= 1)
				if(istype(movement_target,/obj/machinery/portable_atmospherics/hydroponics))
					var/obj/machinery/portable_atmospherics/hydroponics/tray_target = movement_target
					if(tray_target.harvest)
						UnarmedAttack(movement_target)
						tray_target = null
						movement_target = null

				if(istype(movement_target,/obj/item/reagent_containers/food))
					playsound(src.loc, 'sound/items/eatfood.ogg', 50, 1)
					UnarmedAttack(movement_target)
					eating = 1
					if(movement_target.reagents)
						hunger = max(0, hunger - movement_target.reagents.total_volume)

					if(prob(30) || (!movement_target.reagents && get_dist(src, movement_target) <= 1)) //вроде как съели а там хз
						hunger = max(0, hunger - movement_target.reagents.total_volume*5)
						health = min(maxHealth, health + movement_target.reagents.total_volume + 5)

						qdel(movement_target)
						eating = 0

						if(movement_target.fingerprintslast in beastmasters && tameable)
							if(respect_stats)
								smart_ai_holder.aggression = max(1, smart_ai_holder.aggression - 2)
								smart_ai_holder.sympathy = min(150, smart_ai_holder.sympathy + 2)

							beastmasters[movement_target.fingerprintslast] ++

							if(beastmasters[movement_target.fingerprintslast] >= round( tame_difficulty + smart_ai_holder.aggression/75 + smart_ai_holder.dominance/100 ))
								for(var/client/C in GLOB.clients)
									if(C.key == movement_target.fingerprintslast && !(C.mob in friends))
										friends += C.mob

							if(beastmasters[movement_target.fingerprintslast] >= round( tame_difficulty + smart_ai_holder.aggression/75 + smart_ai_holder.dominance/100 + tame_difficulty/2 ))
								for(var/client/C in GLOB.clients)
									if(C.key == movement_target.fingerprintslast)
										faction = "[C.mob.name]"
										owner = C.mob
										smart_ai_holder.set_follow(owner)

							for(var/client/C in GLOB.clients)
								if(C.key == movement_target.fingerprintslast && smart_ai_holder.check_attacker(C.mob) && prob(50))
									smart_ai_holder.remove_attacker(C.mob)

						else
							beastmasters[movement_target.fingerprintslast] = 1

	if(get_dist(src, movement_target) > smart_ai_holder.vision_range)
		eating = 0

/mob/living/simple_animal/hostile/smart_beast/Life()
	. = ..()
	var/datum/ai_holder/smart_animal/smart_ai_holder = ai_holder
	if(!. || !smart_ai_holder)
		return FALSE

	if(!respect_stats)
		aggression_affects_hostility = FALSE

	death_checks()

	if(respect_stats)
		smart_ai_holder.calculate_stats()

	if(!respect_hunger)
		hunger_affects_hostility = FALSE

	else
		hunger += 0.5 + smart_ai_holder.energy/100
		if(hunger > hunger_threshold*10)
			health = max(0, health - (hunger - hunger_threshold*10))

	hostility_checks()

	if(ai_holder.cooperative)
		turns_since_pack_attach++
		if(turns_since_pack_attach > 100)
			attach_to_pack()

		if(pack_leader)
			friends = pack_leader.friends

	if(hunger > hunger_threshold && respect_hunger)
		hunger_checks()

	if(pulledby && ai_holder.retaliate && smart_ai_holder.aggression > 15 && !(pulledby in friends) && prob(75))
		smart_ai_holder.give_target(pulledby, urgent = TRUE)

///////////////////////////////////////////////EXOPLANET ANIMALS///////////////////////////////////////////////

/* AI */

/datum/ai_holder/smart_animal/samak
	init_outmatched_threshold = 150
	init_speak_chance = 5

/datum/ai_holder/smart_animal/shantak
	init_speak_chance = 2

/datum/ai_holder/smart_animal/yithian
	init_outmatched_threshold = 50

/datum/ai_holder/smart_animal/tindalos
	init_outmatched_threshold = 50

/datum/ai_holder/smart_animal/thinbug
	init_outmatched_threshold = 50
	init_speak_chance = 1

/datum/ai_holder/smart_animal/royalcrab
	init_outmatched_threshold = 150
	init_speak_chance = 1

/datum/ai_holder/smart_animal/pack
	cooperative = TRUE
	init_speak_chance = 4

/datum/ai_holder/smart_animal/pack/diyaab
	init_outmatched_threshold = 50
	init_vision_range = 9

/datum/ai_holder/smart_animal/pack/diyaab/post_melee_attack(atom/A)
	. = ..()
	if(holder.Adjacent(A))
		holder.IMove(get_step(holder, pick(GLOB.alldirs)))
		holder.face_atom(A)

/* Say Lists */

/datum/say_list/smart/diyaab
	speak = list("Awrr?","Aowrl!","Worrl")
	emote_see = list("sniffs the air cautiously","looks around")
	emote_hear = list("snuffles")

	say_maybe_target = list("Wrrl?")	// When they briefly see something.
	say_got_target = list()	// When a target is first assigned.
	say_threaten = list("WRAWR!")		// When threatening someone.
	say_stand_down = list("Aowrr")	// When the threatened thing goes away.
	say_escalate = list("AOWRRRL!!!")		// When the threatened thing doesn't go away.

	threaten_sound = null
	stand_down_sound = null

/datum/say_list/smart/shantak
	speak = list("Shuhn","Shrunnph?","Shunpf")
	emote_see = list("scratches the ground","shakes out its mane","tinkles gently")

	say_maybe_target = list("Rrk?")	// When they briefly see something.
	say_got_target = list()	// When a target is first assigned.
	say_threaten = list("RRUK!")		// When threatening someone.
	say_stand_down = list("Ruk")	// When the threatened thing goes away.
	say_escalate = list("RRUKK!!!")		// When the threatened thing doesn't go away.

	threaten_sound = null
	stand_down_sound = null

/datum/say_list/smart/samak
	speak = list("Hruuugh!","Hrunnph")
	emote_see = list("paws the ground","shakes its mane","stomps")
	emote_hear = list("snuffles")

	say_maybe_target = list("Rrk?")	// When they briefly see something.
	say_got_target = list()	// When a target is first assigned.
	say_threaten = list("RRUK!")		// When threatening someone.
	say_stand_down = list("Ruk")	// When the threatened thing goes away.
	say_escalate = list("RRUKK!!!")		// When the threatened thing doesn't go away.

	threaten_sound = 'sound/voice/LizardBellow.ogg'	// Sound file played when the mob's AI calls threaten_target() for the first time.
	stand_down_sound = null							// Sound file played when the mob's AI loses sight of the threatened target.

/datum/say_list/smart/thinbug
	emote_hear = list("scratches the ground","chitters")

	say_maybe_target = list("Rrk?")	// When they briefly see something.
	say_got_target = list()	// When a target is first assigned.
	say_threaten = list("RRUK!")		// When threatening someone.
	say_stand_down = list("Ruk")	// When the threatened thing goes away.
	say_escalate = list("RRUKK!!!")		// When the threatened thing doesn't go away.

	threaten_sound = 'sound/voice/BugBuzz.ogg'
	stand_down_sound = 'sound/voice/Bug.ogg'

/datum/say_list/smart/royalcrab
	emote_see = list("skitters","oozes liquid from its mouth", "scratches at the ground", "clicks its claws")

	say_maybe_target = list("Rrk?")	// When they briefly see something.
	say_got_target = list()	// When a target is first assigned.
	say_threaten = list("RRUK!")		// When threatening someone.
	say_stand_down = list("Ruk")	// When the threatened thing goes away.
	say_escalate = list("RRUKK!!!")		// When the threatened thing doesn't go away.

	threaten_sound = null
	stand_down_sound = null

/datum/say_list/smart/shantak/lava
	speak = list("Karuph","Karump")

/* Actual Mobs */

/mob/living/simple_animal/hostile/smart_beast/samak
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
	diet = DIET_CARNIVOROUS
	mob_bump_flag = HUMAN
	mob_push_flags = ~HEAVY
	mob_swap_flags = ~HEAVY
	pass_flags = PASS_FLAG_TABLE
	mob_size = MOB_MEDIUM
	natural_weapon = /obj/item/natural_weapon/bite/strong
	cold_damage_per_tick = 0
	natural_armor = list(
		melee = ARMOR_MELEE_KNIVES
		)

	ai_holder = /datum/ai_holder/smart_animal/samak
	say_list_type = /datum/say_list/smart/samak

/mob/living/simple_animal/hostile/smart_beast/samak/alt
	desc = "A fast, armoured predator accustomed to hiding and ambushing."
	faction = "samak_alt"
	icon_state = "samak-alt"
	icon_living = "samak-alt"
	icon_dead = "samak-alt_dead"

/mob/living/simple_animal/hostile/smart_beast/diyaab
	name = "diyaab"
	desc = "A small pack animal. Although omnivorous, it will hunt meat on occasion."
	faction = "diyaab"
	icon_state = "diyaab"
	icon_living = "diyaab"
	icon_dead = "diyaab_dead"
	init_tame_difficulty = 10
	move_to_delay = 1
	maxHealth = 25
	health = 25
	speed = 1
	natural_weapon = /obj/item/natural_weapon/claws/weak
	cold_damage_per_tick = 0
	diet = DIET_OMNIVOROUS
	mob_size = MOB_SMALL

	ai_holder = /datum/ai_holder/smart_animal/pack/diyaab
	say_list_type = /datum/say_list/smart/diyaab

/mob/living/simple_animal/hostile/smart_beast/diyaab/pack_spawn/New(new_holder)
	..()
	new /mob/living/simple_animal/hostile/smart_beast/diyaab(src.loc)
	new /mob/living/simple_animal/hostile/smart_beast/diyaab(src.loc)
	if(prob(30))
		new /mob/living/simple_animal/hostile/smart_beast/diyaab(src.loc)
		if(prob(30))
			new /mob/living/simple_animal/hostile/smart_beast/diyaab(src.loc)

/mob/living/simple_animal/hostile/smart_beast/shantak
	name = "shantak"
	desc = "A piglike creature with a bright iridiscent mane that sparkles as though lit by an inner light. Don't be fooled by its beauty though."
	faction = "shantak"
	icon_state = "shantak"
	icon_living = "shantak"
	icon_dead = "shantak_dead"
	movement_cooldown = 4
	init_tame_difficulty = 5
	move_to_delay = 1
	maxHealth = 75
	health = 75
	speed = 1
	natural_weapon = /obj/item/natural_weapon/claws
	cold_damage_per_tick = 0
	diet = DIET_OMNIVOROUS
	mob_bump_flag = HUMAN
	mob_push_flags = ~HEAVY
	mob_swap_flags = ~HEAVY
	pass_flags = PASS_FLAG_TABLE
	mob_size = MOB_MEDIUM

	ai_holder = /datum/ai_holder/smart_animal/shantak
	say_list_type = /datum/say_list/smart/shantak

/mob/living/simple_animal/hostile/smart_beast/shantak/alt
	desc = "A piglike creature with a long and graceful mane. Don't be fooled by its beauty."
	icon_state = "shantak-alt"
	icon_living = "shantak-alt"
	icon_dead = "shantak-alt_dead"

/mob/living/simple_animal/hostile/smart_beast/yithian
	name = "yithian"
	desc = "A friendly creature vaguely resembling an oversized snail without a shell."
	icon_state = "yithian"
	icon_living = "yithian"
	icon_dead = "yithian_dead"
	init_tame_difficulty = 10
	mob_size = MOB_TINY
	density = FALSE
	diet = DIET_HERBIVOROUS
	natural_weapon = /obj/item/natural_weapon/bite/mouse

	ai_holder = /datum/ai_holder/smart_animal/yithian

/mob/living/simple_animal/hostile/smart_beast/tindalos
	name = "tindalos"
	desc = "It looks like a large, flightless grasshopper."
	icon_state = "tindalos"
	icon_living = "tindalos"
	icon_dead = "tindalos_dead"
	movement_cooldown = 4
	mob_size = MOB_TINY
	density = FALSE
	diet = DIET_OMNIVOROUS
	natural_weapon = /obj/item/natural_weapon/claws/weak
	tameable = 0
	pass_flags = PASS_FLAG_TABLE

	ai_holder = /datum/ai_holder/smart_animal/tindalos

/mob/living/simple_animal/hostile/smart_beast/thinbug
	name = "taki"
	desc = "It looks like a bunch of legs."
	icon_state = "thinbug"
	icon_living = "thinbug"
	icon_dead = "thinbug_dead"
	movement_cooldown = 4
	mob_size = MOB_MINISCULE
	density = FALSE
	diet = DIET_CARNIVOROUS
	natural_weapon = /obj/item/natural_weapon/bite/weak
	tameable = 0

	ai_holder = /datum/ai_holder/smart_animal/thinbug
	say_list_type = /datum/say_list/smart/thinbug

/mob/living/simple_animal/hostile/smart_beast/royalcrab
	name = "cragenoy"
	desc = "It looks like a crustacean with an exceedingly hard carapace. Watch the pinchers!"
	faction = "crab"
	icon_state = "royalcrab"
	icon_living = "royalcrab"
	icon_dead = "royalcrab_dead"
	move_to_delay = 3
	maxHealth = 150
	health = 150
	speed = 1
	mob_size = MOB_LARGE
	diet = DIET_CARNIVOROUS
	mob_bump_flag = HUMAN
	mob_push_flags = ~HEAVY
	mob_swap_flags = ~HEAVY
	natural_weapon = /obj/item/natural_weapon/pincers
	natural_armor = list(
		melee = ARMOR_MELEE_RESISTANT
		)
	tameable = 0

	ai_holder = /datum/ai_holder/smart_animal/royalcrab
	say_list = /datum/say_list/smart/royalcrab

/mob/living/simple_animal/hostile/smart_beast/charbaby
	name = "charbaby"
	desc = "A huge grubby creature."
	icon_state = "char"
	icon_living = "char"
	icon_dead = "char_dead"
	init_tame_difficulty = 15
	mob_size = MOB_LARGE
	health = 60
	maxHealth = 60
	natural_weapon = /obj/item/natural_weapon/charbaby
	speed = 2
	response_help =  "pats briefly"
	response_disarm = "gently pushes"
	response_harm = "strikes"
	return_damage_min = 2
	return_damage_max = 3
	harm_intent_damage = 1
	blood_color = COLOR_NT_RED
	diet = DIET_HERBIVOROUS
	mob_bump_flag = HUMAN
	mob_push_flags = ~HEAVY
	mob_swap_flags = ~HEAVY
	natural_armor = list(
		laser = ARMOR_LASER_HANDGUNS
		)
	ai_holder = /datum/ai_holder/smart_animal/charbaby

/datum/ai_holder/smart_animal/charbaby
	init_outmatched_threshold = 50

/datum/ai_holder/smart_animal/charbaby/engage_target()
	. = ..()
	var/mob/living/simple_animal/hostile/smart_beast/C = holder
	if(isliving(C.target_mob) && prob(25))
		var/mob/living/L = C.target_mob
		if(prob(10))
			L.adjust_fire_stacks(1)
			L.IgniteMob()

/obj/item/natural_weapon/charbaby
	name = "scalding hide"
	damtype = BURN
	hitsound = 'sound/items/Welder.ogg'
	force = 5
	attack_verb = list("singed")

/mob/living/simple_animal/hostile/smart_beast/attack_hand(mob/living/carbon/human/H)
	. = ..()
	reflect_unarmed_damage(H, BURN, "amorphous mass")

/mob/living/simple_animal/hostile/smart_beast/shantak/lava
	desc = "A vaguely canine looking beast. It looks as though its fur is made of stone wool."
	icon_state = "lavadog"
	icon_living = "lavadog"
	icon_dead = "lavadog_dead"

	say_list_type = /datum/say_list/smart/shantak/lava