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

/obj/item/paper/school/journal/on_update_icon()
	return

/obj/item/paper/school/note
	icon = 'icons/fd/items/oddities.dmi'
	icon_state = "paper_crumpled"
	name = "Old note"
	info = "Какой вообще смысл сохранять эти обгорелые трупы? Я имею в виду, разве мы не можем просто развеять их по ветру и не париться?<br>\
			В последнее время, их становится только сложнее прятать - пещера-то не резиновая! Да и мерещится тут всякое. Аж дрожь по коже. Я слышал о том, что эти ребята даже после того как подохнут - продолжают ебать всем мозги, но уже не как люди, а как ссаные проекции. 'Эссенции души' - так их Умник обозвал. Криповая хуйня.<br>\
			Воют так громко, что аж уши закладывает...а на следующей неделе из ЗПА ещё с десяток пришлют. Таких же 'нежелательных' кадров. Тьфу, блять.<br>\
			В следующий раз, как увижусь с боссом, нужно будет перетереть о надбавке для себя и пацанов. Я точно кукухой двинусь за такие копейки работать.<br>"

/obj/item/paper/school/note/on_update_icon()
	return

//ASSETS

/obj/effect/smoke_notimer
	icon_state = "smoke wall"
	anchored = TRUE
	opacity = FALSE
	layer = ABOVE_HUMAN_LAYER
	icon = 'icons/fd/structures/smoke.dmi'
	icon_state = "smoke"
	pixel_x = -9
	pixel_y = -6

/obj/item/clothing/head/helmet/officialninja
	name = "high-tech helmet"
	desc = "An professional mercenary equipment."
	icon = 'icons/fd/custom_items/officialhelmet.dmi'
	item_icons = list(slot_head_str = 'icons/fd/custom_items/officialhelmet_worn.dmi')
	icon_state = "officialhelmet"
	item_state = "officialhelmet"
	body_parts_covered = HEAD|FACE|EYES
	armor = list(
		melee = 40,
		bullet = 40,
		laser = 40,
		energy = 40,
		bomb = 40
		)
	flags_inv = BLOCKHAIR

	var/overrun = 0

/obj/item/clothing/head/helmet/officialninja/AltClick(mob/living/carbon/user)
	. = ..()

	if(overrun == 1)
		icon_state = "officialhelmet"
		item_state = "officialhelmet"
		overrun = 0
		update_clothing_icon()
		return TRUE
	if(overrun == 0)
		icon_state = "officialhelmet_red"
		item_state = "officialhelmet_red"
		overrun = 1
		update_clothing_icon()
		return TRUE

/obj/item/clothing/suit/armor/officialninja
	name = "black coat"
	desc = "A very stylish coat."
	icon = 'icons/fd/custom_items/bladerunner.dmi'
	icon_state = "blackcoat"
	item_icons = list(
		slot_wear_suit_str = 'icons/fd/custom_items/bladerunner_worn.dmi')

	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	armor = list(
		melee = 50,
		bullet = 50,
		laser = 50,
		energy = 50,
		bomb = 50
		)

	var/overrun = 0

/obj/item/clothing/suit/armor/officialninja/AltClick(mob/living/carbon/user)
	. = ..()

	if(overrun == 1)
		icon_state = "blackcoat"
		overrun = 0
		update_clothing_icon()
		return TRUE
	if(overrun == 0)
		icon_state = "blackcoat_overrun"
		overrun = 1
		update_clothing_icon()
		return TRUE

/obj/item/clothing/under/officialninja
	name = "official suit"
	desc = "Black official clothing."
	icon = 'icons/fd/custom_items/officialunder.dmi'
	icon_state = "blacksuit"
	item_icons = list(
		slot_w_uniform_str = 'icons/fd/custom_items/officialunder_worn.dmi')

/obj/item/clothing/suit/armor/butler
	name = "black coat"
	desc = "A very stylish coat."
	icon = 'icons/fd/custom_items/butlercoat.dmi'
	icon_state = "butlercoat"
	item_icons = list(
		slot_wear_suit_str = 'icons/fd/custom_items/butlercoat_worn.dmi')

	body_parts_covered = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS
	armor = list(
		melee = 300,
		bullet = 300,
		laser = 300,
		energy = 300,
		bomb = 300
		)

	gas_transfer_coefficient = 0.90
	permeability_coefficient = 0.50
	heat_protection = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS
	cold_protection = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS

	max_pressure_protection = FIRESUIT_MAX_PRESSURE
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0

/obj/item/clothing/head/helmet/butler
	name = "black hat"
	desc = "An old-fashion hat."
	icon = 'icons/fd/custom_items/butlerhat.dmi'
	item_icons = list(slot_head_str = 'icons/fd/custom_items/butlerhat_worn.dmi')
	icon_state = "butlerhat"
	item_state = "butlerhat"
	body_parts_covered = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS
	armor = list(
		melee = 300,
		bullet = 300,
		laser = 300,
		energy = 300,
		bomb = 300
		)

	gas_transfer_coefficient = 0.90
	permeability_coefficient = 0.50
	heat_protection = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS
	cold_protection = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS

	max_pressure_protection = FIRESUIT_MAX_PRESSURE
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE

	siemens_coefficient = 0

/obj/item/clothing/under/butler
	name = "butler clothing"
	desc = "Black official clothing."
	icon = 'icons/fd/custom_items/butler.dmi'
	icon_state = "butler"
	item_icons = list(
		slot_w_uniform_str = 'icons/fd/custom_items/butler_worn.dmi')

	body_parts_covered = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS
	armor = list(
		melee = 300,
		bullet = 300,
		laser = 300,
		energy = 300,
		bomb = 300
		)

	gas_transfer_coefficient = 0.90
	permeability_coefficient = 0.50
	heat_protection = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS
	cold_protection = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS

	max_pressure_protection = FIRESUIT_MAX_PRESSURE
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE

	siemens_coefficient = 0

/obj/item/clothing/glasses/thermal/plain/monocle/butler

	body_parts_covered = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS
	armor = list(
		melee = 200,
		bullet = 200,
		laser = 200,
		energy = 200,
		bomb = 200
		)

	siemens_coefficient = 0

/obj/item/clothing/mask/killer_ninja
	name = "combat equipment"
	desc = "Black combat utility."
	icon = 'icons/fd/custom_items/ninja.dmi'
	icon_state = "ninja"
	item_icons = list(
		slot_wear_mask_str = 'icons/fd/custom_items/ninja_worn.dmi')

	body_parts_covered = FACE|EYES
	armor = list(
		melee = 30,
		bullet = 30,
		laser = 30,
		energy = 30,
		bomb = 30
		)

/obj/item/clothing/head/helmet/v
	name = "old helmet"
	desc = "An old, rusty helmet with some kind of rebreather builded in."
	icon = 'icons/fd/custom_items/vhelmet.dmi'
	item_icons = list(slot_head_str = 'icons/fd/custom_items/vhelmet_worn.dmi')
	icon_state = "v_respirator"
	item_state = "v_respirator"
	body_parts_covered = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS
	armor = list(
		melee = 300,
		bullet = 300,
		laser = 300,
		energy = 300,
		bomb = 300
		)
	flags_inv = BLOCKHAIR

	gas_transfer_coefficient = 0.90
	permeability_coefficient = 0.50
	heat_protection = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS
	cold_protection = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS

	max_pressure_protection = FIRESUIT_MAX_PRESSURE
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE

	siemens_coefficient = 0

/obj/item/clothing/shoes/ice_boots
	name = "ice boots"
	icon = 'icons/fd/custom_items/icearmor.dmi'
	item_icons = list(slot_shoes_str = 'icons/fd/custom_items/icearmor_worn.dmi')
	icon_state = "iceboots"
	item_state = "iceboots"
	desc = "A very hard-looking ice boots."
	force = 10
	body_parts_covered = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS
	armor = list(
		melee = 200,
		bullet = 200,
		laser = 200,
		energy = 200,
		bomb = 200
		)

/obj/item/clothing/shoes/ice_boots/dropped(var/mob/living/user as mob)
	..()
	Destroy()

/obj/item/clothing/shoes/ice_boots/Destroy()
	playsound(src, "shatter", 70, 1)
	src.visible_message("<span class='danger'>[src] рассыпается на тысячи мелких льдинок!</span>")
	..()

/obj/item/clothing/head/helmet/ice_helmet
	name = "ice helmet"
	desc = "A very hard-looking ice knight helmet."
	icon = 'icons/fd/custom_items/icearmor.dmi'
	item_icons = list(slot_head_str = 'icons/fd/custom_items/icearmor_worn.dmi')
	icon_state = "icehelmet"
	item_state = "icehelmet"
	body_parts_covered = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS
	armor = list(
		melee = 200,
		bullet = 200,
		laser = 200,
		energy = 200,
		bomb = 200
		)
	flags_inv = BLOCKHAIR

/obj/item/clothing/head/helmet/ice_helmet/dropped(var/mob/living/user as mob)
	..()
	Destroy()

/obj/item/clothing/head/helmet/ice_helmet/Destroy()
	playsound(src, "shatter", 70, 1)
	src.visible_message("<span class='danger'>[src] рассыпается на тысячи мелких льдинок!</span>")
	..()

/obj/item/clothing/suit/armor/ice_plate
	name = "ice armor"
	desc = "A very hard-looking ice plate."
	icon = 'icons/fd/custom_items/icearmor.dmi'
	icon_state = "iceplate"
	item_icons = list(
		slot_wear_suit_str = 'icons/fd/custom_items/icearmor_worn.dmi')

	body_parts_covered = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS
	armor = list(
		melee = 200,
		bullet = 200,
		laser = 200,
		energy = 200,
		bomb = 200
		)

	gas_transfer_coefficient = 0.90
	permeability_coefficient = 0.50
	heat_protection = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS
	cold_protection = HEAD|FACE|EYES|UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|FEET|HANDS

	max_pressure_protection = FIRESUIT_MAX_PRESSURE
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0

/obj/item/clothing/suit/armor/ice_plate/dropped(var/mob/living/user as mob)
	..()
	Destroy()

/obj/item/clothing/suit/armor/ice_plate/Destroy()
	playsound(src, "shatter", 70, 1)
	src.visible_message("<span class='danger'>[src] рассыпается на тысячи мелких льдинок!</span>")
	..()

/obj/item/clothing/suit/storage/vest/practice
	name = "practice vest"
	desc = "Semi-green battle armor with light plates."
	icon = 'icons/fd/shiptest/armor.dmi'
	icon_state = "vest_stealth"
	item_icons = list(
		slot_wear_suit_str = 'icons/fd/shiptest/onmob/armor.dmi')

/obj/item/clothing/under/practice
	name = "practice clothing"
	desc = "Black tactical suit for training."
	icon = 'icons/fd/shiptest/syndicate.dmi'
	icon_state = "practice"
	item_icons = list(
		slot_w_uniform_str = 'icons/fd/mob/onmob_under.dmi')

/obj/item/fd/fake_melee
	name = "melee"
	desc = "An old weaponry, very rare and valuable."
	icon = 'icons/fd/items/weapons.dmi'
	icon_state = "tribunalknife"
	w_class = ITEM_SIZE_SMALL

/obj/item/fd/fake_melee/halberd
	name = "old halberd"
	desc = "An old weaponry, very rare and valuable."
	icon_state = "halberd"

/obj/item/fd/fake_melee/sbastard
	name = "old bastard sword"
	desc = "An old weaponry, very rare and valuable."
	icon_state = "sbastard"

/obj/item/fd/fake_melee/gladius
	name = "old gladius"
	desc = "An old weaponry, very rare and valuable."
	icon_state = "gladius"

/obj/item/fd/fake_melee/bardiche
	name = "old bardiche"
	desc = "An old weaponry, very rare and valuable."
	icon_state = "bardiche"

/obj/item/fd/fake_melee/sabre
	name = "old sabre"
	desc = "An old weaponry, very rare and valuable."
	icon_state = "sabre"

/obj/item/fd/fake_melee/rapier
	name = "old rapier"
	desc = "An old weaponry, very rare and valuable."
	icon_state = "rapier"

/obj/item/fd/fake_melee/klevec
	name = "old klevec"
	desc = "An old weaponry, very rare and valuable."
	icon_state = "klevec"

/obj/item/fd/fake_melee/scimitar
	name = "old scimitar"
	desc = "An old weaponry, very rare and valuable."
	icon_state = "scimitar"

/obj/random/flora/school
	name = "random flora spawn"
	desc = "This is a random flora spawner."
	icon_state = "trees"
	spawn_nothing_percentage = 50

/obj/random/flora/school/spawn_choices()
	return list(/obj/structure/flora/tree/jungle,
				/obj/structure/flora/tree/jungle/small,
				/obj/structure/flora/ausbushes/brflowers,
				/obj/structure/flora/ausbushes/brflowers,
				/obj/structure/flora/ausbushes/fullgrass,
				/obj/structure/flora/ausbushes/grassybush,
				/obj/structure/flora/ausbushes/lavendergrass,
				/obj/structure/flora/ausbushes/ppflowers,
				/obj/structure/flora/ausbushes/sparsegrass,
				/obj/structure/flora/ausbushes/ywflowers,
				/obj/structure/flora/ausbushes/genericbush,
				/obj/structure/flora/ausbushes/sunnybush,
				/obj/structure/flora/ausbushes/lavendergrass,
				/obj/structure/flora/ausbushes/sunnybush,
				/obj/structure/flora/ausbushes/fullgrass,
				/obj/item/reagent_containers/food/snacks/grown/berries,
				/obj/structure/flora/ausbushes/ywflowers,
				/obj/item/reagent_containers/food/snacks/grown/mushroom/libertycap,
				/obj/item/reagent_containers/food/snacks/grown/poisonberries,
				/obj/item/reagent_containers/food/snacks/grown/apple,
				/obj/structure/flora/tree/jungle/small,
				/obj/structure/flora/tropic/rock,
				/obj/structure/flora/jungle/bush)

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

/obj/structure/closet/secure_closet/freezer/fridge/empty
	name = "refrigerator"
	icon = 'icons/obj/closets/fridge.dmi'
	closet_appearance = null

/obj/structure/closet/secure_closet/freezer/fridge/empty/WillContain()
	return list()

/obj/item/card/id/school
	name = "\improper Larivien's warrant card"
	desc = "A warrant card in a handsome leather case."
	icon_state = "warrantcard"
	assignment = "Cook"
	job_access_type = /datum/job/submap/camp/cook

/obj/item/card/id/school/on_update_icon()
	return

/obj/item/card/id/school/yano
	name = "\improper Curator Yano's warrant card"
	assignment = "Curator"
	job_access_type = null

/obj/item/card/id/school/yano/New()
	..()
	access |= get_all_station_access()

/obj/item/card/id/school/morvar
	name = "\improper Morvar's warrant card"
	assignment = "OII Agent"
	job_access_type = /datum/job/submap/camp/teacher2

/obj/item/card/id/school/dianthus
	name = "\improper Teacher Dianthus's warrant card"
	assignment = "Teacher"
	job_access_type = /datum/job/submap/camp/doctor
