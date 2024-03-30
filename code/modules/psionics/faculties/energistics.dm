/decl/psionic_faculty/energistics
	id = PSI_ENERGISTICS
	name = "Hyloforia"
	associated_intent = I_HURT
	armour_types = list("laser", "melee") //"bomb"

/decl/psionic_power/energistics
	faculty = PSI_ENERGISTICS


/decl/psionic_power/energistics/zorch
	name =             "Zorch"
	cost =             20
	cooldown =         20
	use_ranged =       TRUE
	min_rank =         PSI_RANK_APPRENTICE
	use_description = "Выберите красный интент и верхнюю часть тела, чтобы по нажатию запустить в цель луч концентрированной псионической энергии."

/decl/psionic_power/energistics/zorch/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_CHEST)
		return FALSE
	. = ..()
	if(.)
		user.visible_message("<span class='danger'>Глаза [user] загораются ярким светом!</span>")

		var/user_rank = user.psi.get_rank(faculty)
		var/meta_rank = user.psi.get_rank(PSI_METAKINESIS)
		var/obj/item/projectile/pew
		var/pew_sound

		switch(user_rank)
			if(PSI_RANK_GRANDMASTER)
				if(user.a_intent == I_HELP)
					if(meta_rank >= PSI_RANK_MASTER)
						pew = new /obj/item/projectile/beam/stun/shock/heavy(get_turf(user))
						pew.name = "gigawatt mental beam"
						pew_sound = 'sound/weapons/taser2.ogg'
					else
						pew = new /obj/item/projectile/beam/stun(get_turf(user))
						pew.name = "mental beam"
						pew.color = "#3ca7b1"
						pew_sound = 'sound/weapons/taser2.ogg'
				if(user.a_intent == I_HURT)
					pew = new /obj/item/projectile/beam/heavylaser(get_turf(user))
					pew.name = "gigawatt mental laser"
					pew.color = "#3ca7b1"
					pew_sound = 'sound/weapons/pulse.ogg'
			if(PSI_RANK_MASTER)
				if(user.a_intent == I_HELP)
					if(meta_rank == PSI_RANK_OPERANT)
						pew = new /obj/item/projectile/beam/stun/shock(get_turf(user))
						pew.name = "megawatt mental beam"
						pew_sound = 'sound/weapons/taser2.ogg'
					else
						pew = new /obj/item/projectile/beam/stun(get_turf(user))
						pew.name = "mental beam"
						pew.color = "#3ca7b1"
						pew_sound = 'sound/weapons/taser2.ogg'
				if(user.a_intent == I_HURT)
					pew = new /obj/item/projectile/beam/megabot(get_turf(user))
					pew.name = "megawatt mental laser"
					pew.color = "#3ca7b1"
					pew_sound = 'sound/weapons/Laser.ogg'
			if(PSI_RANK_OPERANT)
				if(user.a_intent == I_HELP)
					pew = new /obj/item/projectile/beam/stun(get_turf(user))
					pew.name = "mental beam"
					pew.color = "#3ca7b1"
					pew_sound = 'sound/weapons/taser2.ogg'
				if(user.a_intent == I_HURT)
					pew = new /obj/item/projectile/beam/midlaser(get_turf(user))
					pew.name = "mental laser"
					pew.color = "#3ca7b1"
					pew_sound = 'sound/weapons/scan.ogg'
			if(PSI_RANK_APPRENTICE)
				pew = new /obj/item/projectile/beam/stun/smalllaser(get_turf(user))
				pew.name = "mental beam"
				pew.color = "#3ca7b1"
				pew_sound = 'sound/weapons/taser2.ogg'

		if(istype(pew))
			playsound(pew.loc, pew_sound, 25, 1)
			pew.original = target
			pew.current = target
			pew.starting = get_turf(user)
			pew.shot_from = user
			pew.launch(target, user.zone_sel.selecting, (target.x-user.x), (target.y-user.y))
			return TRUE


/decl/psionic_power/energistics/disrupt
	name =            "Disrupt"
	cost =            10
	cooldown =        60
	use_melee =       TRUE
	min_rank =        PSI_RANK_APPRENTICE
	use_description = "Выберите глаза на красном интенте и нажмите на любой объект, чтобы создать мощный электромагнитный импульс, направленный в него."

/decl/psionic_power/energistics/disrupt/invoke(var/mob/living/user, var/mob/living/target)
	var/en_rank = user.psi.get_rank(PSI_ENERGISTICS)
	if(user.zone_sel.selecting != BP_EYES)
		return FALSE
	if(user.a_intent != I_HURT)
		return FALSE
	if(istype(target, /turf))
		return FALSE
	. = ..()
	if(.)
		if(en_rank == PSI_RANK_GRANDMASTER)
			var/option = input(user, "Choose something!", "How big should be the empulse?") in list("Concentrated", "Uncontrolled")
			if (!option)
				return
			if(option == "Concentrated")
				new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "blue_electricity_constant")
				target.visible_message("<span class='danger'>[user] переполняет [target] энергией, провоцируя внезапное высвобождение ЭМИ-импульса!</span>")
				empulse(target, 0, 1)
			if(option == "Uncontrolled")
				new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "blue_electricity_constant")
				target.visible_message("<span class='danger'>[user] взмахивает рукой, создавая мощную ЭМИ-волну!</span>")
				empulse(target, 6, 8)
		if(en_rank <= PSI_RANK_OPERANT)
			new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "blue_electricity_constant")
			target.visible_message("<span class='danger'>[user] взмахивает рукой, создавая мощный ЭМИ-импульс!</span>")
			empulse(target, rand(3,6) - en_rank, rand(4,7) - en_rank)
		if(en_rank == PSI_RANK_MASTER)
			new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "blue_electricity_constant")
			target.visible_message("<span class='danger'>[user] взмахивает рукой, создавая мощный ЭМИ-импульс!</span>")
			empulse(target, 1, 2)
		return TRUE


//PROJECTILES
/obj/item/projectile/psi
	name = "psionic projectile"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "dark_pellet"
	damage = 20
	distance_falloff = 1
	penetration_modifier = 1.0
	damage_type = BRUTE
	damage_flags = DAM_BULLET | DAM_SHARP
	miss_sounds = list('sound/weapons/guns/miss1.ogg','sound/weapons/guns/miss2.ogg','sound/weapons/guns/miss3.ogg','sound/weapons/guns/miss4.ogg')
	ricochet_sounds = list('sound/weapons/guns/ricochet1.ogg', 'sound/weapons/guns/ricochet2.ogg',
							'sound/weapons/guns/ricochet3.ogg', 'sound/weapons/guns/ricochet4.ogg')
	impact_sounds = list(BULLET_IMPACT_MEAT = SOUNDS_BULLET_MEAT, BULLET_IMPACT_METAL = SOUNDS_BULLET_METAL)

/obj/item/projectile/psi/strong
	damage = 25
	icon_state = "plasma_bolt"
	color = "#c40eed"
	var/explosion_power = 20
	var/explosion_falloff = 10

/obj/item/projectile/psi/strong/on_hit(var/atom/target, var/blocked = 0)
	cell_explosion(get_turf(target), explosion_power, explosion_falloff)
	..()

/obj/item/projectile/psi/strong_piercing
	damage = 40
	icon_state = "plasma_bolt"
	color = "#c40eed"
	var/explosion_power = 20
	var/explosion_falloff = 10
	var/exploded_inwall = FALSE
	var/delay = 4

	armor_penetration = 100
	penetrating = 2
	penetration_modifier = 1.1
	var/proximity_detonation = FALSE //should we explode near our target, and not inside of it?
	var/exploded = FALSE

/obj/item/projectile/psi/strong_piercing/Bump(atom/A as mob|obj|turf|area, forced=0)
	..()
	if(exploded)
		return

	exploded = TRUE
	if(istype(A,/obj/effect/shield))
		cell_explosion(get_turf(A), explosion_power, explosion_falloff)
		qdel(src)
		return

	sleep(delay)

	if(src && !exploded_inwall)
		cell_explosion(get_turf(src), explosion_power, explosion_falloff)
		qdel(src)

/obj/item/projectile/psi/strong_piercing/Destroy()
	if(src && !exploded_inwall && !istype(loc,/atom/movable))
		exploded = TRUE
		exploded_inwall = TRUE
		cell_explosion(get_turf(src), explosion_power, explosion_falloff)
	..()
//PROJECTILES

/decl/psionic_power/energistics/spit
	name =             "Bullet Spit"
	cost =             20
	cooldown =         45
	use_ranged =       TRUE
	use_melee =       TRUE
	min_rank =         PSI_RANK_APPRENTICE
	use_description = "Выберите голову на красном интенте и нажмите по чему угодно, чтобы запустить из пальца маленькую сферу с сжатой псионической энергией."

	var/psi_shot = "Standart"

/decl/psionic_power/energistics/spit/invoke(var/mob/living/user, var/mob/living/target)

	var/list/options = list(
		"Armor Piercing" = image('icons/screen/psi.dmi', "AP"),
		"Explosive" = image('icons/screen/psi.dmi', "EXP"),
		"Piercing Charges" = image('icons/screen/psi.dmi', "EXPAP"),
		"Standart" = image('icons/screen/psi.dmi', "DEF")
	)

	if(user.zone_sel.selecting != BP_HEAD)
		return FALSE
	. = ..()
	if(.)

		var/user_rank = user.psi.get_rank(faculty)
		var/obj/item/projectile/pew
		var/pew_sound

		if(target == user && user.a_intent == I_HELP)
			var/chosen_option = show_radial_menu(user, user, options, radius = 20, require_near = TRUE)
			if (!chosen_option)
				return
			psi_shot = chosen_option
			to_chat(user, "<span class='warning'>Теперь, ты будешь выпускать снаряды типа '[chosen_option]' при использовании данной способности.</span>")
			return TRUE

		if(user.a_intent != I_HURT)
			return FALSE

		if(psi_shot == "Standart")
			user.visible_message("<span class='danger'>[user] изображает пальцами пистолет, делая выстрел!</span>")
			if(user_rank < PSI_RANK_MASTER)
				pew = new /obj/item/projectile/psi(get_turf(user))
				pew.name = "small psionic bullet"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'
			if(user_rank >= PSI_RANK_MASTER)
				pew = new /obj/item/projectile/psi(get_turf(user))
				pew.name = "psionic bullet"
				pew.damage = 40
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'

		if(psi_shot == "Armor Piercing")
			user.visible_message("<span class='danger'>[user] изображает пальцами пистолет, делая выстрел!</span>")
			if(user_rank == PSI_RANK_APPRENTICE)
				if(prob(10))
					pew = new /obj/item/projectile/psi(get_turf(user))
					pew.name = "piercing psionic bullet"
					pew.color = "#a70909"
					pew.armor_penetration = 80
					pew.penetrating = 5
					pew.penetration_modifier = 1.1
					pew_sound = 'sound/weapons/guns/ricochet4.ogg'
				else
					pew = new /obj/item/projectile/psi(get_turf(user))
					pew.name = "small psionic bullet"
					pew_sound = 'sound/weapons/guns/ricochet4.ogg'
					to_chat(user, "<span class='warning'>Ты пытаешься сконцентрировать всю энергию в одном маленьком сгустке, дабы создать пробивной снаряд, но что-то мешает тебе...</span>")
			if(user_rank == PSI_RANK_OPERANT)
				pew = new /obj/item/projectile/psi(get_turf(user))
				pew.name = "piercing psionic bullet"
				pew.color = "#a70909"
				pew.armor_penetration = 80
				pew.penetrating = 5
				pew.penetration_modifier = 1.1
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'
			if(user_rank >= PSI_RANK_MASTER)
				pew = new /obj/item/projectile/psi(get_turf(user))
				pew.name = "piercing psionic bullet"
				pew.color = "#a70909"
				pew.armor_penetration = 100
				pew.penetrating = 6
				pew.penetration_modifier = 1.1
				pew.damage = 40
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'

		if(psi_shot == "Explosive")
			user.visible_message("<span class='danger'>[user] делает резкий выпад рукой, запуская в полёт огромный сгусток энергии!</span>")
			if(user_rank < PSI_RANK_OPERANT)
				if(prob(10))
					pew = new /obj/item/projectile/psi/strong(get_turf(user))
					pew.name = "explosive psionic round"
					pew.damage = 10
					pew_sound = 'sound/weapons/guns/ricochet4.ogg'
				else
					to_chat(user, "<span class='danger'>Огромный ком энергии накапливается внутри тебя, готовясь вырваться наружу, но что-то идёт не так...</span>")
					cell_explosion(get_turf(user), 10, 5)
			if(user_rank >= PSI_RANK_OPERANT)
				pew = new /obj/item/projectile/psi/strong(get_turf(user))
				pew.name = "explosive psionic round"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'

		if(psi_shot == "Piercing Charges")
			user.visible_message("<span class='danger'>[user] выставляет перед собой руку, создавая импровизированную трубу и пропускает через неё сжатый сгусток энергии!</span>")
			if(user_rank <= PSI_RANK_OPERANT)
				if(prob(30))
					pew = new /obj/item/projectile/psi/strong_piercing(get_turf(user))
					pew.name = "piercing psionic round"
					pew.color = "#a70909"
					pew.damage = 20
					pew_sound = 'sound/weapons/guns/ricochet4.ogg'
				else
					pew = new /obj/item/projectile/psi(get_turf(user))
					pew.name = "piercing psionic bullet"
					pew.color = "#a70909"
					pew.armor_penetration = 80
					pew.penetrating = 5
					pew.penetration_modifier = 1.1
					pew_sound = 'sound/weapons/guns/ricochet4.ogg'
					to_chat(user, "<span class='warning'>Ты пытаешься сконцентрировать всю энергию в одном маленьком сгустке, дабы создать пробивной снаряд, но что-то мешает тебе...</span>")
					cell_explosion(get_turf(user), 15, 5)
			if(user_rank == PSI_RANK_MASTER)
				if(prob(70))
					pew = new /obj/item/projectile/psi/strong_piercing(get_turf(user))
					pew.name = "piercing psionic round"
					pew.color = "#a70909"
					pew.damage = 20
					pew_sound = 'sound/weapons/guns/ricochet4.ogg'
				else
					to_chat(user, "<span class='warning'>Ты пытаешься сконцентрировать всю энергию в одном маленьком сгустке, дабы создать пробивной снаряд, но что-то мешает тебе...</span>")
					cell_explosion(get_turf(user), 15, 5)
			if(user_rank == PSI_RANK_GRANDMASTER)
				pew = new /obj/item/projectile/psi/strong_piercing(get_turf(user))
				pew.name = "piercing psionic round"
				pew.color = "#a70909"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'

		if(istype(pew))
			playsound(pew.loc, pew_sound, 25, 1)
			pew.original = target
			pew.current = target
			pew.starting = get_turf(user)
			pew.shot_from = user
			pew.launch(target, user.zone_sel.selecting, (target.x-user.x), (target.y-user.y))
		return TRUE


/decl/psionic_power/energistics/storm
	name =             "Bullet Storm"
	cost =             30
	cooldown =         120
	min_rank =         PSI_RANK_APPRENTICE
	use_melee =        TRUE
	use_description = "Выберите рот на красном интенте и нажмите в любое место около себя, чтобы создать рой псионических снарядов, летящих в разные стороны."
	var/psi_shot = "Standart"

/decl/psionic_power/energistics/storm/invoke(var/mob/living/user, var/mob/living/target)
	var/list/options = list(
		"Explosive" = image('icons/screen/psi.dmi', "EXP"),
		"Standart" = image('icons/screen/psi.dmi', "DEF")
	)

	if(user.zone_sel.selecting != BP_MOUTH)
		return FALSE
	. = ..()
	if(.)
		var/user_rank = user.psi.get_rank(faculty)

		if(target == user && user.a_intent == I_HELP && user_rank == PSI_RANK_GRANDMASTER)
			var/chosen_option = show_radial_menu(user, user, options, radius = 20, require_near = TRUE)
			if (!chosen_option)
				return
			psi_shot = chosen_option
			to_chat(user, "<span class='warning'>Теперь, ты будешь выпускать снаряды типа '[chosen_option]' при использовании данной способности.</span>")
			return TRUE

		if(user.a_intent != I_HURT)
			return FALSE

		user.visible_message("<span class='danger'>[user] создаёт вокруг себя рой из вращающихся пуль, запуская их в полёт!</span>")

		user.psi.set_cooldown(cooldown)
		sleep(4)
		user.psi.spend_power(cost)
		var/turf/O = get_turf(src)
		switch(user_rank)
			if(PSI_RANK_GRANDMASTER)
				if(psi_shot == "Explosive")
					user.fragmentate(O, 10, 4, list(/obj/item/projectile/psi/strong = 1))
				else
					user.fragmentate(O, 40, 7, list(/obj/item/projectile/psi = 1))
			if(PSI_RANK_MASTER)
				user.fragmentate(O, 30, 6, list(/obj/item/projectile/psi = 1))
			if(PSI_RANK_OPERANT)
				user.fragmentate(O, 20, 5, list(/obj/item/projectile/psi = 1))
			if(PSI_RANK_APPRENTICE)
				user.fragmentate(O, 10, 4, list(/obj/item/projectile/psi = 1))
		return TRUE

/mob/proc/fragmentate(var/turf/T=get_turf(src), var/fragment_number = 30, var/spreading_range = 5, var/list/fragtypes=list(/obj/item/projectile/))
	set waitfor = 0
	var/list/target_turfs = getcircle(T, spreading_range)
	for(var/turf/O in target_turfs)
		sleep(0)
		var/fragment_type = pickweight(fragtypes)
		var/obj/item/projectile/P = new fragment_type(T)
		P.shot_from = src.name
		P.launch(O)


/decl/psionic_power/energistics/cloud
	name =            "Cloud"
	cost =            20
	cooldown =        50
	use_melee =       TRUE
	min_rank =        PSI_RANK_OPERANT
	use_description = "Выберите грудь на зелёном интенте и нажмите по себе, чтобы создать дымовую завесу."
	admin_log = FALSE
	var/turf/previousturf = null
	var/inner_radius = -1 //for all your ring spell needs
	var/outer_radius = 2

/obj/effect/smoke_wall
	icon_state = "smoke wall"
	anchored = TRUE
	opacity = FALSE
	layer = ABOVE_HUMAN_LAYER
	icon = 'icons/fd/structures/smoke.dmi'
	icon_state = "smoke"
	pixel_x = -9
	pixel_y = -6
	var/timer = 30

/obj/effect/smoke_wall/New()
	run_timer()

/obj/effect/smoke_wall/proc/run_timer()
	set waitfor = 0
	var/T = timer
	while(T > 0)
		sleep(1 SECOND)
		T--
	src.alpha = 200
	sleep(2)
	src.alpha = 150
	sleep(2)
	src.alpha = 100
	sleep(2)
	src.alpha = 50
	sleep(2)
	src.alpha = 20
	sleep(2)
	src.alpha = 10
	qdel(src)

/decl/psionic_power/energistics/cloud/invoke(var/mob/living/user, var/mob/living/target)
	var/en_rank_user = user.psi.get_rank(PSI_ENERGISTICS)

	if(en_rank_user == PSI_RANK_GRANDMASTER)
		outer_radius = 4

	if(user.zone_sel.selecting != BP_CHEST)
		return FALSE
	if(target != user)
		return FALSE
	if(user.a_intent != I_HELP)
		return FALSE

	. = ..()

	if(target == user)
		var/list/targets = list()

		for(var/turf/point in oview_or_orange(outer_radius, user, "range"))
			if(!(point in oview_or_orange(inner_radius, user, "range")))
				if(point.density)
					continue
				if(istype(point, /turf/space))
					continue
				targets += point

		if(!targets.len)
			return FALSE

		var/turf/user_turf = get_turf(user)
		for(var/turf/T in targets)
			var/obj/effect/smoke_wall/IW = new(T)
			if(istype(IW))
				IW.pixel_x = (user_turf.x - T.x) * world.icon_size
				IW.pixel_y = (user_turf.y - T.y) * world.icon_size
				animate(IW, pixel_x = 0, pixel_y = 0, time = 3, easing = EASE_OUT)

		return TRUE
