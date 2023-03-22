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

	var/missile_notarget = FALSE

//	var/list/associated_machinery

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

	var/obj/effect/overmap/visitable/S

	for(var/obj/effect/overmap/event/E in loc)
		if(E == /obj/effect/overmap/event/star)
			S.forceMove(locate(rand(OVERMAP_EDGE, GLOB.using_map.overmap_size - OVERMAP_EDGE), rand(OVERMAP_EDGE, GLOB.using_map.overmap_size - OVERMAP_EDGE), GLOB.using_map.overmap_z))
		else
			qdel(E)

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

/obj/effect/overmap/visitable/sector
	name = "generic sector"
	desc = "Sector with some stuff in it."
	icon_state = "sector"
	anchored = TRUE


/obj/effect/overmap/visitable/sector/Initialize()
	. = ..()

	if(known)
		update_known_connections(TRUE)


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

//this is the worst way to do it, we probably need to change it in future

//lower border 1
	var/obj/effect/overmap/event/star/border/eight/BCL = new(locate(27, 26, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/seven/BWL = new(locate(26, 26, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/nine/BEL = new(locate(28, 26, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/ten/BEEL = new(locate(29, 26, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/six/BWWL = new(locate(25, 26, GLOB.using_map.overmap_z))
//lower border 2
	var/obj/effect/overmap/event/star/border/three/BCLL = new(locate(27, 25, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/two/BWLL = new(locate(26, 25, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/four/BELL = new(locate(28, 25, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/five/BEELL = new(locate(29, 25, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/BWWLL = new(locate(25, 25, GLOB.using_map.overmap_z))
//middle
	var/obj/effect/overmap/event/star/border/thirteen/BC = new(locate(27, 27, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/twelve/BW = new(locate(26, 27, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/fourteen/BE = new(locate(28, 27, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/fifthteen/BEE = new(locate(29, 27, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/eleven/BWW = new(locate(25, 27, GLOB.using_map.overmap_z))
//upper border 1
	var/obj/effect/overmap/event/star/border/eighteen/BCU = new(locate(27, 28, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/seventeen/BWU = new(locate(26, 28, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/nineteen/BEU = new(locate(28, 28, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/twenty/BEEU = new(locate(29, 28, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/sixteen/BWWU = new(locate(25, 28, GLOB.using_map.overmap_z))
//upper border 2
	var/obj/effect/overmap/event/star/border/twentythree/BCUU = new(locate(27, 29, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/twentytwo/BWUU = new(locate(26, 29, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/twentyfour/BEUU = new(locate(28, 29, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/twentyfive/BEEUU = new(locate(29, 29, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/border/twentyone/BWWUU = new(locate(25, 29, GLOB.using_map.overmap_z))
//star itself
	var/obj/effect/overmap/event/star/pre_center/four/SW = new(locate(26, 27, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/pre_center/five/SE = new(locate(28, 27, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/center/S = new(locate(27, 27, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/pre_center/six/SWU = new(locate(26, 28, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/pre_center/eight/SEU = new(locate(28, 28, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/pre_center/seven/SU = new(locate(27, 28, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/pre_center/SWL = new(locate(26, 26, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/pre_center/three/SEL = new(locate(28, 26, GLOB.using_map.overmap_z))
	var/obj/effect/overmap/event/star/pre_center/two/SL = new(locate(27, 26, GLOB.using_map.overmap_z))

//i will burn in hell because of this
	testing("Spawning [S],[SW],[SE],[SWU],[SEU],[SU],[SWL],[SEL],[SL],[BCL],[BWL],[BEL],[BEEL],[BWWL],[BCLL],[BWLL],[BELL],[BEELL],[BWWLL],[BC],[BW],[BE],[BEE],[BWW],[BCU],[BWU],[BEU],[BEEU],[BWWU],[BCUU],[BWUU],[BEUU],[BEEUU],[BWWUU] at [S.x],[S.y]")

	testing("Overmap build complete.")
	return 1
