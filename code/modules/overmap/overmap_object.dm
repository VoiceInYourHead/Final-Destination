//var/global/list/overmap_unknown_ids = list()

/obj/effect/overmap
	name = "map object"
	icon = 'icons/obj/overmap.dmi'
	icon_state = "object"
	color = "#fffffe"

//	var/unknown_id                      // A unique identifier used when this entity is scanned. Assigned in Initialize().
//	var/requires_contact = FALSE        // whether or not the effect must be identified by ship sensors before being seen.
//	var/instant_contact  = FALSE        // do we instantly identify ourselves to any ship in sensors range?
//	var/sensor_visibility = 10          // how likely it is to increase identification process each scan.

	var/sector_flags = OVERMAP_SECTOR_KNOWN|OVERMAP_SECTOR_IN_SPACE
	var/known = 1		//shows up on nav computers automatically
	var/scannable       //if set to TRUE will show up on ship sensors for detailed scans
	var/overmap_effect_state //Our overmap effect state.

//Overlay of how this object should look on other skyboxes
/obj/effect/overmap/proc/get_skybox_representation()
	return

/obj/effect/overmap/proc/get_scan_data(mob/user)
	return desc

/obj/effect/overmap/Initialize()
	. = ..()
	if(!GLOB.using_map.use_overmap)
		return INITIALIZE_HINT_QDEL

/*	if(requires_contact)
		invisibility = INVISIBILITY_OVERMAP // Effects that require identification have their images cast to the client via sensors.

	if(scannable)
		unknown_id = "[pick(global.phonetic_alphabet)]-[random_id(/obj/effect/overmap, 100, 999)]"*/

	if(known)
		layer = ABOVE_LIGHTING_LAYER
		plane = EFFECTS_ABOVE_LIGHTING_PLANE

	overmap_effect_state = icon_state

	update_icon()

/obj/effect/overmap/Crossed(var/obj/effect/overmap/visitable/other)
	if(istype(other))
		for(var/obj/effect/overmap/visitable/O in loc)
			SSskybox.rebuild_skyboxes(O.map_z)

/obj/effect/overmap/Uncrossed(var/obj/effect/overmap/visitable/other)
	if(istype(other))
		SSskybox.rebuild_skyboxes(other.map_z)
		for(var/obj/effect/overmap/visitable/O in loc)
			SSskybox.rebuild_skyboxes(O.map_z)

/obj/effect/overmap/on_update_icon()
	filters = filter(type="drop_shadow", color = color + "F0", size = 2, offset = 1,x = 0, y = 0)


/**
 * Flags the effect as `known` and runs relevant update procs. Intended for admin event usage.
 */
/obj/effect/overmap/proc/make_known(notify = FALSE)
	if (!known)
		known = TRUE
		update_known_connections(notify)


/**
 * Runs any relevant code needed for updating anything connected to known overmap effects, such as helms.
 */
/obj/effect/overmap/proc/update_known_connections(notify = FALSE)
	return
