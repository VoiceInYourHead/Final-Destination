//COWBOY MECH//

/obj/item/mech_component/sensors/heavy/universal

/obj/item/mech_component/sensors/heavy/universal/prebuild()
	..()
	software = new(src)
	software.installed_software = list(MECH_SOFTWARE_UTILITY, MECH_SOFTWARE_WEAPONS)

/mob/living/exosuit/premade/farm/cowboy
	name = "SPIDER"
	desc = "A very agile and combat-oriented mech."

/mob/living/exosuit/premade/farm/cowboy/Initialize()
	if(!arms)
		arms = new /obj/item/mech_component/manipulators/combat(src)
		arms.color = COLOR_GUNMETAL
	if(!legs)
		legs = new /obj/item/mech_component/propulsion/combat(src)
		legs.color = COLOR_GUNMETAL
	if(!head)
		head = new /obj/item/mech_component/sensors/heavy/universal(src)
		head.color = COLOR_GUNMETAL
	if(!body)
		body = new /obj/item/mech_component/chassis/combat(src)
		body.color = COLOR_GUNMETAL

	. = ..()

/mob/living/exosuit/premade/farm/cowboy/spawn_mech_equipment()
	install_system(new /obj/item/mech_equipment/mounted_system/taser/plasma_rifle(src), HARDPOINT_RIGHT_HAND)
	install_system(new /obj/item/mech_equipment/catapult(src), HARDPOINT_LEFT_HAND)
	install_system(new /obj/item/mech_equipment/light(src), HARDPOINT_LEFT_SHOULDER)
	install_system(new /obj/item/mech_equipment/light(src), HARDPOINT_RIGHT_SHOULDER)

//COWBOY MECH//

//NERD MECH//

/obj/item/mech_component/sensors/combat/universal

/obj/item/mech_component/sensors/combat/universal/prebuild()
	..()
	software = new(src)
	software.installed_software = list(MECH_SOFTWARE_UTILITY, MECH_SOFTWARE_WEAPONS)

/obj/item/mech_component/propulsion/tracks/techman
	turn_delay = 4
	power_use = 100

/obj/item/mech_component/chassis/light/techman
	has_hardpoints = list(HARDPOINT_BACK, HARDPOINT_RIGHT_SHOULDER, HARDPOINT_LEFT_SHOULDER)

/obj/item/mech_component/chassis/light/techman/prebuild()
	cell = new /obj/item/cell/hyper(src)
	cell.charge = cell.maxcharge

	. = ..()

	m_armour = new /obj/item/robot_parts/robot_component/armour/exosuit/combat(src)

/mob/living/exosuit/premade/farm/techman
	name = "Betty"
	desc = "A modern style mech with alot of fancy work."

/mob/living/exosuit/premade/farm/techman/Initialize()
	if(!arms)
		arms = new /obj/item/mech_component/manipulators/light(src)
		arms.color = COLOR_GUNMETAL
	if(!legs)
		legs = new /obj/item/mech_component/propulsion/tracks/techman(src)
		legs.color = COLOR_GUNMETAL
	if(!head)
		head = new /obj/item/mech_component/sensors/combat/universal(src)
		head.color = COLOR_GUNMETAL
	if(!body)
		body = new /obj/item/mech_component/chassis/light/techman(src)
		body.color = COLOR_GUNMETAL

	. = ..()

/mob/living/exosuit/premade/farm/techman/spawn_mech_equipment()
	install_system(new /obj/item/mech_equipment/mounted_system/taser/autoplasma(src), HARDPOINT_RIGHT_HAND)
	install_system(new /obj/item/mech_equipment/mounted_system/taser/autoplasma(src), HARDPOINT_LEFT_HAND)
	install_system(new /obj/item/mech_equipment/shields(src), HARDPOINT_LEFT_SHOULDER)
	install_system(new /obj/item/mech_equipment/mounted_system/taser/plasma(src), HARDPOINT_RIGHT_SHOULDER)

//NERD MECH//

//LUMBERJACK MECH//

/obj/item/mech_component/sensors/light/combat/universal

/obj/item/mech_component/sensors/light/combat/universal/prebuild()
	..()
	software = new(src)
	software.installed_software = list(MECH_SOFTWARE_UTILITY, MECH_SOFTWARE_WEAPONS)

/mob/living/exosuit/premade/farm/forestman
	name = "INVINCIBLE IV"
	desc = "A very standart lumberjack mech, reworked for military purposes."

/mob/living/exosuit/premade/farm/forestman/Initialize()
	if(!arms)
		arms = new /obj/item/mech_component/manipulators/combat(src)
		arms.color = COLOR_GUNMETAL
	if(!legs)
		legs = new /obj/item/mech_component/propulsion/powerloader(src)
		legs.color = COLOR_GUNMETAL
	if(!head)
		head = new /obj/item/mech_component/sensors/light/combat/universal(src)
		head.color = COLOR_GUNMETAL
	if(!body)
		body = new /obj/item/mech_component/chassis/powerloader/combat(src)
		body.color = COLOR_GUNMETAL

	. = ..()

/mob/living/exosuit/premade/farm/forestman/spawn_mech_equipment()
	install_system(new /obj/item/mech_equipment/ballistic_shield(src), HARDPOINT_RIGHT_HAND)
	install_system(new /obj/item/mech_equipment/mounted_system/melee/mechete(src), HARDPOINT_LEFT_HAND)
	install_system(new /obj/item/mech_equipment/mounted_system/taser/machinegun(src), HARDPOINT_LEFT_SHOULDER)
	install_system(new /obj/item/mech_equipment/mounted_system/taser/machinegun(src), HARDPOINT_RIGHT_SHOULDER)

//SWAMPMAN MECH//

/obj/item/mech_component/sensors/powerloader/universal
	max_damage = 200

/obj/item/mech_component/sensors/powerloader/universal/prebuild()
	..()
	software = new(src)
	software.installed_software = list(MECH_SOFTWARE_UTILITY, MECH_SOFTWARE_ENGINEERING)

/obj/item/mech_component/manipulators/heavy/swampman
	melee_damage = 35
	max_damage = 150

/obj/item/mech_component/propulsion/spider/swampman
	max_damage = 120
	move_delay = 3

/obj/item/mech_component/chassis/heavy/swampman
	max_damage = 220
	mech_health = 800
	has_hardpoints = list(HARDPOINT_BACK, HARDPOINT_RIGHT_SHOULDER, HARDPOINT_LEFT_SHOULDER)

/obj/item/mech_component/chassis/heavy/swampman/prebuild()
	cell = new /obj/item/cell/hyper(src)
	cell.charge = cell.maxcharge

	. = ..()

	m_armour = new /obj/item/robot_parts/robot_component/armour/exosuit/combat(src)

/mob/living/exosuit/premade/farm/swampman
	name = "Leshiy"
	desc = "A very old, junky mech."

/mob/living/exosuit/premade/farm/swampman/Initialize()
	if(!arms)
		arms = new /obj/item/mech_component/manipulators/heavy/swampman(src)
		arms.color = COLOR_GUNMETAL
	if(!legs)
		legs = new /obj/item/mech_component/propulsion/spider/swampman(src)
		legs.color = COLOR_GUNMETAL
	if(!head)
		head = new /obj/item/mech_component/sensors/powerloader/universal(src)
		head.color = COLOR_GUNMETAL
	if(!body)
		body = new /obj/item/mech_component/chassis/heavy/swampman(src)
		body.color = COLOR_GUNMETAL

	. = ..()

/mob/living/exosuit/premade/farm/swampman/spawn_mech_equipment()
	install_system(new /obj/item/mech_equipment/catapult(src), HARDPOINT_RIGHT_HAND)
	install_system(new /obj/item/mech_equipment/drill/plasteel(src), HARDPOINT_LEFT_HAND)
	install_system(new /obj/item/mech_equipment/light(src), HARDPOINT_LEFT_SHOULDER)
	install_system(new /obj/item/mech_equipment/mounted_system/taser/plasma(src), HARDPOINT_RIGHT_SHOULDER)

//SWAMPMAN MECH//

/mob/living/simple_animal/hostile/giant_spider/tunneler/xeno
	name = "metal eater"
	desc = "Scary big bug."

	icon = 'icons/fd/animals/xenoids/burrower.dmi'
	icon_state = "Normal Burrower Walking"
	icon_living = "Normal Burrower Walking"
	icon_dead = "Normal Burrower Dead"

	pixel_x = -6

	maxHealth = 50
	health = 50

	poison_chance = 0
	poison_per_bite = 0

/mob/living/simple_animal/hostile/giant_spider/tunneler/xeno/small
	icon = 'icons/fd/animals/xenoids/larva.dmi'
	icon_state = "Larva"
	icon_living = "Larva"
	icon_dead = "Larva Dead"

	pixel_x = 0

	maxHealth = 5
	health = 5
	special_attack_cooldown = 5 SECONDS
	tunnel_tile_speed = 1

/mob/living/simple_animal/hostile/giant_spider/spitter/xeno
	name = "metal eater"
	desc = "Scary big bug."

	icon = 'icons/fd/animals/xenoids/spitter.dmi'
	icon_state = "Normal Spitter Walking"
	icon_living = "Normal Spitter Walking"
	icon_dead = "Normal Spitter Dead"

	pixel_x = -6

	maxHealth = 20
	health = 20

	poison_chance = 0
	poison_per_bite = 0

/mob/living/simple_animal/hostile/giant_spider/guard/xeno
	name = "metal eater"
	desc = "Scary big bug."

	pixel_x = -16

	icon = 'icons/fd/animals/xenoids/warrior.dmi'
	icon_state = "Normal Warrior Walking"
	icon_living = "Normal Warrior Walking"
	icon_dead = "Normal Warrior Dead"

	maxHealth = 200
	health = 200

	poison_chance = 0
	poison_per_bite = 0

/mob/living/simple_animal/hostile/giant_spider/guard/xeno/boss
	icon = 'icons/fd/animals/xenoids/crusher.dmi'
	icon_state = "Normal Crusher Walking"
	icon_living = "Normal Crusher Walking"
	icon_dead = "Normal Crusher Dead"

	pixel_x = -16

	maxHealth = 500
	health = 500

/mob/living/simple_animal/hostile/giant_spider/carrier/xeno
	name = "metal eater"
	desc = "Scary big bug."

	icon = 'icons/fd/animals/xenoids/hivelord.dmi'
	icon_state = "Normal Hivelord Walking"
	icon_living = "Normal Hivelord Walking"
	icon_dead = "Normal Hivelord Dead"

	pixel_x = -16

	maxHealth = 100
	health = 100

	poison_chance = 0
	poison_per_bite = 0

	spiderling_type = /mob/living/simple_animal/hostile/giant_spider/tunneler/xeno/small
	swarmling_type = /mob/living/simple_animal/hostile/giant_spider/hunter/xeno

/mob/living/simple_animal/hostile/giant_spider/hunter/xeno
	name = "metal eater"
	desc = "Scary big bug."

	icon = 'icons/fd/animals/xenoids/drone.dmi'
	icon_state = "Normal Drone Walking"
	icon_living = "Normal Drone Walking"
	icon_dead = "Normal Drone Dead"

	pixel_x = -6

	maxHealth = 80
	health = 80

	poison_chance = 0
	poison_per_bite = 0

/mob/living/simple_animal/hostile/giant_spider/lurker/xeno
	name = "metal eater"
	desc = "Scary big bug."

	icon = 'icons/fd/animals/xenoids/ravager.dmi'
	icon_state = "Normal Ravager Walking"
	icon_living = "Normal Ravager Walking"
	icon_dead = "Normal Ravager Dead"

	pixel_x = -16

	maxHealth = 20
	health = 20

	poison_chance = 0
	poison_per_bite = 0

/obj/effect/overmap/visitable/sector/rancho
	name = "colonized planetoid"
	desc = "Scanner indicates an phoron rich exoplanet, with a few small villages on it."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	color = "#0e5010"
	free_landing = TRUE
	initial_generic_waypoints = list(
		"nav_rancho_1",
		"nav_rancho_2"
	)

	var/list/lightmain
	var/list/lightswamp

/obj/effect/overmap/visitable/sector/rancho/New(nloc, max_x, max_y)
	name = "[generate_planet_name()], \a [name]"
	..()

/obj/effect/overmap/visitable/sector/rancho/Initialize()
	..()

	lightmain = block(locate(world.maxx, world.maxy, max(map_z)), locate(1, 1, min(map_z)))
	lightswamp = block(locate(world.maxx, world.maxy, max(map_z)), locate(1, 1, min(map_z)))
	for(var/atom/A as anything in lightmain)
		if(!istype(A.loc, /area/rancho/outdoors) || A.density || istype(A.loc, /area/rancho/outdoors_swamp))
			lightmain -= A
	for(var/atom/A as anything in lightswamp)
		if(!istype(A.loc, /area/rancho/outdoors_swamp) || A.density || istype(A.loc, /area/rancho/outdoors))
			lightswamp -= A
	update_daynight()

/obj/effect/overmap/visitable/sector/rancho/proc/update_daynight(light = 0.7, light_color_m = "#e2d1b2",  light_color_s = "#615c3d")
	for(var/turf/T as anything in lightmain)
		T.set_light(light, 0.1, 2, l_color = light_color_m)
	for(var/turf/T as anything in lightswamp)
		T.set_light(light, 0.1, 2, l_color = light_color_s)

/datum/map_template/ruin/away_site/rancho
	name = "colonized planetoid"
	id = "awaysite_rancho"
	spawn_cost = 1000 //NO BITCHES??
	player_cost = 2
	description = "Phoron rich exoplanet, with a few small villages on it"
	suffixes = list("rancho/rancho-1.dmm","rancho/rancho-2.dmm")
	area_usage_test_exempted_root_areas = list(/area/rancho/)
	apc_test_exempt_areas = list(
		/area/rancho/outdoors = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/rancho/indoors = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/rancho/outdoors_swamp = NO_SCRUBBER|NO_VENT|NO_APC
	)

/area/rancho
	name = "Block #7"
	icon_state = "unknown"

/area/rancho/outdoors
	name = "Block #7 - Outdoors"
	requires_power = 0
	dynamic_lighting = 1

/area/rancho/outdoors_swamp
	name = "Block #7 - Swamp"
	requires_power = 0
	dynamic_lighting = 1

/area/rancho/indoors
	name = "Block #7 - Indoors"
	requires_power = 1

/area/rancho/indoors/cargo
	name = "Block #7 - Cargo"

/area/rancho/indoors/swampman
	name = "Block #7 - Swampman House"

/area/rancho/indoors/forestman
	name = "Block #7 - Lumberjack's House"

/area/rancho/indoors/techman
	name = "Block #7 - Mechanic's House"

/obj/effect/shuttle_landmark/nav_rancho/nav1
	name = "Farmer's Block #7 - MAIN"
	landmark_tag = "nav_rancho_1"
	base_area = /area/rancho/outdoors
	base_turf = /turf/simulated/floor/plating

/obj/effect/shuttle_landmark/nav_rancho/nav2
	name = "Farmer's Block #7 - SECONDARY"
	landmark_tag = "nav_rancho_2"
	base_area = /area/rancho/outdoors
	base_turf = /turf/simulated/floor/plating

/obj/structure/flora/tree/swamp
	icon = 'icons/fd/structures/mojave/talltrees.dmi'
	icon_state = "tree_1"
	pixel_x = -16

/obj/structure/flora/tree/swamp/New()
	..()
	icon_state = "tree_[rand(1, 3)]"

/obj/structure/flora/tree/swamp/dead_small
	icon = 'icons/fd/structures/mojave/trees.dmi'
	icon_state = "deadtree_1"
	pixel_x = -16

/obj/structure/flora/tree/swamp/dead_small/New()
	..()
	icon_state = "deadtree_[rand(1, 6)]"

/obj/structure/flora/swamp
	anchored = TRUE

/obj/structure/flora/swamp/tallgrass
	name = "dead grass"
	icon = 'icons/fd/structures/mojave/flora.dmi'
	icon_state = "tall_grass2_1"

/obj/structure/flora/swamp/tallgrass/New()
	..()
	icon_state = "tall_grass2_[rand(1, 4)]"

/obj/structure/flora/swamp/grass
	name = "dead grass"
	icon = 'icons/fd/structures/mojave/flora.dmi'
	icon_state = "tall_grass1_1"

/obj/structure/flora/swamp/grass/New()
	..()
	icon_state = "tall_grass1_[rand(1, 4)]"