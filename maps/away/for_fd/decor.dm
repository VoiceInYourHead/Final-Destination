/obj/structure/fd/placeholder
	name = "there is nothing"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	invisibility = 101
	anchored = TRUE
	density = TRUE

/obj/structure/fd/placeholder/better
	opacity = 1

/obj/item/storage/cargo_containers
	name = "cargo container"
	desc = "Probably used for transporting something!"
	icon = 'icons/fd/structures/cm/contain.dmi'
	icon_state = "grant_l"
	density = TRUE
	anchored = TRUE

	randpixel = 0
	layer = ABOVE_HUMAN_LAYER

	max_w_class = ITEM_SIZE_LARGE
	max_storage_space = 80
	storage_slots = 30

/obj/item/storage/cargo_containers/attack_hand(mob/user)
	return attack_self(user)

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

/obj/structure/fd/nav_console_broken
	name = "navigation console"
	desc = "Console for managing some navigation routes through space and bluespace. Now almost useless."
	icon = 'icons/fd/structures/trinetcore.dmi'
	icon_state = "tncb"
	density = TRUE
	anchored = TRUE
	bound_width = 64

/obj/structure/fd/nav_console/for_junkyard_or_planet
	bound_width = 32

/obj/structure/fd/nav_console_broken/for_junkyard_or_planet
	bound_width = 32

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

/obj/structure/fd/bs_spikes
	name = "bluespace corruption spikes"
	desc = "The really rare, non-fluid state of bluespace."
	icon = 'icons/fd/structures/bluespace_crystal_structure.dmi'
	icon_state = "corruption"
	anchored = TRUE
	density = FALSE

/obj/structure/fd/bs_lamp
	name = "strange pulsating statue"
	desc = "This one probably made by aliens"
	icon = 'icons/fd/hivemind_machines.dmi'
	icon_state = "antenna"
	anchored = TRUE

/obj/structure/fd/bs_lamp/Initialize()
	. = ..()
	set_light(0.3, 1, 3, 1, COLOR_CYAN)

/obj/structure/fd/bs_vines
	name = "bluespace corrupted vines"
	desc = "Bluespace corruptive flora"
	icon = 'icons/fd/structures/bluespace_crystal_structure.dmi'
	icon_state = "wires-1"
	anchored = TRUE
	var/busy

/obj/structure/fd/bs_vines/New()
	..()
	icon_state = "wires-[rand(1, 6)]"

/obj/structure/fd/bs_vines/Initialize()
	. = ..()
	set_light(0.3, 1, 2, 1, COLOR_CYAN)

/obj/structure/fd/bs_vines/user_unbuckle_mob(mob/user)
	if(buckled_mob && !user.stat && !user.restrained())
		if(busy)
			to_chat(user, SPAN_NOTICE("\The [buckled_mob] is already getting out, be patient."))
			return
		var/delay = 60
		if(user == buckled_mob)
			delay *=2
			user.visible_message(
				SPAN_NOTICE("\The [user] tries to chop off \the [src]."),
				SPAN_NOTICE("You begin to pull yourself out of \the [src]."),
				SPAN_NOTICE("You hear water sloshing.")
				)
		else
			user.visible_message(
				SPAN_NOTICE("\The [user] begins pulling \the [buckled_mob] out of \the [src]."),
				SPAN_NOTICE("You begin to pull \the [buckled_mob] out of \the [src]."),
				SPAN_NOTICE("You hear something strange...")
				)
		busy = TRUE
		if(do_after(user, delay, src))
			busy = FALSE
			if(user == buckled_mob)
				if(prob(80))
					to_chat(user, SPAN_WARNING("You slip and fail to get out!"))
					return
				user.visible_message(SPAN_NOTICE("\The [buckled_mob] successfully chopped down \the [src]."))
				qdel(src)
			else
				user.visible_message(SPAN_NOTICE("\The [buckled_mob] has been freed from \the [src] by \the [user]."))
			unbuckle_mob()
		else
			busy = FALSE
			to_chat(user, SPAN_WARNING("You slip and fail to get out!"))
			return

/obj/structure/fd/bs_vines/unbuckle_mob()
	..()

/obj/structure/fd/bs_vines/buckle_mob(var/mob/living/carbon/L)
	..()

/obj/structure/fd/bs_vines/Crossed(var/atom/movable/AM)
	if(isliving(AM))
		var/mob/living/carbon/L = AM
		if(L.throwing || L.can_overcome_gravity())
			return
		buckle_mob(L)
		to_chat(L, SPAN_DANGER("You're tangled in \the [src]!"))

/obj/structure/fd/bs_vines/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/material/hatchet))
		if(do_after(user, 80))
			qdel(src)

/obj/structure/fd/bs_vines/alien
	icon = 'icons/fd/animals/Effects.dmi'
	icon_state = "weeds1"

/obj/structure/fd/bs_vines/alien/New()
	..()
	icon_state = "weeds[rand(1, 3)]"

/obj/structure/fd/bs_vines/alien/Crossed(var/atom/movable/AM)
	if(ishuman(AM) && prob(30))
		var/mob/living/carbon/L = AM
		if(L.throwing || L.can_overcome_gravity())
			return
		buckle_mob(L)
		to_chat(L, SPAN_DANGER("You're tangled in \the [src]!"))

/obj/structure/fd/bs_crystal
	name = "bluespace crystal"
	desc = "The really rare, non-fluid state of bluespace."
	icon = 'icons/fd/structures/bluespace_crystal_structure.dmi'
	icon_state = "crystal"
	anchored = TRUE
	density = TRUE
	var/range_to_remove = TRUE
	var/ticks = 0
	var/list/affected_mobs = list()

/obj/structure/fd/bs_crystal/Initialize()
	START_PROCESSING(SSobj, src)
	return ..()

/obj/structure/fd/bs_crystal/Destroy()
	STOP_PROCESSING(SSobj, src)
	for(var/mob/living/carbon/human/affecting as anything in affected_mobs)
		affected_mobs -= affecting
		affecting.clear_fullscreen("malf-scanline")
	return ..()

/obj/structure/fd/bs_crystal/Process()

	++ticks
	var/mob/living/carbon/human/affecting

	// find a victim in case the last one is gone
	var/list/targets_in_range = list()
	for(affecting in view(5, src) - affected_mobs)
		if(!can_affect(affecting))
			continue
		targets_in_range += affecting

	if(length(targets_in_range))
		affecting = pick(targets_in_range)
		affected_mobs += affecting
		affecting.overlay_fullscreen("malf-scanline", /obj/screen/fullscreen/bluespace_affection)

	for(affecting as anything in affected_mobs)
		if(!in_range(src, affecting))
			affected_mobs -= affecting
			affecting.clear_fullscreen("malf-scanline")

	if(length(affected_mobs))
		affecting = pick(affected_mobs)

	// once every 20 seconds
		if(!(ticks % 20))
			affecting.visible_message("<span class='danger'><em>[affecting] starts to cough very loudly!</em></span>")
			to_chat(affecting, "<span class='danger'>You feeling something very sharp in your throat!</span>")
			affecting.adjustOxyLoss(70)
			affecting.adjustBruteLoss(30)

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