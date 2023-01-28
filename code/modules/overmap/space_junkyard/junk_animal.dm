/obj/effect/overmap/visitable/sector/junkyard/proc/remove_animal(mob/M)
	animals -= M
	GLOB.death_event.unregister(M, src)
	GLOB.destroyed_event.unregister(M, src)
	repopulate_types |= M.type

/obj/effect/overmap/visitable/sector/junkyard/proc/handle_repopulation()
	for (var/i = 1 to round(max_animal_count - animals.len))
		if (prob(10))
			var/turf/T = pick_area_turf(junk_area, list(/proc/not_turf_contains_dense_objects))
			var/mob_type = pick(repopulate_types)
			var/mob/S = new mob_type(T)
			track_animal(S)
	if (animals.len >= max_animal_count)
		repopulating = 0

/obj/effect/overmap/visitable/sector/junkyard/proc/track_animal(mob/A)
	animals += A
	GLOB.death_event.register(A, src, /obj/effect/overmap/visitable/sector/junkyard/proc/remove_animal)
	GLOB.destroyed_event.register(A, src, /obj/effect/overmap/visitable/sector/junkyard/proc/remove_animal)

/obj/effect/landmark/junkyard_spawn
	name = "spawn junkyard animal"

/obj/effect/landmark/junkyard_spawn/proc/do_spawn(obj/effect/overmap/visitable/sector/junkyard/junk)
	if (LAZYLEN(junk.fauna_types))
		var/beastie = pick(junk.fauna_types)
		var/mob/M = new beastie(get_turf(src))
		junk.track_animal(M)

/obj/effect/landmark/junkyard_spawn/megafauna
	name = "spawn junkyard megafauna"

/obj/effect/landmark/junkyard_spawn/megafauna/do_spawn(obj/effect/overmap/visitable/sector/junkyard/junk)
	if (LAZYLEN(junk.megafauna_types))
		var/beastie = pick(junk.megafauna_types)
		var/mob/M = new beastie(get_turf(src))
		junk.track_animal(M)