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
	sleep(20)
	for(var/mob/living/S in world)
		if (S.z in affecting_z)
			S.playsound_local(S.loc, 'sound/effects/warning3b.ogg', 80)

/datum/event/star/tick()
	start()
	sleep(3)

/datum/event/star/start()
	spawn()
		var/list/targetareas = victim.get_areas(affecting_z)

		var/area/finalarea = pick(targetareas)
		var/turf/simulated/floor/targetturf = pick_area_turf(finalarea.type, list(/proc/is_not_space_turf))

		// Have a chance to ignite lots of other parts.
		var/firecount = 0
		var/actual_severity = rand(8, 16)
		for(var/turf/simulated/floor/W in range(7, targetturf))
			W.sun_flare()
			firecount++

			if(firecount >= actual_severity)
				break

/datum/event/star/end()
	command_announcement.Announce("[location_name()] managed to move far enough from the star deadzone.", "[location_name()] Sensor Array", zlevels = affecting_z)

/atom/proc/sun_flare()
	if(locate(/obj/effect/turf_fire/star_fire) in src)
		return
	new/obj/effect/turf_fire/star_fire(src)

/obj/effect/turf_fire/star_fire
	fire_power = 50
	interact_with_atmos = FALSE
	passive_loss = TRUE


/datum/event/star/strong/announce()
	command_announcement.Announce("The [location_name()] is floating in front of a burning star. Recommendations: Leave burning deadzone immediately.", "[location_name()] Sensor Array", zlevels = affecting_z)
	sleep(20)
	for(var/mob/living/S in world)
		if (S.z in affecting_z)
			S.playsound_local(S.loc, 'sound/effects/warning3b.ogg', 80)

/datum/event/star/strong/tick()
	start()
	sleep(2)

/datum/event/star/strong/start()
	spawn()
		var/list/targetareas = victim.get_areas(affecting_z)

		var/area/finalarea = pick(targetareas)
		var/turf/simulated/floor/targetturf = pick_area_turf(finalarea.type, list(/proc/is_not_space_turf))

		// Have a chance to ignite lots of other parts.
		var/firecount = 0
		var/actual_severity = rand(8, 16)
		for(var/turf/simulated/floor/W in range(7, targetturf))
			W.sun_fire()
			firecount++

			if(firecount >= actual_severity)
				break

/datum/event/star/strong/end()
	return

/atom/proc/sun_fire()
	if(locate(/obj/effect/turf_fire/star_fire) in src)
		return
	new/obj/effect/turf_fire/star_fire/strong(src)

/obj/effect/turf_fire/star_fire/strong
	fire_power = 90
	color = "#fc3f05"
	passive_loss = FALSE
	light_color = COLOR_RED