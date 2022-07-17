/obj/effect/landmark/corpse/city
	name = "Dead Civilian"
	corpse_outfits = list(/decl/hierarchy/outfit/cityciv)

/obj/effect/landmark/corpse/city/natarmay
	name = "Dead Trooper"
	corpse_outfits = list(/decl/hierarchy/outfit/citytrooper)

/obj/effect/landmark/corpse/city/natarmay/light
	name = "Dead Light Trooper"
	corpse_outfits = list(/decl/hierarchy/outfit/citytrooper/light)

/obj/effect/landmark/corpse/city/natarmay/sec_chief
	name = "Dead Security Chief"
	corpse_outfits = list(/decl/hierarchy/outfit/citytrooper/sec_chief)

/obj/effect/landmark/corpse/city/scientist
	name = "Dead Scientist"
	corpse_outfits = list(/decl/hierarchy/outfit/cityscience)

/obj/effect/landmark/corpse/city/director //����������� ��������� � ������� ��������� �� ����. ����� ���� ������ ����
	name = "Dead Director"
	corpse_outfits = list(/decl/hierarchy/outfit/citydirector)

/decl/hierarchy/outfit/cityciv
	name = OUTFIT_JOB_NAME ("Dead Civilian")
	uniform = /obj/item/clothing/under/lawyer/infil
//	suit =
	shoes = /obj/item/clothing/shoes/dress
//	gloves =
//	head =
//	back =
//	l_ear =

/decl/hierarchy/outfit/citytrooper
	name = OUTFIT_JOB_NAME ("Dead Trooper")
	uniform = /obj/item/clothing/under/solgov/utility/army
	suit = /obj/item/clothing/suit/armor/vest/solgov
	shoes = /obj/item/clothing/shoes/dutyboots
	gloves = /obj/item/clothing/gloves/thick/swat
	head = /obj/item/clothing/head/helmet/solgov
//	back =
//	l_ear =

/decl/hierarchy/outfit/citytrooper/light
	name = OUTFIT_JOB_NAME ("Dead Light Trooper")
	uniform = /obj/item/clothing/under/solgov/utility/army/tan/security
	suit = /obj/item/clothing/suit/armor/pcarrier/tan
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/thick/combat
	head = /obj/item/clothing/head/solgov/utility/army/tan
//	back =
//	l_ear =

/decl/hierarchy/outfit/citytrooper/sec_chief
	name = OUTFIT_JOB_NAME ("City Security Chief")
	uniform = /obj/item/clothing/under/solgov/utility/army/command
	suit = /obj/item/clothing/suit/armor/hos/jensen
	shoes = /obj/item/clothing/shoes/dress
	gloves = /obj/item/clothing/gloves/thick/duty/solgov/cmd
	head = /obj/item/clothing/head/solgov/service/army/command
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
