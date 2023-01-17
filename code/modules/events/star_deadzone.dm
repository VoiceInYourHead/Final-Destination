/datum/event/star
	has_skybox_image = TRUE

/datum/event/star/get_skybox_image()
	if(prob(75)) // Sometimes, give no skybox image, to avoid metagaming it
		var/image/res = overlay_image('icons/skybox/radbox.dmi', "beam", null, RESET_COLOR)
		res.alpha = rand(40,80)
		return res

/datum/event/star/announce()
			command_announcement.Announce("The [location_name()] is heading too close to the star deadzone.", "[location_name()] Sensor Array", zlevels = affecting_z)

/datum/event/star/start(var/obj/effect/overmap/visitable/finaltarget)
	spawn()
		var/turf/simulated/floor/center = null
		var/list/targetareas = finaltarget.get_areas(affecting_z)
		targetareas -= locate(/area/space)

		// 100 attempts
		for(var/i=0, i<100, i++)
			targetareas -= locate(/area/space)
			var/area/finalarea = pick(targetareas)
			var/turf/targetturf = pick_area_turf(finalarea.type, list(/proc/is_not_space_turf))

			var/turf/simulated/floor/flammable
			if(flammable == targetturf)
				// Make sure at least one piece of floor will ignite!
				targetturf.sun_fire()
				log_and_message_admins("AHUET ONO GORIT")

			if(flammable != targetturf)
				i = i + 1

				// Have a chance to ignite lots of other parts.
				var/firecount = 0
				var/actual_severity = severity * rand(8, 12)
				for(var/turf/simulated/floor/W in range(5, center))
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

//for some reason this shit aren't working