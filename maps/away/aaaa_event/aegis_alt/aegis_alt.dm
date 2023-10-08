/obj/effect/overmap/visitable/ship/aegis_alt
	name = "B-CV-12 Aegis"
	desc = "Sen#ors det3cTed a m3d-ium war5hIp 7ran5mit-tIng the c0des 'B-CV-12 Aegis 89-671'. The-re a9e m-Any t6pes 0f w3Ap0n5 0n b0aRd. RadiAti0n f50m energ4 5Hi3lds is present. RadIati8n of unkno@n energy is &r%s#3^. The shape is similar to a bud with many petals, merges with the background."
	//Sensors detected a medium warship transmitting the codes 'PV AEGIS 89-671'. There are many types of weapons on board. Radiation from energy shields is present. Radiation of unknown energy is present. The shape is similar to a bud with many petals, merges with the background.
	color = "#272f31"
	alpha = 200
	fore_dir = WEST
	dir = WEST

	integrity_failure_cap = 500 // утверждено Воидом
	do_repair_hull = TRUE
	repair_speed = 0.1
	vessel_mass = 50000 // this is fucking flying plasteel ingot, утверждено Воидом
	max_speed = 1/(2 SECONDS)
	initial_generic_waypoints = list(
		"nav_aegis_1",
		"nav_aegis_2",
		"nav_aegis_3",
		"nav_aegis_antag"
	)
	initial_restricted_waypoints = list("Leaper" = list("nav_hangar_leaper"))

/obj/effect/overmap/visitable/ship/aegis_alt/New(nloc, max_x, max_y)
	name = "B-CV-12 Aegis"
	..()

/datum/map_template/ruin/away_site/aegis_alt
	name = "B-CV-12 Aegis"
	id = "awaysite_aegis_alt"
	description = "Private Military Force high-armored medium ship, with ton of guns and combat equipment."
	suffixes = list("aaaa_event/aegis_alt/aegis_alt1.dmm", "aaaa_event/aegis_alt/aegis_alt2.dmm")
	spawn_cost = 10 // dont do it man
	area_usage_test_exempted_root_areas = list(/area/aegis)
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/leaper)
