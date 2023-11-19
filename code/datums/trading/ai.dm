/*

TRADING BEACON

Trading beacons are generic AI driven trading outposts.
They sell generic supplies and ask for generic supplies.
*/

/datum/trader/trading_beacon
	name = "Омега"
	origin = "Торговый Маяк"
	name_language = LANGUAGE_EAL
	trade_flags = TRADER_MONEY|TRADER_GOODS|TRADER_WANTED_ONLY
	speech = list(TRADER_HAIL_GENERIC    = "Приветствую, Я MERCHANT, ИскИн на борту ORIGIN, основной задачей которого является покупка и продажа вещей за CURRENCY и другие припасы.",
				TRADER_HAIL_DENY         = "Приношу свои извинения, ваша линия была добавлена в чёрный список. Хорошего дня.",

				TRADER_TRADE_COMPLETE    = "Благодарю за покупку.",
				TRADER_NOT_ENOUGH  = "Прошу прощения, но ваше предложение не удовлетворяет реальную стоимость этого товара.",
				TRADER_NO_BLACKLISTED = "Предлагаемый вами товар запрещён на территории большинства известных государств. Мои законы не позволяют принять его в качестве оплаты.",
				TRADER_HOW_MUCH          = "ITEM будет стоить для вас VALUE CURRENCY, или объекта аналогичной ценности.",
				TRADER_WHAT_WANT         = "Я регистрирую потребность в",

				TRADER_COMPLEMENT_FAILURE   = "Прошу прощения, но я не могу позволить своим вне-рабочим отношениям как-то повлиять на торги.",
				TRADER_COMPLEMENT_SUCCESS = "Благодарю, но я не могу позволить своим вне-рабочим отношениям как-то повлиять на торги.",
				TRADER_INSULT_GOOD       = "Я не понимаю, разве эти условия недостаточно удовлетворяют спрос?",
				TRADER_INSULT_BAD        = "Я не понимаю, это было оскорблением?",

				TRADER_BRIBE_FAILURE     = "Мы благодарим вас за ваше вложение - но ORIGIN является станцией. Он в любом случае никуда не улетит.",
				)
	possible_wanted_items = list(/obj/item/device/                       = TRADER_SUBTYPES_ONLY,
								/obj/item/device/assembly                = TRADER_BLACKLIST_ALL,
								/obj/item/device/assembly_holder         = TRADER_BLACKLIST_ALL,
								/obj/item/device/encryptionkey/syndicate = TRADER_BLACKLIST,
								/obj/item/tank/phoron/onetankbomb = TRADER_BLACKLIST,
								/obj/item/device/radio                   = TRADER_BLACKLIST_ALL,
								/obj/item/modular_computer/pda                     = TRADER_BLACKLIST_SUB,
								/obj/item/device/uplink                  = TRADER_BLACKLIST)
	possible_trading_items = list(/obj/item/storage/bag                       = TRADER_SUBTYPES_ONLY,
								/obj/item/storage/bag/cash/infinite           = TRADER_BLACKLIST,
								/obj/item/storage/backpack                    = TRADER_ALL,
								/obj/item/storage/backpack/cultpack           = TRADER_BLACKLIST,
								/obj/item/storage/backpack/holding            = TRADER_BLACKLIST_ALL,
								/obj/item/storage/backpack/satchel/grey/withwallet = TRADER_BLACKLIST,
								/obj/item/storage/backpack/satchel/syndie_kit = TRADER_BLACKLIST_ALL,
								/obj/item/storage/backpack/chameleon          = TRADER_BLACKLIST,
								/obj/item/storage/backpack/ert                = TRADER_BLACKLIST_ALL,
								/obj/item/storage/backpack/dufflebag/syndie   = TRADER_BLACKLIST_SUB,
								/obj/item/storage/belt/champion               = TRADER_THIS_TYPE,
								/obj/item/storage/briefcase                   = TRADER_THIS_TYPE,
								/obj/item/storage/fancy                       = TRADER_SUBTYPES_ONLY,
								/obj/item/storage/laundry_basket              = TRADER_THIS_TYPE,
								/obj/item/storage/secure/briefcase            = TRADER_THIS_TYPE,
								/obj/item/storage/plants                      = TRADER_THIS_TYPE,
								/obj/item/storage/ore                         = TRADER_THIS_TYPE,
								/obj/item/storage/toolbox                     = TRADER_ALL,
								/obj/item/storage/wallet                      = TRADER_THIS_TYPE,
								/obj/item/storage/photo_album                 = TRADER_THIS_TYPE,
								/obj/item/mag_table_plate  = TRADER_THIS_TYPE,
								/obj/item/clothing/glasses                           = TRADER_SUBTYPES_ONLY,
								/obj/item/clothing/glasses/hud                       = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/glasses/blindfold/tape = TRADER_BLACKLIST,
								/obj/item/clothing/glasses/chameleon                 = TRADER_BLACKLIST
								)

	insult_drop = 0
	compliment_increase = 0

/datum/trader/trading_beacon/New()
	..()
	origin = "[origin] #[rand(100,999)]"

/datum/trader/trading_beacon/mine
	origin = "Добывающий Маяк"

	possible_trading_items = list(/obj/item/stack/material/glass            = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/iron             = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/sandstone        = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/marble           = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/diamond          = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/uranium          = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/phoron           = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/plastic          = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/gold             = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/silver           = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/platinum         = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/mhydrogen        = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/tritium          = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/osmium           = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/steel            = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/plasteel         = TRADER_SUBTYPES_ONLY,
								/obj/machinery/mining                     = TRADER_SUBTYPES_ONLY
								)

/datum/trader/trading_beacon/manufacturing
	origin = "Производственный Маяк"

	possible_trading_items = list(/obj/structure/AIcore             = TRADER_THIS_TYPE,
								/obj/structure/girder/displaced     = TRADER_THIS_TYPE,
								/obj/structure/mopbucket            = TRADER_THIS_TYPE,
								/obj/structure/ore_box              = TRADER_THIS_TYPE,
								/obj/structure/coatrack             = TRADER_THIS_TYPE,
								/obj/structure/bookcase             = TRADER_THIS_TYPE,
								/obj/item/bee_pack                  = TRADER_THIS_TYPE,
								/obj/item/bee_smoker                = TRADER_THIS_TYPE,
								/obj/item/beehive_assembly          = TRADER_THIS_TYPE,
								/obj/item/glass_jar                 = TRADER_THIS_TYPE,
								/obj/item/honey_frame               = TRADER_THIS_TYPE,
								/obj/structure/dispenser            = TRADER_SUBTYPES_ONLY,
								/obj/structure/filingcabinet        = TRADER_THIS_TYPE,
								/obj/structure/safe                 = TRADER_THIS_TYPE,
								/obj/structure/plushie              = TRADER_SUBTYPES_ONLY,
								/obj/item/contraband/poster         = TRADER_THIS_TYPE
								)

/datum/trader/trading_beacon/starter
	possible_wanted_items = list(/obj/item/device/                       = TRADER_SUBTYPES_ONLY,
								/obj/item/device/assembly                = TRADER_BLACKLIST_ALL,
								/obj/item/device/assembly_holder         = TRADER_BLACKLIST_ALL,
								/obj/item/device/encryptionkey/syndicate = TRADER_BLACKLIST,
								/obj/item/tank/phoron/onetankbomb = TRADER_BLACKLIST,
								/obj/item/device/radio                   = TRADER_BLACKLIST_ALL,
								/obj/item/modular_computer/pda                     = TRADER_BLACKLIST_SUB,
								/obj/item/device/uplink                  = TRADER_BLACKLIST,
								/obj/item/stack/material/phoron          = TRADER_ALL)
	possible_trading_items = list(/obj/item/storage/bag                       = TRADER_SUBTYPES_ONLY,
								/obj/item/storage/bag/cash/infinite           = TRADER_BLACKLIST,
								/obj/item/storage/backpack                    = TRADER_ALL,
								/obj/item/storage/backpack/cultpack           = TRADER_BLACKLIST,
								/obj/item/storage/backpack/holding            = TRADER_BLACKLIST,
								/obj/item/storage/backpack/satchel/grey/withwallet = TRADER_BLACKLIST,
								/obj/item/storage/backpack/satchel/syndie_kit = TRADER_BLACKLIST_ALL,
								/obj/item/storage/backpack/chameleon          = TRADER_BLACKLIST,
								/obj/item/storage/backpack/ert                = TRADER_BLACKLIST_ALL,
								/obj/item/storage/backpack/dufflebag/syndie   = TRADER_BLACKLIST_SUB,
								/obj/item/storage/briefcase                   = TRADER_THIS_TYPE,
								/obj/item/storage/fancy                       = TRADER_SUBTYPES_ONLY,
								/obj/item/storage/laundry_basket              = TRADER_THIS_TYPE,
								/obj/item/storage/secure/briefcase            = TRADER_THIS_TYPE,
								/obj/item/storage/plants                      = TRADER_THIS_TYPE,
								/obj/item/storage/ore                         = TRADER_THIS_TYPE,
								/obj/item/storage/toolbox                     = TRADER_ALL,
								/obj/item/storage/wallet                      = TRADER_THIS_TYPE,
								/obj/item/storage/photo_album                 = TRADER_THIS_TYPE,
								/obj/item/mag_table_plate  = TRADER_THIS_TYPE,
								/obj/item/clothing/glasses                    = TRADER_SUBTYPES_ONLY,
								/obj/item/clothing/glasses/hud                = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/glasses/blindfold/tape     = TRADER_BLACKLIST,
								/obj/item/clothing/glasses/chameleon          = TRADER_BLACKLIST,
								/obj/item/stack/material/glass                = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/iron                 = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/sandstone            = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/marble               = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/diamond              = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/uranium              = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/phoron               = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/plastic              = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/gold                 = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/silver               = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/platinum             = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/mhydrogen            = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/tritium              = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/osmium               = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/steel                = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/material/plasteel             = TRADER_SUBTYPES_ONLY,
								/obj/machinery/mining                         = TRADER_SUBTYPES_ONLY,
								/obj/structure/AIcore                         = TRADER_THIS_TYPE,
								/obj/structure/girder/displaced               = TRADER_THIS_TYPE,
								/obj/structure/mopbucket                      = TRADER_THIS_TYPE,
								/obj/structure/ore_box                        = TRADER_THIS_TYPE,
								/obj/structure/coatrack                       = TRADER_THIS_TYPE,
								/obj/structure/bookcase                       = TRADER_THIS_TYPE,
								/obj/item/bee_pack                            = TRADER_THIS_TYPE,
								/obj/item/bee_smoker                          = TRADER_THIS_TYPE,
								/obj/item/beehive_assembly                    = TRADER_THIS_TYPE,
								/obj/item/glass_jar                           = TRADER_THIS_TYPE,
								/obj/item/honey_frame                         = TRADER_THIS_TYPE,
								/obj/structure/dispenser                      = TRADER_SUBTYPES_ONLY,
								/obj/structure/filingcabinet                  = TRADER_THIS_TYPE,
								/obj/structure/safe                           = TRADER_THIS_TYPE,
								/obj/structure/plushie                        = TRADER_SUBTYPES_ONLY,
								/obj/item/contraband/poster                   = TRADER_THIS_TYPE
								)

/datum/trader/trading_beacon/starter/select_spawn_location()
	var/turf/torch = get_turf(locate(/obj/effect/overmap/visitable/ship/torch))
	if(!torch)
		stack_trace("Cringe! Torch not found in trading_beacon/starter/select_spawn_location()")
		return ..()

	var/list/turfs = orange(2, torch)
	for(var/turf/T in shuffle(turfs))
		var/valid = TRUE
		for(var/obj/effect/overmap/event/E in T)
			if(E)
				valid = FALSE
				break
		for(var/obj/effect/overmap/trading/M in T)
			if(M)
				valid = FALSE
				break
		for(var/obj/effect/overmap/visitable/V in T)
			if(V)
				valid = FALSE
				break
		if(valid)
			return T

	stack_trace("Cringe! No room for /datum/trader/trading_beacon/starter, it'll be placed in default location")
	return ..()
