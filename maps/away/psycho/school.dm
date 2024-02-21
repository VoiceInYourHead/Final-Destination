#include "school_radio.dm"
#include "school_mobs.dm"

//LORE ITEMS

/obj/item/paper/school/journal
	icon = 'icons/fd/items/oddities2.dmi'
	icon_state = "book_log"
	name = "Dusty Journal"
	language = LANGUAGE_CULT_GLOBAL
	info = "Для начала, думаю, будет резонно извиниться перед вами за то, что сообщаю это таким образом.<br>\
			По моим расчётам, отталкиваясь от уровня вашей привязанности к моей персоне и общего любопытства - вы должны найти данную записку спустя месяц(ориентировочно) после моей трагической кончины.<br>\
			Если я не ошибся в расчётах, то примерно в это же время мне найдут замену и вероятнее всего приставят к вашему лагерю кого-то более покладистого и недальновидного. Для наблюдения, естественно. Вполне возможно, он даже поддержит ваш интерес к поиску правды, но вы...я более чем уверен, что вы достаточно сообразительны для того, чтобы понять это и без меня.<br>\
			<b>------</b> <br>\
			Касательно моего трагичного исхода. Был ли инцидент подстроен в заранее, с целью ликвидации конкретно меня? Да. Было ли это дело рук самого Центрального Правительства? Определённо да. Почему? Здесь стоит остановиться и рассказать вам немного подробнее о том, что послужило причиной моего ВЕРОЯТНОГО устранения.<br>\
			Для начала, о битве при Нью-Амстердаме. Говорить об этом не принято, но Институт понёс куда более значительные потери, чем заявляется официально. Не смотря на одержанную победу - наш любимый и широко уважаемый Профессор Кучулейн - и сам получил травмы, несовместимые с жизнью. По сей причине, уже некоторое время он не находится при делах и не имеет никакого контроля над происходящим в рамках организации.<br>\
			Это позволило государству, а вместе с тем и фракциям поменьше, что этим государством 'управляют' - пустить свои корни в рабочую инфраструктуру НИИ, постепенно заменяя старый кадровый состав своими агентами.<br>\
			По моим примерным расчётам, в данный момент мы имеем следующее соотношение: 44% лоялистов к 56% подрядчиков, косвенно или напрямую относящихся к 'N.E.M.E.S.I.S.'.<br>\
			<b>------</b> <br>\
			Их основная цель - отбор и промывание наилучших выпускников с целью дальнейшего применения оных в карательных целях. Не всегда удачно, не всегда гуманно. Некоторые не переживают данную процедуру вовсе.<br>\
			Когда я находился в своей командировке - мне удалось лицезреть данную картину самолично.<br>\
			Не то что на улицах - даже в школах теперь небезопасно. Но сражаться или бежать - смысла тоже нет. Учителей крайне быстро устранят, а ученики даже не вспомнят о их существовании. При всём уважении к тебе и Крису, Наоки - вы не протянете и минуты.<br>\
			Тем не менее, был бы я собой, если бы не позаботился о плане 'Б'?<br>\
			<b>------</b> <br>\
			В спине левой статуи, на главной площади лагеря - вы найдёте папку с документами, среди которых находятся доказательства выше написанного, а также имена и информация о людях, которым вы можете доверять.<br>\
			Не пытайтесь найти или связаться с ними самостоятельно. Это лишь поставит ваше и их прикрытие под удар. Я оставил для них такие же инструкции.<br>\
			Всё что требуется от вас - это держать данную информацию в голове и не провоцировать верхушку на преждевременные действия. Положитесь на них, как я положился на вас, коллеги.<br>\
			<b>------</b> <br>\
			Что же до учащихся...<br>\
			Вы не сможете спасти каждого из них. Кто-то откажется верить вам, кто-то просто будет обузой для остальных.<br>\
			Лучшее, что мы можем сделать - это подарить им мгновения спокойствия перед грядущим, сфокусировав свои силы на тех, кто сможет спасти ещё сотни в будущем.<br>\
			Впрочем, вы ведь всё равно не станете слушать меня, верно? Не думаю, что я нахожусь в той позиции, чтобы осуждать подобную иррациональную и безумную приверженность добру и благу. В конце концов, именно я, прямо сейчас, мёртв. А вы ещё живы и читаете это.<br>\
			<b>------</b> <br>\
			Я хочу пожелать вам удачи.<br>\
			Какое бы вы решение в итоге не приняли...я не сомневаюсь в том, что вы отдадитесь ему с головой.<br>\
			Но пообещайте мне одно.<br>\
			Не забывайте о них. О тех, кто погиб, ради того, чтобы вы добрались до этой точки. И продолжайте двигаться вперёд. Не важно, насколько больны будут раны, и насколько стёрты будут ваши пятки - продолжайте, идти.<br>\
			Ради всех студентов, что стали их жертвами. Ради всех коллег и друзей, что погибли на этой тайной войне. Ради наших общих идеалов и будущего, которое ждёт следующие поколения.<br>\
			Ради того, чтобы нам ВСЕМ было куда возвращаться.<br>"

//ASSETS

/obj/structure/fd/school/prop1
	name = "Old shotgun"
	desc = "The mass-produced W-T Remmington 29x shotgun is a favourite of police and security forces in the past. Now - it's only a relic."
	icon = 'icons/obj/guns/shotguns.dmi'
	icon_state = "shotgun"
	anchored = TRUE

/obj/structure/fd/school/prop2
	name = "UFO sign"
	desc = "Just an neon sign of an old UFO vision."
	icon = 'icons/fd/structures/manhattan/signs/signs.dmi'
	icon_state = "ufo"
	anchored = TRUE

/obj/structure/fd/school/prop3
	name = "City sign"
	desc = "Just an neon sign of an night city."
	icon = 'icons/fd/structures/manhattan/signs/signs_large.dmi'
	icon_state = "city_of_night"
	anchored = TRUE

/obj/structure/fd/school/prop4
	name = "Ancient fresco"
	desc = "Very old piece of art, probably from Earth."
	icon = 'icons/fd/structures/manhattan/mnhtn_paintings.dmi'
	icon_state = "1,15"
	anchored = TRUE

/obj/structure/fd/school/prop5
	name = "figure"
	desc = "Just an neon figure"
	icon = 'icons/fd/structures/manhattan/signs/signs.dmi'
	icon_state = "square"
	anchored = TRUE

/obj/structure/fd/school/prop6
	name = "symbol"
	desc = "Strange looking symbol"
	icon = 'icons/fd/fabric_symbols.dmi'
	icon_state = "9"
	anchored = TRUE

/obj/structure/fd/school/prop7
	name = "old workbench"
	desc = "Old and primitive working station for some metalworking."
	icon = 'icons/fd/structures/workbenches.dmi'
	icon_state = "weaponbench"
	anchored = TRUE
	density = TRUE
	bound_width = 64

/obj/structure/fd/school/prop8
	name = "oven"
	desc = "Old oven made from clay."
	icon = 'icons/fd/structures/kitchen.dmi'
	icon_state = "oven0"
	anchored = TRUE
	var/on = FALSE

/obj/structure/fd/school/prop8/attack_hand(mob/user as mob)
	if(do_after(user, 20) && !on)
		on = TRUE
		icon_state = "oven1"
		set_light(0.4, 2, 3, l_color = "#c58822")
		return
	else
		if(do_after(user, 20))
			on = FALSE
			icon_state = "oven0"
			set_light(0, 0, 0, l_color = "#ffffff")
			update_light()
			return

/obj/machinery/fabricator/school
	name = "advanced crafting station"
	desc = "A very complex and options-heavy machine, used to create some very complex things."
	icon = 'icons/fd/structures/workbenches.dmi'
	icon_state = "tinkerbench"
	bound_width = 64

	layer = ABOVE_HUMAN_LAYER

/obj/machinery/fabricator/school/on_update_icon()
	return

/obj/effect/overmap/visitable/sector/camp
	name = "jungle planet"
	desc = "A jungle planet with high amount of hostile xenofauna and environment."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	color = "#6db8b8"
	initial_generic_waypoints = list(
		"nav_camp_1",
		"nav_camp_2",
		"nav_camp_antag"
	)

/obj/effect/submap_landmark/joinable_submap/camp
	name = "Psionics Camp"
	archetype = /decl/submap_archetype/camp

/decl/submap_archetype/camp
	descriptor = "Secret SCG camp on unknown planet"
	map = "Psionics Camp"
	crew_jobs = list(
		/datum/job/submap/camp/ardent,
		/datum/job/submap/camp/saturio,
		/datum/job/submap/camp/maxim,
		/datum/job/submap/camp/okita,
		/datum/job/submap/camp/numerius,
		/datum/job/submap/camp/julian,

		/datum/job/submap/camp/shtorn,
		/datum/job/submap/camp/sara,
		/datum/job/submap/camp/vivian,
		/datum/job/submap/camp/mara,

		/datum/job/submap/camp/psionic2,
		/datum/job/submap/camp/teacher1,
		/datum/job/submap/camp/teacher2,
		/datum/job/submap/camp/teacher3,
		/datum/job/submap/camp/teacher4,
		/datum/job/submap/camp/cook,
		/datum/job/submap/camp/doctor
	)

/decl/hierarchy/outfit/job/psionic
	backpack_overrides = null
	hierarchy_type = /decl/hierarchy/outfit/job/psionic
	uniform = /obj/item/clothing/under/syndicate/tacticool
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = null
	pda_type = null
	back = null
	flags = OUTFIT_RESET_EQUIPMENT

/decl/hierarchy/outfit/job/psionic/student
	uniform = /obj/item/clothing/under/syndicate/tacticool
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = null
	pda_type = null
	back = /obj/item/storage/backpack/satchel/pocketbook/brown
	l_ear = null
	r_pocket = /obj/item/pen
	l_pocket = /obj/item/storage/wallet/random

/decl/hierarchy/outfit/job/psionic/staff
	id_types = null
	pda_type = null
	uniform = /obj/item/clothing/under/lawyer/black
	shoes = /obj/item/clothing/shoes/dress
	glasses = /obj/item/clothing/glasses/prescription
	r_pocket = /obj/item/device/radio/map_preset/psy_school
	l_pocket = /obj/item/storage/wallet/random
	l_ear = /obj/item/device/radio/headset/map_preset/psy_school
	back = /obj/item/storage/backpack/satchel/pocketbook/brown

///BOYS///

/datum/job/submap/camp/ardent
	title = "Ardent Mire"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

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

//SATURIO CUSTOM ITEMS

/obj/item/material/twohanded/sledgehammer/dwarf
	icon = 'icons/fd/items/melee_inventory.dmi'
	icon_state = "hammer_power0"
	base_icon = "hammer_power"
	item_state = "breacher1"

/datum/job/submap/camp/maxim
	title = "Maxim Kuznetsov"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

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

/obj/effect/submap_landmark/spawnpoint/camp/okita
	name = "Okita Takeda"

//OKITA CUSTOM ITEMS

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


/datum/job/submap/camp/numerius
	title = "Numerius De Vigo"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

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

/obj/effect/submap_landmark/spawnpoint/camp/mara
	name = "Mara Sumitomo"

///END///

/datum/job/submap/camp/psionic2
	title = "New Student"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/psionic2
	name = "New Student"

/datum/job/submap/camp/teacher1
	title = "Psionic teacher 1"
	info = "You here to teach some dumbasses how to beat bad guys and not die in progress"
	supervisors = "your fantasy and Void google doc."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff
	total_positions = 1
	loadout_allowed = TRUE
	skill_points = 30

//NAOKI CUSTOM ITEMS

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

/obj/effect/submap_landmark/spawnpoint/camp/teacher1
	name = "Psionic teacher 1"

/datum/job/submap/camp/teacher2
	title = "Psionic teacher 2"
	info = "You here to teach some dumbasses how to beat bad guys and not die in progress"
	supervisors = "your fantasy and Void google doc."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff
	total_positions = 1
	loadout_allowed = TRUE
	skill_points = 30

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

/datum/job/submap/camp/teacher4
	title = "Psionic teacher 4"
	info = "You here to teach some dumbasses how to beat bad guys and not die in progress"
	supervisors = "your fantasy and Void google doc."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff
	total_positions = 1
	loadout_allowed = TRUE
	skill_points = 30

/obj/effect/submap_landmark/spawnpoint/camp/teacher4
	name = "Psionic teacher 4"

/datum/job/submap/camp/doctor
	title = "Doctor"
	info = "You here to heal people, your'e the greatest biomant in this whole place."
	supervisors = "the Hippocratic oath."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff
	total_positions = 1
	loadout_allowed = TRUE
	skill_points = 30

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

/datum/map_template/ruin/away_site/camp
	name = "Jungle Planet"
	id = "awaysite_camp"
	spawn_cost = 1000 //NO BITCHES??
	player_cost = 4
	description = "PSY School with students and teachers. For events only."
	suffixes = list("psycho/school_remake-1.dmm", "psycho/school_remake-2.dmm")
	area_usage_test_exempted_root_areas = list(/area/psionic_school)
	apc_test_exempt_areas = list(
		/area/psionic_school = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/psionic_school/outdoor = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/psionic_school/indoor = NO_SCRUBBER|NO_VENT|NO_APC
	)

/obj/effect/shuttle_landmark/nav_camp/nav1
	name = "Planet Landing Point #1"
	landmark_tag = "nav_camp_1"
	base_area = /area/psionic_school/outdoor

/obj/effect/shuttle_landmark/nav_camp/nav2
	name = "Planet Landing Point #2"
	landmark_tag = "nav_camp_2"
	base_area = /area/psionic_school/outdoor

/obj/effect/shuttle_landmark/nav_camp/nav3
	name = "Planet Navpoint #3"
	landmark_tag = "nav_camp_antag"
	base_area = /area/psionic_school/outdoor

/area/psionic_school
	name = "\improper Camp"
	icon_state = "unknown"
	requires_power = 0
	dynamic_lighting = 1
	base_turf = /turf/unsimulated/floor/exoplanet/barren

/area/psionic_school/outdoor
	name = "\improper Streets"
	icon_state = "dark"
	requires_power = 0
	dynamic_lighting = 1
	sound_env = LARGE_ENCLOSED

/area/psionic_school/indoor
	name = "\improper Indoor"
	icon_state = "red"
	requires_power = 0
	dynamic_lighting = 1

//MAIN BUILDING

/area/psionic_school/indoor/main
	name = "\improper Main Building"

/area/psionic_school/indoor/main/firingrange
	name = "\improper Firing Range"

/area/psionic_school/indoor/main/gym
	name = "\improper Gym"

/area/psionic_school/indoor/main/arena1
	name = "\improper Training Arena 1"

/area/psionic_school/indoor/main/arena2
	name = "\improper Training Arena 2"

/area/psionic_school/indoor/main/arena3
	name = "\improper Training Arena 3"

/area/psionic_school/indoor/main/class1
	name = "\improper Classroom 1"

/area/psionic_school/indoor/main/class2
	name = "\improper Classroom 2"

//OTHER

/area/psionic_school/indoor/train
	name = "\improper Train Station"

/area/psionic_school/indoor/tcomms
	name = "\improper Telecommunications"

/area/psionic_school/indoor/sec
	name = "\improper Security Checkpoint"

/area/psionic_school/indoor/green
	name = "\improper Greenhouse"

/area/psionic_school/indoor/sara
	name = "\improper Sara's Treehouse"

/area/psionic_school/indoor/sara/upper
	base_turf = /turf/simulated/open

//CAMPUS

/area/psionic_school/indoor/campus
	name = "\improper Campus"

/area/psionic_school/indoor/campus/storage
	name = "\improper Storage"

/area/psionic_school/indoor/campus/toilet1
	name = "\improper Restroom 1"

/area/psionic_school/indoor/campus/toilet2
	name = "\improper Restroom 2"

/area/psionic_school/indoor/campus/studentsbath1
	name = "\improper Bath 1"

/area/psionic_school/indoor/campus/studentsbath2
	name = "\improper Bath 2"

/area/psionic_school/indoor/campus/girls
	name = "\improper Girls Block"

/area/psionic_school/indoor/campus/girls/r1
	name = "\improper Girls Block(Room 1)"

/area/psionic_school/indoor/campus/girls/r2
	name = "\improper Girls Block(Room 2)"

/area/psionic_school/indoor/campus/girls/r3
	name = "\improper Girls Block(Room 3)"

/area/psionic_school/indoor/campus/girls/r4
	name = "\improper Girls Block(Room 4)"

/area/psionic_school/indoor/campus/male
	name = "\improper Male Block"

/area/psionic_school/indoor/campus/male/forge
	name = "\improper Male Block(Forge)"

/area/psionic_school/indoor/campus/male/church
	name = "\improper Male Block(Church)"

/area/psionic_school/indoor/campus/male/r1
	name = "\improper Male Block(Room 1)"

/area/psionic_school/indoor/campus/male/r2
	name = "\improper Male Block(Room 2)"

/area/psionic_school/indoor/campus/male/r3
	name = "\improper Male Block(Room 3)"

/area/psionic_school/indoor/campus/male/r4
	name = "\improper Male Block(Room 4)"

/area/psionic_school/indoor/campus/teacherroom1
	name = "\improper Teacher Room 1"

/area/psionic_school/indoor/campus/teacherroom1/toilet

/area/psionic_school/indoor/campus/teacherroom2
	name = "\improper Teacher Room 2"

/area/psionic_school/indoor/campus/teacherroom2/toilet

/area/psionic_school/indoor/campus/teacherroom3
	name = "\improper Teacher Room 3"

/area/psionic_school/indoor/campus/teacherroom3/toilet

/area/psionic_school/indoor/campus/teacherroom4
	name = "\improper Teacher Room 4"

/area/psionic_school/indoor/campus/teacherroom4/toilet

/area/psionic_school/indoor/campus/library
	name = "\improper Library"

/area/psionic_school/indoor/campus/stud_hall
	name = "\improper Campus Hallway(Floor 1)"

/area/psionic_school/indoor/campus/teacher_hall
	name = "\improper Campus Hallway(Floor 2)"

//CAFETERIA

/area/psionic_school/indoor/kitchen
	name = "\improper Kitchen"

/area/psionic_school/indoor/kitchen/canteen
	name = "\improper Canteen"

/area/psionic_school/indoor/kitchen/freezer
	name = "\improper Kitchen Freezer"

/area/psionic_school/indoor/bar
	name = "\improper Bar"

/area/psionic_school/indoor/bar/lounge
	name = "\improper Bar Lounge"

//HOSPITAL

/area/psionic_school/indoor/medbay
	name = "\improper Hospital"

/area/psionic_school/indoor/medbay/breakroom
	name = "\improper Hospital Breakroom"

/area/psionic_school/indoor/medbay/ward1
	name = "\improper Hospital Ward 1"

/area/psionic_school/indoor/medbay/ward2
	name = "\improper Hospital Ward 2"

/area/psionic_school/indoor/medbay/storage
	name = "\improper Hospital Storage"

/area/psionic_school/indoor/medbay/office
	name = "\improper Doctor's Office"

// ACCESS
/var/const/access_camp_teacher1 = "ACCESS_CAMP_TEACHER1"

/datum/access/access_camp_teacher1
	id = access_camp_teacher1
	desc = "Teacher 1"
	region = ACCESS_REGION_NONE

/var/const/access_camp_teacher2 = "ACCESS_CAMP_TEACHER2"

/datum/access/access_camp_teacher2
	id = access_camp_teacher2
	desc = "Teacher 2"
	region = ACCESS_REGION_NONE

/var/const/access_camp_teacher3 = "ACCESS_CAMP_TEACHER3"

/datum/access/access_camp_teacher3
	id = access_camp_teacher3
	desc = "Teacher 3"
	region = ACCESS_REGION_NONE

/var/const/access_camp_teacher4 = "ACCESS_CAMP_TEACHER4"

/datum/access/access_camp_teacher4
	id = access_camp_teacher4
	desc = "Teacher 4"
	region = ACCESS_REGION_NONE

/var/const/access_camp_teacher5 = "ACCESS_CAMP_TEACHER5"

/datum/access/access_camp_teacher5
	id = access_camp_teacher5
	desc = "Teacher 5"
	region = ACCESS_REGION_NONE

/var/const/access_camp_med = "ACCESS_CAMP_MED"

/datum/access/access_camp_med
	id = access_camp_med
	desc = "Teacher"
	region = ACCESS_REGION_NONE
