/obj/structure/fd/intel_console
	name = "Old terminal"
	desc = "Strange, pretty old looking data terminal. Possibly holds some good info to sold or use!"
	icon = 'icons/fd/structures/miscobjs.dmi'
	icon_state = "retrosmall"
	density = TRUE
	anchored = TRUE
	var/state = 1 // 1 - fully functional(still need cell to work), 2 - slightly broken(use welder to fix it), 3 - destroyed(use glass to fix the screen and then welder to put everything together)
	var/powerless = TRUE //do we have cell installed? No cell by default
	var/data = 5 //Do we have any data that we can extract?
	var/list/disk = list(/obj/item/fd/data,
						/obj/item/fd/data/weapons,
						/obj/item/fd/data/weapons/lvl2/kinetic,
						/obj/item/fd/data/weapons/lvl2/energy,
						/obj/item/fd/data/weapons/lvl2/magnetic,
						/obj/item/fd/data/weapons/lvl2/special,
						/obj/item/fd/data/weapons/lvl3/kinetic,
						/obj/item/fd/data/weapons/lvl3/energy,
						/obj/item/fd/data/weapons/lvl3/magnetic,
						/obj/item/fd/data/weapons/lvl3/special,
						/obj/item/fd/data/weapons/lvl3/secret,
						/obj/item/fd/data/weapons/lvl4/kinetic,
						/obj/item/fd/data/weapons/lvl4/energy,
						/obj/item/fd/data/weapons/lvl4/magnetic,
						/obj/item/fd/data/weapons/lvl4/special,
						/obj/item/fd/data/weapons/lvl4/secret) //possible pool of data-disks that can be inside
	var/icon_state_functional = "retrosmall"
	var/icon_state_unpowered = "retrosmallp"
	var/icon_state_broken = "retrosmall0"
	var/icon_state_brolen_fully = "retrosmallb"

/obj/structure/fd/intel_console/New()
	. = ..()
	state = pick(1,2,3)
	data = rand(1,5)
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
		if(data == 1)
			to_chat(user, "<span class='notice'>This terminal don't have any other designs to extract...but still, you can use it to find something!</span>")
		if(data == 0)
			to_chat(user, "<span class='warning'>This terminal don't have any more useful data to extract...</span>")
		if(data > 1)
			if(do_after(user, 80) && isMultitool(I))
				to_chat(user, "<span class='notice'>You started to extract terminal data!</span>")
				var/obj/item/datamine = pickweight(disk)
				datamine = new datamine(loc)
				data -= 2
				to_chat(user, "<span class='notice'>You found [datamine]!</span>")

	else
		to_chat(user, "<span class='warning'>[I] will not help here, probably...</span>")
		return

/obj/structure/fd/intel_console/attack_hand(mob/user)
	if(state == 1 && powerless == FALSE)
		if(data > 0)
			if(do_after(user, 80))
				var/option =  alert(user, "What exactly you want to find?", "Terminal searching", "Crates", "Cryopods")
				switch(option)
					if("Cryopods")
						var/obj/structure/abandoned_cryo/C = locate() in orange(30)
						if(C)
							to_chat(user, "<span class='notice'>Nearest cryopod coordinates is: [C.x], [C.y]</span>")
							data -= 1
						else
							to_chat(user, "<span class='notice'>Seems like there is nothing like this in range of that terminal!</span>")
					if("Crates")
						var/obj/structure/closet/crate/CR = locate() in orange(30)
						if(CR)
							to_chat(user, "<span class='notice'>Nearest loot-crate coordinates is: [CR.x], [CR.y]</span>")
							data -= 1
						else
							to_chat(user, "<span class='notice'>Seems like there is nothing like this in range of that terminal!</span>")
		else
			to_chat(user, "<span class='notice'>Seems like all the data were already extracted from this one!</span>")


/obj/item/fd/data
	name = "old datamine disk (TIER 0 - ENGINEERING)"
	desc = "Disk that holds various info - from old-state tech blueprints to astronomical maps."
	icon = 'icons/fd/marines/disk.dmi'
	icon_state = "datadisk0"
	origin_tech = list(TECH_MATERIAL = 1, TECH_ENGINEERING = 1)

/obj/item/fd/data/New()
	..()
	icon_state = "datadisk[rand(0, 22)]"

/obj/item/fd/data/weapons
	name = "old datamine disk (TIER 1 - WEAPONRY)"
	origin_tech = list(TECH_COMBAT = 1, TECH_MATERIAL = 1, TECH_POWER = 1, TECH_MAGNET = 1)

//TIER 2

/obj/item/fd/data/weapons/lvl2/kinetic
	name = "old datamine disk (TIER 2 - KINETIC WEAPONRY)"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 6)

/obj/item/fd/data/weapons/lvl2/energy
	name = "old datamine disk (TIER 2 - ENERGY WEAPONRY)"
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 4, TECH_POWER = 5)

/obj/item/fd/data/weapons/lvl2/magnetic
	name = "old datamine disk (TIER 2 - MAGNETIC WEAPONRY)"
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 4, TECH_MAGNET = 5)

/obj/item/fd/data/weapons/lvl2/special
	name = "old datamine disk (TIER 2 - EXPERIMENTAL WEAPONRY)"
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 4, TECH_ESOTERIC = 5, TECH_BIO = 5)

//TIER 3

/obj/item/fd/data/weapons/lvl3/kinetic
	name = "old datamine disk (TIER 3 - KINETIC WEAPONRY)"
	origin_tech = list(TECH_COMBAT = 8, TECH_MATERIAL = 9)

/obj/item/fd/data/weapons/lvl3/energy
	name = "old datamine disk (TIER 3 - ENERGY WEAPONRY)"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 5, TECH_POWER = 7)

/obj/item/fd/data/weapons/lvl3/magnetic
	name = "old datamine disk (TIER 3 - MAGNETIC WEAPONRY)"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 5, TECH_MAGNET = 7)

/obj/item/fd/data/weapons/lvl3/special
	name = "old datamine disk (TIER 3 - EXPERIMENTAL WEAPONRY)"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 5, TECH_ESOTERIC = 8, TECH_BIO = 7)

/obj/item/fd/data/weapons/lvl3/secret
	name = "old datamine disk (TIER 3 - SECRET WEAPONRY)"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 5, TECH_BLUESPACE = 5, TECH_PHORON = 5)

//TIER 4

/obj/item/fd/data/weapons/lvl4/kinetic
	name = "old datamine disk (TIER 4 - KINETIC WEAPONRY)"
	origin_tech = list(TECH_COMBAT = 12, TECH_MATERIAL = 10)

/obj/item/fd/data/weapons/lvl4/energy
	name = "old datamine disk (TIER 4 - ENERGY WEAPONRY)"
	origin_tech = list(TECH_COMBAT = 8, TECH_MATERIAL = 7, TECH_POWER = 9)

/obj/item/fd/data/weapons/lvl4/magnetic
	name = "old datamine disk (TIER 4 - MAGNETIC WEAPONRY)"
	origin_tech = list(TECH_COMBAT = 8, TECH_MATERIAL = 7, TECH_MAGNET = 7)

/obj/item/fd/data/weapons/lvl4/special
	name = "old datamine disk (TIER 4 - EXPERIMENTAL WEAPONRY)"
	origin_tech = list(TECH_COMBAT = 8, TECH_MATERIAL = 7, TECH_ESOTERIC = 10, TECH_BIO = 9)

/obj/item/fd/data/weapons/lvl4/secret
	name = "old datamine disk (TIER 4 - SECRET WEAPONRY)"
	origin_tech = list(TECH_COMBAT = 8, TECH_MATERIAL = 7, TECH_BLUESPACE = 8, TECH_PHORON = 7)
