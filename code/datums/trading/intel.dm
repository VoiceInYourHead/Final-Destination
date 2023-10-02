/datum/trader/ship/intel_collector
	name = "Загадочный Фиксер"
	origin = "Странствующий в Тени"
	trade_flags = TRADER_GOODS|TRADER_MONEY|TRADER_WANTED_ONLY|TRADER_WANTED_ALL
	want_multiplier = 1.5
	margin = 2
	possible_origins = list("PV 'Странствующий в Тени'", "PV 'Библиотекарь'",)
	speech = list(TRADER_HAIL_GENERIC    = "Мне нужны данные, а вам деньги. Не задавайте лишних вопросов и мы сработаемся.",
				TRADER_HAIL_DENY         = "...",

				TRADER_TRADE_COMPLETE    = "Хм...я смогу извлечь из этого некоторую выгоду.",
				TRADER_NO_BLACKLISTED   = "Меня не интересуют подобные безделушки.",
				TRADER_FOUND_UNWANTED = "Простите, но этим вы меня не удивите.",
				TRADER_NOT_ENOUGH   = "Вам понадобится куда больше, если вы хотите это купить...",
				TRADER_HOW_MUCH          = "Я готов продать вам эту информацию за VALUE CURRENCY.",
				TRADER_WHAT_WANT         = "На данный момент я нахожусь в поисках...",

				TRADER_COMPLEMENT_FAILURE   = "Отрадно наблюдать за вашими потугами.",
				TRADER_COMPLEMENT_SUCCESS = "Должен отметить ваши старания, но я здесь лишь ради бизнеса.",
				TRADER_INSULT_GOOD       = "Хочется признать, трепать языком вы умеете...главное, следите за тем, чтобы его не отрезали после таких слов.",
				TRADER_INSULT_BAD        = "Жалкая попытка.",
				)

	overmap_object_color = COLOR_BLACK

	insult_drop = 0
	compliment_increase = 0

	possible_wanted_items = list(/obj/item/fd/data = TRADER_SUBTYPES_ONLY)

/datum/trader/collector
	name = "Загадочный коллекционер"
	origin = "Музей"
	trade_flags = TRADER_GOODS|TRADER_MONEY|TRADER_WANTED_ONLY|TRADER_WANTED_ALL
	want_multiplier = 1.5
	margin = 2
	possible_origins = list("Музей имени Говарда Л.", "Частная выстовочная площадка",)
	speech = list(TRADER_HAIL_GENERIC    = "Добро пожаловать, мой дорогой друг! Что вы принесли сегодня?",
				TRADER_HAIL_DENY         = "ВЫ БЫЛИ ЗАБЛОКИРОВАНЫ",

				TRADER_TRADE_COMPLETE    = "Отличный товар...воистину большой улов!",
				TRADER_NO_BLACKLISTED   = "Простите, но я, всё-таки, ЛЕГАЛЬНЫЙ предприниматель.",
				TRADER_FOUND_UNWANTED = "Такое даже на витрину поставить стыдно...уж простите.",
				TRADER_NOT_ENOUGH   = "Вам понадобится куда больше, если вы хотите это купить, мой друг!",
				TRADER_HOW_MUCH          = "Я готов продать вам эту прекрасную вещицу всего за VALUE CURRENCY!",
				TRADER_WHAT_WANT         = "Я буду крайне удивлён, если у вас окажется...",

				TRADER_COMPLEMENT_FAILURE   = "Допустим?...",
				TRADER_COMPLEMENT_SUCCESS = "Ох-хо-хо, не стоит, правда!",
				TRADER_INSULT_GOOD       = "Послушайте...давайте вести себя цивильно, хорошо? Пожалуйста.",
				TRADER_INSULT_BAD        = "Надеюсь, что я просто не так вас понял...",
				)

	overmap_object_color = COLOR_WHITE

	possible_wanted_items = list(/obj/item/fd/ancient_items = TRADER_SUBTYPES_ONLY,
								/obj/item/cell/bluespace_ancient = TRADER_THIS_TYPE,
								/obj/item/clothing/glasses/psionic = TRADER_THIS_TYPE)