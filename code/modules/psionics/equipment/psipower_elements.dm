/obj/item/psychic_power/psielectro
	name = "orb of energy"
	force = 5
	edge = TRUE
	maintain_cost = 10
	icon_state = "electro"
	item_state = "electro"
	attack_cooldown = 5
	var/charge = 0
	var/cooldown = 0
//	var/ranged = FALSE

/obj/item/psychic_power/psielectro/attack_self(var/mob/living/user as mob)
	var/el_rank = user.psi.get_rank(PSI_METAKINESIS)
	if(el_rank >= PSI_RANK_MASTER)
		user.put_in_hands(new /obj/item/psychic_power/electric_whip(user))
		qdel(src)

/obj/item/psychic_power/psielectro/Process()
	if(cooldown > 0)
		cooldown--

	. = ..()

/obj/item/psychic_power/psielectro/New(var/mob/living/user)
	var/el_rank = user.psi.get_rank(PSI_METAKINESIS)
	maintain_cost -= el_rank

	..()

/obj/item/psychic_power/psielectro/apply_hit_effect(mob/living/target, mob/living/user, var/hit_zone)
	var/el_rank = user.psi.get_rank(PSI_METAKINESIS)

	if(target.psi && !target.psi.suppressed)
		var/el_rank_target = target.psi.get_rank(PSI_METAKINESIS)
		if(el_rank_target >= el_rank && prob(50))
			user.visible_message("<span class='danger'>[target] пропускает ток через себя, возвращая его [user] в виде молнии!</span>")
			user.electrocute_act(rand(el_rank_target * 2, el_rank_target * 5), target, 1, target.zone_sel.selecting)
			new /obj/effect/temporary(get_turf(user),3, 'icons/effects/effects.dmi', "electricity_constant")
			..()
	target.electrocute_act(rand(el_rank * 2, el_rank * 5), user, 1, user.zone_sel.selecting)
	new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "electricity_constant")
	..()

/obj/item/psychic_power/psielectro/afterattack(atom/A as mob|obj|turf|area, var/mob/living/user as mob, proximity)

//TURFS AND ANYTHING ELSE

	if(proximity)
		var/datum/effect/effect/system/spark_spread/sparks = new ()
		sparks.set_up(3, 0, get_turf(A))
		sparks.start()

	if(!proximity)
		return

	var/el_rank = user.psi.get_rank(PSI_METAKINESIS)

//MOBS

	if(istype(A, /mob/living))
		var/mob/living/target = A

		if(cooldown > 0)
			to_chat(user, "<span class='warning'>Ты не можешь использовать данную способность настолько часто!</span>")
			return
		if(target == user)
			to_chat(user, "<span class='warning'>Вы не можете зарядить самого себя!</span>")
			return
		if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) <= PSI_RANK_OPERANT)
			user.visible_message("<span class='danger'>[user] направляет свору еле-заметных молний в тело [target]!</span>")
		if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) >= PSI_RANK_MASTER)
			user.visible_message("<span class='danger'>[user] поражает [target] мощным электрическим шквалом!</span>")
		if(target.psi && !target.psi.suppressed)
			var/el_rank_target = target.psi.get_rank(PSI_METAKINESIS)
			if(el_rank_target >= el_rank && prob(50))
				user.visible_message("<span class='danger'>[target] пропускает ток через себя, возвращая его [user] в виде молнии!</span>")
				user.electrocute_act(rand(el_rank_target * 2,el_rank_target * 5), target, 1, target.zone_sel.selecting)
				cooldown += 1
				new /obj/effect/temporary(get_turf(user),3, 'icons/effects/effects.dmi', "electricity_constant")
				return TRUE
		target.electrocute_act(rand(el_rank + charge * 2,el_rank + charge * 5), user, 1, user.zone_sel.selecting)
		cooldown += 1
		if(charge >= 1)
			charge -= 1
		new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "electricity_constant")
		return TRUE

//LIGHT

	if(istype(A, /obj/machinery/light))

		if(A.do_psionics_check(maintain_cost, user))
			to_chat(user, SPAN_WARNING("Your power skates across \the [A.name], but cannot get a grip..."))
			return FALSE

		var/obj/machinery/light/lighting = A
		if(lighting.on)
			if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) >= PSI_RANK_OPERANT)
				if(do_after(user, 30))
					if(proximity)
						user.visible_message("<span class='danger'>[user] прислоняет руку к источнику света, и уже через пару секунд он угасает!</span>")
						to_chat(user, "<span class='warning'>Вы прислоняете руку к рабочей лампе, высасывая из неё всё содержимое!</span>")
					else
						user.visible_message("<span class='danger'>[user] протягивает руку к [lighting], и затем, резким взмахом вырывает всю энергию, которая в нём хранилась!</span>")
						to_chat(user, "<span class='warning'>Вы с скрипом разбиваете источник света, вытягивая всё электричество, которое в нём было.</span>")
					lighting.broken(TRUE)
					user.psi.stamina = min(user.psi.max_stamina, user.psi.stamina + rand(5,10))
					charge += 1
		else
			return

//CELLS

	var/obj/item/cell/charging_cell = A.get_cell()
	if(istype(charging_cell))

		if(A.do_psionics_check(maintain_cost, user))
			to_chat(user, SPAN_WARNING("Your power skates across \the [A.name], but cannot get a grip..."))
			return FALSE

		if(proximity)
			user.visible_message("<span class='warning'>[user] прикладывает руку к [charging_cell], наполняя её энергией!</span>")
		else
			user.visible_message("<span class='warning'>[user] направляет руку к [charging_cell], посылая в неё поток молний!</span>")
		charging_cell.give(rand(el_rank * 3,el_rank * 6))
		new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
		return TRUE

//AIRLOCKS

	if(istype(A,/obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/D = A
		var/option = input(user, "Do something!", "What do you want to do?") in list("Open/Close", "Bolt/Unbolt", "Electrify")
		if (!option)
			return

		if(A.do_psionics_check(maintain_cost, user))
			to_chat(user, SPAN_WARNING("Your power skates across \the [A.name], but cannot get a grip..."))
			return FALSE

		if(option == "Open/Close")
			if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) <= PSI_RANK_OPERANT)
				if(prob(30))
					to_chat("<span class='warning'>Вы несколько раз щёлкаете пальцами у [D.name], но ничего не происходит!</span>")
					user.visible_message("<span class='notice'>[user] несколько раз щёлкает пальцами у [D.name] в непонимании.</span>")
					return
			if(D && AIRLOCK_OPEN)
				D.open()
				user.visible_message("<span class='notice'>[user] щёлкает пальцами и [D.name] открывается.</span>")
				new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
				playsound(D.loc, "sparks", 50, 1)
			if(D && AIRLOCK_CLOSED)
				D.close()
				user.visible_message("<span class='notice'>[user] щёлкает пальцами и [D.name] закрывается.</span>")
				new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
				playsound(D.loc, "sparks", 50, 1)

		if(option == "Electrify")
			D.electrify(50, 0)
			if(proximity)
				user.visible_message("<span class='warning'>[user] прикладывает руку к панели [D.name], пропуская через неё поток тока.</span>")
			else
				user.visible_message("<span class='warning'>[user] посылает в [D.name] мощный поток электричества.</span>")
			new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
			playsound(D.loc, "sparks", 50, 1)

		if(option == "Bolt/Unbolt")
			if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) >= PSI_RANK_MASTER)
				D.toggle_lock()
				if(proximity)
					user.visible_message("<span class='notice'>[user] прислоняет обе руки к [D.name], приводя болты в движение.</span>")
				else
					user.visible_message("<span class='notice'>[user] сжимает руку в кулак, приводя болты [D.name] в движение.</span>")
				new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
				playsound(D.loc, "sparks", 50, 1)
			else
				user.visible_message("<span class='notice'>[user] прислоняет обе руки к [D.name], но ничего не происходит.</span>")
				to_chat("<span class='warning'>Вы прислоняете свои руки к [D.name], пытаясь пропустить поток через его внутренние механизмы, но ничего не получается!</span>")
				return

	..()

/obj/item/psychic_power/psifire
	name = "orb of eternal flame"
	force = 5
	edge = TRUE
	maintain_cost = 10
	icon_state = "pyro"
	item_state = "pyro"
	attack_cooldown = 5

	var/combat_mode = TRUE
	var/turf/previousturf = null

	var/range = 2
	var/flame_power = 25
	var/flame_color = COLOR_RED

/obj/item/psychic_power/psifire/New(var/mob/living/user)
	var/fire_rank = user.psi.get_rank(PSI_METAKINESIS)

	maintain_cost -= fire_rank
	flame_power += fire_rank
	range += fire_rank

	if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) >= PSI_RANK_MASTER)
		flame_color = "#33ccc9"
		flame_power += 5

	..()

/obj/item/psychic_power/psifire/AltClick(mob/living/carbon/user)
	var/list/options = list(
		"HELP" = image('icons/screen/psi.dmi', "HELP"),
		"HARM" = image('icons/screen/psi.dmi', "HARM")
	)

	var/chosen_option = show_radial_menu(user, user, options, radius = 25, require_near = TRUE)
	if (!chosen_option)
		return 0
	if(user.psi.suppressed)
		return 0
	switch(chosen_option)
		if("HARM")
			combat_mode = TRUE
			to_chat(user, "<span class='warning'>Вы приготовились к бою. Теперь, ваше касание будет поджигать людей.</span>")
		if("HELP")
			combat_mode = FALSE
			to_chat(user, "<span class='warning'>Вы вновь можете безопасно прикасаться к вещам вокруг.</span>")

/obj/item/psychic_power/psifire/apply_hit_effect(mob/living/target, mob/living/user, var/hit_zone)
	if(combat_mode)
		user.visible_message("<span class='danger'>[user] прислоняет руку к [target], зажигая его как спичку!</span>")
		target.fire_act(exposed_temperature = 300, exposed_volume = 250)
	..()

/obj/item/psychic_power/psifire/afterattack(atom/A as mob|obj|turf|area, var/mob/living/user as mob, proximity)
//TURFS

	if(istype(A, /turf/) && !proximity && combat_mode)
		var/turf/target_turf = get_turf(A)
		if(target_turf)
			var/turflist = getline(user, target_turf)
			flame_turf(turflist)
			user.visible_message("<span class='danger'>[user] взмахивает рукой, создавая стену из огня!</span>")

	else if(!proximity)
		return

//EATING FIRE

	if(istype(A, /obj/effect/turf_fire))
		var/obj/effect/turf_fire/fire = A
		if(fire.fire_power >= 20)
			if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) >= PSI_RANK_OPERANT)
				if(do_after(user, 30))
					user.visible_message("<span class='danger'>[user] протягивает руку к [fire], постепенно поглащая его!</span>")
					to_chat(user, "<span class='warning'>Вы подводите руку к [fire], вытягивая всю энергии, что в нём скопилась. Огонь приятно обвивает вашу руку.</span>")
					qdel(fire)
					user.psi.stamina = min(user.psi.max_stamina, user.psi.stamina + rand(5,10))
		else
			return

//OTHER STUFF

	var/obj/OBJ = A
	if(istype(OBJ))
		if(istype(A, /obj/item/clothing/mask/smokable/cigarette))
			var/obj/item/clothing/mask/smokable/cigarette/S = A
			S.light("[user] щёлкает пальцами как зажигалкой, подпаливая [S.name].")
			playsound(S.loc, "light_bic", 100, 1, -4)
		else
			user.visible_message("<span class='warning'>[user] прислоняет руку к [OBJ]. Можно заметить, как от места соприкосновения идёт пар.</span>")
			OBJ.HandleObjectHeating(src, user, 700)

//MOBS

	if(istype(A, /mob/living) && combat_mode)
		var/mob/living/target = A

		user.visible_message("<span class='danger'>[user] прислоняет руку к [target], зажигая его как спичку!</span>")
		target.fire_act(exposed_temperature = 300, exposed_volume = 250)
	else if(istype(A, /mob/living))
		var/mob/living/target = A
		if(istype(target.wear_mask, /obj/item/clothing/mask/smokable/cigarette) && user.zone_sel.selecting == BP_MOUTH)
			var/obj/item/clothing/mask/smokable/cigarette/cig = target.wear_mask
			if(target == user)
				cig.attackby(src, user)
			else
				cig.light("<span class='notice'>[user] щёлкает пальцами как зажигалкой, подпаливая [cig.name] во рту [target].</span>")

/obj/item/psychic_power/psifire/proc/flame_turf(list/turflist)
	var/length = LAZYLEN(turflist)
	if(length < 1)
		return
	turflist.len = min(length, range)

	playsound(src, pick('sound/weapons/guns/flamethrower1.ogg','sound/weapons/guns/flamethrower2.ogg','sound/weapons/guns/flamethrower3.ogg' ), 50, TRUE, -3)

	for(var/turf/T in turflist)
		if(T.density || istype(T, /turf/space))
			break
		if(!previousturf && length(turflist)>1)
			previousturf = get_turf(src)
			continue	//so we don't burn the tile we be standin on
		if(previousturf && (!T.CanPass(null, previousturf, 0,0) || !previousturf.CanPass(null, T, 0,0)))
			break
		previousturf = T

		//Consume part of our fuel to create a fire spot
		var/obj/effect/turf_fire/TF = T.IgniteTurf(flame_power, flame_color)
		if(istype(TF))
			TF.interact_with_atmos = FALSE
		T.hotspot_expose((flame_power * 3) + 300, 50)
		sleep(1)
	previousturf = null

/obj/item/psychic_power/psiice
	name = "orb of eternal cold"
	force = 5
	edge = TRUE
	maintain_cost = 10
	icon_state = "cryo"
	item_state = "cryo"
	attack_cooldown = 5
	var/combat_mode = TRUE
	var/structure_attack = "ICE WALL"
	var/range = 2
	var/cooldown = 0
	var/turf/previousturf = null
	var/inner_radius = -1 //for all your ring spell needs
	var/outer_radius = 2

/obj/item/psychic_power/psiice/New(var/mob/living/user)
	var/cryo_rank = user.psi.get_rank(PSI_METAKINESIS)

	maintain_cost -= cryo_rank
	range += cryo_rank

	..()

/obj/item/projectile/bullet/pellet/ice
	damage = 20
	pellets = 4
	range_step = 1
	spread_step = 50
	armor_penetration = 20
	icon = 'proxima/icons/obj/guns/projectiles.dmi'
	icon_state = "syringeproj_many"
	color = "#9ee0dd"

/obj/structure/girder/ice_wall
	icon_state = "ice wall"
	anchored = TRUE
	density = TRUE
	layer = ABOVE_HUMAN_LAYER
	w_class = ITEM_SIZE_NO_CONTAINER
	health_max = 200
	icon = 'icons/fd/freeze.dmi'
	icon_state = "ice_cube"
	var/timer = 30

/obj/structure/girder/ice_wall/New()
	run_timer()

/obj/structure/girder/ice_wall/attackby(obj/item/W, mob/user)
	if (user.a_intent == I_HURT)
		..()
		return

	if(istype(W, /obj/item/gun/energy/plasmacutter) || istype(W, /obj/item/psychic_power/psiblade/master/grand/paramount))
		if(istype(W, /obj/item/gun/energy/plasmacutter))
			var/obj/item/gun/energy/plasmacutter/cutter = W
			if(!cutter.slice(user))
				return
		playsound(src.loc, 'sound/items/Welder.ogg', 100, 1)
		to_chat(user, "<span class='notice'>Now slicing apart the wall...</span>")
		if(do_after(user,reinf_material ? 40: 20,src))
			to_chat(user, "<span class='notice'>You slice apart the wall!</span>")
			if(reinf_material)
				reinf_material.place_dismantled_product(get_turf(src))
			dismantle()
		return

	if(istype(W, /obj/item/pickaxe/diamonddrill))
		playsound(src.loc, 'sound/weapons/Genhit.ogg', 100, 1)
		if(do_after(user,reinf_material ? 60 : 40,src))
			to_chat(user, "<span class='notice'>You drill through the wall!</span>")
			if(reinf_material)
				reinf_material.place_dismantled_product(get_turf(src))
			dismantle()
		return

/obj/structure/girder/ice_wall/dismantle()
	qdel(src)

/obj/structure/girder/ice_wall/proc/run_timer()
	set waitfor = 0
	var/T = timer
	while(T > 0)
		sleep(1 SECOND)
		T--
	src.visible_message(SPAN_WARNING("[src] тает!"))
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

/obj/item/psychic_power/psiice/Process()
	if(cooldown > 0)
		cooldown--

	. = ..()

/obj/item/psychic_power/psiice/attack_self(var/mob/living/user as mob)
	var/cryo_rank = user.psi.get_rank(PSI_METAKINESIS)
	if(combat_mode)
		var/list/options = list(
			"ICE WALL" = image('icons/screen/psi.dmi', "WALL"),
			"ICE SPIKES" = image('icons/screen/psi.dmi', "SPIKES"),
			"ICE FISTS" = image('icons/screen/psi.dmi', "FISTS"),
			"ICE SWORD" = image('icons/screen/psi.dmi', "SWORD")
		)
		var/chosen_option = show_radial_menu(user, user, options, radius = 25, require_near = TRUE)
		if (!chosen_option)
			return 0
		if(user.psi.suppressed)
			return 0
		if(!combat_mode)
			return 0
		switch(chosen_option)
			if("ICE WALL")
				structure_attack = "ICE WALL"
				to_chat(user, "<span class='warning'>Теперь вы будете возводить ледяные стены при использовании дальней атаки!</span>")
				return 1
			if("ICE SPIKES")
				if(cryo_rank < PSI_RANK_OPERANT)
					to_chat(user, "<span class='warning'>Вы ещё недостаточно обучены для подобного приёма!</span>")
					return 0
				structure_attack = "ICE SPIKES"
				to_chat(user, "<span class='warning'>Теперь вы будете метать ледяные иглы при использовании дальней атаки!</span>")
				return 1
			if("ICE FISTS")
				user.put_in_hands(new /obj/item/cryokinesis/fists(user))
				qdel(src)
				return 1
			if("ICE SWORD")
				user.put_in_hands(new /obj/item/cryokinesis/rapier(user))
				qdel(src)
				return 1

/obj/item/psychic_power/psiice/AltClick(var/mob/living/user as mob)
	var/list/options = list(
		"HELP" = image('icons/screen/psi.dmi', "HELP"),
		"HARM" = image('icons/screen/psi.dmi', "HARM")
	)

	var/chosen_option = show_radial_menu(user, user, options, radius = 25, require_near = TRUE)
	if (!chosen_option)
		return 0
	if(user.psi.suppressed)
		return 0
	switch(chosen_option)
		if("HARM")
			combat_mode = TRUE
			to_chat(user, "<span class='warning'>Вы приготовились к бою. Теперь, ваше касание будет замораживать людей, вы сможете создавать ледяные стены и прочие приспособления.</span>")
		if("HELP")
			combat_mode = FALSE
			to_chat(user, "<span class='warning'>Вы вновь можете безопасно прикасаться к вещам вокруг.</span>")

/obj/item/psychic_power/psiice/apply_hit_effect(mob/living/target, mob/living/user, var/hit_zone)
	var/cryo_rank = user.psi.get_rank(PSI_METAKINESIS)

	if(target.do_psionics_check(maintain_cost, user))
		to_chat(user, SPAN_WARNING("Your power skates across \the [target.name], but cannot get a grip..."))
		return FALSE
	cooldown += 2

	if(target == user && cryo_rank >= PSI_RANK_MASTER)
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
			var/obj/structure/girder/ice_wall/IW = new(T)
			if(istype(IW))
				IW.pixel_x = (user_turf.x - T.x) * world.icon_size
				IW.pixel_y = (user_turf.y - T.y) * world.icon_size
				animate(IW, pixel_x = 0, pixel_y = 0, time = 3, easing = EASE_OUT)

		..()

	new /obj/structure/girder/ice_wall(get_turf(target))
	new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "extinguish")
	target.Stun(3*cryo_rank)
	user.visible_message("<span class='danger'>[user] прикасается к телу [target] побледневшей рукой, обращая его в лёд!</span>")
	target.bodytemperature = 500 / cryo_rank
	..()

/obj/item/psychic_power/psiice/afterattack(atom/A as mob|obj|turf|area, var/mob/living/user as mob, proximity)
	var/cryo_rank = user.psi.get_rank(PSI_METAKINESIS)

	if(cooldown > 0)
		to_chat(user, "<span class='warning'>Ты не можешь использовать данную способность настолько часто!</span>")
		return

	if(!proximity && cryo_rank >= PSI_RANK_OPERANT && structure_attack == "ICE SPIKES")
		var/obj/item/projectile/pew
		var/pew_sound
		cooldown += 2
		user.visible_message("<span class='danger'>[user] запускает вперёд град ледяных пик!</span>")
		pew = new /obj/item/projectile/bullet/pellet/ice(get_turf(user))
		pew.name = "stack of ice spikes"
		pew_sound = 'sound/weapons/guns/ricochet4.ogg'
		if(istype(pew))
			playsound(pew.loc, pew_sound, 25, 1)
			pew.original = A
			pew.current = A
			pew.starting = get_turf(user)
			pew.shot_from = user
			pew.launch(A, user.zone_sel.selecting, (A.x-user.x), (A.y-user.y))

//TURFS

	if(istype(A, /turf/))
		var/turf/target = A
		if(combat_mode)
			if(!proximity && cryo_rank >= PSI_RANK_MASTER && structure_attack == "ICE WALL")
				if(do_after(user, 10))
					cooldown += 2
					user.visible_message("<span class='danger'>[user] возводит стену из льда!</span>")
					var/turf/target_turf = get_turf(target)
					if(target_turf)
						var/turflist = getline(user, target_turf)
						ice_turf(turflist)
			if(!proximity)
				return
			if(do_after(user, 10))
				cooldown += 2
				user.visible_message("<span class='danger'>[user] возводит стену из льда!</span>")
				new /obj/effect/temporary(target,3, 'icons/effects/effects.dmi', "blueshatter")
				sleep(1)
				new /obj/structure/girder/ice_wall(get_turf(target))
				return TRUE
		else
			if(!proximity)
				return
			if(istype(A, /turf/simulated/))
				var/turf/simulated/sim = target
				cooldown += 2
				user.visible_message("<span class='danger'>[user] покрывает [sim] ледяной коркой!</span>")
				sim.wet_floor(5 * cryo_rank)
				new /obj/effect/temporary(sim,3, 'icons/effects/effects.dmi', "blueshatter")
				return TRUE

	if(!proximity)
		return

//MOBS

	if(istype(A, /mob/living) && combat_mode == TRUE)
		if(A.do_psionics_check(maintain_cost, user))
			to_chat(user, SPAN_WARNING("Your power skates across \the [A.name], but cannot get a grip..."))
			return FALSE
		cooldown += 2
		var/mob/living/target = A

		if(target == user && cryo_rank >= PSI_RANK_MASTER)
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
				var/obj/structure/girder/ice_wall/IW = new(T)
				if(istype(IW))
					IW.pixel_x = (user_turf.x - T.x) * world.icon_size
					IW.pixel_y = (user_turf.y - T.y) * world.icon_size
					animate(IW, pixel_x = 0, pixel_y = 0, time = 3, easing = EASE_OUT)

			return TRUE

		new /obj/structure/girder/ice_wall(get_turf(target))
		new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "extinguish")
		target.Stun(3*cryo_rank)
		user.visible_message("<span class='danger'>[user] прикасается к телу [target] побледневшей рукой, обращая его в лёд!</span>")
		target.bodytemperature = 500 / cryo_rank
		return TRUE

//ITEMS

	if(istype(A,/obj/item))
		var/obj/item/S = A
		S.temperature = T0C - 20

/obj/item/psychic_power/psiice/proc/ice_turf(list/turflist)
	var/length = LAZYLEN(turflist)
	if(length < 1)
		return
	turflist.len = min(length, range)

	playsound(src, pick('sound/weapons/guns/flamethrower1.ogg','sound/weapons/guns/flamethrower2.ogg','sound/weapons/guns/flamethrower3.ogg' ), 50, TRUE, -3)

	for(var/turf/T in turflist)
		if(T.density || istype(T, /turf/space))
			break
		if(!previousturf && length(turflist)>1)
			previousturf = get_turf(src)
			continue	//so we don't burn the tile we be standin on
		if(previousturf && (!T.CanPass(null, previousturf, 0,0) || !previousturf.CanPass(null, T, 0,0)))
			break
		previousturf = T

		//Consume part of our fuel to create a fire spot
		new /obj/structure/girder/ice_wall(get_turf(T))
		sleep(1)
	previousturf = null
