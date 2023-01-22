/datum/event/nebula
	has_skybox_image = TRUE
	var/cloud_hueshift
	var/obj/effect/overmap/visitable/ship/victim

/datum/event/nebula/get_skybox_image()
	if(!cloud_hueshift)
		cloud_hueshift = color_rotation(rand(-3,3)*15)
	var/image/res = overlay_image('icons/skybox/ionbox.dmi', "ions", cloud_hueshift, RESET_COLOR)
	res.blend_mode = BLEND_ADD
	return res

/datum/event/nebula/start()
	var/obj/visitor = map_sectors["[pick(affecting_z)]"]
	if(!isobj(visitor))
		return
//	var/minP = OVERMAP_EDGE
//	var/maxP = GLOB.using_map.overmap_size - OVERMAP_EDGE
	var/turf/destination = locate(rand(2, 54), rand(2, 54), GLOB.using_map.overmap_z)
	if (!isturf(destination))
		return
	visitor.dropInto(destination)

/datum/event/nebula/announce()
	command_announcement.Announce("The [location_name()] is now passing through the unstable bluespace cloud.", "[location_name()] Sensor Array", zlevels = affecting_z)

/datum/event/nebula/end()

	for(var/mob/living/carbon/S in world)
		if (!S.isSynthetic() && (S.z in affecting_z))
			to_chat(S, SPAN_DANGER("<font size=10>You seeing the chain of the bright blue flashes all around the ship, causing your head to almost explode!</font>"))
			var/nebulasplash = rand(5,15)
			S.adjustBrainLoss(rand(20,30))
			S.confused += nebulasplash
			S.eye_blurry += nebulasplash-1