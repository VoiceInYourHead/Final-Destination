// Structures that store things!
/obj/structure/storage
	name = "filing cabinet"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_CLIMBABLE
	obj_flags = OBJ_FLAG_ANCHORABLE
	var/obj/item/storage/internal/structure/storage
	var/slots = 6						//The number of storage slots in this container.
	var/max_w_class = ITEM_SIZE_NORMAL	//Max size of objects that this object can store (in effect only if can_hold isn't set)
	var/storage_space = null			//Total storage cost of items this can hold. Will be autoset based on storage_slots if left null.
	var/mob_can_enter = FALSE

/obj/structure/storage/Initialize()
	. = ..()
	storage = new/obj/item/storage/internal/structure(src, slots, max_w_class, storage_space)

/obj/structure/storage/Destroy()
	QDEL_NULL(storage)
	. = ..()

/obj/structure/storage/attack_hand(mob/user as mob)
	if (storage.handle_attack_hand(user))
		..(user)

/obj/structure/storage/MouseDrop(obj/over_object as obj)
	if (mob_can_enter)
		if (storage.handle_mousedrop(usr, over_object))
			..(over_object)
	return

/obj/structure/storage/emp_act(severity)
	storage.emp_act(severity)
	..()

/obj/structure/storage/chestdrawer
	name = "chest drawer"
	icon_state = "chestdrawer"
	slots = 8
	storage_space = 15

/obj/structure/storage/nightstand
	name = "nightstand"
	icon = 'icons/fd/structures/furniture2.dmi'
	icon_state = "nightstand"
	slots = null
	storage_space = 10
	max_w_class = ITEM_SIZE_SMALL

/obj/structure/storage/chest
	name = "chest"
	icon = 'icons/fd/structures/furniture2.dmi'
	icon_state = "chestdrawer"
	slots = null
	storage_space = 25
	max_w_class = ITEM_SIZE_LARGE

/obj/structure/storage/vehicles
	name = "containment unit"
	icon = 'icons/fd/halo_vehicles/vehicle_walls.dmi'
	icon_state = "container"
	density = FALSE
	slots = null
	storage_space = 20
	max_w_class = ITEM_SIZE_NORMAL
	obj_flags = OBJ_FLAG_CONDUCTIBLE
