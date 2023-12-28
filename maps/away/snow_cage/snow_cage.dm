/obj/effect/overmap/visitable/sector/snow_cage
	name = "arctic planet"
	desc = "An arctic planet with a small number of signatures on the surface. Scans indicate non-natural structures under the planet's surface."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	initial_generic_waypoints = list(
		"nav_snowcage_1",
		"nav_snowcage_2",
		"nav_snowcage_3"
	)

/datum/map_template/ruin/away_site/snow_cage
	name = "arctic planet"
	id = "awaysite_splanet"
	spawn_cost = 1000 //NO BITCHES??
	player_cost = 2
	description = "An arctic planet with a small number of signatures on the surface. Scans indicate non-natural structures under the planet's surface."
	suffixes = list("snow_cage/snow_cage-1.dmm","snow_cage/snow_cage-2.dmm","snow_cage/snow_cage-3.dmm","snow_cage/snow_cage-4.dmm")
	area_usage_test_exempted_root_areas = list(/area/splanet/)
	apc_test_exempt_areas = list(
		/area/splanet/outdoors = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/splanet/underground = NO_SCRUBBER|NO_VENT|NO_APC
	)

/obj/effect/shuttle_landmark/nav_splanet/nav1
	name = "Forest Landing Point #1"
	landmark_tag = "nav_snowcage_1"
	base_area = /area/splanet/outdoors

/obj/effect/shuttle_landmark/nav_splanet/nav2
	name = "Forest Landing Point #2"
	landmark_tag = "nav_snowcage_2"
	base_area = /area/splanet/outdoors

/obj/effect/shuttle_landmark/nav_splanet/nav3
	name = "Forest Landing Point #3"
	landmark_tag = "nav_snowcage_3"
	base_area = /area/splanet/outdoors

/area/splanet/outdoors
	name = "arctic forest"
	icon_state = "centcom"
	dynamic_lighting = 1
	base_turf = /turf/unsimulated/floor/exoplanet/barren
	screen_filter = /obj/screenfilter/snow

/area/splanet/underground
	name = "Ascent crashsite"
	base_turf = /turf/unsimulated/floor/exoplanet/barren


//MOBS

/obj/effect/pile
	name = "grey junk-pile"
	desc = "It looks like an unknown mass of different things and materials"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "molten_big"

/obj/effect/pile/Initialize()
	. = ..()

	for(var/atom/movable/O in loc)
		if(!O.anchored)
			O.forceMove(src)

			if (istype(O, /mob/living))
				var/mob/living/L = O
				if (!(L.status_flags & NOTARGET))
					L.status_flags ^= NOTARGET

/obj/effect/pile/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/shovel))
		if(do_after(user, 80))
			qdel(src)

/obj/effect/pile/Destroy()
	src.visible_message("<span class='warning'>\The [src] falls over.</span>")
	for(var/atom/movable/A in contents)
		A.dropInto(loc)
		if (istype(A, /mob/living))
			var/mob/living/L = A
			if (L.status_flags & NOTARGET)
				L.status_flags ^= NOTARGET
	return ..()


/datum/say_list/smart/digger
	speak = list("Skree!","SkRKkK")
	emote_see = list("digs hole in the ground","trembles","giggles")
	emote_hear = list("shakes it's ears")

	say_maybe_target = list("SKkk?")	// When they briefly see something.
	say_got_target = list()	// When a target is first assigned.
	say_threaten = list("SKRRRRK!")		// When threatening someone.
	say_stand_down = list("SKrr")	// When the threatened thing goes away.
	say_escalate = list("SKREEE!")		// When the threatened thing doesn't go away.

	threaten_sound = null	// Sound file played when the mob's AI calls threaten_target() for the first time.
	stand_down_sound = null							// Sound file played when the mob's AI loses sight of the threatened target.

/datum/ai_holder/smart_animal/digger
	init_speak_chance = 5
	init_outmatched_threshold = 50

/mob/living/simple_animal/hostile/smart_beast/digger
	name = "earthdigger"
	desc = "Strange looking rodent with sharp claws, probably used as some kind of digging tool."
	faction = "digger"
	icon = 'icons/fd/animals/adhomai.dmi'
	icon_state = "tunneler"
	icon_living = "tunneler"
	icon_dead = "tunneler_dead"
	init_tame_difficulty = 3
	movement_cooldown = 1
	maxHealth = 45
	health = 45
	speed = 1
	hunger_affects_hostility = FALSE
	natural_weapon = /obj/item/natural_weapon/claws/weak
	cold_damage_per_tick = 0
	diet = DIET_OMNIVOROUS
	pass_flags = PASS_FLAG_TABLE
	density = FALSE
	mob_size = MOB_SMALL
	gender = MALE

	ai_holder = /datum/ai_holder/smart_animal/digger
	say_list_type = /datum/say_list/smart/digger

	special_attack_min_range = 2
	special_attack_max_range = 7
	special_attack_cooldown = 5 SECONDS

	/// How long the dig telegraphing is.
	var/tunnel_warning = 0.5 SECONDS
	/// How long to wait between each tile. Higher numbers result in an easier to dodge tunnel attack.
	var/tunnel_tile_speed = 4

/mob/living/simple_animal/hostile/smart_beast/digger/New(new_holder)
	gender = pick(MALE,FEMALE)
	if(gender == MALE)
		desc = "Strange looking rodent with sharp claws, probably used as some kind of digging tool. This one is probably male"
	if(gender == FEMALE)
		desc = "Strange looking rodent with sharp claws, probably used as some kind of digging tool. This one is probably female"
		icon_state = "tunneler_f"
		icon_living = "tunneler_f"
		icon_dead = "tunneler_f_dead"

	. = ..()

/mob/living/simple_animal/hostile/smart_beast/digger/should_special_attack(atom/A)
	// Make sure its possible for the spider to reach the target so it doesn't try to go through a window.
	var/turf/destination = get_turf(A)
	var/turf/starting_turf = get_turf(src)
	var/turf/T = starting_turf
	for (var/i = 1 to get_dist(starting_turf, destination))
		if (T == destination)
			break

		T = get_step(T, get_dir(T, destination))
		if (T.density)
			return FALSE
	return T == destination

/mob/living/simple_animal/hostile/smart_beast/digger/do_special_attack(atom/A)
	set waitfor = FALSE
	set_AI_busy(TRUE)

	// Save where we're gonna go soon.
	var/turf/destination = get_turf(A)
	var/turf/starting_turf = get_turf(src)

	// Telegraph to give a small window to dodge if really close.
	do_windup_animation(A, tunnel_warning)
	sleep(tunnel_warning) // For the telegraphing.

	// Do the dig!
	visible_message(SPAN_DANGER("\The [src] tunnels towards \the [A]!"))
	submerge()

	if (handle_tunnel(destination) == FALSE)
		set_AI_busy(FALSE)
		emerge()
		return FALSE

	// Did we make it?
	if (!(src in destination))
		set_AI_busy(FALSE)
		emerge()
		return FALSE

	var/overshoot = TRUE

	// Test if something is at destination.
	for (var/mob/living/L in destination)
		if (L == src)
			continue

		visible_message(SPAN_DANGER("\The [src] erupts from underneath, and hits \the [L]!"))
		playsound(src, 'sound/weapons/heavysmash.ogg', 75, 1)
		L.Weaken(3)
		overshoot = FALSE

	if (!overshoot) // We hit the target, or something, at destination, so we're done.
		set_AI_busy(FALSE)
		emerge()
		return TRUE

	// Otherwise we need to keep going.
	to_chat(src, SPAN_WARNING("You overshoot your target!"))
	playsound(src, 'sound/weapons/punchmiss.ogg', 75, 1)
	var/dir_to_go = get_dir(starting_turf, destination)
	for (var/i = 1 to rand(2, 4))
		destination = get_step(destination, dir_to_go)

	handle_tunnel(destination)
	set_AI_busy(FALSE)
	emerge()
	return FALSE



/// Does the tunnel movement, stuns enemies, etc.
/mob/living/simple_animal/hostile/smart_beast/digger/proc/handle_tunnel(turf/destination)
	var/turf/T = get_turf(src) // Hold our current tile.

	// Regular tunnel loop.
	for (var/i = 1 to get_dist(src, destination))
		if (stat)
			return FALSE // We died or got knocked out on the way.
		if (loc == destination)
			break // We somehow got there early.

		// Update T.
		T = get_step(src, get_dir(src, destination))
		if (T.density)
			to_chat(src, "<span class='critical'>You hit something really solid!</span>")
			playsound(src, "punch", 75, 1)
			Weaken(5)
			return FALSE // Hit a wall.

		// Stun anyone in our way.
		for (var/mob/living/L in T)
			playsound(src, 'sound/weapons/heavysmash.ogg', 75, 1)
			L.Weaken(2)

		// Get into the tile.
		forceMove(T)

		// Visuals and sound.
		dig_under_floor(get_turf(src))
		playsound(src, 'sound/effects/break_stone.ogg', 75, 1)
		sleep(tunnel_tile_speed)

// For visuals.
/mob/living/simple_animal/hostile/smart_beast/digger/proc/submerge()
	alpha = 0
	dig_under_floor(get_turf(src))
	new /obj/effect/temporary/tunneler_hole(get_turf(src), 1 MINUTE)

// Ditto.
/mob/living/simple_animal/hostile/smart_beast/digger/proc/emerge()
	alpha = 255
	dig_under_floor(get_turf(src))
	new /obj/effect/temporary/tunneler_hole(get_turf(src), 1 MINUTE)

/mob/living/simple_animal/hostile/smart_beast/digger/proc/dig_under_floor(turf/T)
	new /obj/item/ore/glass(T) // This will be rather weird when on station but the alternative is too much work.