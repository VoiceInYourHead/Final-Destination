/obj/structure/fd/placeholder
	name = "there is nothing"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	invisibility = 101
	anchored = TRUE
	density = TRUE

/obj/structure/fd/placeholder/better
	opacity = 1

/obj/structure/fd/gateway
	name = "gateway"
	desc = "The pretty old trchnology, used in the past to transport people from place to place in few seconds."
	icon = 'icons/obj/machines/gateway_full.dmi'
	icon_state = "gateway_off"
	density = TRUE
	anchored = TRUE
	pixel_x = -30

/obj/structure/fd/nav_console
	name = "navigation console"
	desc = "Console for managing some navigation routes through space and bluespace. Now almost useless."
	icon = 'icons/fd/structures/trinetcore.dmi'
	icon_state = "tnc"
	density = TRUE
	anchored = TRUE
	bound_width = 64
	layer = ABOVE_HUMAN_LAYER

/obj/structure/fd/nav_console_broken
	name = "navigation console"
	desc = "Console for managing some navigation routes through space and bluespace. Now almost useless."
	icon = 'icons/fd/structures/trinetcore.dmi'
	icon_state = "tncb"
	density = TRUE
	anchored = TRUE
	bound_width = 64
	layer = ABOVE_HUMAN_LAYER

/obj/structure/fd/bluespace_drive_unfinished
	name = "Unfinished bluespace-drive"
	desc = "Unused project, lefted here like other stuff."
	icon = 'icons/fd/structures/reactor.dmi'
	icon_state = "placeholder1"
	density = TRUE
	anchored = TRUE

/obj/structure/fd/sputnik
	name = "crashed satellite"
	desc = "Satellite, crashed from orbit. It was a pure luck that it wasn't destroyed in midair by atmosphere."
	icon = 'icons/fd/structures/miscobjs.dmi'
	icon_state = "pogrom"
	density = TRUE
	anchored = TRUE

/obj/structure/fd/science_bed
	name = "some high-tech looking bed"
	desc = "Probably used for some kind of tests or experiments!"
	icon = 'icons/fd/structures/computer.dmi'
	icon_state = "econtrol"
	density = TRUE
	anchored = TRUE

/obj/structure/fd/science_bed_control
	name = "control panel"
	desc = "Probably used for some kind of tests or experiments!"
	icon = 'icons/fd/structures/objects.dmi'
	icon_state = "ob0"
	density = FALSE
	anchored = TRUE

/obj/structure/fd/teleport_console
	name = "broken console"
	desc = "Probably used for some kind of tests or experiments!"
	icon = 'icons/fd/structures/miscobjs.dmi'
	icon_state = "teleportb"
	density = TRUE
	anchored = TRUE

/obj/structure/fd/gateway_console
	name = "broken console"
	desc = "Console for setting up needed coordinates for gateway."
	icon = 'icons/fd/structures/computer.dmi'
	icon_state = "radar"
	density = TRUE
	anchored = TRUE

/obj/structure/fd/bluespace_drive
	name = "Bluespace Drive"
	desc = "Fully working and repaired bluespace drive, used to perform bluespace jumps at FTL speed."
	icon = 'icons/fd/structures/slipspace_drive.dmi'
	icon_state = "slipspace"
	density = TRUE
	anchored = FALSE
	pixel_x = -16
	pixel_y = -15

/obj/structure/fd/aaaa/notes
	name = "statue"
	desc = "Very strange statue"
	icon = 'icons/32x48.dmi'
	icon_state = "silent_2"
	density = TRUE
	anchored = TRUE

/obj/structure/fd/aaaa/eyes
	name = "webs"
	desc = "Very strange black thing"
	icon = 'icons/48x48.dmi'
	icon_state = "spider"
	density = TRUE
	anchored = TRUE
	pixel_x = -8

/obj/structure/fd/scorched/orgy
	name = "pile of scorshed bodies"
	desc = "Very strange black thing"
	icon = 'icons/fd/structures/Disposed.dmi'
	icon_state = "Orgy"
	density = TRUE
	anchored = TRUE
	bound_width = 64

	layer = ABOVE_HUMAN_LAYER

/obj/structure/fd/skull
	name = "big animal skull"
	desc = "This thing probably was pretty big"
	icon = 'icons/fd/structures/Skulls_and_bones2.dmi'
	icon_state = "Fullskullv1"
	density = TRUE
	anchored = TRUE
	bound_width = 64
	bound_height = 64

/obj/structure/fd/skull/New()
	..()
	icon_state = "Fullskullv[rand(1, 2)]"

/obj/structure/fd/skull2
	name = "big animal skull"
	desc = "This thing probably was pretty big"
	icon = 'icons/fd/structures/Skulls_and_bones2.dmi'
	icon_state = "HoleHead"
	density = TRUE
	anchored = TRUE
	bound_width = 64

	layer = ABOVE_HUMAN_LAYER


/obj/structure/fd/skull3
	name = "big animal skull"
	desc = "This thing probably was pretty big"
	icon = 'icons/fd/structures/Skulls_and_bones2.dmi'
	icon_state = "Gv3"
	density = TRUE
	anchored = TRUE
	bound_width = 64

	layer = ABOVE_HUMAN_LAYER

/obj/structure/fd/ribs
	name = "big animal ribs"
	desc = "This thing probably was pretty big"
	icon = 'icons/fd/structures/Skulls_and_bones2.dmi'
	icon_state = "Ribs"
	density = TRUE
	anchored = TRUE
	bound_width = 64

	layer = ABOVE_HUMAN_LAYER

/obj/structure/fd/bone
	name = "big animal bone"
	desc = "This thing probably was pretty big"
	icon = 'icons/fd/structures/Skulls_and_bones2.dmi'
	icon_state = "Bone"
	density = TRUE
	anchored = TRUE

/obj/structure/fd/bs_crystal
	name = "bluespace crystal"
	desc = "The really rare, non-fluid state of bluespace."
	icon = 'icons/fd/structures/bluespace_crystal_structure.dmi'
	icon_state = "crystal"
	anchored = TRUE
	density = TRUE
	var/range_to_remove = TRUE
	var/ticks = 0

/obj/structure/fd/bs_crystal/Initialize()
	START_PROCESSING(SSobj, src)
	return ..()

/obj/structure/fd/bs_crystal/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/fd/bs_crystal/Process()

	++ticks

	// find a victim in case the last one is gone
	var/mob/living/carbon/human/affecting = null
	for(var/mob/living/carbon/human/H in shuffle(view(10, src)))
		if(can_affect(H))
			affecting = H
			break

	// we're done here
	if(!affecting)
		return

	// do fun stuff
	if(affecting in view(5, src))
		affecting.overlay_fullscreen("malf-scanline", /obj/screen/fullscreen/bluespace_affection)

		// once every 20 seconds
		if(!(ticks % 20))
			affecting.visible_message("<span class='danger'><em>[affecting] starts to cough very loudly!</em></span>")
			to_chat(affecting, "<span class='danger'>You feeling something very sharp in your throat!</span>")
			affecting.adjustOxyLoss(70)
			affecting.adjustBruteLoss(30)
	else
		affecting.clear_fullscreen("malf-scanline")


/obj/structure/fd/bs_crystal/proc/can_affect(mob/living/carbon/human/H)
	if(H.wear_mask)
		return FALSE
	if(H.head && (H.head.body_parts_covered & FACE))
		return FALSE
	return TRUE

/obj/structure/fd/bs_crystal/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/pickaxe))
		if(do_after(user, 80))
			new /obj/item/fd/ancient_items/bs_shard(src.loc)
				qdel(src)

/obj/structure/fd/body
	name = "dead body"
	desc = "Seems like he/she died a very long ago."
	icon = 'icons/fd/structures/TNC_Corpses.dmi'
	icon_state = "CaptainDead"
	anchored = TRUE

/obj/structure/fd/body/bluespace_infected
	name = "corrupted body"
	desc = "This body most likely were affected by bluespace distortion. It's better not to touch it even."
	icon_state = "TNCDead8_infected"