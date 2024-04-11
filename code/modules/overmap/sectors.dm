//===================================================================================
//Overmap object representing zlevel(s)
//===================================================================================
/obj/effect/overmap/visitable
	name = "map object"
	scannable = TRUE
	dir = 1

	var/list/map_z = list()

	var/list/initial_generic_waypoints //store landmark_tag of landmarks that should be added to the actual lists below on init.
	var/list/initial_restricted_waypoints //For use with non-automatic landmarks (automatic ones add themselves).

	var/list/generic_waypoints = list()    //waypoints that any shuttle can use
	var/list/restricted_waypoints = list() //waypoints for specific shuttles
	var/docking_codes

	var/start_x			//Coordinates for self placing
	var/start_y			//will use random values if unset

	var/base = 0		//starting sector, counts as station_levels
	var/fore_dir = NORTH                //what dir is considered north for the actual map
	dir = NORTH

	var/hide_from_reports = FALSE

	var/free_landing = TRUE

	var/ship_target = null
	var/planet_target = null
	var/missile_target
	var/planet_x = 1
	var/planet_y = 1
	var/coord_target_x = 10
	var/coord_target_y = 10

//	var/list/associated_machinery

/obj/effect/overmap/visitable/proc/fight_or_flight() // if it's a star - we run, else - kill it with fire
	for(var/obj/effect/overmap/event/E in get_turf(src))
		if(istype(E,/obj/effect/overmap/event/star))
			forceMove(locate(rand(OVERMAP_EDGE, GLOB.using_map.overmap_size - OVERMAP_EDGE), rand(OVERMAP_EDGE, GLOB.using_map.overmap_size - OVERMAP_EDGE), GLOB.using_map.overmap_z))
			fight_or_flight()
			break
		else
			qdel(E)

/obj/effect/overmap/visitable/Initialize()
	. = ..()
	if(. == INITIALIZE_HINT_QDEL)
		return

	find_z_levels()     // This populates map_z and assigns z levels to the ship.
	register_z_levels() // This makes external calls to update global z level information.

	if(!GLOB.using_map.overmap_z)
		build_overmap()

	start_x = start_x || rand(OVERMAP_EDGE, GLOB.using_map.overmap_size - OVERMAP_EDGE)
	start_y = start_y || rand(OVERMAP_EDGE, GLOB.using_map.overmap_size - OVERMAP_EDGE)

	forceMove(locate(start_x, start_y, GLOB.using_map.overmap_z))

	fight_or_flight()

	docking_codes = "[ascii2text(rand(65,90))][ascii2text(rand(65,90))][ascii2text(rand(65,90))][ascii2text(rand(65,90))]"

	testing("Located sector \"[name]\" at [start_x],[start_y], containing Z [english_list(map_z)]")

	LAZYADD(SSshuttle.sectors_to_initialize, src) //Queued for further init. Will populate the waypoint lists; waypoints not spawned yet will be added in as they spawn.
	SSshuttle.clear_init_queue()

/*/obj/effect/overmap/visitable/proc/get_linked_machines_of_type(var/base_type)
	ASSERT(ispath(base_type, /obj/machinery))
	for(var/thing in LAZYACCESS(associated_machinery, base_type))
		var/weakref/machine_ref = thing
		var/obj/machinery/machine = machine_ref.resolve()
		if(istype(machine, base_type) && !QDELETED(machine))
			LAZYDISTINCTADD(., machine)
		else
			LAZYREMOVE(associated_machinery[base_type], thing)

/obj/effect/overmap/visitable/proc/unregister_machine(var/obj/machinery/machine, var/base_type)
	ASSERT(istype(machine))
	base_type = base_type || machine.base_type || machine.type
	if(islist(associated_machinery) && associated_machinery[base_type])
		LAZYREMOVE(associated_machinery[base_type], weakref(machine))

/obj/effect/overmap/visitable/proc/register_machine(var/obj/machinery/machine, var/base_type)
	ASSERT(istype(machine))
	if(!QDELETED(machine))
		base_type = base_type || machine.base_type || machine.type
		LAZYINITLIST(associated_machinery)
		LAZYDISTINCTADD(associated_machinery[base_type], weakref(machine))*/


//This is called later in the init order by SSshuttle to populate sector objects. Importantly for subtypes, shuttles will be created by then.
/obj/effect/overmap/visitable/proc/populate_sector_objects()

/obj/effect/overmap/visitable/proc/get_areas()
	return get_filtered_areas(list(/proc/area_belongs_to_zlevels = map_z))

/obj/effect/overmap/visitable/proc/find_z_levels()
	map_z = GetConnectedZlevels(z)

/obj/effect/overmap/visitable/proc/register_z_levels()
	for(var/zlevel in map_z)
		map_sectors["[zlevel]"] = src

	GLOB.using_map.player_levels |= map_z
	if(!(sector_flags & OVERMAP_SECTOR_IN_SPACE))
		GLOB.using_map.sealed_levels |= map_z
	if(sector_flags & OVERMAP_SECTOR_BASE)
		GLOB.using_map.station_levels |= map_z
		GLOB.using_map.contact_levels |= map_z
		GLOB.using_map.map_levels |= map_z

//Helper for init.
/obj/effect/overmap/visitable/proc/check_ownership(obj/object)
	if((object.z in map_z) && !(get_area(object) in SSshuttle.shuttle_areas))
		return 1

//If shuttle_name is false, will add to generic waypoints; otherwise will add to restricted. Does not do checks.
/obj/effect/overmap/visitable/proc/add_landmark(obj/effect/shuttle_landmark/landmark, shuttle_name)
	landmark.sector_set(src, shuttle_name)
	if(shuttle_name)
		LAZYADD(restricted_waypoints[shuttle_name], landmark)
	else
		generic_waypoints += landmark

/obj/effect/overmap/visitable/proc/remove_landmark(obj/effect/shuttle_landmark/landmark, shuttle_name)
	if(shuttle_name)
		var/list/shuttles = restricted_waypoints[shuttle_name]
		LAZYREMOVE(shuttles, landmark)
	else
		generic_waypoints -= landmark

/obj/effect/overmap/visitable/proc/get_waypoints(var/shuttle_name)
	. = list()
	for(var/obj/effect/overmap/visitable/contained in src)
		. += contained.get_waypoints(shuttle_name)
	for(var/thing in generic_waypoints)
		.[thing] = name
	if(shuttle_name in restricted_waypoints)
		for(var/thing in restricted_waypoints[shuttle_name])
			.[thing] = name

/obj/effect/overmap/visitable/proc/generate_skybox()
	return

/obj/effect/overmap/visitable/proc/check_target(obj/effect/overmap/target)
	if(target in view(7, src))
		return TRUE
	return FALSE

/obj/effect/overmap/visitable/proc/get_target(var/target_type)
	if(target_type == TARGET_SHIP)
		if(ship_target && check_target(ship_target))
			return ship_target

	if(target_type == TARGET_MISSILE)
		if(missile_target && check_target(missile_target))
			return missile_target

	if(target_type == TARGET_POINT)
		return list(coord_target_x, coord_target_y)

	if(target_type == TARGET_PLANET)
		if(planet_target && check_target(planet_target))
			return list(planet_target, planet_x, planet_y)
		else
			return list(null, planet_x, planet_y)

	if(target_type == TARGET_PLANETCOORD)
		return list(planet_x, planet_y)

	return null

/obj/effect/overmap/visitable/proc/set_target(var/target_type, var/obj/effect/overmap/target, var/target_x, var/target_y)
	if(target_type == TARGET_SHIP)
		if(target && check_target(target))
			ship_target = target
			return TRUE

	if(target_type == TARGET_MISSILE)
		if(target && check_target(target))
			missile_target = target
			return TRUE

	if(target_type == TARGET_POINT)
		coord_target_x = target_x
		coord_target_y = target_y

	if(target_type == TARGET_PLANET)
		if(target && check_target(target))
			planet_target = target
			planet_x = target_x
			planet_y = target_y
			return TRUE
		else
			planet_x = target_x
			planet_y = target_y

	return FALSE

/obj/effect/overmap/visitable/sector
	name = "generic sector"
	desc = "Sector with some stuff in it."
	icon_state = "sector"
	anchored = TRUE


/obj/effect/overmap/visitable/sector/Initialize()
	. = ..()

	if(known)
		update_known_connections(TRUE)

	for(var/datum/trader/merchant)
		merchant.update_disposition_list()

/obj/effect/overmap/visitable/sector/update_known_connections(notify = FALSE)
	. = ..()

	for(var/obj/machinery/computer/ship/helm/H in SSmachines.machinery)
		H.add_known_sector(src, notify)


// Because of the way these are spawned, they will potentially have their invisibility adjusted by the turfs they are mapped on
// prior to being moved to the overmap. This blocks that. Use set_invisibility to adjust invisibility as needed instead.
/obj/effect/overmap/visitable/sector/hide()

/proc/build_overmap()
	if(!GLOB.using_map.use_overmap)
		return 1

	testing("Building overmap...")
	INCREMENT_WORLD_Z_SIZE
	GLOB.using_map.overmap_z = world.maxz

	testing("Putting overmap on [GLOB.using_map.overmap_z]")
	var/area/overmap/A = new
	for (var/square in block(locate(1,1,GLOB.using_map.overmap_z), locate(GLOB.using_map.overmap_size,GLOB.using_map.overmap_size,GLOB.using_map.overmap_z)))
		var/turf/T = square
		if(T.x == GLOB.using_map.overmap_size || T.y == GLOB.using_map.overmap_size)
			T = T.ChangeTurf(/turf/unsimulated/map/edge)
		else
			T = T.ChangeTurf(/turf/unsimulated/map)
		ChangeArea(T, A)

	GLOB.using_map.sealed_levels |= GLOB.using_map.overmap_z

	testing("Overmap build complete.")
	return 1
