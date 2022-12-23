
/obj/effect/overmap/visitable/sector/stranded
	name = "snowy planet"
	desc = "An arctic planet with a small number of signatures on the surface. Scans indicate non-natural structures under the planet's surface."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	color = "#6db8b8"
	initial_generic_waypoints = list(
		"nav_splanet_1",
		"nav_splanet_2",
		"nav_splanet_antag"
	)

/obj/effect/submap_landmark/joinable_submap/stranded
	name = "Snowy Planet"
	archetype = /decl/submap_archetype/stranded

/decl/submap_archetype/stranded
	descriptor = "Unknown planet"
	map = "Snowy Planet"
	crew_jobs = list(
		/datum/job/submap/stranded/pod1,
		/datum/job/submap/stranded/pod2,
		/datum/job/submap/stranded/pod3,
		/datum/job/submap/stranded/pod4,
		/datum/job/submap/stranded/pod5,
		/datum/job/submap/stranded/pod6
	)

/datum/job/submap/stranded/pod1
	title = "First Pod"
	info = "Your ship has been destroyed by a terrible disaster."
	outfit_type = /decl/hierarchy/outfit/job/survivor
	total_positions = 4

/datum/job/submap/stranded/pod1/New(var/datum/submap/_owner, var/abstract_job = FALSE)
	..()
	if(_owner) // Might be called from admin tools, etc
		info = "Your ship, the [_owner.name], has been destroyed by a terrible disaster, \
		leaving you stranded in your survival pod on a hostile exoplanet. Your pod's distress \
		signal appear to be malfunctioning. All you can do now is survive, and hope for a passing ship..."

/obj/effect/submap_landmark/spawnpoint/stranded/crashed_pod1
	name = "First Pod"

/datum/job/submap/stranded/pod2
	title = "Second Pod"
	info = "Your ship has been destroyed by a terrible disaster."
	outfit_type = /decl/hierarchy/outfit/job/survivor
	total_positions = 4

/datum/job/submap/stranded/pod2/New(var/datum/submap/_owner, var/abstract_job = FALSE)
	..()
	if(_owner) // Might be called from admin tools, etc
		info = "Your ship, the [_owner.name], has been destroyed by a terrible disaster, \
		leaving you stranded in your survival pod on a hostile exoplanet. Your pod's distress \
		signal appear to be malfunctioning. All you can do now is survive, and hope for a passing ship..."

/obj/effect/submap_landmark/spawnpoint/stranded/crashed_pod2
	name = "Second Pod"

/datum/job/submap/stranded/pod3
	title = "Third Pod"
	info = "Your ship has been destroyed by a terrible disaster."
	outfit_type = /decl/hierarchy/outfit/job/survivor
	total_positions = 4

/datum/job/submap/stranded/pod3/New(var/datum/submap/_owner, var/abstract_job = FALSE)
	..()
	if(_owner) // Might be called from admin tools, etc
		info = "Your ship, the [_owner.name], has been destroyed by a terrible disaster, \
		leaving you stranded in your survival pod on a hostile exoplanet. Your pod's distress \
		signal appear to be malfunctioning. All you can do now is survive, and hope for a passing ship..."

/obj/effect/submap_landmark/spawnpoint/stranded/crashed_pod3
	name = "Third Pod"

/datum/job/submap/stranded/pod4
	title = "Fourth Pod"
	info = "Your ship has been destroyed by a terrible disaster."
	outfit_type = /decl/hierarchy/outfit/job/survivor
	total_positions = 4

/datum/job/submap/stranded/pod4/New(var/datum/submap/_owner, var/abstract_job = FALSE)
	..()
	if(_owner) // Might be called from admin tools, etc
		info = "Your ship, the [_owner.name], has been destroyed by a terrible disaster, \
		leaving you stranded in your survival pod on a hostile exoplanet. Your pod's distress \
		signal appear to be malfunctioning. All you can do now is survive, and hope for a passing ship..."

/obj/effect/submap_landmark/spawnpoint/stranded/crashed_pod4
	name = "Fourth Pod"

/datum/job/submap/stranded/pod5
	title = "Fifth Pod"
	info = "Your ship has been destroyed by a terrible disaster."
	outfit_type = /decl/hierarchy/outfit/job/survivor
	total_positions = 4

/datum/job/submap/stranded/pod5/New(var/datum/submap/_owner, var/abstract_job = FALSE)
	..()
	if(_owner) // Might be called from admin tools, etc
		info = "Your ship, the [_owner.name], has been destroyed by a terrible disaster, \
		leaving you stranded in your survival pod on a hostile exoplanet. Your pod's distress \
		signal appear to be malfunctioning. All you can do now is survive, and hope for a passing ship..."

/obj/effect/submap_landmark/spawnpoint/stranded/crashed_pod5
	name = "Fifth Pod"

/datum/job/submap/stranded/pod6
	title = "Sixth Pod"
	info = "Your ship has been destroyed by a terrible disaster."
	outfit_type = /decl/hierarchy/outfit/job/survivor
	total_positions = 4

/datum/job/submap/stranded/pod6/New(var/datum/submap/_owner, var/abstract_job = FALSE)
	..()
	if(_owner) // Might be called from admin tools, etc
		info = "Your ship, the [_owner.name], has been destroyed by a terrible disaster, \
		leaving you stranded in your survival pod on a hostile exoplanet. Your pod's distress \
		signal appear to be malfunctioning. All you can do now is survive, and hope for a passing ship..."

/obj/effect/submap_landmark/spawnpoint/stranded/crashed_pod6
	name = "Sixth Pod"

/datum/map_template/ruin/away_site/stranded
	name = "Snowy Planet"
	id = "awaysite_splanet"
	spawn_cost = 5
	player_cost = 4
	description = "Arctic planet with three z-lvls"
	suffixes = list("stranded/stranded-1.dmm", "stranded/stranded-2.dmm", "stranded/stranded-3.dmm")
	generate_mining_by_z = 3
	area_usage_test_exempted_root_areas = list(/area/stranded)
	apc_test_exempt_areas = list(
		/area/stranded = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/stranded/underground = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/stranded/surface = NO_SCRUBBER|NO_VENT|NO_APC
	)

/obj/effect/shuttle_landmark/nav_splanet/nav1
	name = "Planet Landing Point #1"
	landmark_tag = "nav_splanet_1"
	base_area = /area/stranded/surface

/obj/effect/shuttle_landmark/nav_splanet/nav2
	name = "Planet Landing Point #2"
	landmark_tag = "nav_splanet_2"
	base_area = /area/stranded/surface

/obj/effect/shuttle_landmark/nav_splanet/nav3
	name = "Planet Navpoint #3"
	landmark_tag = "nav_splanet_antag"
	base_area = /area/stranded/surface

/area/stranded
	name = "\improper Planet insides"
	icon = 'icons/turf/areas.dmi'
	icon_state = "centcom"
/area/stranded/surface
	name = "\improper Planet Surface"
	icon = 'icons/turf/areas.dmi'
	icon_state = "unknown"
	ambience = list('maps/away/stranded/cold_outside.ogg', 'maps/away/stranded/cold_outside2.ogg')
	sound_env = ASTEROID
	planetary_surface = TRUE

/area/stranded/surface/Entered(mob/living/L,  atom/A)
	. = ..()
	if(istype(L) && !istype(A, /area/stranded/surface))//Doesn't work but this does stop the lag.
		L.overlay_fullscreen("snowfall_heavy_old", /obj/screen/fullscreen/snowstorm)

/area/stranded/surface/Exited(mob/living/L, area/A)
	. = ..()
	if(istype(L) && !istype(A, /area/stranded/surface))
		L.clear_fullscreen("snowfall_heavy_old")

/area/stranded/underground
	name = "\improper Planet Underground"
	icon = 'icons/turf/areas.dmi'
	icon_state = "unknown"
	ambience = list('sound/ambience/spookyspace1.ogg', 'sound/ambience/spookyspace2.ogg')
	sound_env = ASTEROID

/area/stranded/pod1
	name = "\improper Escape Pod #1"

/area/stranded/pod2
	name = "\improper Escape Pod #2"

/area/stranded/pod3
	name = "\improper Escape Pod #3"

/area/stranded/pod4
	name = "\improper Escape Pod #4"

/area/stranded/pod5
	name = "\improper Escape Pod #5"

/area/stranded/pod6
	name = "\improper Escape Pod #6"