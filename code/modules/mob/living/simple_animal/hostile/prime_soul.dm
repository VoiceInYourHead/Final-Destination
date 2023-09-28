/mob/living/simple_animal/hostile/boss/prime_soul
	name = "Andrey Surov"
	desc = "run"
	icon = 'icons/mob/simple_animal/prime_soul.dmi'
	icon_state = "body"
	icon_living = "body"
	icon_dead = "body"
	response_help = "tries to poke"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 4
	movement_cooldown = 0
	maxHealth = 1000
	health = 1000
	harm_intent_damage = 5
	can_escape = TRUE
	a_intent = I_HURT
	natural_weapon = /obj/item/natural_weapon/punch/minos
	pry_time = 4 SECONDS
	taser_kill = 0
	melee_attack_delay = 2.5
	unsuitable_atmos_damage = 0
	faction = "boss"
	status_flags = CANPUSH
	does_spin = FALSE

	ai_holder = /datum/ai_holder/simple_animal/prime_soul

	var/seen = FALSE
	var/attacking = TRUE

	var/stamina = 6
	var/max_stamina = 6

	var/phase_two = FALSE
	var/attack_cooldown = 0
	var/stamina_recharge = 0

	var/datum/sound_token/boss_theme
	var/sound_id = "minos"

/mob/living/simple_animal/hostile/boss/prime_soul/proc/meet_player(mob/player)
	face_atom(player)
	anchored = 1
	playsound(src, 'sound/prime_soul/Mp_intro2.ogg', 60, 0, extrarange = 13, falloff = 4)
	playsound(src, 'sound/prime_soul/intro_music.ogg', 60, 0, extrarange = 13, falloff = 4)
	ISay("Ah... Free... At last.")
	sleep(52)
	dir = turn(dir,90)
	sleep(15)
	ISay("O Gabriel... Now dawns thy reckoning")
	sleep(50)
	dir = turn(dir,-180)
	sleep(17)
	ISay("And thy gore shall GLISTEN before the temples of MAN!")
	sleep(70)
	face_atom(player)
	sleep(14)
	ISay("Creature of steel? My gratitude upon thee for my freedom.")
	sleep(86)
	face_atom(player)
	ISay("But the crimes thy kind have committed against humanity are NOT forgotten!")
	sleep(100)
	face_atom(player)
	ISay("And thy punishment... IS DEATH!")
	sleep(54)
	anchored = 0
	face_atom(player)
	boss_theme = GLOB.sound_player.PlayLoopingSound(src, sound_id, 'sound/music/Heaven_Pierce_Her-ORDER.ogg', volume = 60, range = 20, falloff = 4, prefer_mute = TRUE)
	ai_holder.hostile = TRUE
	attacking = FALSE

///////////////////////* ATTACK TYPES START *///////////////////////

/mob/living/simple_animal/hostile/boss/prime_soul/proc/PREPARE_THYSELF(atom/movable/target)
	playsound(src, pick('sound/prime_soul/Mp_prepare.ogg', 'sound/prime_soul/Mp_prepare2.ogg'), 80, 0, extrarange = 13, falloff = 4)
	ai_holder.set_busy(TRUE)
	natural_weapon = /obj/item/natural_weapon/kick
	do_windup_animation(target,10)
	sleep(10)
	forceMove(get_step(target,get_dir(target,src)))
	IAttack(target)
	do_windup_animation(target,8)
	sleep(8)
	forceMove(get_step(target,get_dir(target,src)))
	IAttack(target)
	do_windup_animation(target,8)
	sleep(8)
	switch(rand(1,2))
		if(1)
			natural_weapon = /obj/item/natural_weapon/punch/minos/uppercut
			forceMove(get_step(target,get_dir(target,src)))
			if(IAttack(target))
				sleep(4)
				if(get_dist(src,target) < 2)
					target.throw_at(get_step(target,get_dir(src,target)), 3, 1)
		if(2)
			if(get_dist(src,target) > 2)
				DIE(target)
			else
				CRUSH(target)
	natural_weapon = initial(natural_weapon)
	ai_holder.forget_path()
	ai_holder.set_busy(FALSE)
	attacking = FALSE

/mob/living/simple_animal/hostile/boss/prime_soul/proc/THY_END_IS_NOW(atom/movable/target)
	playsound(src, pick('sound/prime_soul/Mp_thyend.ogg', 'sound/prime_soul/Mp_thyend2.ogg'), 80, 0, extrarange = 13, falloff = 4)
	ai_holder.set_busy(TRUE)
	natural_weapon = /obj/item/natural_weapon/punch/minos/snake
	do_windup_animation(target,7)
	sleep(7)
	forceMove(get_step(target,get_dir(target,src)))
	IAttack(target)
	do_windup_animation(target,7)
	sleep(7)
	forceMove(get_step(target,get_dir(target,src)))
	IAttack(target)
	do_windup_animation(target,7)
	sleep(7)
	forceMove(get_step(target,get_dir(target,src)))
	IAttack(target)
	do_windup_animation(target,7)
	sleep(7)
	forceMove(get_step(target,get_dir(target,src)))
	IAttack(target)
	natural_weapon = initial(natural_weapon)
	sleep(10)
	ai_holder.forget_path()
	ai_holder.set_busy(FALSE)
	attacking = FALSE

/mob/living/simple_animal/hostile/boss/prime_soul/proc/DIE(atom/movable/target)
	ai_holder.set_busy(TRUE)
	sleep(5)
	density = 0
	forceMove(get_step(target,get_dir(target,src)))
	do_crush_animation(10, 160)
	sleep(6)
	playsound(src, pick('sound/prime_soul/Mp_die.ogg', 'sound/prime_soul/Mp_die2.ogg'), 80, 0, extrarange = 13, falloff = 4)
	ISay("DIE!")
	sleep(4)
	cell_explosion(get_turf(src), 150, 50)
	density = 1
	sleep(10)
	ai_holder.forget_path()
	ai_holder.set_busy(FALSE)
	attacking = FALSE

/mob/living/simple_animal/hostile/boss/prime_soul/proc/CRUSH(atom/movable/target)
	ai_holder.set_busy(TRUE)
	density = 0
	do_crush_animation(10, 160)
	sleep(6)
	playsound(src, 'sound/prime_soul/Mp_crush.ogg', 80, 0, extrarange = 17, falloff = 4)
	ISay("CRUSH!")
	sleep(4)
	cell_explosion(get_turf(src), 150, 50)
	density = 1
	sleep(10)
	ai_holder.forget_path()
	ai_holder.set_busy(FALSE)
	attacking = FALSE

/mob/living/simple_animal/hostile/boss/prime_soul/proc/JUDGEMENT(atom/movable/target)
	playsound(src, pick('sound/prime_soul/Mp_judgement.ogg', 'sound/prime_soul/Mp_judgement2.ogg'), 80, 0, extrarange = 13, falloff = 4)
	ai_holder.set_busy(TRUE)
	do_windup_animation(target,10)
	sleep(10)
	var/rotation_angle
	switch(get_dir(src, target))
		if(WEST)
			rotation_angle = 90
		if(NORTHWEST)
			rotation_angle = 90
		if(SOUTHWEST)
			rotation_angle = 90
		if(EAST)
			rotation_angle = -90
		if(NORTHEAST)
			rotation_angle = -90
		if(SOUTHEAST)
			rotation_angle = -90
		if(NORTH)
			rotation_angle = 180
		else
			rotation_angle = 0
	var/matrix/dropckick = matrix(transform).Update(rotation = rotation_angle)
	animate(src, transform = dropckick, time = 2)
	throw_at(target, get_dist(src,target), get_dist(src,target) / 6)
	face_atom(target)
	sleep(6)
	anchored = 1
	cell_explosion(get_step(src, dir), 150, 50)
	anchored = 0
	sleep(2)
	dropckick = matrix(transform).Update(rotation = -rotation_angle)
	animate(src, transform = dropckick, time = 2)
	sleep(8)
	ai_holder.forget_path()
	ai_holder.set_busy(FALSE)
	attacking = FALSE

///////////////////////* ATTACK TYPES END *///////////////////////

/mob/living/simple_animal/hostile/boss/prime_soul/Life()
	..()
//	var/datum/ai_holder/simple_animal/prime_soul/minos_holder = ai_holder
	var/target = ai_holder.target

	if(!seen)
		for(var/mob/living/L in orange(5,src))
			if(L.key && L.client)
				seen = TRUE
				meet_player(L)
				break

	if(!attacking)
//		if(attack_cooldown >= 1)
		var/i = 0
		while(i < 20)
			if(stamina <= 0 || !target || i >= 19)
				attacking = FALSE
				break
			i++
			attack_cooldown = 0
			attacking = TRUE
			var/pick_attack = pick("PREPARE THYSELF!", "THY END IS NOW!", "DIE!", "JUDGEMENT!")
			switch(pick_attack)
				if("PREPARE THYSELF!")
					if(stamina - 3 < 0)
						continue
					stamina-=3
					ISay(pick_attack)
					PREPARE_THYSELF(target)
					break
				if("THY END IS NOW!")
					if(stamina - 2 < 0)
						continue
					stamina-=2
					ISay(pick_attack)
					THY_END_IS_NOW(target)
					break
				if("DIE!")
					if(stamina - 1 < 0)
						continue
					stamina-=1
					if(get_dist(src, target) > 2)
						DIE(target)
					else
						CRUSH(target)
					break
				if("JUDGEMENT!")
					if(stamina - 2 < 0)
						continue
					stamina-=2
					ISay(pick_attack)
					JUDGEMENT(target)
					break
				else
					ISay("Huh?..")
					continue // huh???
//		else
//			attack_cooldown++

	if(stamina <= 0)
		if(health < maxHealth / 2 && !phase_two)
			playsound(src, 'sound/prime_soul/Mp_weak.ogg', 90, 0, extrarange = 13, falloff = 4)
			ISay("WEAK!")
			max_stamina = 12
			phase_two = TRUE

		if(stamina_recharge >= 3)
			stamina = max_stamina
			stamina_recharge = 0

		else
			stamina_recharge++

/mob/living/simple_animal/hostile/boss/prime_soul/New()
	..()

/mob/living/simple_animal/hostile/boss/prime_soul/death(gibbed, deathmessage, show_dead_message)
	if(gibbed)
		return
	anchored = 1
	ai_holder.set_busy(TRUE)
	attacking = TRUE
	QDEL_NULL(boss_theme)
	visible_emote("screams")
	playsound(src, 'sound/prime_soul/Mp_outro.ogg', 75, 0, extrarange = 13, falloff = 4)
	sleep(40)
	ISay("Forgive me, my children, for I have failed to bring you salvation")
	sleep(70)
	ISay("From this cold, dark world...")
	sleep(50)
	visible_emote("screams even louder")
	do_crush_animation(80, 60)
	playsound(src, 'sound/prime_soul/Pinos_death_scream.ogg', 100, 0, extrarange = 13, falloff = 4)
	set_light(1, 20, 25, 2, l_color = "#f2feff")
	sleep(55)
	cell_explosion(get_turf(src), 500, 100)
	..(gibbed, deathmessage, show_dead_message)
	set_light(0)
	qdel(src)

/mob/living/simple_animal/hostile/boss/prime_soul/Destroy()
	QDEL_NULL(boss_theme)
	. = ..()

/mob/living/simple_animal/hostile/boss/prime_soul/Allow_Spacemove(check_drift = 0)
	return 1


/mob/living/simple_animal/hostile/boss/prime_soul/do_attack(atom/A, turf/T)
	face_atom(A)
	var/missed = FALSE
	if (get_dist(src, A) > 1 || (get_dir(src,A) != 0 && get_dir(src,A) != src.dir && get_dir(src,A) != turn(src.dir,45) && get_dir(src,A) != turn(src.dir,-45)))
		missed = TRUE

	if(missed) // Most likely we have a slow attack and they dodged it or we somehow got moved.
		playsound(src, 'sound/weapons/punchmiss.ogg', 75, 1)
		visible_message(SPAN_WARNING("\The [src] misses their attack."))
		return FALSE

	var/obj/item/natural_weapon/weapon = get_natural_weapon()

	if (weapon.resolve_attackby(A, src))
		apply_melee_effects(A)
	else if(istype(A,/mob/living/simple_animal)) //костыль куз я так и не смог разобраться почему оно не хочет резолвить атаку на симплмобов :P
		apply_melee_effects(A)

	return TRUE

/mob/living/simple_animal/hostile/boss/prime_soul/melee_pre_animation(atom/A)
	if(attacking)
		return
	..()

/mob/living/simple_animal/hostile/boss/prime_soul/ex_act()
	return

/datum/ai_holder/simple_animal/prime_soul
	intelligence_level = AI_SMART
	retaliate = TRUE				// The majority of smart mobs will fight back.
	hostile = FALSE
	use_astar = TRUE
	returns_home = TRUE
	home_low_priority = TRUE
	wander = FALSE
	vision_range = 20
	destructive = FALSE
	mauling = TRUE
	can_breakthrough = TRUE
	violent_breakthrough = TRUE

/datum/ai_holder/simple_animal/prime_soul/lose_target_position()
	playsound(holder, 'sound/prime_soul/Mp_useless.ogg', 100, 0, extrarange = 13, falloff = 4)
	..()
