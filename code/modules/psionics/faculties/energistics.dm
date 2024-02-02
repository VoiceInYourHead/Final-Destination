/decl/psionic_faculty/energistics
	id = PSI_ENERGISTICS
	name = "Energistics"
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
	if(user.zone_sel.selecting == BP_MOUTH)
		return FALSE
	. = ..()
	if(.)
		user.visible_message("<span class='danger'>Глаза [user] загораются ярким светом!</span>")

		var/user_rank = user.psi.get_rank(faculty)
		var/obj/item/projectile/pew
		var/pew_sound

		switch(user_rank)
			if(PSI_RANK_GRANDMASTER)
				pew = new /obj/item/projectile/beam/heavylaser(get_turf(user))
				pew.name = "gigawatt mental laser"
				pew_sound = 'sound/weapons/pulse.ogg'
			if(PSI_RANK_MASTER)
				pew = new /obj/item/projectile/beam/megabot(get_turf(user))
				pew.name = "megawatt mental laser"
				pew_sound = 'sound/weapons/Laser.ogg'
			if(PSI_RANK_OPERANT)
				pew = new /obj/item/projectile/beam/midlaser(get_turf(user))
				pew.name = "mental laser"
				pew_sound = 'sound/weapons/scan.ogg'
			if(PSI_RANK_APPRENTICE)
				pew = new /obj/item/projectile/beam/smalllaser(get_turf(user))
				pew.name = "mental beam"
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
	use_description = "Выберите голову или глаза на красном интенте и нажмите на любой объект, чтобы создать мощный электромагнитный импульс, направленный в него."

/decl/psionic_power/energistics/disrupt/invoke(var/mob/living/user, var/mob/living/target)
	var/en_rank = user.psi.get_rank(PSI_ENERGISTICS)
	if(user.zone_sel.selecting != BP_HEAD && user.zone_sel.selecting != BP_EYES)
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

/decl/psionic_power/energistics/spit
	name =             "Bullet Spit"
	cost =             20
	cooldown =         45
	use_ranged =       TRUE
	min_rank =         PSI_RANK_APPRENTICE
	use_description = "Выберите правую или левую кисть на красном интенте и нажмите по чему угодно, чтобы запустить из пальца маленькую сферу с сжатой псионической энергией."

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
	damage = 15
	icon_state = "plasma_bolt"
	color = "#c40eed"
	var/explosion_power = 50
	var/explosion_falloff = 10

/obj/item/projectile/psi/strong/on_hit(var/atom/target, var/blocked = 0)
	cell_explosion(get_turf(target), explosion_power, explosion_falloff)
	..()

/decl/psionic_power/energistics/spit/invoke(var/mob/living/user, var/mob/living/target)
	if(!(user.zone_sel.selecting in list(BP_L_HAND, BP_R_HAND)))
		return FALSE
	. = ..()
	if(.)
		user.visible_message("<span class='danger'>[user] изображает пальцами пистолет, делая выстрел!</span>")

		var/user_rank = user.psi.get_rank(faculty)
		var/obj/item/projectile/pew
		var/pew_sound

		user.psi.set_cooldown(cooldown)
		sleep(4)
		user.psi.spend_power(cost)
		switch(user_rank)
			if(PSI_RANK_GRANDMASTER)
				pew = new /obj/item/projectile/psi/strong(get_turf(user))
				pew.name = "big psionic round"
				pew.damage = 25
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'
			if(PSI_RANK_MASTER)
				pew = new /obj/item/projectile/psi/strong(get_turf(user))
				pew.name = "psionic round"
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'
			if(PSI_RANK_OPERANT)
				pew = new /obj/item/projectile/psi(get_turf(user))
				pew.name = "psionic bullet"
				pew.damage = 40
				pew_sound = 'sound/weapons/guns/ricochet4.ogg'
			if(PSI_RANK_APPRENTICE)
				pew = new /obj/item/projectile/psi(get_turf(user))
				pew.name = "small psionic bullet"
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

/decl/psionic_power/energistics/storm/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_MOUTH)
		return FALSE
	. = ..()
	if(.)
		user.visible_message("<span class='danger'>[user] создаёт вокруг себя рой из вращающихся пуль, запуская их в полёт!</span>")

		var/user_rank = user.psi.get_rank(faculty)

		user.psi.set_cooldown(cooldown)
		sleep(4)
		user.psi.spend_power(cost)
		var/turf/O = get_turf(src)
		switch(user_rank)
			if(PSI_RANK_GRANDMASTER)
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