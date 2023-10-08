/obj/item/projectile/bullet/pellet/fragment
	damage = 30
	range_step = 2 //controls damage falloff with distance. projectiles lose a "pellet" each time they travel this distance. Can be a non-integer.

	base_spread = 0 //causes it to be treated as a shrapnel explosion instead of cone
	spread_step = 40

	silenced = TRUE
	fire_sound = null
	no_attack_log = TRUE
	muzzle_type = null

/obj/item/projectile/bullet/pellet/fragment/strong
	damage = 60

/obj/item/grenade/frag
	name = "fragmentation grenade"
	desc = "A military fragmentation grenade, designed to explode in a deadly shower of fragments, while avoiding massive structural damage."
	icon_state = "frggrenade"

	var/list/fragment_types = list(/obj/item/projectile/bullet/pellet/fragment = 1)
	var/num_fragments = 90 //total number of fragments produced by the grenade
	var/explosion_power = 200
	var/explosion_falloff = 50

	//The radius of the circle used to launch projectiles. Lower values mean less projectiles are used but if set too low gaps may appear in the spread pattern
	var/spread_range = 7 //leave as is, for some reason setting this higher makes the spread pattern have gaps close to the epicenter

/obj/item/grenade/frag/detonate()
	..()

	var/turf/O = get_turf(src)
	if(!O) return

	if(explosion_power)
		on_explosion(O)

	fragmentate(O, num_fragments, spread_range, fragment_types, name)

	qdel(src)


/proc/fragmentate(turf/T, fragment_number = 30, spreading_range = 5, list/fragtypes=list(/obj/item/projectile/bullet/pellet/fragment), shoot_from)
	set waitfor = 0
	var/list/target_turfs = getcircle(T, spreading_range)
	var/fragments_per_projectile = round(fragment_number/length(target_turfs))

	for(var/turf/O in target_turfs)
		sleep(0)
		var/fragment_type = pickweight(fragtypes)
		var/obj/item/projectile/bullet/pellet/fragment/P = new fragment_type(T)
		P.pellets = fragments_per_projectile
		P.shot_from = shoot_from
		P.hitchance_mod = 50

		P.launch(O)
/* shit mess, removed because I want make that proc global
		// Handle damaging whatever the grenade's inside. Currently only checks for mobs.
		if(loc != get_turf(src))
			var/recursion_limit = 3 // Prevent infinite loops
			var/atom/current_check = src
			while (recursion_limit)
				current_check = current_check.loc
				if (isturf(current_check))
					break
				if (ismob(current_check))
					P.attack_mob(current_check, 0, 25)
				recursion_limit--
*/
		//Make sure to hit any mobs in the source turf
		for(var/mob/living/M in T)
			//lying on a frag grenade while the grenade is on the ground causes you to absorb most of the shrapnel.
			//you will most likely be dead, but others nearby will be spared the fragments that hit you instead.
			if(M.lying)
				P.attack_mob(M, 0, 5)
			else
				P.attack_mob(M, 0, 50)


/obj/item/grenade/frag/proc/on_explosion(var/turf/O)
	if(explosion_power)
		cell_explosion(O, explosion_power, explosion_falloff)

/obj/item/grenade/frag/shell
	name = "fragmentation grenade"
	desc = "A light fragmentation grenade, designed to be fired from a launcher. It can still be activated and thrown by hand if necessary."
	icon_state = "fragshell"

	num_fragments = 50 //less powerful than a regular frag grenade

/obj/item/grenade/frag/high_yield
	name = "fragmentation bomb"
	desc = "Larger and heavier than a standard fragmentation grenade, this device is extremely dangerous. It cannot be thrown as far because of its weight."
	icon_state = "frag"

	w_class = ITEM_SIZE_NORMAL
	throw_speed = 3
	throw_range = 5 //heavy, can't be thrown as far

	fragment_types = list(/obj/item/projectile/bullet/pellet/fragment=1,/obj/item/projectile/bullet/pellet/fragment/strong=4)
	num_fragments = 200  //total number of fragments produced by the grenade
	explosion_power = 250

/obj/item/grenade/frag/high_yield/on_explosion(var/turf/O)
	if(explosion_power)
		cell_explosion(O, round(explosion_power * 1.5), explosion_falloff) //has a chance to blow a hole in the floor

/obj/item/grenade/frag/high_explosive
	name = "HE grenade"
	desc = "A military high-explosive grenade, designed to cause massive structural damage in enemy lines."
	icon_state = "frggrenade"

	num_fragments = 4
	explosion_power = 300

/obj/item/grenade/frag/high_explosive/on_explosion(var/turf/O)
	if(explosion_power)
		cell_explosion(O, round(explosion_power * 1.5), explosion_falloff) //has a chance to blow a hole in the floor
