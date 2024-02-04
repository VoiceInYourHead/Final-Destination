/obj/item/psychic_power/psielectro
	name = "orb of energy"
	force = 5
	edge = TRUE
	maintain_cost = 10
	icon_state = "electro"
	item_state = "electro"
	attack_cooldown = 5
	var/cooldown = 0
	var/ranged = FALSE

/obj/item/psychic_power/psielectro/Process()
	if(cooldown > 0)
		cooldown--

	. = ..()

/obj/item/psychic_power/psielectro/New(var/mob/living/user)
	var/el_rank = user.psi.get_rank(PSI_METAKINESIS)
	maintain_cost -= el_rank

	if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) == PSI_RANK_GRANDMASTER)
		ranged = TRUE

	..()

/obj/item/psychic_power/psielectro/afterattack(atom/A as mob|obj|turf|area, var/mob/living/user as mob, proximity)

//TURFS AND ANYTHING ELSE

	if(proximity)
		var/datum/effect/effect/system/spark_spread/sparks = new ()
		sparks.set_up(3, 0, get_turf(A))
		sparks.start()

	if(!proximity && !ranged)
		return

	var/el_rank = user.psi.get_rank(PSI_METAKINESIS)

//MOBS

	if(istype(A, /mob/living))
		var/mob/living/target = A

		if(cooldown > 0)
			to_chat(user, "<span class='warning'>�� �� ������ ������������ ������ ����������� ��������� �����!</span>")
			return
		if(target == user)
			to_chat(user, "<span class='warning'>�� �� ������ �������� ������ ����!</span>")
			return
		if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) <= PSI_RANK_OPERANT)
			user.visible_message("<span class='danger'>[user] ���������� ����� ���-�������� ������ � ���� [target]!</span>")
		if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) >= PSI_RANK_MASTER)
			user.visible_message("<span class='danger'>[user] �������� [target] ������ ������������� �������!</span>")
		if(target.psi && !target.psi.suppressed)
			var/el_rank_target = target.psi.get_rank(PSI_METAKINESIS)
			if(el_rank_target >= el_rank && prob(50))
				user.visible_message("<span class='danger'>[target] ���������� ��� ����� ����, ��������� ��� [user] � ���� ������!</span>")
				user.electrocute_act(rand(el_rank_target * 2,el_rank_target * 5), target, 1, target.zone_sel.selecting)
				cooldown += 1
				new /obj/effect/temporary(get_turf(user),3, 'icons/effects/effects.dmi', "electricity_constant")
				return TRUE
		target.electrocute_act(rand(el_rank * 2,el_rank * 5), user, 1, user.zone_sel.selecting)
		cooldown += 1
		new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "electricity_constant")
		return TRUE

//LIGHT

	if(istype(A, /obj/machinery/light))
		var/obj/machinery/light/lighting = A
		if(lighting.on)
			if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) >= PSI_RANK_OPERANT)
				if(do_after(user, 30))
					if(proximity)
						user.visible_message("<span class='danger'>[user] ���������� ���� � ��������� �����, � ��� ����� ���� ������ �� �������!</span>")
						to_chat(user, "<span class='warning'>�� ����������� ���� � ������� �����, ��������� �� �� �� ����������!</span>")
					else
						user.visible_message("<span class='danger'>[user] ����������� ���� � [lighting], � �����, ������ ������� �������� ��� �������, ������� � ��� ���������!</span>")
						to_chat(user, "<span class='warning'>�� � ������� ���������� �������� �����, ��������� �� �������������, ������� � ��� ����.</span>")
					lighting.broken(TRUE)
					user.psi.stamina = min(user.psi.max_stamina, user.psi.stamina + rand(5,10))
		else
			return

//CELLS

	var/obj/item/cell/charging_cell = A.get_cell()
	if(istype(charging_cell))
		if(proximity)
			user.visible_message("<span class='warning'>[user] ������������ ���� � [charging_cell], �������� � ��������!</span>")
		else
			user.visible_message("<span class='warning'>[user] ���������� ���� � [charging_cell], ������� � �� ����� ������!</span>")
		charging_cell.give(rand(el_rank * 3,el_rank * 6))
		new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
		return TRUE

//AIRLOCKS

	if(istype(A,/obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/D = A
		var/option = input(user, "Do something!", "What do you want to do?") in list("Open/Close", "Bolt/Unbolt", "Electrify")
		if (!option)
			return
		if(option == "Open/Close")
			if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) <= PSI_RANK_OPERANT)
				if(prob(30))
					to_chat("<span class='warning'>�� ��������� ��� �������� �������� � [D.name], �� ������ �� ����������!</span>")
					user.visible_message("<span class='notice'>[user] ��������� ��� ������� �������� � [D.name] � �����������.</span>")
					return
			if(D && AIRLOCK_OPEN)
				D.open()
				user.visible_message("<span class='notice'>[user] ������� �������� � [D.name] �����������.</span>")
				new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
				playsound(D.loc, "sparks", 50, 1)
			if(D && AIRLOCK_CLOSED)
				D.close()
				user.visible_message("<span class='notice'>[user] ������� �������� � [D.name] �����������.</span>")
				new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
				playsound(D.loc, "sparks", 50, 1)

		if(option == "Electrify")
			D.electrify(50, 0)
			if(proximity)
				user.visible_message("<span class='warning'>[user] ������������ ���� � ������ [D.name], ��������� ����� �� ����� ����.</span>")
			else
				user.visible_message("<span class='warning'>[user] �������� � [D.name] ������ ����� �������������.</span>")
			new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
			playsound(D.loc, "sparks", 50, 1)

		if(option == "Bolt/Unbolt")
			if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) >= PSI_RANK_MASTER)
				D.toggle_lock()
				if(proximity)
					user.visible_message("<span class='notice'>[user] ���������� ��� ���� � [D.name], ������� ����� � ��������.</span>")
				else
					user.visible_message("<span class='notice'>[user] ������� ���� � �����, ������� ����� [D.name] � ��������.</span>")
				new /obj/effect/temporary(get_turf(A),3, 'icons/effects/effects.dmi', "electricity_constant")
				playsound(D.loc, "sparks", 50, 1)
			else
				user.visible_message("<span class='notice'>[user] ���������� ��� ���� � [D.name], �� ������ �� ����������.</span>")
				to_chat("<span class='warning'>�� ����������� ���� ���� � [D.name], ������� ���������� ����� ����� ��� ���������� ���������, �� ������ �� ����������!</span>")
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

/obj/item/psychic_power/psifire/AltClick(mob/user)
	combat_mode = !combat_mode
	if(combat_mode)
		to_chat(user, "<span class='warning'>�� ������������� � ���. ������, ���� ������� ����� ��������� �����</span>")
	if(!combat_mode)
		to_chat(user, "<span class='warning'>�� ����� ������ ��������� ����������� � ����� ������.</span>")

/obj/item/psychic_power/psifire/afterattack(atom/A as mob|obj|turf|area, var/mob/living/user as mob, proximity)
//TURFS

	if(istype(A, /turf/) && !proximity && combat_mode)
		var/turf/target_turf = get_turf(A)
		if(target_turf)
			var/turflist = getline(user, target_turf)
			flame_turf(turflist)
			user.visible_message("<span class='danger'>[user] ���������� �����, �������� ����� �� ����!</span>")

	else if(!proximity)
		return

//EATING FIRE

	if(istype(A, /obj/effect/turf_fire))
		var/obj/effect/turf_fire/fire = A
		if(fire.fire_power >= 20)
			if(user.psi && !user.psi.suppressed && user.psi.get_rank(PSI_METAKINESIS) >= PSI_RANK_OPERANT)
				if(do_after(user, 30))
					user.visible_message("<span class='danger'>[user] ����������� ���� � [fire], ���������� �������� ���!</span>")
					to_chat(user, "<span class='warning'>�� ��������� ���� � [fire], ��������� ��� �������, ��� � ��� ���������. ����� ������� �������� ���� ����.</span>")
					qdel(fire)
					user.psi.stamina = min(user.psi.max_stamina, user.psi.stamina + rand(5,10))
		else
			return

//OTHER STUFF

	var/obj/OBJ = A
	if(istype(OBJ))
		if(istype(A, /obj/item/clothing/mask/smokable/cigarette))
			var/obj/item/clothing/mask/smokable/cigarette/S = A
			S.light("[user] ������� �������� ��� ����������, ���������� [S.name].")
			playsound(S.loc, "light_bic", 100, 1, -4)
		else
			user.visible_message("<span class='warning'>[user] ���������� ���� � [OBJ]. ����� ��������, ��� �� ����� ��������������� ��� ���.</span>")
			OBJ.HandleObjectHeating(src, user, 700)

//MOBS

	if(istype(A, /mob/living) && combat_mode)
		var/mob/living/target = A
		user.visible_message("<span class='danger'>[user] ���������� ���� � [target], ������� ��� ��� ������!</span>")
		target.fire_act(exposed_temperature = 300, exposed_volume = 250)
	else if(istype(A, /mob/living))
		var/mob/living/target = A
		if(istype(target.wear_mask, /obj/item/clothing/mask/smokable/cigarette) && user.zone_sel.selecting == BP_MOUTH)
			var/obj/item/clothing/mask/smokable/cigarette/cig = target.wear_mask
			if(target == user)
				cig.attackby(src, user)
			else
				cig.light("<span class='notice'>[user] ������� �������� ��� ����������, ���������� [cig.name] �� ��� [target].</span>")

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
	var/range = 2
	var/cooldown = 0
	var/turf/previousturf = null

/obj/item/psychic_power/psiice/New(var/mob/living/user)
	var/cryo_rank = user.psi.get_rank(PSI_METAKINESIS)

	maintain_cost -= cryo_rank
	range += cryo_rank

	..()

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
		to_chat(user, "<span class='notice'>Now slicing apart the girder...</span>")
		if(do_after(user,reinf_material ? 40: 20,src))
			to_chat(user, "<span class='notice'>You slice apart the girder!</span>")
			if(reinf_material)
				reinf_material.place_dismantled_product(get_turf(src))
			dismantle()
		return

	if(istype(W, /obj/item/pickaxe/diamonddrill))
		playsound(src.loc, 'sound/weapons/Genhit.ogg', 100, 1)
		if(do_after(user,reinf_material ? 60 : 40,src))
			to_chat(user, "<span class='notice'>You drill through the girder!</span>")
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
	src.visible_message(SPAN_WARNING("[src] ����!"))
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

/obj/item/psychic_power/psiice/AltClick(mob/user)
	combat_mode = !combat_mode
	if(combat_mode)
		to_chat(user, "<span class='warning'>�� ������������� � ���. ������, ���� ������� ����� ��������� �����</span>")
	if(!combat_mode)
		to_chat(user, "<span class='warning'>�� ����� ������ ��������� ����������� � ����� ������.</span>")

/obj/item/psychic_power/psiice/afterattack(atom/A as mob|obj|turf|area, var/mob/living/user as mob, proximity)
	var/cryo_rank = user.psi.get_rank(PSI_METAKINESIS)

//TURFS

	if(istype(A, /turf/))
		var/turf/target = A
		if(combat_mode)
			if(!proximity && cryo_rank >= PSI_RANK_MASTER)
				if(do_after(user, 20))
					cooldown += 2
					var/turf/target_turf = get_turf(target)
					if(target_turf)
						var/turflist = getline(user, target_turf)
						ice_turf(turflist)
			if(!proximity)
				return
			if(do_after(user, 20))
				cooldown += 2
				user.visible_message("<span class='danger'>[user] �������� ����� �� ����!</span>")
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
				user.visible_message("<span class='danger'>[user] ��������� [sim] ������� ������!</span>")
				sim.wet_floor(5 * cryo_rank)
				new /obj/effect/temporary(sim,3, 'icons/effects/effects.dmi', "blueshatter")
				return TRUE

	if(cooldown > 0)
		to_chat(user, "<span class='warning'>�� �� ������ ������������ ������ ����������� ��������� �����!</span>")
		return

	if(!proximity)
		return

//MOBS

	if(istype(A, /mob/living))
		cooldown += 2
		var/mob/living/target = A
		new /obj/structure/girder/ice_wall(get_turf(target))
		new /obj/effect/temporary(get_turf(target),3, 'icons/effects/effects.dmi', "extinguish")
		target.Stun(3*cryo_rank)
		user.visible_message("<span class='danger'>[user] ����������� � ���� [target] ������������ �����, ������� ��� � ��!</span>")
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