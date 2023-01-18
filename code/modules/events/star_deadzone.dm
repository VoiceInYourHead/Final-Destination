/datum/event/star
	has_skybox_image = TRUE
	var/obj/effect/overmap/visitable/ship/victim

/datum/event/star/get_skybox_image()
	if(prob(75)) // Sometimes, give no skybox image, to avoid metagaming it
		var/image/res = overlay_image('icons/skybox/radbox.dmi', "beam", null, RESET_COLOR)
		res.alpha = rand(40,80)
		return res

/datum/event/star/announce()
			command_announcement.Announce("The [location_name()] is heading too close to the star deadzone.", "[location_name()] Sensor Array", zlevels = affecting_z)

/datum/event/star/start()
	spawn()
		var/list/targetareas = victim.get_areas(affecting_z)

		// 100 attempts
		for(var/i = 1 to 100)
			var/area/finalarea = pick(targetareas)
			var/turf/simulated/floor/targetturf = pick_area_turf(finalarea.type, list(/proc/is_not_space_turf))

			// Make sure at least one piece of floor will ignite!
			targetturf.sun_fire()

			// Have a chance to ignite lots of other parts.
			var/firecount = 0
			var/actual_severity = severity * rand(8, 12)
			for(var/turf/simulated/floor/W in range(5, targetturf))
				W.sun_fire()
				firecount++

				if(firecount >= actual_severity)
					break

/datum/event/star/end()
	command_announcement.Announce("[location_name()] managed to move far enough from the star deadzone.", "[location_name()] Sensor Array", zlevels = affecting_z)

/atom/proc/sun_fire()
	if(locate(/obj/effect/turf_fire/sun) in src)
		return
	var/number_fires = rand(3,4)
	for(var/i=0, i<number_fires, i++)
		new/obj/effect/turf_fire/sun(src)