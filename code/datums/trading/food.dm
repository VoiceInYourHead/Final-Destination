/datum/trader/pizzaria
	name = "Работник Пиццерии"
	name_language = TRADER_DEFAULT_NAME
	skill_req = SKILL_COOKING
	origin = "Пиццерия"
	possible_origins = list("Папа Джо", "Летающая Пицца", "Пицца-Доминатор", "Маленькая Ки", "Планета Пиццы", "Сырная Луис", "Вкус Нео-Италии", "Пицца Гестапо")
	trade_flags = TRADER_MONEY
	possible_wanted_items = list() //They are a pizza shop, not a bargainer.
	possible_trading_items = list(/obj/item/reagent_containers/food/snacks/sliceable/pizza   = TRADER_SUBTYPES_ONLY)
	overmap_object_color = COLOR_YELLOW


	speech = list(TRADER_HAIL_GENERIC    = "Приветствую! Добро пожаловать в ORIGIN, могу я услышать ваш заказ?",
				TRADER_HAIL_DENY         = "ПШШШПШПШПШП...Простите? вас плохо слышно! ПШШШПШПШПШШПШШШШ",

				TRADER_TRADE_COMPLETE    = "Спасибо за то, что выбираете ORIGIN!",
				TRADER_NO_GOODS    = "Простите, но мы принимаем ТОЛЬКО деньги.",
				TRADER_NO_BLACKLISTED = "Слушайте, вы же знаете что это...ОЧЕНЬ незаконная херня?",
				TRADER_NOT_ENOUGH  = "М-м...простите, но этого недостаточно для оплаты заказа.",
				TRADER_HOW_MUCH          = "Эта пицца обойдётся вам в VALUE CURRENCY.",

				TRADER_COMPLEMENT_FAILURE   = "Не слишком ли это прямолинейно, а?",
				TRADER_COMPLEMENT_SUCCESS = "Спасибо! Вы тоже нравитесь мне!",
				TRADER_INSULT_GOOD       = "Пожалуйста, прекратите...",
				TRADER_INSULT_BAD        = "Послушайте, не смотря на то, что контракт обязывает меня держать вас на линии минимум минуту - это не значит, что я буду выслушивать это дерьмо.",

				TRADER_BRIBE_FAILURE     = "Э-э...Спасибо? Не то что бы мы могли улететь, но...",
				)

/datum/trader/pizzaria/trade_quantity(quantity, list/offers, num, turf/location)
	. = ..()
	for (var/atom/movable/M in .)
		var/obj/item/pizzabox/box = new(location)
		M.forceMove(box)
		box.pizza = M
		box.boxtag = "A special order from [origin]"

/datum/trader/ship/chinese
	name = "Капитан Панда Бистро"
	name_language = TRADER_DEFAULT_NAME
	skill_req = SKILL_COOKING
	origin = "Китайский Ресторан"
	possible_origins = list("888 Шанхайская кухня", "Маленький Гонконг мр. Ли", "Дом полковника Ву", "Счастливый Дракон")
	trade_flags = TRADER_MONEY
	possible_wanted_items = list()
	possible_trading_items = list(/obj/item/reagent_containers/food/snacks/meatkabob    	       = TRADER_THIS_TYPE,
							/obj/item/reagent_containers/food/snacks/monkeysdelight             = TRADER_THIS_TYPE,
							/obj/item/reagent_containers/food/snacks/ricepudding                = TRADER_THIS_TYPE,
							/obj/item/reagent_containers/food/snacks/slice/xenomeatbread/filled = TRADER_THIS_TYPE,
							/obj/item/reagent_containers/food/snacks/soydope                    = TRADER_THIS_TYPE,
							/obj/item/reagent_containers/food/snacks/stewedsoymeat              = TRADER_THIS_TYPE,
							/obj/item/reagent_containers/food/drinks/dry_ramen                  = TRADER_THIS_TYPE
							)

	var/list/fortunes = list("Сегодня лишь вам под силу создать тот райский уголок, о котором вы мечтаете.",
							"Отказываясь от всех вариантов кроме лучшего - вы лишь сильнее отдаляете оптимальное решение от себя.",
							"Улыбка - это ваш пропуск в сердца других.",
							"Упорный труд окупается в будущем, лень окупается сейчас.",
							"Изменения порождают боль, а боль порождает изменения",
							"Глубоко в долине, за потоком воды- Именно там ты сможешь коснуться своей мечты.",
							"Никогда не сдавайся. Пока ты веришь в себя - тебе всё будет ни по чём.",
							"Любовь может жить вечно - если вы этого хотите.",
							"Иногда, мы сами не замечаем, как направляем свои чувства не в то русло. Иногда, любовь всей нашей жизни может быть совсем рядом.",
							"Принятие ошибок - порождает прогресс.",
							"Пожалуйста, помогите мне! Я китайский ребёнок, которого держат на фабрике по производству печенек с предсказаниями!")

	overmap_object_color = COLOR_RED

	speech = list(TRADER_HAIL_GENERIC     = "В мире существует лишь две неизменных константы - смерть и китайская еда. Чем я могу вам помочь?",
				TRADER_HAIL_DENY          = "Мы не обслуживаем тех, кто не проявляет достаточного уважения к нашему делу.",

				TRADER_TRADE_COMPLETE     = "Благодарим за покупку.",
				TRADER_NO_BLACKLISTED    = "Боюсь, что наш ресторан не марает руки контрабандой.",
				TRADER_NO_GOODS     = "Мы принимаем оплату лишь в CURRENCY.",
				TRADER_NOT_ENOUGH   = "Простите, но этого недостаточно даже для того, чтобы оплатить день моей жизни.",
				TRADER_HOW_MUCH           = "ITEM стоит VALUE CURRENCY. Не больше, не меньше.",

				TRADER_COMPLEMENT_FAILURE    = "Вы действительно странный человек, незнакомец. Очень странный.",
				TRADER_COMPLEMENT_SUCCESS  = "Очень приятно встретить такого же философа в этом бескрайнем космосе. Я запомню это учение, незнакомец.",
				TRADER_INSULT_GOOD        = "Однажды, один умный человек сказал: \"Насилие порождает насилие, и за смерть платят смертью.\" Подумайте об этом.",
				TRADER_INSULT_BAD         = "Вы возомнили себя змеёй, но ваши клыки слишком тупы, чтобы сделать человеку вроде меня больно.",

				TRADER_BRIBE_FAILURE     = "Хм...Я подумаю об этом.",
				TRADER_BRIBE_SUCCESS      = "Возможно, вы действительно заслуживаете чуть больше моего внимания.",
				)

/datum/trader/ship/chinese/trade_quantity(quantity, list/offers, num, turf/location)
	. = ..()
	quantity = 1
	if(.)
		var/obj/item/reagent_containers/food/snacks/fortunecookie/cookie = new(location)
		var/obj/item/paper/paper = new(cookie)
		cookie.trash = paper
		paper.SetName("Fortune")
		paper.info = pick(fortunes)

/datum/trader/grocery
	name = "Бакалейщик"
	name_language = TRADER_DEFAULT_NAME
	skill_req = SKILL_COOKING
	possible_origins = list("Хайгвей", "Спейсвей", "Марка Будущего")
	trade_flags = TRADER_MONEY

	possible_trading_items = list(/obj/item/reagent_containers/food/snacks                      = TRADER_SUBTYPES_ONLY,
							/obj/item/reagent_containers/food/drinks/cans                       = TRADER_SUBTYPES_ONLY,
							/obj/item/reagent_containers/food/drinks/bottle                     = TRADER_SUBTYPES_ONLY,
							/obj/item/reagent_containers/food/drinks/bottle/small               = TRADER_BLACKLIST,
							/obj/item/reagent_containers/food/snacks/boiledslimecore            = TRADER_BLACKLIST,
							/obj/item/reagent_containers/food/snacks/checker                    = TRADER_BLACKLIST_ALL,
							/obj/item/reagent_containers/food/snacks/fruit_slice                = TRADER_BLACKLIST,
							/obj/item/reagent_containers/food/snacks/slice                      = TRADER_BLACKLIST_ALL,
							/obj/item/reagent_containers/food/snacks/grown                      = TRADER_BLACKLIST_ALL,
							/obj/item/reagent_containers/food/snacks/human                      = TRADER_BLACKLIST_ALL,
							/obj/item/reagent_containers/food/snacks/sliceable/braincake        = TRADER_BLACKLIST,
							/obj/item/reagent_containers/food/snacks/meat/human                 = TRADER_BLACKLIST,
							/obj/item/reagent_containers/food/snacks/variable                   = TRADER_BLACKLIST_ALL
							)

	speech = list(TRADER_HAIL_GENERIC     = "Приветствую в ORIGIN, продуктовом мазагине будущего!",
				TRADER_HAIL_DENY          = "Прошу прощения, но ваша линия была добавлена в чёрный список.",

				TRADER_TRADE_COMPLETE     = "Спасибо за покупку в ORIGIN!",
				TRADER_NO_BLACKLISTED    = "Я...воу. Нет, нет, НЕТ. Я не стану это принимать.",
				TRADER_NO_GOODS     = "ORIGIN принимает оплату только в CURRENCY.",
				TRADER_NOT_ENOUGH   = "Боюсь, здесь недостаточно денег для покупки.",
				TRADER_HOW_MUCH           = "Даная покупка обойдётся вам в VALUE CURRENCY. Хотите купить что-нибудь ещё?",

				TRADER_COMPLEMENT_FAILURE    = "Послушайте, это рабочая линия - её слышат ВСЕ сотрудники.",
				TRADER_COMPLEMENT_SUCCESS  = "Огромное спасибо!",
				TRADER_INSULT_GOOD        = "Пожалуйста, только не устраивайте тут сцену, мы можем договориться...",
				TRADER_INSULT_BAD         = "Прошу, успокойтесь. Иначе мне придётся позвать менеджера.",

				TRADER_BRIBE_FAILURE      = "Конечно мы останемся! ORIGIN всегда здесь для вас!",
				)

	overmap_object_color = COLOR_GREEN

/datum/trader/bakery
	name = "Шеф-кондитер"
	skill_req = SKILL_COOKING
	name_language = TRADER_DEFAULT_NAME
	origin = "Пекарня"
	possible_origins = list("Дизайнерские торты Хью", "Пекарня у дома", "Кондитерское кафе", "Пекарня Мамы Джо", "Кремпай", "Тортострофа")

	speech = list(TRADER_HAIL_GENERIC     = "Приветствую в ORIGIN! Мы готовы предложить вам уникальный билет в мир сладостей!",
				TRADER_HAIL_DENY          = "Наша еда - это привилегия, а не право. До свидания.",

				TRADER_TRADE_COMPLETE     = "Благодарим вас за покупку! Заходите к нам ещё!",
				TRADER_NO_BLACKLISTED    = "Слушайте, мы принимаем только деньги. Не...точно не это.",
				TRADER_NO_GOODS     = "Торты за деньги и только за деньги! Мы не принимаем других вариантов оплаты!",
				TRADER_NOT_ENOUGH   = "Боюсь, наши блюда намного дороже этого.",
				TRADER_HOW_MUCH           = "Этот замечательный ITEM обойдётся для вас в VALUE CURRENCY.",

				TRADER_COMPLEMENT_FAILURE    = "Оу, ну...мне очень приятно?...",
				TRADER_COMPLEMENT_SUCCESS  = "Вы почти такие же сладенькие, как мои пироги!",
				TRADER_INSULT_GOOD        = "Мои пироги - самые натуральные!",
				TRADER_INSULT_BAD         = "У вас мина такая же кислая, как у лимона.",

				TRADER_BRIBE_FAILURE      = "Разве же мы можем бросить наших постоянных клиентов? Да и заставить станцию летать крайне сложно...",
				)
	possible_trading_items = list(/obj/item/reagent_containers/food/snacks/slice/birthdaycake/filled     = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/food/snacks/slice/carrotcake/filled         = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/food/snacks/slice/cheesecake/filled         = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/food/snacks/slice/chocolatecake/filled      = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/food/snacks/slice/lemoncake/filled          = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/food/snacks/slice/limecake/filled           = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/food/snacks/slice/orangecake/filled         = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/food/snacks/slice/plaincake/filled          = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/food/snacks/slice/pumpkinpie/filled         = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/food/snacks/slice/bananabread/filled        = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/food/snacks/sliceable                       = TRADER_SUBTYPES_ONLY,
								/obj/item/reagent_containers/food/snacks/sliceable/pizza                 = TRADER_BLACKLIST_ALL,
								/obj/item/reagent_containers/food/snacks/sliceable/xenomeatbread         = TRADER_BLACKLIST,
								/obj/item/reagent_containers/food/snacks/sliceable/flatdough             = TRADER_BLACKLIST,
								/obj/item/reagent_containers/food/snacks/sliceable/braincake             = TRADER_BLACKLIST,
								/obj/item/reagent_containers/food/snacks/pie                             = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/food/snacks/applepie                        = TRADER_THIS_TYPE)

	overmap_object_color = COLOR_GREEN