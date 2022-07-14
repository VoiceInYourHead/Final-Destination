/obj/effect/landmark/corpse/city
	name = "Dead Civilian"
	corpse_outfits = list(/decl/hierarchy/outfit/cityciv)

/obj/effect/landmark/corpse/city/natarmay
	name = "Dead Trooper"
	corpse_outfits = list(/decl/hierarchy/outfit/citytrooper)

/obj/effect/landmark/corpse/city/scientist
	name = "Dead Scientist"
	corpse_outfits = list(/decl/hierarchy/outfit/cityscience)

/obj/effect/landmark/corpse/city/director //обязательно поместить в кабинет директора за стол. Может быть только один
	name = "Dead Director"
	corpse_outfits = list(/decl/hierarchy/outfit/citydirector)

/decl/hierarchy/outfit/cityciv
	name = OUTFIT_JOB_NAME ("Dead Civilian")
//	uniform =
//	suit =
//	shoes =
//	gloves =
//	head =
//	back =
//	l_ear =

/decl/hierarchy/outfit/cityciv/New()
	shoes = pick(/obj/item/clothing/shoes/dress,/obj/item/clothing/shoes/dutyboots)
	uniform = pick(/obj/item/clothing/under/suit_jacket/really_black,/obj/item/clothing/under/overalls,/obj/item/clothing/under/lawyer/infil,/obj/item/clothing/under/lawyer/oldman,/obj/item/clothing/under/frontier,/obj/item/clothing/under/blazer)

/decl/hierarchy/outfit/citytrooper
	name = OUTFIT_JOB_NAME ("Dead Trooper")
	uniform = /obj/item/clothing/under/solgov/utility/army
	suit = /obj/item/clothing/suit/armor/vest/solgov
	shoes = /obj/item/clothing/shoes/dutyboots
	gloves = /obj/item/clothing/gloves/thick/swat
	head = /obj/item/clothing/head/helmet/solgov
//	back =
//	l_ear =

/decl/hierarchy/outfit/cityscience
	name = OUTFIT_JOB_NAME ("Dead Scientist")
	uniform = /obj/item/clothing/under/rank/scientist
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/science/ec
	shoes = /obj/item/clothing/shoes/dress
//	gloves =
//	head =
//	back =
//	l_ear =

/decl/hierarchy/outfit/citydirector
	name = OUTFIT_JOB_NAME ("Dead Director")
	uniform = /obj/item/clothing/under/rank/research_director/rdalt
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/rd/ec
	shoes = /obj/item/clothing/shoes/dress
//	gloves =
//	head =
//	back =
//	l_ear =