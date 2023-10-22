/obj/machinery/button/blast_door/obs_station
	icon = 'icons/fd/items/faction_item.dmi'
	name = "pedestal"
	desc = "It controls blast doors, remotely."
	icon_state = "nt_pedestal0_old"

/obj/machinery/button/blast_door/obs_station/attackby(obj/item/I, mob/user, params)
	. = ..()

	if(istype(I, /obj/item/card/id/obs))
		qdel(I)

/obj/machinery/button/blast_door/obs_station/on_update_icon()
	if(operating)
		icon_state = "nt_pedestal1_old"

/var/const/access_obs1 = "ACCESS_OBS1"
/datum/access/obs1
	id = access_obs1
	desc = "Key Access"
	region = ACCESS_REGION_NONE

/var/const/access_obs2 = "ACCESS_OBS2"
/datum/access/obs2
	id = access_obs2
	desc = "Key Access"
	region = ACCESS_REGION_NONE

/obj/item/card/id/obs/one
	name = "strange sword"
	desc = "Who even put it here?"
	icon = 'icons/fd/items/faction_item.dmi'
	color = "#3c7397"
	icon_state = "nt_sword_old"
	access = list(access_obs1)

/obj/item/card/id/obs/one/on_update_icon()
	return

/obj/item/card/id/obs/two
	name = "strange sword"
	desc = "Who even put it here?"
	icon = 'icons/fd/items/faction_item.dmi'
	color = "#992426"
	icon_state = "nt_sword_old"
	access = list(access_obs2)

/obj/item/card/id/obs/two/on_update_icon()
	return