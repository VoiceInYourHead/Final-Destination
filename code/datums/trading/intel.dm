/datum/trader/ship/intel_collector
	name = "Загадочная личность"
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