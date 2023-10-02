/datum/trader/ship/toyshop
	name = "Продавец магазина игрушек"
	name_language = TRADER_DEFAULT_NAME
	origin = "Магазин Игрушек"
	trade_flags = TRADER_GOODS|TRADER_MONEY|TRADER_WANTED_ONLY
	possible_origins = list("LEGS GO", "Игрушки Кейси", "Собери-своего-кота", "Магическая коробка", "Тех-тоннели и Гриферы")
	speech = list(TRADER_HAIL_GENERIC    = "Э-э... привет? Добро пожаловать в ORIGIN, Я желаю вам, м-м...найти то что вы ищите.",
				TRADER_HAIL_DENY         = "Не, вам тут не рады. Проваливайте.",

				TRADER_TRADE_COMPLETE       = "Спасибо за покупку в...ORIGIN.",
				TRADER_NO_BLACKLISTED      = "Э-э-э...не-а, нет.",
				TRADER_FOUND_UNWANTED = "Не-а! Подобная мелочь мне неинтересна. Мне нужно что-то по-солиднее.",
				TRADER_NOT_ENOUGH   = "То, что они сделаны из пластика - ещё не значит что они ничего не стоят...",
				TRADER_HOW_MUCH          = "Ну-у...что-то в районе...VALUE. Окей? Или, может, вы предложете мне что-то для обмена?",
				TRADER_WHAT_WANT         = "М-м-м.....Я хочу-у...",

				TRADER_COMPLEMENT_FAILURE   = "Ха! Очень смешно! Вам стоит попробовать себя в ведении собственного стендапа.",
				TRADER_COMPLEMENT_SUCCESS = "Ну...эм, да, я хожу время от времени в спорт-зал, а что?",
				TRADER_INSULT_GOOD       = "А вы тот ещё тролль, знаете?",
				TRADER_INSULT_BAD        = "Я уже напечатал злостный пост про вас на спейс-эддите, поняли?",

				TRADER_BRIBE_FAILURE     = "Не-е. У меня ещё куча точек, которые нужно облететь...",
				TRADER_BRIBE_SUCCESS      = "А знаете? Я всё равно не планировал чем-либо заниматься в ближайшие TIME минут, энивей.",
				)

	overmap_object_color = COLOR_YELLOW

	possible_wanted_items = list(/obj/item/toy/figure       = TRADER_THIS_TYPE,
								/obj/item/toy/figure/ert    = TRADER_THIS_TYPE,
								/obj/item/toy/prize/honk    = TRADER_THIS_TYPE)

	possible_trading_items = list(/obj/item/toy/prize                 = TRADER_SUBTYPES_ONLY,
								/obj/item/toy/prize/honk              = TRADER_BLACKLIST,
								/obj/item/toy/figure                  = TRADER_SUBTYPES_ONLY,
								/obj/item/toy/figure/ert              = TRADER_BLACKLIST,
								/obj/item/toy/plushie                 = TRADER_SUBTYPES_ONLY,
								/obj/item/toy/katana                  = TRADER_THIS_TYPE,
								/obj/item/toy/sword                   = TRADER_THIS_TYPE,
								/obj/item/toy/bosunwhistle            = TRADER_THIS_TYPE,
								/obj/item/board                = TRADER_THIS_TYPE,
								/obj/item/storage/box/checkers = TRADER_ALL,
								/obj/item/deck                 = TRADER_SUBTYPES_ONLY,
								/obj/item/pack                 = TRADER_SUBTYPES_ONLY,
								/obj/item/dice                 = TRADER_ALL,
								/obj/item/dice/d20/cursed      = TRADER_BLACKLIST,
								/obj/item/gun/launcher/money   = TRADER_THIS_TYPE)

/datum/trader/ship/electronics
	name = "Продавец магазина электроники"
	name_language = TRADER_DEFAULT_NAME
	skill_req = SKILL_COMPUTER
	origin = "Магазин Электроники"
	possible_origins = list("Лучшее по Скидке", "Перегрузка", "Старое Яйцо", "Цитадель Плат", "Синтетическая Деревня", "Позитронное Решение", "Корпорация Санволт.")

	speech = list(TRADER_HAIL_GENERIC    = "Приветствую! Добро пожаловать в ORIGIN, Я надеюсь что вы найдёте здесь то что ищите.",
				TRADER_HAIL_DENY         = "Позвоните нам в другой раз.",

				TRADER_TRADE_COMPLETE    = "Благодарим вас за покупку в ORIGIN, хотели бы вы также продлить гарантию на приобретённые товары?",
				TRADER_NO_BLACKLISTED   = "Слушайте, это магазин /electronics/, НЕ оружия и ядерных боеголовок.",
				TRADER_NO_GOODS    = "Как бы мне не хотелось это купить...но я не могу, простите.",
				TRADER_NOT_ENOUGH  = "Вы предлагаете мне неадекватно маленькую сумму.",
				TRADER_HOW_MUCH          = "Ваша общая сумма составит VALUE CURRENCY.",

				TRADER_COMPLEMENT_FAILURE   = "Ха-ха-ха! Ага...очень смешно...",
				TRADER_COMPLEMENT_SUCCESS = "Это было очень милым поступком с вашей стороны!",
				TRADER_INSULT_GOOD       = "Это замечание было неуместным. Прошу, не заставляйте меня звать менеджера.",
				TRADER_INSULT_BAD        = "Послушайте, если вы продолжите в том же духе - мне придётся бросить трубку.",

				TRADER_BRIBE_FAILURE     = "Простите, но не в моих силах решать это.",
				TRADER_BRIBE_SUCCESS      = "Почему бы и нет? Небольшая задержка не сделает особой погоды.",
				)

	overmap_object_color = COLOR_YELLOW

	possible_trading_items = list(/obj/item/stock_parts/computer/battery_module      = TRADER_SUBTYPES_ONLY,
								/obj/item/stock_parts/circuitboard                            = TRADER_SUBTYPES_ONLY,
								/obj/item/stock_parts/circuitboard/telecomms                  = TRADER_BLACKLIST,
								/obj/item/stock_parts/circuitboard/unary_atmos                = TRADER_BLACKLIST,
								/obj/item/stock_parts/circuitboard/arcade                     = TRADER_BLACKLIST,
								/obj/item/stock_parts/circuitboard/broken                     = TRADER_BLACKLIST,
								/obj/item/stack/cable_coil                               = TRADER_SUBTYPES_ONLY,
								/obj/item/stack/cable_coil/cyborg                        = TRADER_BLACKLIST,
								/obj/item/stack/cable_coil/random                        = TRADER_BLACKLIST,
								/obj/item/stack/cable_coil/cut                           = TRADER_BLACKLIST,
								/obj/item/airalarm_electronics                    = TRADER_THIS_TYPE,
								/obj/item/airlock_electronics                     = TRADER_ALL,
								/obj/item/cell/standard                           = TRADER_THIS_TYPE,
								/obj/item/cell/crap                               = TRADER_THIS_TYPE,
								/obj/item/cell/high                               = TRADER_THIS_TYPE,
								/obj/item/cell/super                              = TRADER_THIS_TYPE,
								/obj/item/cell/hyper                              = TRADER_THIS_TYPE,
								/obj/item/mag_table_plate      = TRADER_THIS_TYPE,
								/obj/item/module                                  = TRADER_SUBTYPES_ONLY,
								/obj/item/tracker_electronics                     = TRADER_THIS_TYPE,
								/obj/item/device/flashlight              = TRADER_ALL,
								/obj/item/device/kit/paint                 = TRADER_SUBTYPES_ONLY,
								/obj/item/aicard                    = TRADER_THIS_TYPE,
								/obj/item/device/binoculars                = TRADER_THIS_TYPE,
								/obj/item/device/cable_painter             = TRADER_THIS_TYPE,
								/obj/item/device/flash                     = TRADER_THIS_TYPE,
								/obj/item/device/paint_sprayer             = TRADER_THIS_TYPE,
								/obj/item/device/multitool                 = TRADER_THIS_TYPE,
								/obj/item/device/lightreplacer             = TRADER_THIS_TYPE,
								/obj/item/device/megaphone                 = TRADER_THIS_TYPE,
								/obj/item/device/paicard                   = TRADER_THIS_TYPE,
								/obj/item/device/scanner/health            = TRADER_THIS_TYPE,
								/obj/item/device/scanner/gas                  = TRADER_ALL,
								/obj/item/device/scanner/spectrometer         = TRADER_ALL,
								/obj/item/device/scanner/reagent           = TRADER_ALL,
								/obj/item/device/scanner/xenobio             = TRADER_THIS_TYPE,
								/obj/item/device/suit_cooling_unit         = TRADER_THIS_TYPE,
								/obj/item/device/t_scanner                 = TRADER_THIS_TYPE,
								/obj/item/device/taperecorder              = TRADER_THIS_TYPE,
								/obj/item/device/batterer                  = TRADER_THIS_TYPE,
								/obj/item/device/synthesized_instrument/violin                    = TRADER_THIS_TYPE,
								/obj/item/device/hailer                    = TRADER_THIS_TYPE,
								/obj/item/device/uv_light                  = TRADER_THIS_TYPE,
								/obj/item/device/mmi                       = TRADER_ALL,
								/obj/item/device/robotanalyzer             = TRADER_THIS_TYPE,
								/obj/item/device/toner                     = TRADER_THIS_TYPE,
								/obj/item/device/camera_film               = TRADER_THIS_TYPE,
								/obj/item/device/camera                    = TRADER_THIS_TYPE,
								/obj/item/device/destTagger                = TRADER_THIS_TYPE,
								/obj/item/device/gps                       = TRADER_THIS_TYPE,
								/obj/item/device/measuring_tape            = TRADER_THIS_TYPE,
								/obj/item/device/ano_scanner               = TRADER_THIS_TYPE,
								/obj/item/device/core_sampler              = TRADER_THIS_TYPE,
								/obj/item/device/depth_scanner             = TRADER_THIS_TYPE,
								/obj/item/pinpointer/radio            = TRADER_THIS_TYPE,
								/obj/item/stack/medical/advanced           = TRADER_BLACKLIST)


/* Clothing stores: each a different type. A hat/glove store, a shoe store, and a jumpsuit store. */

/datum/trader/ship/clothingshop
	name = "Продавец магазина одежды"
	name_language = TRADER_DEFAULT_NAME
	origin = "Магазин Одежды"
	possible_origins = list("Космический Сокол", "Демокративная Республика Банана", "22 Навечно", "Текстильная Фабрика Ньюбергов", "Братья Блокс")
	speech = list(TRADER_HAIL_GENERIC    = "Приветствую вас! Добро пожаловать в ORIGIN!",
				TRADER_HAIL_DENY         = "Мы не предоставляем наши услуги кому-попало.",

				TRADER_TRADE_COMPLETE    = "Спасибо за приобретение наших товаров! И помните: мы не принимаем возвраты без оригинальных лычек!",
				TRADER_NO_BLACKLISTED   = "Хм, как насчёт пойти куда подальше?",
				TRADER_NO_GOODS    = "Мы не покупаем - только продаём.",
				TRADER_NOT_ENOUGH  = "Прошу прощения, ценовая политика ORIGIN не позволяет нам продавать товары ниже указанного ценника.",
				TRADER_HOW_MUCH          = "Ваша общая сумма составит VALUE CURRENCY.",

				TRADER_COMPLEMENT_FAILURE   = "Простите?",
				TRADER_COMPLEMENT_SUCCESS = "Оу, мне так приятно слышать это!",
				TRADER_INSULT_GOOD       = "Остановитесь.",
				TRADER_INSULT_BAD        = "Серьёзно, вам стоит прекратить это.",

				TRADER_BRIBE_FAILURE     = "К сожалению, правила запрещают нам оставаться на одном месте дольше указанного времени.",
				TRADER_BRIBE_SUCCESS      = "Хм...хорошо! Думаю, у вас есть пара минут, пока мы разбираемся с внезапным 'отказом двигателей'.",
				)

	overmap_object_color = COLOR_PINK

	possible_trading_items = list(/obj/item/clothing/under                = TRADER_SUBTYPES_ONLY,
								/obj/item/clothing/under/acj              = TRADER_BLACKLIST,
								/obj/item/clothing/under/chameleon        = TRADER_BLACKLIST,
								/obj/item/clothing/under/cloud            = TRADER_BLACKLIST,
								/obj/item/clothing/under/color            = TRADER_BLACKLIST,
								/obj/item/clothing/under/dress            = TRADER_BLACKLIST,
								/obj/item/clothing/under/ert              = TRADER_BLACKLIST,
								/obj/item/clothing/under/gimmick          = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/under/lawyer           = TRADER_BLACKLIST,
								/obj/item/clothing/under/pj               = TRADER_BLACKLIST,
								/obj/item/clothing/under/rank             = TRADER_BLACKLIST,
								/obj/item/clothing/under/shorts           = TRADER_BLACKLIST,
								/obj/item/clothing/under/stripper         = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/under/swimsuit         = TRADER_BLACKLIST,
								/obj/item/clothing/under/syndicate        = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/under/tactical         = TRADER_BLACKLIST,
								/obj/item/clothing/under/vox              = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/under/wedding          = TRADER_BLACKLIST,
								/obj/item/clothing/under/punpun           = TRADER_BLACKLIST)


/datum/trader/ship/clothingshop/New()
	..()
	speech[TRADER_HAIL_START + SPECIES_VOX] = "Добрый...день? Я не знаю, найдётся ли у нас что-то по размеру для вас...но вы всё ещё можете посмотреть!"

/datum/trader/ship/clothingshop/shoes
	possible_origins = list("Безопасно для Ног", "Звёздная Обувь", "Сапоги Гримбли", "Правильные Шаги")
	possible_trading_items = list(/obj/item/clothing/shoes                = TRADER_SUBTYPES_ONLY,
								/obj/item/clothing/shoes/chameleon        = TRADER_BLACKLIST,
								/obj/item/clothing/shoes/combat           = TRADER_BLACKLIST,
								/obj/item/clothing/shoes/clown_shoes      = TRADER_BLACKLIST,
								/obj/item/clothing/shoes/cult             = TRADER_BLACKLIST,
								/obj/item/clothing/shoes/cyborg           = TRADER_BLACKLIST,
								/obj/item/clothing/shoes/lightrig         = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/shoes/magboots         = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/shoes/swat             = TRADER_BLACKLIST,
								/obj/item/clothing/shoes/syndigaloshes    = TRADER_BLACKLIST)

/datum/trader/ship/clothingshop/hatglovesaccessories
	possible_origins = list("Шляпы и аксессуары Балди", "Шляпа как раз", "Космическая Мода")
	possible_trading_items = list(/obj/item/clothing/accessory            = TRADER_ALL,
								/obj/item/clothing/accessory/badge        = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/accessory/storage/holster      = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/accessory/medal        = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/accessory/storage      = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/gloves                 = TRADER_SUBTYPES_ONLY,
								/obj/item/clothing/gloves/lightrig        = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/gloves/rig             = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/gloves/thick/swat            = TRADER_BLACKLIST,
								/obj/item/clothing/gloves/chameleon       = TRADER_BLACKLIST,
								/obj/item/clothing/head                   = TRADER_SUBTYPES_ONLY,
								/obj/item/clothing/head/HoS               = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/head/beret/centcom     = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/head/bio_hood          = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/head/bomb_hood         = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/head/caphat            = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/head/centhat           = TRADER_BLACKLIST,
								/obj/item/clothing/head/chameleon         = TRADER_BLACKLIST,
								/obj/item/clothing/head/collectable       = TRADER_BLACKLIST,
								/obj/item/clothing/head/culthood          = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/head/helmet            = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/head/lightrig          = TRADER_BLACKLIST_ALL,
								/obj/item/clothing/head/radiation         = TRADER_BLACKLIST,
								/obj/item/clothing/head/warden            = TRADER_BLACKLIST,
								/obj/item/clothing/head/welding           = TRADER_BLACKLIST)



/*
Sells devices, odds and ends, and medical stuff
*/
/datum/trader/drugs
	name = "Наркодиллер"
	name_language = TRADER_DEFAULT_NAME
	origin = "Наркопритон"
	skill_req = SKILL_CHEMISTRY
	possible_origins = list("Карнавал чувств", "CBT", "Отвал башки", "Доктор Стоун", "Страна развлечений МакМаффина")
	possible_trading_items = list(/obj/item/device/kit/paint                 = TRADER_SUBTYPES_ONLY,

								/obj/item/device/paint_sprayer                                  = TRADER_THIS_TYPE,
								/obj/item/device/megaphone                                      = TRADER_THIS_TYPE,
								/obj/item/device/scanner/health                                 = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/syringe/drugs                      = TRADER_THIS_TYPE,
								/obj/item/storage/pill_bottle/three_eye                         = TRADER_THIS_TYPE,
								/obj/item/storage/pill_bottle/zoom                              = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/glass/beaker/vial/random           = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/food/snacks/grown/ambrosiavulgaris = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/food/snacks/grown/ambrosiadeus     = TRADER_THIS_TYPE,
								/obj/item/reagent_containers/food/drinks/bottle/oiljug          = TRADER_THIS_TYPE,
								/obj/item/device/scanner/reagent           = TRADER_ALL,
								/obj/item/stack/medical/advanced           = TRADER_ALL,
								)
	speech = list(TRADER_HAIL_GENERIC    = "ЙО-О-ОУ! Присаживайся! У нас тут есть буквально всё, чувак! От марихуаны до три-глаза и синего сока!",
				TRADER_HAIL_DENY         = "Чувак, даже у наркоши вроде меня есть чувства.",

				TRADER_TRADE_COMPLETE    = "Пасибки! А, и это, возврату если чё не подлежит, окда?",
				TRADER_NO_BLACKLISTED   = "Э-э...не, это нелегально даже для меня, чел.",
				TRADER_NO_GOODS    = "Сорян, но я только продаю!",
				TRADER_NOT_ENOUGH  = "Чел, я продаю РЕАЛЬНЫЙ ТОВАР, и я требую РЕАЛЬНЫХ денег.",
				TRADER_HOW_MUCH          = "Слушай...достать эту штучку мне стоило многого, но я бы продал её за VALUE.",

				TRADER_COMPLEMENT_FAILURE   = "Че-е-ел.",
				TRADER_COMPLEMENT_SUCCESS = "Брата-ан! Я всегда знал что ты крут!",
				TRADER_INSULT_GOOD       = "Чё говоришь? Не слышу! ВЖВЖВЖВЖВЖЖВЖВЖВЖВ!",
				TRADER_INSULT_BAD        = "Слушай, я же тебя копам...а, да, точно.",

				TRADER_BRIBE_FAILURE     = "Чувак, это СТАНЦИЯ. Ты там накурился уже, что ли? Как мы нахуй улетим куда-то?",
				)

	overmap_object_color = COLOR_PURPLE

/datum/trader/drugs/New()
	..()
	speech[TRADER_HAIL_START + "silicon"] = "Йо-оу, кибер-братан! Заходи-заходи, не стесняйся! У нас тут для тебя масло припасено!"

/datum/trader/ship/robots
	name = "Роботехник"
	name_language = TRADER_DEFAULT_NAME
	skill_req = SKILL_DEVICES
	origin = "Магазин Роботов"
	possible_origins = list("ИскИн здорового человека", "Механические Друзья", "Бот-Чоп-Шоп", "Производственная баржа ОМНИ")
	possible_trading_items = list(
								/obj/item/device/bot_kit                          = TRADER_THIS_TYPE,
								/obj/item/device/paicard                          = TRADER_THIS_TYPE,
								/obj/item/aicard                                  = TRADER_THIS_TYPE,
								/mob/living/bot                                   = TRADER_SUBTYPES_ONLY)
	speech = list(TRADER_HAIL_GENERIC = "Добро пожаловать в ORIGIN! Позвольте мне продемонстрировать вам весь ассортимент наших синтетических друзей!",
				TRADER_HAIL_DENY      = "ORIGIN не собирается продолжать с вами разговор.",

				TRADER_TRADE_COMPLETE = "Надеюсь, этот борг сослужит вам отличную службу!",
				TRADER_NO_BLACKLISTED= "Я работаю с РОБОТАМИ, а не с...этим.",
				TRADER_NO_GOODS = "Я продаю роботов, не покупаю их.",
				TRADER_NOT_ENOUGH = "Вижу, у вас не очень хорошо с деньгами.",
				TRADER_HOW_MUCH       = "Этот юнит обойдётся вам в VALUE!",

				TRADER_COMPLEMENT_FAILURE= "Ну, я почти поверил в сказанное вами.",
				TRADER_COMPLEMENT_SUCCESS= "Спасибо! Эта мастерская - работа всей моей жизни!",
				TRADER_INSULT_GOOD    = "Я промолчу...",
				TRADER_INSULT_BAD     = "Даже мои ИскИны способны на большее!",

				TRADER_BRIBE_FAILURE  = "Меня ждёт ещё туева куча клиентов.",
				TRADER_BRIBE_SUCCESS   = "Ну...я могу потратить ещё пару минут своего времени.",
				)

	overmap_object_color = COLOR_WHITE

/datum/trader/ship/robots/New()
	..()
	speech[TRADER_HAIL_START + "silicon"] = "Добро пожаловать в ORIGIN! Я- оу, ты синтетик! Что же, твои деньги тоже сойдут. Проходи, проходи!"

/datum/trader/xeno_shop
	name = "Коллекционер Ксенофауны"
	origin = "СТС 'Не браконьер'"
	skill_req = SKILL_SCIENCE
	trade_flags = TRADER_GOODS|TRADER_MONEY|TRADER_WANTED_ONLY|TRADER_WANTED_ALL
	possible_origins = list("Ксено-обнимашки", "Сборщик образцов корпорации 'Xynergy'", "Реселлер животных", "Отдел восстановления 'NanoTrasen '", "Пет-шоп одинокого Пита","Магазин Кузины Вей")
	speech = list(TRADER_HAIL_GENERIC    = "Добро пожаловать! У вас есть что предложить нам?.",
				TRADER_HAIL_DENY         = "Простите, но мы не желаем разговаривать с живодёрами и моральными уродами.",

				TRADER_TRADE_COMPLETE    = "Не забывайте следить за ними! Мы навестим вас, чтобы проверить их состояние позже!",
				TRADER_NO_BLACKLISTED   = "Легально, я не могу приобрести это. Морально...ну, я просто отказываюсь это делать.",
				TRADER_FOUND_UNWANTED = "Меня интересует лишь живность. Мне не нужна еда или эти ваши светящиеся штучки.",
				TRADER_NOT_ENOUGH   = "Я бы, конечно, отдал тебе его так...Но мне ещё нужно кормить чем-то остальных.",
				TRADER_HOW_MUCH          = "Отличный выбор. Он обойдётся вам в VALUE CURRENCY.",
				TRADER_WHAT_WANT         = "На данный момент у меня достаточно посредников.",

				TRADER_COMPLEMENT_FAILURE   = "Согласно законам 34 планет, с которыми я регулярно торгую, сказанное вами считается сексуальным харассментом.",
				TRADER_COMPLEMENT_SUCCESS = "Спасибо. Мне действительно было это нужно.",
				TRADER_INSULT_GOOD       = "Не нужно расстраиваться. Я уверена, что мы можем решить это.",
				TRADER_INSULT_BAD        = "Я продавала собак, которые лаяли громче и страшнее этого.",
				)

	possible_wanted_items = list(/mob/living/simple_animal/hostile/smart_beast/tindalos = TRADER_THIS_TYPE,
								/mob/living/simple_animal/passive/tomato                = TRADER_THIS_TYPE,
								/mob/living/simple_animal/hostile/smart_beast/yithian   = TRADER_THIS_TYPE,
								/mob/living/simple_animal/hostile/smart_beast/diyaab    = TRADER_THIS_TYPE,
								/mob/living/simple_animal/hostile/smart_beast/shantak   = TRADER_THIS_TYPE,
								/mob/living/simple_animal/hostile/smart_beast/samak     = TRADER_THIS_TYPE,
								/mob/living/simple_animal/hostile/carp                  = TRADER_THIS_TYPE)

	possible_trading_items = list(/mob/living/simple_animal/hostile/carp= TRADER_THIS_TYPE,
								/obj/item/beartrap			  = TRADER_THIS_TYPE,
								/obj/item/device/scanner/xenobio = TRADER_THIS_TYPE)

	overmap_object_color = COLOR_PURPLE

/datum/trader/medical
	name = "Поставщик Медицины"
	origin = "Лазарет СТС 'Неподчинённый'"
	skill_req = SKILL_MEDICAL
	trade_flags = TRADER_GOODS|TRADER_MONEY|TRADER_WANTED_ONLY
	want_multiplier = 1.2
	margin = 2
	possible_origins = list("Практика др. Крюгера", "Абсолютно легальная медицина (Возврату не подлежит)", "Опиоиды Мома и Попа", "Частная клиника Лили Свит")
	speech = list(TRADER_HAIL_GENERIC    = "Э? Откуда у вас этот номер?! Ну, если вы хотите поторговать...",
				TRADER_HAIL_DENY         = "Это предзаписанное сообщение. 'Трахни себя, мудила'.",

				TRADER_TRADE_COMPLETE    = "Было приятно иметь с вами дело. И помните, возврату не подлежит.",
				TRADER_NO_BLACKLISTED   = "Воу-воу-воу, полегче! Мы тут таким не промышляем.",
				TRADER_FOUND_UNWANTED = "И что, по вашему мнению, я должна делать с этим мусором?",
				TRADER_NOT_ENOUGH   = "Прости, приятель, но деньги вперёд.",
				TRADER_HOW_MUCH          = "Хм-м, как насчёт VALUE CURRENCY?",
				TRADER_WHAT_WANT         = "Слушай, мне бы действительно не помешало немного...",

				TRADER_COMPLEMENT_FAILURE   = "Ха-ха, как мило с твоей стороны. Почему бы тебе не пойти и грохнуться в лифтовую шахту?.",
				TRADER_COMPLEMENT_SUCCESS = "Слушай, ты всегда можешь пригласить меня на свидание в нерабочее время.",
				TRADER_INSULT_GOOD       = "Воу, приятель, обязательно быть ТАКИМ грубым? Я же девушка, всё-таки.",
				TRADER_INSULT_BAD        = "*приглушённый смех* Прости, кажется, я должна была оскорбиться?",
				)

	possible_wanted_items = list(/obj/item/reagent_containers/food/drinks/bottle = TRADER_THIS_TYPE,
								/obj/item/organ/internal/liver = TRADER_THIS_TYPE,
								/obj/item/organ/internal/kidneys = TRADER_THIS_TYPE,
								/obj/item/organ/internal/lungs = TRADER_THIS_TYPE,
								/obj/item/organ/internal/heart = TRADER_THIS_TYPE,
								/obj/item/storage/fancy/cigarettes = TRADER_ALL
								)

	possible_trading_items = list(/obj/item/storage/pill_bottle = TRADER_SUBTYPES_ONLY,
								  /obj/item/storage/firstaid/fire  = TRADER_THIS_TYPE,
								  /obj/item/storage/firstaid/toxin  = TRADER_THIS_TYPE,
								  /obj/item/storage/firstaid/adv  = TRADER_THIS_TYPE,
								  /obj/item/storage/box/bloodpacks  = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/ivbag  = TRADER_SUBTYPES_ONLY,
								  /obj/item/retractor = TRADER_THIS_TYPE,
								  /obj/item/hemostat = TRADER_THIS_TYPE,
								  /obj/item/cautery = TRADER_THIS_TYPE,
								  /obj/item/surgicaldrill = TRADER_THIS_TYPE,
								  /obj/item/scalpel = TRADER_THIS_TYPE,
								  /obj/item/scalpel/manager = TRADER_THIS_TYPE,
								  /obj/item/circular_saw = TRADER_THIS_TYPE,
								  /obj/item/bonegel = TRADER_THIS_TYPE,
								  /obj/item/bonesetter = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/glass/bottle/inaprovaline = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/glass/bottle/stoxin = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/glass/bottle/antitoxin = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/glass/bottle/inaprovaline = TRADER_THIS_TYPE,
								  /obj/item/bodybag/cryobag = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/dexalin/small = TRADER_THIS_TYPE,
								  /obj/item/sign/medipolma = TRADER_THIS_TYPE
								)

	overmap_object_color = COLOR_BLUE

/datum/trader/medical/chem
	name = "Поставщик Химикатов"
	skill_req = SKILL_CHEMISTRY
	origin = "Абсолютно легальная медицина (Возврату не подлежит)"
	possible_origins = list("Корпорация Ток-Хем", "PH International", "Группа Вагнера", "Абсолютно легальная медицина (Возврату не подлежит)")

	possible_wanted_items = list(/obj/item/reagent_containers/glass/bottle = TRADER_ALL,
								 /obj/item/reagent_containers/chem_disp_cartridge = TRADER_ALL
								)

	possible_trading_items = list(/obj/item/reagent_containers/glass/bottle =              TRADER_SUBTYPES_ONLY,
								  /obj/item/reagent_containers/glass/bottle/adminordrazine = TRADER_BLACKLIST,
								  /obj/item/reagent_containers/glass/bottle/chloralhydrate = TRADER_BLACKLIST,
								  /obj/item/reagent_containers/glass/bottle/cyanide = TRADER_BLACKLIST,
								  /obj/item/reagent_containers/glass/bottle/diethylamine = TRADER_BLACKLIST,
								  /obj/item/reagent_containers/glass/bottle/frostoil = TRADER_BLACKLIST,
								  /obj/item/reagent_containers/glass/bottle/frostoil = TRADER_BLACKLIST,
								  /obj/item/reagent_containers/chem_disp_cartridge = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/hydrazine = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/lithium = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/carbon = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/ammonia = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/acetone = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/sodium = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/aluminium = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/silicon = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/phosphorus = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/sulfur = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/hclacid = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/potassium = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/iron = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/copper = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/mercury = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/radium = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/ethanol = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/sugar = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/sacid = TRADER_THIS_TYPE,
								  /obj/item/reagent_containers/chem_disp_cartridge/tungsten = TRADER_THIS_TYPE
								  )

/datum/trader/mining
	name = "Добывающая корпорация 'Rock'n'Drill'"
	origin = "Автоматическая добывающая станция AH-532"
	trade_flags = TRADER_GOODS|TRADER_MONEY|TRADER_WANTED_ONLY|TRADER_WANTED_ALL
	want_multiplier = 1.5
	margin = 2
	possible_origins = list("RnD-AS 'Пивоварня'", "RnD-AS 'Саранча'",)
	speech = list(TRADER_HAIL_GENERIC    = "Добро пожаловать на производственную фабрику R'n'D. Пожалуйста, назовите ваш запрос.",
				TRADER_HAIL_DENY         = "...",

				TRADER_TRADE_COMPLETE    = "Транзакция произведена.",
				TRADER_NO_BLACKLISTED   = "Данный товар не принимается.",
				TRADER_FOUND_UNWANTED = "На данный момент мы не нуждаемся в данных ресурсах.",
				TRADER_NOT_ENOUGH   = "Данной суммы недостаточно для произведения покупки.",
				TRADER_HOW_MUCH          = "За один экземпляр ITEM, вы должны будете заплатить VALUE CURRENCY.",
				TRADER_WHAT_WANT         = "На данный момент нам требуется...",

				TRADER_COMPLEMENT_FAILURE   = "Простите, повторите ваш запрос.",
				TRADER_COMPLEMENT_SUCCESS = "Простите, повторите ваш запрос.",
				TRADER_INSULT_GOOD       = "Простите, повторите ваш запрос.",
				TRADER_INSULT_BAD        = "Простите, повторите ваш запрос.",
				)

	overmap_object_color = COLOR_BROWN

	insult_drop = 0
	compliment_increase = 0

	possible_wanted_items = list(/obj/item/ore/ = TRADER_SUBTYPES_ONLY,
								/obj/item/disk/survey = TRADER_THIS_TYPE,
								/obj/item/ore/slag = TRADER_BLACKLIST)

	possible_trading_items = list(/obj/machinery/mining/drill = TRADER_THIS_TYPE,
								  /obj/machinery/mining/brace = TRADER_THIS_TYPE,
								  /obj/machinery/floodlight = TRADER_THIS_TYPE,
								  /obj/machinery/floodlight = TRADER_THIS_TYPE,
								  /obj/item/storage/box/greenglowsticks = TRADER_THIS_TYPE,
								  /obj/item/clothing/suit/space/void/engineering/salvage/prepared  = TRADER_THIS_TYPE,
								  /obj/item/stack/material/uranium/ten = TRADER_THIS_TYPE,
								  /obj/item/stack/material/plasteel/fifty = TRADER_THIS_TYPE,
								  /obj/item/stack/material/steel/fifty = TRADER_THIS_TYPE
								)
