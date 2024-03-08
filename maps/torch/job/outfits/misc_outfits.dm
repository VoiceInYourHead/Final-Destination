/decl/hierarchy/outfit/job/torch/passenger/passenger
	name = OUTFIT_JOB_NAME("Passenger - Torch")
	uniform = /obj/item/clothing/under/syndicate/combat
	l_ear = /obj/item/device/radio/headset
	shoes = /obj/item/clothing/shoes/dutyboots
	pda_type = /obj/item/modular_computer/pda
	r_pocket = /obj/item/device/radio/hailing
	id_types = list(/obj/item/card/id/torch/passenger)

/decl/hierarchy/outfit/job/torch/passenger/passenger/engineer
	name = OUTFIT_JOB_NAME("Passenger - Engineer")
	suit = /obj/item/clothing/suit/storage/hazardvest
	belt = /obj/item/storage/belt/utility/full
	gloves = /obj/item/clothing/gloves/insulated/black
	backpack_contents = list(/obj/item/stack/material/steel/fifty = 1, /obj/item/stack/material/glass/fifty = 1)

/decl/hierarchy/outfit/job/torch/passenger/passenger/doctor
	name = OUTFIT_JOB_NAME("Passenger - Doctor")
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/coat
	belt = /obj/item/storage/belt/medical/emt
	gloves = /obj/item/clothing/gloves/latex/nitrile
	backpack_contents = list(/obj/item/storage/firstaid/surgery = 1, /obj/item/storage/firstaid/combat = 1)

/decl/hierarchy/outfit/job/torch/passenger/passenger/soldier
	name = OUTFIT_JOB_NAME("Passenger - Soldier")
	uniform = /obj/item/clothing/under/solgov/utility/army
	head = /obj/item/clothing/head/solgov/utility/army
	back = /obj/item/storage/backpack/rucksack/green
	shoes = /obj/item/clothing/shoes/jungleboots
	suit = /obj/item/clothing/suit/armor/pcarrier/medium/sol
	belt = /obj/item/storage/belt/holster/security/tactical
	backpack_contents = list(/obj/item/gun/projectile/pistol/military = 1, /obj/item/ammo_magazine/pistol/double = 2)

/decl/hierarchy/outfit/job/torch/passenger/passenger/soldier/iccgn
	name = OUTFIT_JOB_NAME("Passenger - Soldier ICCGN")
	head = /obj/item/clothing/head/iccgn/beret
	uniform = /obj/item/clothing/under/iccgn/utility
	shoes = /obj/item/clothing/shoes/iccgn/utility
	gloves = /obj/item/clothing/gloves/iccgn/duty
	suit = /obj/item/clothing/suit/armor/pcarrier/medium

/decl/hierarchy/outfit/job/torch/passenger/passenger/soldier/fleet
	name = OUTFIT_JOB_NAME("Passenger - Fleet Crew")
	hierarchy_type = /decl/hierarchy/outfit/job/torch/crew/fleet
	uniform = /obj/item/clothing/under/solgov/utility/fleet
	shoes = /obj/item/clothing/shoes/dutyboots

/decl/hierarchy/outfit/job/torch/passenger/passenger/explorer
	name = OUTFIT_JOB_NAME("Passenger - Explorer")
	hierarchy_type = /decl/hierarchy/outfit/job/torch/crew
	uniform = /obj/item/clothing/under/solgov/utility/expeditionary
	belt = /obj/item/storage/belt/holster/machete
	backpack_contents = list(/obj/item/device/scanner/gas = 1, /obj/item/device/scanner/plant = 1, /obj/item/device/scanner/xenobio = 1, /obj/item/material/hatchet/machete/steel = 1)

/decl/hierarchy/outfit/job/torch/passenger/passenger/vagabond
	name = OUTFIT_JOB_NAME("Vagabond - Recon")
	belt = /obj/item/storage/belt/holster/machete
	back = /obj/item/storage/backpack/dufflebag
	backpack_contents = list(/obj/item/device/flashlight/maglight = 1, /obj/item/device/holopad = 1, /obj/item/device/binoculars = 1)

/decl/hierarchy/outfit/job/torch/passenger/passenger/psychologist
	name = OUTFIT_JOB_NAME("Passenger - Psychologist")
	uniform = /obj/item/clothing/under/rank/psych/turtleneck
	shoes = /obj/item/clothing/shoes/laceup

/decl/hierarchy/outfit/job/torch/passenger/passenger/journalist
	name = OUTFIT_JOB_NAME("Journalist - Torch")
	backpack_contents = list(/obj/item/device/camera/tvcamera = 1,
	/obj/item/clothing/accessory/badge/press = 1)

/decl/hierarchy/outfit/job/torch/passenger/passenger/investor
	name = OUTFIT_JOB_NAME("Investor - Torch")

/decl/hierarchy/outfit/job/torch/passenger/passenger/investor/post_equip(var/mob/living/carbon/human/H)
	..()
	var/obj/item/storage/secure/briefcase/money/case = new(H.loc)
	H.put_in_hands(case)

/decl/hierarchy/outfit/job/torch/merchant
	name = OUTFIT_JOB_NAME("Merchant - Torch")
	uniform = /obj/item/clothing/under/color/black
	l_ear = null
	shoes = /obj/item/clothing/shoes/black
	pda_type = /obj/item/modular_computer/pda
	id_types = list(/obj/item/card/id/torch/merchant)

/decl/hierarchy/outfit/job/torch/ert
	name = OUTFIT_JOB_NAME("ERT - Torch")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/combat
	head = /obj/item/clothing/head/beret/solgov/fleet
	gloves = /obj/item/clothing/gloves/thick
	id_types = list(/obj/item/card/id/centcom/ERT)
	pda_type = /obj/item/modular_computer/pda/ert
	l_ear = /obj/item/device/radio/headset/ert
	shoes = /obj/item/clothing/shoes/dutyboots

/decl/hierarchy/outfit/job/torch/ert/leader
	name = OUTFIT_JOB_NAME("ERT Leader - Torch")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/combat/command
	head = /obj/item/clothing/head/beret/solgov/fleet/command

/decl/hierarchy/outfit/job/torch/ert/suit
	name = OUTFIT_JOB_NAME("ERT Heavy - Torch")
	back = /obj/item/rig/ert/fleet
	flags = OUTFIT_RESET_EQUIPMENT | OUTFIT_ADJUSTMENT_SKIP_BACKPACK
	head = null
	gloves = null
