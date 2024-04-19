
///BOYS///

/datum/job/submap/camp/akira
	title = "Akiro Tendo"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/item/storage/box/large/school/akira
	w_class = ITEM_SIZE_TINY
	max_w_class = ITEM_SIZE_GARGANTUAN
	startswith = list()

/obj/effect/submap_landmark/spawnpoint/camp/akira
	name = "Akiro Tendo"

/datum/job/submap/camp/ardent
	title = "Ardent Mire"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/item/storage/box/large/school/ardent
	w_class = ITEM_SIZE_TINY
	max_w_class = ITEM_SIZE_GARGANTUAN
	startswith = list(/obj/item/fd/ancient_items/bs_shard = 1)

/obj/effect/submap_landmark/spawnpoint/camp/ardent
	name = "Ardent Mire"

/datum/job/submap/camp/saturio
	title = "Saturio Amantes"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/saturio
	name = "Saturio Amantes"

//SATURIO CUSTOM ITEMS//

/obj/item/material/twohanded/sledgehammer/dwarf
	icon = 'icons/fd/items/melee_inventory.dmi'
	icon_state = "hammer_power0"
	base_icon = "hammer_power"
	item_state = "breacher1"

// //

/datum/job/submap/camp/maxim
	title = "Maxim Kuznetsov"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/item/storage/box/large/school/maxim
	w_class = ITEM_SIZE_TINY
	max_w_class = ITEM_SIZE_GARGANTUAN
	startswith = list()

/obj/effect/submap_landmark/spawnpoint/camp/maxim
	name = "Maxim Kuznetsov"

/datum/job/submap/camp/okita
	title = "Okita Takeda"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/item/storage/box/large/school/okita
	w_class = ITEM_SIZE_TINY
	max_w_class = ITEM_SIZE_GARGANTUAN
	startswith = list(/obj/item/material/knife/kitchen/plasteelchefknife = 1, /obj/item/clothing/head/helmet/custom/biker = 1, /obj/item/material/sword/katana/raiden/okita = 1, /obj/item/clothing/suit/storage/toggle/bomber = 1, /obj/item/clothing/accessory/toggleable/corpjacket/nanotrasen = 1)

/obj/effect/submap_landmark/spawnpoint/camp/okita
	name = "Okita Takeda"

//OKITA CUSTOM ITEMS//

/obj/item/material/sword/katana/raiden/okita
	force = 20

/obj/item/clothing/head/helmet/custom/biker
	name = "bike helmet"
	desc = "It's a heavy-stylized bike helmet. Kinda looks like axolotl."
	icon = 'icons/fd/custom_items/sliva_helmet.dmi'
	item_icons = list(slot_head_str = 'icons/fd/custom_items/sliva_helmet_worn.dmi')
	icon_state = "sliva"
	item_state = "sliva"
	valid_accessory_slots = null
	body_parts_covered = HEAD|FACE|EYES //face shield
	armor = list(
		melee = ARMOR_MELEE_VERY_HIGH,
		bullet = ARMOR_BALLISTIC_MINOR
		)
	siemens_coefficient = 0.7
	flags_inv = BLOCKHAIR

// //

/datum/job/submap/camp/numerius
	title = "Numerius De Vigo"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/item/storage/box/large/school/numerius
	w_class = ITEM_SIZE_TINY
	max_w_class = ITEM_SIZE_GARGANTUAN
	startswith = list(/obj/item/fd/ancient_items/lighting_staff = 1, /obj/item/clothing/suit/storage/det_trench/grey = 1, /obj/item/material/sword/katana/vibro/numerius = 1)

/obj/item/material/sword/katana/vibro/numerius
	force = 20

/obj/effect/submap_landmark/spawnpoint/camp/numerius
	name = "Numerius De Vigo"

/datum/job/submap/camp/julian
	title = "Julian Morawski"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/julian
	name = "Julian Morawski"

/datum/job/submap/camp/zeza
	title = "Kass Zeza"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/zeza
	name = "Kass Zeza"

/datum/job/submap/camp/manea
	title = "Dionisie Manea"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/item/storage/box/large/school/manea
	w_class = ITEM_SIZE_TINY
	max_w_class = ITEM_SIZE_GARGANTUAN
	startswith = list(/obj/item/clothing/suit/storage/oversize_jacket = 1)

/obj/effect/submap_landmark/spawnpoint/camp/manea
	name = "Dionisie Manea"

/datum/job/submap/camp/allen
	title = "John Allen"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/allen
	name = "John Allen"

/datum/job/submap/camp/trueman
	title = "Ron Trueman"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/item/storage/box/large/school/trueman
	w_class = ITEM_SIZE_TINY
	max_w_class = ITEM_SIZE_GARGANTUAN
	startswith = list()

/obj/effect/submap_landmark/spawnpoint/camp/trueman
	name = "Ron Trueman"

///GIRLS///

/datum/job/submap/camp/shtorn
	title = "Shtorn Avasarala"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/shtorn
	name = "Shtorn Avasarala"

/datum/job/submap/camp/demetra
	title = "Demetra Ionian"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/item/storage/box/large/school/demetra
	w_class = ITEM_SIZE_TINY
	max_w_class = ITEM_SIZE_GARGANTUAN
	startswith = list()

/obj/effect/submap_landmark/spawnpoint/camp/demetra
	name = "Demetra Ionian"

/datum/job/submap/camp/sara
	title = "Sara Mayer"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/sara
	name = "Sara Mayer"

/datum/job/submap/camp/vivian
	title = "Vivian Rockwell"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/item/storage/box/large/school/vivian
	w_class = ITEM_SIZE_TINY
	max_w_class = ITEM_SIZE_GARGANTUAN
	startswith = list()

/obj/effect/submap_landmark/spawnpoint/camp/vivian
	name = "Vivian Rockwell"

/datum/job/submap/camp/mara
	title = "Mara Sumitomo"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/item/storage/box/large/school/mara
	w_class = ITEM_SIZE_TINY
	max_w_class = ITEM_SIZE_GARGANTUAN
	startswith = list(/obj/item/storage/fancy/cigarettes/luckystars = 1)

/obj/effect/submap_landmark/spawnpoint/camp/mara
	name = "Mara Sumitomo"


///END///

/*/datum/job/submap/camp/psionic2
	title = "New Student"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/psionic2
	name = "New Student"*/
