#include "school_radio.dm"
#include "school_mobs.dm"

/obj/machinery/vending/npc
	shut_up = 0
	slogan_delay = 10
	use_power = 0
	icon = 'icons/mob/human_races/species/human/npc.dmi'
	icon_state = "preview"

/obj/machinery/vending/attackby(obj/item/W as obj, var/mob/living/user as mob)

	var/obj/item/card/id/I = W.GetIdCard()

	if (currently_vending && vendor_account && !vendor_account.suspended)
		var/paid = 0
		var/handled = 0

		if (I) //for IDs and PDAs and wallets with IDs
			paid = pay_with_card(I,W)
			handled = 1
		else if (istype(W, /obj/item/spacecash/ewallet))
			var/obj/item/spacecash/ewallet/C = W
			paid = pay_with_ewallet(C)
			handled = 1
		else if (istype(W, /obj/item/spacecash/bundle))
			var/obj/item/spacecash/bundle/C = W
			paid = pay_with_cash(C)
			handled = 1

		if(paid)
			src.vend(currently_vending, usr)
			return TRUE
		else if(handled)
			SSnano.update_uis(src)
			return TRUE // don't smack that machine with your 2 thalers

	if (I || istype(W, /obj/item/spacecash))
		attack_hand(user)
		return TRUE
	if(istype(W, /obj/item/material/coin) && premium.len > 0)
		if(!user.unEquip(W, src))
			return FALSE
		coin = W
		categories |= CAT_COIN
		to_chat(user, "<span class='notice'>You insert \the [W] into \the [src].</span>")
		SSnano.update_uis(src)
		return TRUE
	if((user.a_intent == I_HELP) && attempt_to_stock(W, user))
		return TRUE
	if((. = component_attackby(W, user)))
		return

/obj/machinery/vending/npc/emag_act()
	return

/obj/machinery/vending/npc/on_update_icon()
	return

/obj/machinery/vending/npc/police
	name = "Policeman"
	desc = "The one who protects you."
	icon_state = "npc_police"
	product_slogans = "Когда уже перерыв...;Интересно, как там дома?;Уже шестое исчезновение за неделю и ни одной зацепки...;Эй! Позовите сюда Майка!;Нужно отнести это дело шефу в офис.;Надеюсь, я успею закончить отчёт до конца смены...не хочу сидеть сверхурочные.;Вечером по пивку, а?;Думаю, стоит сделать перекур.;У кого-нибудь есть лишний листок?;Какой же бардак...;Я так устал...;Мне действительно стоит поговорить с боссом об отпуске, это перебор;Пу-пу-пу-у..."
	product_ads = "Я занят.;Обратитесь ко мне позже.;У вас нет других дел?;Отвалите...;Найдите себе занятие получше.;Ну?;Что вам нужно?;Что вы здесь забыли?"

/obj/machinery/vending/npc/civilian
	name = "Random Citizen"
	desc = "The one who don't like you."

/obj/machinery/vending/npc/civilian/punk
	name = "Street Punk"
	icon_state = "npc_civilian5"
	product_slogans = "Хорошего прикура!;Братан, да у меня лучшее курево в городе!;Что, решил курнуть?;Давай-давай! Никотиновый рай уже заждался тебя!;Кстати, могу посоветовать отличного кальянщика..."
	products = list(
					/obj/item/storage/cigpaper/filters = 5,
					/obj/item/storage/cigpaper = 3,
					/obj/item/storage/cigpaper/fancy = 2,
					/obj/item/storage/chewables/rollable/bad = 2,
					/obj/item/storage/chewables/rollable/generic = 2,
					/obj/item/storage/chewables/rollable/fine = 2,
					/obj/item/storage/fancy/cigarettes = 5,
					/obj/item/storage/fancy/cigarettes/luckystars = 2,
					/obj/item/storage/fancy/cigarettes/jerichos = 2,
					/obj/item/storage/fancy/cigarettes/menthols = 2,
					/obj/item/storage/fancy/cigarettes/carcinomas = 2,
					/obj/item/storage/fancy/cigarettes/professionals = 2,
					/obj/item/storage/fancy/cigarettes/cigarello = 2,
					/obj/item/storage/fancy/cigarettes/cigarello/mint = 2,
					/obj/item/storage/fancy/cigarettes/cigarello/variety = 2,
					/obj/item/storage/box/matches = 10,
					/obj/item/flame/lighter/random = 4,
					/obj/item/storage/chewables/tobacco = 2,
					/obj/item/storage/chewables/tobacco2 = 2,
					/obj/item/storage/chewables/tobacco3 = 2,
					/obj/item/clothing/mask/smokable/ecig/simple = 10,
					/obj/item/clothing/mask/smokable/ecig/util = 5,
					/obj/item/clothing/mask/smokable/ecig/deluxe = 1,
					/obj/item/reagent_containers/ecig_cartridge/med_nicotine = 10,
					/obj/item/reagent_containers/ecig_cartridge/high_nicotine = 5,
					/obj/item/reagent_containers/ecig_cartridge/orange = 5,
					/obj/item/reagent_containers/ecig_cartridge/mint = 5,
					/obj/item/reagent_containers/ecig_cartridge/watermelon = 5,
					/obj/item/reagent_containers/ecig_cartridge/grape = 5,
					/obj/item/reagent_containers/ecig_cartridge/lemonlime = 5,
					/obj/item/reagent_containers/ecig_cartridge/coffee = 5,
					/obj/item/reagent_containers/ecig_cartridge/blanknico = 2,
					/obj/item/flame/lighter/zippo = 4,
					/obj/item/storage/fancy/cigar = 5)

	prices = list(
					/obj/item/flame/lighter/zippo = 80,
					/obj/item/storage/fancy/cigar = 50,
					/obj/item/storage/chewables/tobacco = 40,
					/obj/item/storage/chewables/tobacco2 = 50,
					/obj/item/storage/chewables/tobacco3 = 60,
					/obj/item/storage/cigpaper/filters = 5,
					/obj/item/storage/cigpaper = 8,
					/obj/item/storage/cigpaper/fancy = 12,
					/obj/item/storage/chewables/rollable/bad = 20,
					/obj/item/storage/chewables/rollable/generic = 40,
					/obj/item/storage/chewables/rollable/fine = 60,
					/obj/item/storage/fancy/cigarettes = 45,
					/obj/item/storage/fancy/cigarettes/luckystars = 50,
					/obj/item/storage/fancy/cigarettes/jerichos = 65,
					/obj/item/storage/fancy/cigarettes/menthols = 55,
					/obj/item/storage/fancy/cigarettes/carcinomas = 65,
					/obj/item/storage/fancy/cigarettes/professionals = 70,
					/obj/item/storage/fancy/cigarettes/cigarello = 85,
					/obj/item/storage/fancy/cigarettes/cigarello/mint = 85,
					/obj/item/storage/fancy/cigarettes/cigarello/variety = 85,
					/obj/item/storage/box/matches = 2,
					/obj/item/flame/lighter/random = 5,
					/obj/item/clothing/mask/smokable/ecig/simple = 50,
					/obj/item/clothing/mask/smokable/ecig/util = 100,
					/obj/item/clothing/mask/smokable/ecig/deluxe = 250,
					/obj/item/reagent_containers/ecig_cartridge/med_nicotine = 15,
					/obj/item/reagent_containers/ecig_cartridge/high_nicotine = 15,
					/obj/item/reagent_containers/ecig_cartridge/orange = 15,
					/obj/item/reagent_containers/ecig_cartridge/mint = 15,
					/obj/item/reagent_containers/ecig_cartridge/watermelon = 15,
					/obj/item/reagent_containers/ecig_cartridge/grape = 15,
					/obj/item/reagent_containers/ecig_cartridge/lemonlime = 15,
					/obj/item/reagent_containers/ecig_cartridge/coffee = 15,
					/obj/item/reagent_containers/ecig_cartridge/blanknico = 15)

/obj/machinery/vending/npc/civilian/engineer
	name = "Mechanic"
	product_slogans = "Да-да, а теперь проваливай!;Я работаю, не видишь? Бери что нужно и вали.;Гр-р...;Спасибо за покупку, а теперь попрошу покинуть поле моего зрения.;Ага...оставьте деньги на столе."
	slogan_delay = 20
	icon_state = "npc_civilian6"
	products = list(/obj/item/reagent_containers/food/drinks/bottle/oiljug = 6,
					/obj/item/storage/belt/utility = 4,/obj/item/clothing/glasses/meson = 4,/obj/item/clothing/gloves/insulated = 4, /obj/item/screwdriver = 12,
					/obj/item/crowbar = 12,/obj/item/wirecutters = 12,/obj/item/device/multitool = 12,/obj/item/wrench = 12,/obj/item/device/t_scanner = 12,
					/obj/item/cell/standard = 8, /obj/item/weldingtool = 8,/obj/item/clothing/head/welding = 8,
					/obj/item/light/tube = 10,/obj/item/stock_parts/scanning_module = 5,/obj/item/stock_parts/micro_laser = 5,
					/obj/item/stock_parts/matter_bin = 5,/obj/item/stock_parts/manipulator = 5,/obj/item/stock_parts/console_screen = 5,
					/obj/item/stock_parts/capacitor = 5, /obj/item/stock_parts/keyboard = 5, /obj/item/stock_parts/power/apc/buildable = 5,
					/obj/item/cell/high = 5, /obj/item/airlock_electronics = 10, /obj/item/module/power_control = 10, /obj/item/stack/cable_coil = 5)
	prices = list(
					/obj/item/reagent_containers/food/drinks/bottle/oiljug = 20,
					/obj/item/storage/belt/utility = 20,
					/obj/item/clothing/glasses/meson = 100,
					/obj/item/clothing/gloves/insulated = 50,
					/obj/item/screwdriver = 10,
					/obj/item/crowbar = 10,
					/obj/item/wirecutters = 10,
					/obj/item/device/multitool = 100,
					/obj/item/wrench = 10,
					/obj/item/device/t_scanner = 50,
					/obj/item/cell/standard = 50,
					/obj/item/weldingtool = 20,
					/obj/item/clothing/head/welding = 20,
					/obj/item/light/tube = 5,
					/obj/item/stock_parts/scanning_module = 35,
					/obj/item/stock_parts/micro_laser = 50,
					/obj/item/stock_parts/matter_bin = 35,
					/obj/item/stock_parts/console_screen = 35,
					/obj/item/stock_parts/manipulator = 35,
					/obj/item/stock_parts/capacitor = 50,
					/obj/item/stock_parts/keyboard = 15,
					/obj/item/stock_parts/power/apc/buildable = 50,
					/obj/item/cell/high = 100,
					/obj/item/airlock_electronics = 50,
					/obj/item/module/power_control = 50,
					/obj/item/stack/cable_coil = 20)

/obj/machinery/vending/npc/civilian/swordsman
	name = "Swordsman"
	slogan_delay = 20
	icon_state = "npc_civilian2"
	product_slogans = "Надеюсь, вы найдёте ему достойное применение;Прошу, осторожней, эта сталь древнее Терранского Содружества.;Благодарю за покупку.;Хороший выбор.;Надеюсь, это станет отличным дополнением к вашей коллекции."

	products = list(
					/obj/item/fd/fake_melee/halberd = 3,
					/obj/item/fd/fake_melee/sbastard = 3,
					/obj/item/fd/fake_melee/gladius = 3,
					/obj/item/fd/fake_melee/bardiche = 3,
					/obj/item/fd/fake_melee/sabre = 3,
					/obj/item/fd/fake_melee/rapier = 3,
					/obj/item/fd/fake_melee/klevec = 3,
					/obj/item/fd/fake_melee/scimitar = 3)

	prices = list(
					/obj/item/fd/fake_melee/halberd = 100,
					/obj/item/fd/fake_melee/sbastard = 100,
					/obj/item/fd/fake_melee/gladius = 100,
					/obj/item/fd/fake_melee/bardiche = 100,
					/obj/item/fd/fake_melee/sabre = 100,
					/obj/item/fd/fake_melee/rapier = 100,
					/obj/item/fd/fake_melee/klevec = 100,
					/obj/item/fd/fake_melee/scimitar = 100)

/obj/machinery/vending/npc/civilian/clothtrader
	name = "Boutique Owner"
	icon_state = "npc_civilian4"
	slogan_delay = 20
	product_slogans = "Отличный выбор!;Этот костюм будет смотреться на вас просто отлично!;Хорошего вам дня!;Благодарю за покупку!;У вас отличный вкус!"

	products = list(
		/obj/item/clothing/under/color = 3,
		/obj/item/clothing/under/shortjumpskirt = 3,
		/obj/item/clothing/under/color/blackjumpshorts = 3,
		/obj/item/clothing/under/sl_suit = 3,
		/obj/item/clothing/under/suit_jacket = 3,
		/obj/item/clothing/under/suit_jacket/burgundy = 3,
		/obj/item/clothing/under/suit_jacket/charcoal = 3,
		/obj/item/clothing/under/suit_jacket/checkered = 3,
		/obj/item/clothing/under/suit_jacket/really_black = 3,
		/obj/item/clothing/under/suit_jacket/female = 3,
		/obj/item/clothing/under/gentlesuit = 3,
		/obj/item/clothing/under/suit_jacket/navy = 3,
		/obj/item/clothing/under/lawyer/oldman = 3,
		/obj/item/clothing/under/lawyer/purpsuit = 3,
		/obj/item/clothing/under/suit_jacket/red = 3,
		/obj/item/clothing/under/lawyer/red = 3,
		/obj/item/clothing/under/lawyer/black = 3,
		/obj/item/clothing/under/suit_jacket/tan = 3,
		/obj/item/clothing/under/scratch = 3,
		/obj/item/clothing/under/lawyer/bluesuit = 3,
		/obj/item/clothing/under/blazer = 3,
		/obj/item/clothing/under/blackjumpskirt = 3,
		/obj/item/clothing/under/kilt = 3,
		/obj/item/clothing/under/sundress_white = 3,
		/obj/item/clothing/under/dress/dress_fire = 3,
		/obj/item/clothing/under/dress/dress_green = 3,
		/obj/item/clothing/under/dress/dress_orange = 3,
		/obj/item/clothing/under/dress/dress_pink = 3,
		/obj/item/clothing/under/dress/dress_purple = 3,
		/obj/item/clothing/under/sundress = 3,
		/obj/item/clothing/suit/storage/toggle/hoodie/cti = 3,
		/obj/item/clothing/suit/storage/toggle/hoodie/mu = 3,
		/obj/item/clothing/suit/storage/toggle/hoodie/nt = 3,
		/obj/item/clothing/suit/storage/toggle/hoodie/smw = 3,
		/obj/item/clothing/suit/storage/toggle/bomber = 3,
		/obj/item/clothing/suit/storage/leather_jacket/nanotrasen = 3,
		/obj/item/clothing/suit/storage/toggle/brown_jacket/nanotrasen = 3,
		/obj/item/clothing/suit/storage/leather_jacket = 3,
		/obj/item/clothing/suit/storage/toggle/brown_jacket = 3,
		/obj/item/clothing/suit/storage/mbill = 3,
		/obj/item/clothing/glasses/green = 3,
		/obj/item/clothing/glasses/hipster = 3,
		/obj/item/clothing/glasses/sunglasses = 3,
		/obj/item/clothing/glasses/aviators_black = 3,
		/obj/item/clothing/glasses/aviators_silver = 3,
		/obj/item/clothing/glasses/aviators_gold = 3,
		/obj/item/clothing/glasses/aviators_rose = 3,
		/obj/item/clothing/shoes/jackboots = 3,
		/obj/item/clothing/shoes/workboots = 3,
		/obj/item/clothing/shoes/dutyboots = 3,
		/obj/item/clothing/shoes/jungleboots = 3,
		/obj/item/clothing/shoes/desertboots = 3,
		/obj/item/clothing/shoes/black = 3,
		/obj/item/clothing/shoes/blue = 3,
		/obj/item/clothing/shoes/brown = 3,
		/obj/item/clothing/shoes/laceup = 3,
		/obj/item/clothing/shoes/dress/white = 3,
		/obj/item/clothing/shoes/green = 3,
		/obj/item/clothing/shoes/leather = 3,
		/obj/item/clothing/shoes/orange = 3,
		/obj/item/clothing/shoes/purple = 3,
		/obj/item/clothing/shoes/rainbow = 3,
		/obj/item/clothing/shoes/red = 3,
		/obj/item/clothing/shoes/white = 3,
		/obj/item/clothing/shoes/yellow = 3,
		/obj/item/clothing/gloves/color/evening = 3,
		/obj/item/clothing/head/soft/black = 3,
		/obj/item/clothing/head/soft/blue = 3,
		/obj/item/clothing/head/soft/green = 3,
		/obj/item/clothing/head/soft/grey = 3,
		/obj/item/clothing/head/mailman = 3,
		/obj/item/clothing/head/soft/orange = 3,
		/obj/item/clothing/head/soft/purple = 3,
		/obj/item/clothing/head/soft/rainbow = 3,
		/obj/item/clothing/head/soft/red = 3,
		/obj/item/clothing/head/soft/mime = 3,
		/obj/item/clothing/head/soft/yellow = 3,
		/obj/item/clothing/head/hairflower = 3,
		/obj/item/clothing/head/hairflower/blue = 3,
		/obj/item/clothing/head/hairflower/pink = 3,
		/obj/item/clothing/head/hairflower/yellow = 3,
		/obj/item/clothing/head/boaterhat = 3,
		/obj/item/clothing/head/bowler = 3,
		/obj/item/clothing/head/fedora = 3,
		/obj/item/clothing/head/feathertrilby = 3,
		/obj/item/clothing/head/fez = 3,
		/obj/item/clothing/head/that = 3,
		/obj/item/clothing/head/det = 3,
		/obj/item/clothing/head/det/grey = 3,
		/obj/item/clothing/head/panama = 3
	)
	prices = list(
		/obj/item/clothing/under/color = 30,
		/obj/item/clothing/under/shortjumpskirt = 30,
		/obj/item/clothing/under/color/blackjumpshorts = 30,
		/obj/item/clothing/under/sl_suit = 30,
		/obj/item/clothing/under/suit_jacket = 30,
		/obj/item/clothing/under/suit_jacket/burgundy = 30,
		/obj/item/clothing/under/suit_jacket/charcoal = 30,
		/obj/item/clothing/under/suit_jacket/checkered = 30,
		/obj/item/clothing/under/suit_jacket/really_black = 30,
		/obj/item/clothing/under/suit_jacket/female = 30,
		/obj/item/clothing/under/gentlesuit = 30,
		/obj/item/clothing/under/suit_jacket/navy = 30,
		/obj/item/clothing/under/lawyer/oldman = 30,
		/obj/item/clothing/under/lawyer/purpsuit = 30,
		/obj/item/clothing/under/suit_jacket/red = 30,
		/obj/item/clothing/under/lawyer/red = 30,
		/obj/item/clothing/under/lawyer/black = 30,
		/obj/item/clothing/under/suit_jacket/tan = 30,
		/obj/item/clothing/under/scratch = 30,
		/obj/item/clothing/under/lawyer/bluesuit = 30,
		/obj/item/clothing/under/blazer = 30,
		/obj/item/clothing/under/blackjumpskirt = 30,
		/obj/item/clothing/under/kilt = 30,
		/obj/item/clothing/under/sundress_white = 30,
		/obj/item/clothing/under/dress/dress_fire = 30,
		/obj/item/clothing/under/dress/dress_green = 30,
		/obj/item/clothing/under/dress/dress_orange = 30,
		/obj/item/clothing/under/dress/dress_pink = 30,
		/obj/item/clothing/under/dress/dress_purple = 30,
		/obj/item/clothing/under/sundress = 30,
		/obj/item/clothing/suit/storage/toggle/hoodie/cti = 30,
		/obj/item/clothing/suit/storage/toggle/hoodie/mu = 30,
		/obj/item/clothing/suit/storage/toggle/hoodie/nt = 30,
		/obj/item/clothing/suit/storage/toggle/hoodie/smw = 30,
		/obj/item/clothing/suit/storage/toggle/bomber = 30,
		/obj/item/clothing/suit/storage/leather_jacket/nanotrasen = 30,
		/obj/item/clothing/suit/storage/toggle/brown_jacket/nanotrasen = 30,
		/obj/item/clothing/suit/storage/leather_jacket = 30,
		/obj/item/clothing/suit/storage/toggle/brown_jacket = 30,
		/obj/item/clothing/suit/storage/mbill = 30,
		/obj/item/clothing/glasses/green = 30,
		/obj/item/clothing/glasses/hipster = 30,
		/obj/item/clothing/glasses/sunglasses = 30,
		/obj/item/clothing/glasses/aviators_black = 30,
		/obj/item/clothing/glasses/aviators_silver = 30,
		/obj/item/clothing/glasses/aviators_gold = 30,
		/obj/item/clothing/glasses/aviators_rose = 30,
		/obj/item/clothing/shoes/jackboots = 30,
		/obj/item/clothing/shoes/workboots = 30,
		/obj/item/clothing/shoes/dutyboots = 30,
		/obj/item/clothing/shoes/black = 30,
		/obj/item/clothing/shoes/blue = 30,
		/obj/item/clothing/shoes/brown = 30,
		/obj/item/clothing/shoes/laceup = 30,
		/obj/item/clothing/shoes/dress/white = 30,
		/obj/item/clothing/shoes/green = 30,
		/obj/item/clothing/shoes/leather = 30,
		/obj/item/clothing/shoes/orange = 30,
		/obj/item/clothing/shoes/purple = 30,
		/obj/item/clothing/shoes/rainbow = 30,
		/obj/item/clothing/shoes/red = 30,
		/obj/item/clothing/shoes/white = 30,
		/obj/item/clothing/shoes/yellow = 30,
		/obj/item/clothing/gloves/color/evening = 30,
		/obj/item/clothing/head/soft/black = 30,
		/obj/item/clothing/head/soft/blue = 30,
		/obj/item/clothing/head/soft/green = 30,
		/obj/item/clothing/head/soft/grey = 30,
		/obj/item/clothing/head/mailman = 30,
		/obj/item/clothing/head/soft/orange = 30,
		/obj/item/clothing/head/soft/purple = 30,
		/obj/item/clothing/head/soft/rainbow = 30,
		/obj/item/clothing/head/soft/red = 30,
		/obj/item/clothing/head/soft/mime = 30,
		/obj/item/clothing/head/soft/yellow = 30,
		/obj/item/clothing/head/hairflower = 30,
		/obj/item/clothing/head/hairflower/blue = 30,
		/obj/item/clothing/head/hairflower/pink = 30,
		/obj/item/clothing/head/hairflower/yellow = 30,
		/obj/item/clothing/head/boaterhat = 30,
		/obj/item/clothing/head/bowler = 30,
		/obj/item/clothing/head/fedora = 30,
		/obj/item/clothing/head/feathertrilby = 30,
		/obj/item/clothing/head/fez = 30,
		/obj/item/clothing/head/that = 30,
		/obj/item/clothing/head/det = 30,
		/obj/item/clothing/head/det/grey = 30,
		/obj/item/clothing/head/panama = 30
	)

/obj/machinery/vending/npc/civilian/armyman
	name = "Mil-shop Owner"
	icon_state = "npc_civilian1"
	slogan_delay = 20
	product_slogans = "Вообще...я продаю кое-что более деликатное - но не говори копам!;Что? На страйкбол собираетесь?;Смотрите не махайте этим где попало - а то попадёт мне.;Отличная сделка.;У нас только самый лучший товар!"

	products = list(
					/obj/item/tape_roll = 10,
					/obj/item/storage/toolbox/syndicate = 5,
					/obj/item/storage/belt/security = 5,
					/obj/item/storage/belt/holster/machete = 5,
					/obj/item/storage/belt/holster/security/tactical = 5,
					/obj/item/storage/backpack/rucksack/green = 10,
					/obj/item/reagent_containers/food/drinks/glass2/fitnessflask/proteinshake = 10,
					/obj/item/organ/internal/augment/active/item/powerfist = 2,
					/obj/item/melee/telebaton = 2,
					/obj/item/storage/box/handcuffs = 5,
					/obj/item/gun/projectile/flare/loaded = 2,
					/obj/item/gun/launcher/net = 2,
					/obj/item/gun/projectile/shotgun/pump/exploration = 2,
					/obj/item/device/flash = 5,
					/obj/item/device/binoculars = 10,
					/obj/item/ammo_magazine/shotholder/net = 20,
					/obj/item/ammo_magazine/shotholder/stun = 20,
					/obj/item/ammo_magazine/shotholder/beanbag = 20,
					/obj/item/organ/internal/augment/active/item/armblade = 2,
					/obj/item/clothing/under/solgov/utility/army/urban = 10,
					/obj/item/clothing/under/solgov/utility/army/tan = 10,
					/obj/item/clothing/under/solgov/utility/army = 10)

	prices = list(
					/obj/item/tape_roll = 5,
					/obj/item/storage/toolbox/syndicate = 30,
					/obj/item/storage/belt/security = 20,
					/obj/item/storage/belt/holster/machete = 20,
					/obj/item/storage/belt/holster/security/tactical = 20,
					/obj/item/storage/backpack/rucksack/green = 25,
					/obj/item/reagent_containers/food/drinks/glass2/fitnessflask/proteinshake = 15,
					/obj/item/organ/internal/augment/active/item/powerfist = 120,
					/obj/item/melee/telebaton = 50,
					/obj/item/storage/box/handcuffs = 20,
					/obj/item/gun/projectile/flare/loaded = 35,
					/obj/item/gun/launcher/net = 100,
					/obj/item/gun/projectile/shotgun/pump/exploration = 150,
					/obj/item/device/flash = 50,
					/obj/item/device/binoculars = 50,
					/obj/item/ammo_magazine/shotholder/net = 20,
					/obj/item/ammo_magazine/shotholder/stun = 20,
					/obj/item/ammo_magazine/shotholder/beanbag = 20,
					/obj/item/organ/internal/augment/active/item/armblade = 120,
					/obj/item/clothing/under/solgov/utility/army/urban = 20,
					/obj/item/clothing/under/solgov/utility/army/tan = 20,
					/obj/item/clothing/under/solgov/utility/army = 20)

/obj/machinery/vending/npc/civilian/coffeshop
	name = "Cashier"
	icon_state = "npc_civilian3"

	products = list(
					/obj/item/reagent_containers/food/snacks/aesirsalad = 5,
					/obj/item/reagent_containers/food/snacks/applepie = 5,
					/obj/item/reagent_containers/food/snacks/bananapie = 5,
					/obj/item/reagent_containers/food/snacks/caesar_salad = 5,
					/obj/item/reagent_containers/food/snacks/cherrypie = 5,
					/obj/item/reagent_containers/food/snacks/citrusdelight = 5,
					/obj/item/reagent_containers/food/snacks/dionaroast = 5,
					/obj/item/reagent_containers/food/snacks/donut/normal = 10,
					/obj/item/reagent_containers/food/snacks/enchiladas = 5,
					/obj/item/reagent_containers/food/snacks/fishburger = 10,
					/obj/item/reagent_containers/food/snacks/fries = 10,
					/obj/item/reagent_containers/food/snacks/fruitsalad = 5,
					/obj/item/reagent_containers/food/snacks/greek_salad = 5,
					/obj/item/reagent_containers/food/snacks/hamburger = 10,
					/obj/item/reagent_containers/food/snacks/hotdog = 10,
					/obj/item/reagent_containers/food/snacks/icecream = 10,
					/obj/item/reagent_containers/food/snacks/loadedbakedpotato = 5,
					/obj/item/reagent_containers/food/snacks/meatpie = 5,
					/obj/item/reagent_containers/food/snacks/milosoup = 5,
					/obj/item/reagent_containers/food/snacks/omelette = 5,
					/obj/item/reagent_containers/food/snacks/pancakes = 5,
					/obj/item/reagent_containers/food/snacks/sandwich = 10,
					/obj/item/reagent_containers/food/snacks/taco = 10,
					/obj/item/reagent_containers/food/snacks/tomatosoup = 5,
					/obj/item/reagent_containers/food/snacks/vegetablesoup = 5,
					/obj/item/reagent_containers/food/snacks/waffles = 5,
					/obj/item/reagent_containers/food/drinks/tea/black = 10,
					/obj/item/reagent_containers/food/drinks/tea/green = 10,
					/obj/item/reagent_containers/food/drinks/coffee = 10,
					/obj/item/reagent_containers/food/drinks/bottle/lemonjuice = 10,
					/obj/item/reagent_containers/food/drinks/bottle/limejuice = 10,
					/obj/item/reagent_containers/food/drinks/bottle/orangejuice = 10)

	prices = list(
					/obj/item/reagent_containers/food/snacks/aesirsalad = 50,
					/obj/item/reagent_containers/food/snacks/applepie = 30,
					/obj/item/reagent_containers/food/snacks/bananapie = 30,
					/obj/item/reagent_containers/food/snacks/caesar_salad = 50,
					/obj/item/reagent_containers/food/snacks/cherrypie = 30,
					/obj/item/reagent_containers/food/snacks/citrusdelight = 30,
					/obj/item/reagent_containers/food/snacks/dionaroast = 80,
					/obj/item/reagent_containers/food/snacks/donut/normal = 10,
					/obj/item/reagent_containers/food/snacks/enchiladas = 30,
					/obj/item/reagent_containers/food/snacks/fishburger = 30,
					/obj/item/reagent_containers/food/snacks/fries = 10,
					/obj/item/reagent_containers/food/snacks/fruitsalad = 30,
					/obj/item/reagent_containers/food/snacks/greek_salad = 30,
					/obj/item/reagent_containers/food/snacks/hamburger = 30,
					/obj/item/reagent_containers/food/snacks/hotdog = 30,
					/obj/item/reagent_containers/food/snacks/icecream = 10,
					/obj/item/reagent_containers/food/snacks/loadedbakedpotato = 50,
					/obj/item/reagent_containers/food/snacks/meatpie = 50,
					/obj/item/reagent_containers/food/snacks/milosoup = 80,
					/obj/item/reagent_containers/food/snacks/omelette = 30,
					/obj/item/reagent_containers/food/snacks/pancakes = 30,
					/obj/item/reagent_containers/food/snacks/sandwich = 30,
					/obj/item/reagent_containers/food/snacks/taco = 30,
					/obj/item/reagent_containers/food/snacks/tomatosoup = 30,
					/obj/item/reagent_containers/food/snacks/vegetablesoup = 30,
					/obj/item/reagent_containers/food/snacks/waffles = 30,
					/obj/item/reagent_containers/food/drinks/tea/black = 20,
					/obj/item/reagent_containers/food/drinks/tea/green = 20,
					/obj/item/reagent_containers/food/drinks/coffee = 15,
					/obj/item/reagent_containers/food/drinks/bottle/lemonjuice = 15,
					/obj/item/reagent_containers/food/drinks/bottle/limejuice = 15,
					/obj/item/reagent_containers/food/drinks/bottle/orangejuice = 15)

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
				/obj/structure/flora/ausbushes/fullgrass,
				/obj/structure/flora/ausbushes/grassybush,
				/obj/structure/flora/ausbushes/lavendergrass,
				/obj/structure/flora/ausbushes/ppflowers,
				/obj/structure/flora/ausbushes/sparsegrass,
				/obj/structure/flora/ausbushes/ywflowers,
				/obj/structure/flora/ausbushes/genericbush,
				/obj/structure/flora/ausbushes/sunnybush,
				/obj/structure/flora/ausbushes/sunnybush,
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

/obj/effect/overmap/visitable/sector/camp
	name = "jungle planet"
	desc = "A jungle planet."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	color = "#6db8b8"
	initial_generic_waypoints = list(
		"nav_camp_1",
		"nav_camp_2",
		"nav_camp_antag"
	)

	var/list/lightup
	var/lightlevel = 0.3 //This default makes turfs not generate light. Adjust to have exoplanents be lit.

/obj/effect/overmap/visitable/sector/camp/Initialize()
	..()

	lightup = block(locate(world.maxx, world.maxy, max(map_z)), locate(1, 1, min(map_z)))
	for(var/atom/A as anything in lightup)
		if(!istype(A.loc, /area/psionic_school/outdoor) || A.density || istype(A.loc, /area/psionic_school/outdoor/cave))
			lightup -= A
	update_daynight()

/obj/effect/overmap/visitable/sector/camp/proc/update_daynight(light = 0.7, light_color = "#e2d1b2")
	for(var/turf/T as anything in lightup)
		T.set_light(light, 0.1, 2, l_color = light_color)

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
		/datum/job/submap/camp/zeza,

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

//OKITA CUSTOM ITEMS//

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

/area/psionic_school/outdoor/cave
	name = "\improper Cave"

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
