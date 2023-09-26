/obj/structure/fd/intel_console
	name = "Old terminal"
	desc = "Strange, pretty old looking data terminal. Possibly holds some good info to sold or use!"
	icon = 'icons/fd/structures/miscobjs.dmi'
	icon_state = "retrosmall"
	density = TRUE
	anchored = TRUE
	var/state = 1 // 1 - fully functional(still need cell to work), 2 - slightly broken(use welder to fix it), 3 - destroyed(use glass to fix the screen and then welder to put everything together)
	var/powerless = TRUE //do we have cell installed? No cell by default
	var/data = TRUE //Do we have any data that we can extract?
	var/list/disk = list(/obj/item/fd/data) //possible pool of data-disks that can be inside
	var/icon_state_functional = "retrosmall"
	var/icon_state_unpowered = "retrosmallp"
	var/icon_state_broken = "retrosmall0"
	var/icon_state_brolen_fully = "retrosmallb"

/obj/structure/fd/intel_console/New()
	. = ..()
	state = pick(1,2,3)
	update_icon()

/obj/structure/fd/intel_console/LateInitialize()
	. = ..()
	update_icon()

/obj/structure/fd/intel_console/on_update_icon()
	if(state == 1 && powerless == TRUE)
		icon_state = icon_state_unpowered
	if(state == 1 && powerless == FALSE)
		icon_state = icon_state_functional
	if(state == 2)
		icon_state = icon_state_broken
	if(state == 3)
		icon_state = icon_state_brolen_fully
	return

/obj/structure/fd/intel_console/attackby(var/obj/item/I, var/mob/user)

	if(state == 3 && istype(I, /obj/item/stack/material/glass/))
		var/obj/item/stack/material/glass/guass = I
		if(guass.amount <= 5)
			to_chat(user, "<span class='warning'>You don't have enough materials! You need atleast 5 in a stack!</span>")
			return
		to_chat(user, "<span class='notice'>You started to repair terminal screen, it will take some time...</span>")
		if(do_after(user, 30) && guass.amount >= 5)
			guass.amount -= 5
			state = 2
			update_icon()
			if(guass.amount <= 0)
				qdel(I)
	if(state == 2 && isWelder(I))
		var/obj/item/weldingtool/welder = I
		if(do_after(user, 50) && welder.remove_fuel(0, user))
			playsound(loc, 'sound/items/Welder.ogg', 100, 1)
			to_chat(user, "<span class='notice'>You started to repair terminal input controller, it will take some time...</span>")
			state = 1
			update_icon()
	if(state == 1)
		if(powerless == TRUE && istype(I, /obj/item/cell/))
			if(do_after(user, 30))
				powerless = FALSE
				to_chat(user, "<span class='notice'>You carefully inserted the battery inside...</span>")
				qdel(I)
				update_icon()
	if(state == 1 && powerless == FALSE)
		if(data == TRUE)
			if(do_after(user, 80) && isMultitool(I))
				to_chat(user, "<span class='notice'>You started to extract terminal data!</span>")
				if(prob(30))
					data = FALSE
					to_chat(user, "<span class='warning'>This terminal don't have any useful data to extract...</span>")
				else
					var/obj/item/datamine = pickweight(disk)
					datamine = new datamine(loc)
					data = FALSE
					to_chat(user, "<span class='notice'>You found [datamine]!</span>")

	else
		to_chat(user, "<span class='warning'>[I] will not help here, probably...</span>")
		return

/obj/item/fd/data
	name = "old datamine disk"
	desc = "Disk that holds various info - from old-state tech blueprints to astronomical maps."
	icon = 'icons/fd/marines/disk.dmi'
	icon_state = "datadisk0"
	origin_tech = list(TECH_MATERIAL = 1, TECH_ENGINEERING = 1)