#include "bearcat_areas.dm"
#include "bearcat_jobs.dm"
#include "bearcat_access.dm"
#include "bearcat_radio.dm"

/obj/effect/submap_landmark/joinable_submap/bearcat
	name = "FTU-TV Bearcat"
	archetype = /decl/submap_archetype/derelict/bearcat

/decl/submap_archetype/derelict/bearcat
	descriptor = "derelict cargo vessel"
	map = "Bearcat Wreck"
	crew_jobs = list(
		/datum/job/submap/bearcat_captain,
		/datum/job/submap/bearcat_crewman
	)

/obj/effect/overmap/visitable/ship/bearcat
	name = "FTU-TV Bearcat"
	color = "#00ffff"
	vessel_mass = 20000
	integrity_failure_cap = 150
	integrity_failure = 60
	do_repair_hull = FALSE
	max_speed = 1/(10 SECONDS)
	burn_delay = 10 SECONDS

	var/list/clouds
	var/lightlevel = 0.3 //This default makes turfs not generate light. Adjust to have exoplanents be lit.

/obj/effect/overmap/visitable/ship/bearcat/Initialize()
	..()

	clouds = block(locate(world.maxx, world.maxy, max(map_z)), locate(1, 1, min(map_z)))
	for(var/atom/A as anything in clouds)
		if(!istype(A.loc, /area/space) || A.density || istype(A, /turf/simulated/open))
			clouds -= A
	update_daynight()

/obj/effect/overmap/visitable/ship/bearcat/proc/update_daynight(light = 0.7, light_color = "#e0ca9f")
	for(var/turf/T as anything in clouds)
		T.set_light(light, 0.1, 2, l_color = light_color)

/obj/effect/overmap/visitable/ship/bearcat/New()
	for(var/area/ship/scrap/A)
		A.name = "\improper [name] - [A.name]"
		GLOB.using_map.area_purity_test_exempt_areas += A.type
	name = "[name], \a [initial(name)]"
	..()

/datum/map_template/ruin/away_site/bearcat_wreck
	name = "Bearcat Wreck"
	id = "awaysite_bearcat_wreck"
	description = "A wrecked light freighter."
	suffixes = list("bearcat/bearcat-1.dmm", "bearcat/bearcat-2.dmm")
	spawn_cost = 1
	player_cost = 4
	shuttles_to_initialise = list(/datum/shuttle/autodock/ferry/lift)
	area_usage_test_exempted_root_areas = list(/area/ship)
	apc_test_exempt_areas = list(
		/area/ship/scrap/maintenance/engine/port = NO_SCRUBBER|NO_VENT,
		/area/ship/scrap/maintenance/engine/starboard = NO_SCRUBBER|NO_VENT,
		/area/ship/scrap/crew/hallway/port= NO_SCRUBBER|NO_VENT,
		/area/ship/scrap/crew/hallway/starboard= NO_SCRUBBER|NO_VENT,
		/area/ship/scrap/maintenance/hallway = NO_SCRUBBER|NO_VENT,
		/area/ship/scrap/maintenance/lower = NO_SCRUBBER|NO_VENT,
		/area/ship/scrap/maintenance/atmos = NO_SCRUBBER,
		/area/ship/scrap/escape_port = NO_SCRUBBER|NO_VENT,
		/area/ship/scrap/escape_star = NO_SCRUBBER|NO_VENT,
		/area/ship/scrap/shuttle/lift = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/ship/scrap/command/hallway = NO_SCRUBBER|NO_VENT
	)
	spawn_weight = 0.67

/datum/shuttle/autodock/ferry/lift
	name = "Cargo Lift"
	shuttle_area = /area/ship/scrap/shuttle/lift
	warmup_time = 3	//give those below some time to get out of the way
	waypoint_station = "nav_bearcat_lift_bottom"
	waypoint_offsite = "nav_bearcat_lift_top"
	sound_takeoff = 'sound/effects/lift_heavy_start.ogg'
	sound_landing = 'sound/effects/lift_heavy_stop.ogg'
	ceiling_type = null
	knockdown = 0
	defer_initialisation = TRUE

/obj/machinery/computer/shuttle_control/lift
	name = "cargo lift controls"
	shuttle_tag = "Cargo Lift"
	ui_template = "shuttle_control_console_lift.tmpl"
	icon_state = "tiny"
	icon_keyboard = "tiny_keyboard"
	icon_screen = "lift"
	density = FALSE

/obj/effect/shuttle_landmark/lift/top
	name = "Top Deck"
	landmark_tag = "nav_bearcat_lift_top"
	flags = SLANDMARK_FLAG_AUTOSET

/obj/effect/shuttle_landmark/lift/bottom
	name = "Lower Deck"
	landmark_tag = "nav_bearcat_lift_bottom"
	base_area = /area/ship/scrap/cargo/lower
	base_turf = /turf/simulated/floor

/obj/machinery/power/apc/derelict
	cell_type = /obj/item/cell/crap/empty
	locked = 0
	coverlocked = 0

/obj/machinery/door/airlock/autoname/command
	door_color = COLOR_COMMAND_BLUE

/obj/machinery/door/airlock/autoname/engineering
	door_color = COLOR_AMBER

/obj/effect/landmark/deadcap
	name = "Dead Captain"

/obj/effect/landmark/deadcap/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/landmark/deadcap/LateInitialize()
	var/turf/T = get_turf(src)
	var/mob/living/carbon/human/corpse = new(T)
	scramble(1, corpse, 100)
	corpse.real_name = "Captain"
	corpse.name = "Captain"
	var/decl/hierarchy/outfit/outfit = outfit_by_type(/decl/hierarchy/outfit/deadcap)
	outfit.equip(corpse)
	corpse.adjustOxyLoss(corpse.maxHealth)
	corpse.setBrainLoss(corpse.maxHealth)
	var/obj/structure/bed/chair/C = locate() in T
	if (C)
		C.buckle_mob(corpse)
	qdel(src)

/decl/hierarchy/outfit/deadcap
	name = "Derelict Captain"
	uniform = /obj/item/clothing/under/casual_pants/classicjeans
	suit = /obj/item/clothing/suit/storage/hooded/wintercoat
	shoes = /obj/item/clothing/shoes/black
	r_pocket = /obj/item/device/radio/map_preset/bearcat

/decl/hierarchy/outfit/deadcap/post_equip(mob/living/carbon/human/H)
	..()
	var/obj/item/clothing/uniform = H.w_uniform
	if(uniform)
		var/obj/item/clothing/accessory/toggleable/hawaii/random/eyegore = new()
		if(uniform.can_attach_accessory(eyegore))
			uniform.attach_accessory(null, eyegore)
		else
			qdel(eyegore)
	var/obj/item/cell/super/C = new()
	H.put_in_any_hand_if_possible(C)
