/obj/effect/overmap/event
	pixel_step_size = 2 // looks alot smoother :P
	var/wander_around = FALSE
	var/wander_timer_min = 50
	var/wander_timer_max = 100
	var/wander_timer = 0
	var/wander_blockers = list(/obj/effect/overmap/event) // list of types we won't enter when fuckin' around and not
	var/follow_ships = FALSE

/obj/effect/overmap/event/New(loc)
	..()
	if(wander_around)
		START_PROCESSING(SSobj, src)
		wander_timer = rand(wander_timer_min,wander_timer_max)

/obj/effect/overmap/event/Destroy()
	if(wander_around) STOP_PROCESSING(SSobj, src)
	..()

/obj/effect/overmap/event/Process()
	..()
	if(wander_around) try_move()

/obj/effect/overmap/event/proc/try_move()
	if(wander_timer > 0)
		wander_timer--
		return FALSE

	if(follow_ships)
		var/list/guys_around = list()
		guys_around += range(1,src)
		guys_around += view(3,src) - range(1,src)
		for(var/obj/effect/overmap/visitable/V in guys_around) // we look for the ships/stations around
			if(!V) continue
			if(V.sector_flags & OVERMAP_SECTOR_UNTARGETABLE) continue
			if(istype(V,/obj/effect/overmap/visitable/sector/junkyard)) continue
			if(istype(V,/obj/effect/overmap/visitable/sector/exoplanet)) continue
			var/new_dir = get_dir(src,V)
			if(!new_dir)
				wander_timer = rand(wander_timer_min,wander_timer_max)
				return FALSE
			var/blocker = FALSE
			for(var/atom/A in get_step(loc,new_dir))
				for(var/type in wander_blockers)
					if(istype(A,type)) blocker = TRUE
			if(blocker && get_dist(V,src)==1) return FALSE
			if(blocker) continue
			Move(get_step(loc,new_dir),new_dir)
			wander_timer = rand(wander_timer_min,wander_timer_max)
			return TRUE

	var/map_edge = GLOB.using_map.overmap_size - 1
	var/list/turf_around = list()
	for(var/turf/T in block(locate(x+1,y+1,z),locate(x-1,y-1,z))) // now we just wander around
		if(!T) continue
		if(T==loc) continue
		if(T.x<=1) continue
		if(T.y<=1) continue
		if(T.x>=map_edge) continue
		if(T.y>=map_edge) continue
		var/blocker = FALSE
		for(var/atom/A in T)
			for(var/type in wander_blockers)
				if(istype(A,type)) blocker = TRUE
		if(blocker) continue
		turf_around += T

	if(!turf_around.len)
		wander_timer = rand(wander_timer_min,wander_timer_max)
		return FALSE

	var/turf/to_move = pick(turf_around)

	Move(to_move,get_dir(src,to_move))
	wander_timer = rand(wander_timer_min,wander_timer_max)
	return TRUE
