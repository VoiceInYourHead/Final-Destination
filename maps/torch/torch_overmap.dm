/obj/effect/overmap/visitable/ship/torch
	name = "SEV Torch"
	desc = "This is a frigate, broadcasting SCGEC codes and the designation \"SEV Torch, HSC-4-13-X\"."
	fore_dir = WEST
	dir = WEST
	vessel_mass = 100000
	integrity_failure_cap = 460
	repair_speed = 0.01
	burn_delay = 2 SECONDS
	base = TRUE
	sector_flags = OVERMAP_SECTOR_KNOWN|OVERMAP_SECTOR_IN_SPACE|OVERMAP_SECTOR_BASE

	initial_restricted_waypoints = list(
		"Charon" = list("nav_hangar_charon"), 	//can't have random shuttles popping inside the ship
		"Guppy" = list("nav_hangar_guppy"),
		"Bubble" = list("nav_hangar_bubble"),
		"Butterfly" = list("nav_hangar_butterfly"),
		"Aquila" = list("nav_hangar_aquila"),
		"Ascent Caulship" = list("nav_ascent_caulship_torch"), //restricts caulship specific docking waypoint on deck 4 starboard side
		"Skrellian Scout" = list("nav_skrellscout_dock"), //restricts Skrell Scoutship specific docking waypoint on deck 4 portside
		"Skrellian Shuttle" = list("nav_skrellscoutsh_altdock"),
		"Rescue" = list("nav_ert_dock"), //restricts ERT Shuttle specific docking waypoint on deck 4 portside
		"ITV The Reclaimer" = list("nav_hangar_gantry_torch"), //gantry shuttles
		"ITV Vulcan" = list("nav_hangar_gantry_torch_two"),
		"ITV Spiritus" = list("nav_hangar_gantry_torch_three"),
		"SRV Venerable Catfish" = list("nav_verne_5"), //docking location for verne shuttle
		"Cyclopes" = list("nav_merc_dock")
	)

	initial_generic_waypoints = list(
		//start Bridge Deck
		"nav_merc_deck5",
		"nav_ninja_deck5",
		"nav_skipjack_deck5",
		"nav_ert_deck5",
		"nav_bridge_charon",
		"nav_bridge_guppy",
		"nav_bridge_bubble",
		"nav_bridge_butterfly",
		"nav_bridge_aquila",

		//start First Deck
		"nav_merc_deck1",
		"nav_ninja_deck1",
		"nav_skipjack_deck1",
		"nav_ert_deck4",
		"nav_deck4_charon",
		"nav_deck4_guppy",
		"nav_deck4_bubble",
		"nav_deck4_butterfly",
		"nav_deck4_aquila",

		//start Second Deck
		"nav_merc_deck2",
		"nav_ninja_deck2",
		"nav_skipjack_deck2",
		"nav_ert_deck3",
		"nav_deck3_charon",
		"nav_deck3_guppy",
		"nav_deck3_bubble",
		"nav_deck3_butterfly",
		"nav_deck3_aquila",

		//start Third Deck
		"nav_merc_deck3",
		"nav_ninja_deck3",
		"nav_skipjack_deck3",
		"nav_ert_deck2",
		"nav_deck2_charon",
		"nav_deck2_guppy",
		"nav_deck2_bubble",
		"nav_deck2_butterfly",
		"nav_deck2_aquila",

		//start Forth Deck
		"nav_merc_deck4",
		"nav_ninja_deck4",
		"nav_skipjack_deck4",
		"nav_ert_deck1",
		"nav_deck1_charon",
		"nav_deck1_guppy",
		"nav_deck1_bubble",
		"nav_deck1_butterfly",
		"nav_deck1_aquila",
		"nav_vox_raider_dock",

		//start Hanger Deck
		"nav_merc_hanger",
		"nav_ninja_hanger",
		"nav_skipjack_hanger",
		"nav_ert_hanger",
	)

	var/list/clouds
	var/lightlevel = 0.3 //This default makes turfs not generate light. Adjust to have exoplanents be lit.

/obj/effect/overmap/visitable/ship/torch/Initialize()
	..()

	clouds = block(locate(world.maxx, world.maxy, max(map_z)), locate(1, 1, min(map_z)))
	for(var/atom/A as anything in clouds)
		if(!istype(A.loc, /area/space))
			clouds -= A
	update_daynight()

/obj/effect/overmap/visitable/ship/torch/proc/update_daynight(light = 0.3, light_color = "#e4c995")
	for(var/turf/T as anything in clouds)
		T.set_light(light, 0.1, 2, l_color = light_color)

/obj/effect/overmap/visitable/ship/landable/exploration_shuttle
	name = "Charon"
	desc = "An SSE-U11 long range shuttle, broadcasting SCGEC codes and the callsign \"Torch-2 Charon\"."
	shuttle = "Charon"
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	integrity_failure_cap = 35
	vessel_mass = 5000
	fore_dir = NORTH
	skill_needed = SKILL_BASIC
	vessel_size = SHIP_SIZE_SMALL

/obj/effect/overmap/visitable/ship/landable/aquila
	name = "Aquila"
	desc = "A PM-24 modular transport, broadcasting SCGEC codes and the callsign \"Torch-1 Aquila\"."
	shuttle = "Aquila"
	integrity_failure_cap = 60
	vessel_mass = 6000
	max_speed = 1/(1 SECONDS)
	burn_delay = 0.5 SECONDS //spammable, but expensive
	fore_dir = NORTH
	vessel_size = SHIP_SIZE_SMALL

/obj/effect/overmap/visitable/ship/landable/guppy
	name = "Guppy"
	desc = "An SSE-U3 utility pod, broadcasting SCGEC codes and the callsign \"Torch-3 Guppy\"."
	shuttle = "Guppy"
	max_speed = 1/(3 SECONDS)
	burn_delay = 2 SECONDS
	integrity_failure_cap = 20
	vessel_mass = 3000 //very inefficient pod
	fore_dir = SOUTH
	dir = SOUTH
	skill_needed = SKILL_BASIC
	vessel_size = SHIP_SIZE_TINY

/obj/effect/overmap/visitable/ship/landable/bubble
	name = "Bubble"
	desc = "An SSE-U2 utility pod, broadcasting SCGEC codes and the callsign \"Torch-4 Bubble\"."
	shuttle = "Bubble"
	max_speed = 1/(3 SECONDS)
	burn_delay = 2 SECONDS
	integrity_failure_cap = 20
	vessel_mass = 3000 //very inefficient pod
	fore_dir = SOUTH
	dir = SOUTH
	skill_needed = SKILL_BASIC
	vessel_size = SHIP_SIZE_TINY

/obj/effect/overmap/visitable/ship/landable/butterfly
	name = "Butterfly"
	desc = "An SSE-U09 long range shuttle, broadcasting SCGEC codes and the callsign \"Torch-5 Butterfly\"."
	shuttle = "Butterfly"
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	integrity_failure_cap = 40
	vessel_mass = 4000
	fore_dir = SOUTH
	dir = SOUTH
	skill_needed = SKILL_BASIC
	vessel_size = SHIP_SIZE_TINY

/obj/machinery/computer/shuttle_control/explore/aquila
	name = "aquila control console"
	shuttle_tag = "Aquila"
	req_access = list(access_aquila_helm)

/obj/machinery/computer/shuttle_control/explore/exploration_shuttle
	name = "shuttle control console"
	shuttle_tag = "Charon"
	req_access = list(access_expedition_shuttle_helm)

/obj/machinery/computer/shuttle_control/explore/guppy
	name = "guppy control console"
	shuttle_tag = "Guppy"
	req_access = list(access_guppy_helm)

/obj/machinery/computer/shuttle_control/explore/bubble
	name = "Bubble control console"
	shuttle_tag = "Bubble"
	req_access = list(access_guppy_helm)

/obj/machinery/computer/shuttle_control/explore/butterfly
	name = "Butterfly control console"
	shuttle_tag = "Butterfly"

/obj/effect/overmap/visitable/ship/torch/Initialize()
	. = ..()

	var/obj/effect/overmap/visitable/sector/residue/R = new()
	R.forceMove(locate(src.x, src.y, GLOB.using_map.overmap_z))

	for(var/obj/machinery/computer/ship/helm/H in SSmachines.machinery)
		H.add_known_sector(R)
	add_starter_trader()

/obj/effect/overmap/visitable/ship/torch/proc/add_starter_trader()
	var/trader_type = /datum/trader/trading_beacon/starter
	GLOB.traders[trader_type] = new trader_type
	GLOB.trader_types += trader_type

/obj/effect/overmap/visitable/sector/residue
	name = "Bluespace Residue"
	desc = "Trace radiation emanating from this sector is consistent with the aftermath of a bluespace jump."
	icon_state = "event"
	known = TRUE
	sector_flags = OVERMAP_SECTOR_KNOWN | OVERMAP_SECTOR_UNTARGETABLE

/obj/effect/overmap/visitable/sector/residue/Initialize()
	..()
	generic_waypoints = list()