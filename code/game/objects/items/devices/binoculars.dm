/obj/item/device/binoculars

	name = "binoculars"
	desc = "A pair of binoculars."
	zoomdevicename = "eyepieces"
	icon = 'icons/obj/binoculars.dmi'
	icon_state = "binoculars"
	item_state = "binoculars"

	obj_flags = OBJ_FLAG_CONDUCTIBLE
	force = 5.0
	w_class = ITEM_SIZE_SMALL
	throwforce = 5.0
	throw_range = 15
	throw_speed = 3
	var/zoom_offset = 14 //standart for zoom
	var/zoom_size = 9


/obj/item/device/binoculars/attack_self(mob/user)
	if(zoom)
		unzoom(user)
	else
		zoom(user, zoom_offset, zoom_size)

/obj/item/device/binoculars/New()
	icon_state = pick("binoculars","binoculars1","binoculars_nvg")
	switch(icon_state)
		if("binoculars1")
			zoom_offset = 16
			zoom_size = 9
		if("binoculars_nvg")
			zoom_offset = 19
			zoom_size = 11
		else
			zoom_offset = 14
			zoom_size = 9
	update_icon()
	. = ..()
