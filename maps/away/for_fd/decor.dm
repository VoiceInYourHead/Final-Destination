/obj/structure/fd/placeholder
	name = "there is nothing"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	invisibility = 101
	anchored = TRUE
	density = TRUE

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
	bound_x = 64

/obj/structure/fd/bluespace_drive_unfinished
	name = "Unfinished bluespace-drive"
	desc = "Unused project, lefted here like other stuff."
	icon = 'icons/fd/structures/reactor.dmi'
	icon_state = "placeholder1"
	density = TRUE
	anchored = TRUE
//	bound_x = 64
//	bound_y = 64

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
