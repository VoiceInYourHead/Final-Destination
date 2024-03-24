/datum/job/submap/camp/teacher1
	title = "Psionic teacher 1"
	info = "You here to teach some dumbasses how to beat bad guys and not die in progress"
	supervisors = "your fantasy and Void google doc."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff/yano
	total_positions = 1
	loadout_allowed = TRUE
	skill_points = 30


//NAOKI CUSTOM ITEMS//

/obj/item/clothing/glasses/custom/aizawa_red
	name = "red combat glasses"
	desc = "Protects the eyes from various flashes and direct damage."
	icon = 'icons/fd/items/andersen_goggles.dmi'
	item_icons = list(slot_glasses_str = 'icons/fd/items/andersen_worn.dmi')
	icon_state = "andersen_goggles"
	item_state = "andersen_goggles"
	action_button_name = "Flip Welding Goggles"
	matter = list(MATERIAL_STEEL = 1500, MATERIAL_GLASS = 1000)
	use_alt_layer = TRUE
	var/up = FALSE
	flash_protection = FLASH_PROTECTION_MAJOR

/obj/item/clothing/glasses/custom/aizawa_red/attack_self()
	toggle()

/obj/item/clothing/glasses/custom/aizawa_red/verb/toggle()
	set category = "Object"
	set name = "Adjust welding goggles"
	set src in usr

	if(!usr.incapacitated())
		if(src.up)
			src.up = !src.up
			flags_inv |= HIDEEYES
			body_parts_covered |= EYES
			icon_state = initial(icon_state)
			flash_protection = initial(flash_protection)
			to_chat(usr, "You flip \the [src] down to protect your eyes.")
		else
			src.up = !src.up
			flags_inv &= ~HIDEEYES
			body_parts_covered &= ~EYES
			icon_state = "[initial(icon_state)]_up"
			flash_protection = FLASH_PROTECTION_NONE
			to_chat(usr, "You push \the [src] up out of your face.")
		update_clothing_icon()
		update_vision()
		usr.update_action_buttons()

// //

/obj/effect/submap_landmark/spawnpoint/camp/teacher1
	name = "Psionic teacher 1"

/datum/job/submap/camp/teacher2
	title = "Psionic teacher 2"
	info = "You here to teach some dumbasses how to beat bad guys and not die in progress"
	supervisors = "your fantasy and Void google doc."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff/morvar
	total_positions = 1
	loadout_allowed = TRUE
	skill_points = 30
	access = list("ACCESS_CAMP_TEACHER4")

/obj/effect/submap_landmark/spawnpoint/camp/teacher2
	name = "Psionic teacher 2"

/datum/job/submap/camp/teacher3
	title = "Psionic teacher 3"
	info = "You here to teach some dumbasses how to beat bad guys and not die in progress"
	supervisors = "your fantasy and Void google doc."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff
	total_positions = 1
	loadout_allowed = TRUE
	skill_points = 30

/obj/effect/submap_landmark/spawnpoint/camp/teacher3
	name = "Psionic teacher 3"

/datum/job/submap/camp/doctor
	title = "Doctor"
	info = "You here to heal people, your'e the greatest biomant in this whole place."
	supervisors = "the Hippocratic oath."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff/dianthus
	total_positions = 1
	loadout_allowed = TRUE
	skill_points = 30
	access = list(list("ACCESS_CAMP_TEACHER3","ACCESS_CAMP_MED"))

/obj/effect/submap_landmark/spawnpoint/camp/doctor
	name = "Doctor"

/datum/job/submap/camp/cook
	title = "Cook"
	info = "You here to cook food for people, what else do you expecting?"
	supervisors = "your imagination."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff
	total_positions = 1
	loadout_allowed = TRUE
	skill_points = 20
	access = list("ACCESS_CAMP_TEACHER5")

/obj/effect/submap_landmark/spawnpoint/camp/cook
	name = "Cook"

//AMORE CUSTOM ITEMS

/obj/item/paper/school/amore
	icon = 'icons/fd/items/mrakiizar_book.dmi'
	icon_state = "mrakiizar_book1"
	name = "Old Book"
	var/closed = FALSE

/obj/item/paper/school/amore/attack_self()
	if(!closed)
		closed = TRUE
		icon_state = "mrakiizar_book_closed"
	else
		closed = FALSE
		icon_state = "mrakiizar_book1"

/obj/item/paper/school/amore/on_update_icon()
	return
