/datum/map_template/ruin/junkyard/junk_chunk
	name = "Random trash #1"
	id = "chunk1"
	description = "Just small ruins."
	suffixes = list("ruins/junk_1.dmm")
	spawn_cost = 0.5
	template_flags = TEMPLATE_FLAG_CLEAR_CONTENTS | TEMPLATE_FLAG_ALLOW_DUPLICATES
	ruin_tags = RUIN_WRECK

/datum/map_template/ruin/junkyard/junk_chunk/second
	name = "Random trash #2"
	id = "chunk2"
	suffixes = list("ruins/junk_2.dmm")
	spawn_cost = 0.8

/datum/map_template/ruin/junkyard/junk_chunk/third
	name = "Random trash #3"
	id = "chunk3"
	suffixes = list("ruins/junk_3.dmm")
	spawn_cost = 0.2

/datum/map_template/ruin/junkyard/junk_chunk/fourth
	name = "Random trash #4"
	id = "chunk4"
	suffixes = list("ruins/junk_4.dmm")
	spawn_cost = 0.2

/datum/map_template/ruin/junkyard/junk_chunk/fifth
	name = "Random trash #5"
	id = "chunk5"
	suffixes = list("ruins/junk_5.dmm")
	spawn_cost = 1

/datum/map_template/ruin/junkyard/junk_chunk/sixth
	name = "Random trash #6"
	id = "chunk6"
	suffixes = list("ruins/junk_6.dmm")
	spawn_cost = 0.2

/datum/map_template/ruin/junkyard/junk_chunk/seventh
	name = "Random trash #7"
	id = "chunk7"
	suffixes = list("ruins/junk_7.dmm")
	spawn_cost = 0.2

// Random spawns for junkyard with not-guaranteed chances, literally a copypaste of original ones made for easy access

/obj/random/junkyard/tool
	name = "random tool"
	desc = "This is a random tool."
	icon = 'icons/obj/tools.dmi'
	icon_state = "welder"
	spawn_nothing_percentage = 50

/obj/random/junkyard/tool/spawn_choices()
	return list(/obj/item/screwdriver,
				/obj/item/wirecutters,
				/obj/item/weldingtool,
				/obj/item/weldingtool/largetank,
				/obj/item/crowbar,
				/obj/item/wrench,
				/obj/item/device/flashlight,
				/obj/item/device/flashlight/upgraded)

/obj/random/junkyard/tech_supply
	name = "random tech supply"
	desc = "This is a random piece of technology supplies."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	spawn_nothing_percentage = 80

/obj/random/junkyard/tech_supply/spawn_choices()
	return list(/obj/random/powercell = 3,
				/obj/random/technology_scanner = 2,
				/obj/item/stack/package_wrap/twenty_five = 1,
				/obj/item/hand_labeler = 1,
				/obj/random/bomb_supply = 2,
				/obj/item/extinguisher = 1,
				/obj/item/clothing/gloves/insulated/cheap = 1,
				/obj/item/stack/cable_coil/random = 2,
				/obj/random/toolbox = 2,
				/obj/item/storage/belt/utility = 2,
				/obj/item/storage/belt/utility/atmostech = 1,
				/obj/random/tool = 5,
				/obj/item/tape_roll = 2)

/obj/random/junkyard/smokes
	name = "random smokeable"
	desc = "This is a random smokeable item."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "Bpacket"
	spawn_nothing_percentage = 50

/obj/random/junkyard/smokes/spawn_choices()
	return list(/obj/item/storage/fancy/cigarettes = 5,
				/obj/item/storage/fancy/cigarettes/dromedaryco = 4,
				/obj/item/storage/fancy/cigarettes/killthroat = 1,
				/obj/item/storage/fancy/cigarettes/luckystars = 3,
				/obj/item/storage/fancy/cigarettes/jerichos = 3,
				/obj/item/storage/fancy/cigarettes/menthols = 2,
				/obj/item/storage/fancy/cigarettes/carcinomas = 3,
				/obj/item/storage/fancy/cigarettes/professionals = 2,
				/obj/item/storage/fancy/cigar = 1,
				/obj/item/clothing/mask/smokable/cigarette = 2,
				/obj/item/clothing/mask/smokable/cigarette/menthol = 2,
				/obj/item/clothing/mask/smokable/cigarette/cigar = 1,
				/obj/item/clothing/mask/smokable/cigarette/cigar/cohiba = 1,
				/obj/item/clothing/mask/smokable/cigarette/cigar/havana = 1)

/obj/random/junkyard/powercell
	name = "random powercell"
	desc = "This is a random powercell."
	icon = 'icons/obj/power.dmi'
	icon_state = "hcell"
	spawn_nothing_percentage = 80

/obj/random/junkyard/powercell/spawn_choices()
	return list(/obj/item/cell/crap = 1,
				/obj/item/cell/standard = 8,
				/obj/item/cell/high = 5,
				/obj/item/cell/super = 2,
				/obj/item/cell/hyper = 1,
				/obj/item/cell/device/standard = 7,
				/obj/item/cell/device/high = 5)

/obj/random/junkyard/bomb_supply
	name = "bomb supply"
	desc = "This is a random bomb supply."
	icon = 'icons/obj/assemblies/new_assemblies.dmi'
	icon_state = "signaller"
	spawn_nothing_percentage = 30

/obj/random/junkyard/bomb_supply/spawn_choices()
	return list(/obj/item/device/assembly/igniter,
				/obj/item/device/assembly/prox_sensor,
				/obj/item/device/assembly/signaler,
				/obj/item/device/assembly/timer,
				/obj/item/device/multitool)

/obj/random/junkyard/toolbox
	name = "random toolbox"
	desc = "This is a random toolbox."
	icon = 'icons/obj/storage.dmi'
	icon_state = "red"
	spawn_nothing_percentage = 30

/obj/random/junkyard/toolbox/spawn_choices()
	return list(/obj/item/storage/toolbox/mechanical = 30,
				/obj/item/storage/toolbox/electrical = 20,
				/obj/item/storage/toolbox/emergency = 20,
				/obj/item/storage/toolbox/syndicate = 1)

/obj/random/junkyard/medical
	name = "Random Medical equipment"
	desc = "This is a random medical item."
	icon = 'icons/obj/items.dmi'
	icon_state = "medrandom"
	spawn_nothing_percentage = 50

/obj/random/junkyard/medical/spawn_choices()
	return list(/obj/random/medical/lite = 21,
				/obj/item/bodybag = 2,
				/obj/item/reagent_containers/glass/bottle/inaprovaline = 2,
				/obj/item/reagent_containers/glass/bottle/antitoxin = 2,
				/obj/item/storage/pill_bottle = 2,
				/obj/item/storage/pill_bottle/tramadol = 1,
				/obj/item/storage/pill_bottle/citalopram = 2,
				/obj/item/storage/pill_bottle/dexalin_plus = 1,
				/obj/item/storage/pill_bottle/dermaline = 1,
				/obj/item/storage/pill_bottle/bicaridine = 1,
				/obj/item/reagent_containers/syringe/antitoxin = 2,
				/obj/item/reagent_containers/syringe/antiviral = 1,
				/obj/item/reagent_containers/syringe/inaprovaline = 2,
				/obj/item/storage/box/freezer = 1,
				/obj/item/stack/nanopaste = 1)

/obj/random/junkyard/medical/lite
	name = "Random Medicine"
	desc = "This is a random simple medical item."
	icon = 'icons/obj/items.dmi'
	icon_state = "medrandom"
	spawn_nothing_percentage = 25

/obj/random/junkyard/medical/lite/spawn_choices()
	return list(/obj/item/stack/medical/bruise_pack = 4,
				/obj/item/stack/medical/ointment = 4,
				/obj/item/storage/pill_bottle/antidexafen = 2,
				/obj/item/storage/pill_bottle/paracetamol = 2,
				/obj/item/stack/medical/advanced/bruise_pack = 2,
				/obj/item/stack/medical/advanced/ointment = 2,
				/obj/item/stack/medical/splint = 1,
				/obj/item/reagent_containers/hypospray/autoinjector = 3,
				/obj/item/storage/pill_bottle/kelotane = 2,
				/obj/item/storage/pill_bottle/antitox = 2,
				/obj/item/storage/med_pouch/trauma = 2,
				/obj/item/storage/med_pouch/burn = 2,
				/obj/item/storage/med_pouch/toxin = 2,
				/obj/item/storage/med_pouch/radiation = 2,
				/obj/item/storage/med_pouch/oxyloss = 2)

/obj/random/junkyard/material //Random materials for building stuff
	name = "random material"
	desc = "This is a random material."
	icon = 'icons/obj/materials.dmi'
	icon_state = "sheet"
	spawn_nothing_percentage = 60

/obj/random/junkyard/material/spawn_choices()
	return list(/obj/item/stack/material/steel/ten,
				/obj/item/stack/material/glass/ten,
				/obj/item/stack/material/glass/reinforced/ten,
				/obj/item/stack/material/plastic/ten,
				/obj/item/stack/material/wood/ten,
				/obj/item/stack/material/cardboard/ten,
				/obj/item/stack/material/rods/ten,
				/obj/item/stack/material/plasteel/ten,
				/obj/item/stack/material/steel/fifty,
				/obj/item/stack/material/glass/fifty,
				/obj/item/stack/material/glass/reinforced/fifty,
				/obj/item/stack/material/plastic/fifty,
				/obj/item/stack/material/wood/fifty,
				/obj/item/stack/material/cardboard/fifty,
				/obj/item/stack/material/rods/fifty,
				/obj/item/stack/material/plasteel/fifty)

/obj/random/junkyard/biggun
	name = "Random Heavy Weapon"
	desc = "This is a random rifle."
	icon = 'icons/obj/guns/assault_rifle.dmi'
	icon_state = "arifle"
	spawn_nothing_percentage = 50

/obj/random/junkyard/biggun/spawn_choices()
	return list(/obj/item/gun/energy/lasercannon,
				/obj/item/gun/energy/laser,
				/obj/item/gun/energy/captain,
				/obj/item/gun/energy/pulse_rifle,
				/obj/item/gun/energy/pulse_rifle/carbine,
				/obj/item/gun/energy/sniperrifle,
				/obj/item/gun/projectile/shotgun/doublebarrel,
				/obj/item/gun/energy/xray,
				/obj/item/gun/projectile/automatic/battlerifle,
				/obj/item/gun/projectile/sniper/semistrip,
				/obj/item/gun/projectile/sniper/garand,
				/obj/item/gun/projectile/automatic/assault_rifle,
				/obj/item/gun/projectile/automatic/sec_smg,
				/obj/item/gun/energy/crossbow/largecrossbow,
				/obj/item/gun/projectile/shotgun/pump/combat,
				/obj/item/gun/energy/ionrifle,
				/obj/item/gun/projectile/shotgun/pump
	)

/obj/random/junkyard/lilgun
	name = "Random Light Weapon"
	desc = "This is a random sidearm."
	icon = 'icons/obj/guns/pistol.dmi'
	icon_state = "secguncomp"
	spawn_nothing_percentage = 50

/obj/random/junkyard/lilgun/spawn_choices()
	return list(/obj/item/gun/projectile/pistol/sec,
				/obj/item/gun/energy/gun,
				/obj/item/gun/energy/stunrevolver,
				/obj/item/gun/projectile/shotgun/doublebarrel/sawn,
				/obj/item/gun/energy/xray/pistol,
				/obj/item/gun/energy/pulse_rifle/pistol,
				/obj/item/gun/energy/plasmacutter,
				/obj/item/gun/energy/incendiary_laser,
				/obj/item/gun/projectile/automatic/machine_pistol,
				/obj/item/gun/projectile/pistol/military/alt,
				/obj/item/gun/projectile/pistol/holdout,
				/obj/item/gun/projectile/revolver,
				/obj/item/gun/projectile/revolver/medium,
				/obj/item/gun/energy/retro,
				/obj/item/gun/projectile/pistol/throwback,
				/obj/item/gun/energy/ionrifle/small
	)

/obj/random/junkyard/ammo
	name = "Random Ammunition"
	desc = "This is random ammunition."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "magnum"
	spawn_nothing_percentage = 30

/obj/random/junkyard/ammo/spawn_choices()
	return list(/obj/item/storage/box/ammo/beanbags = 6,
				/obj/item/storage/box/ammo/shotgunammo = 2,
				/obj/item/storage/box/ammo/shotgunshells = 4,
				/obj/item/storage/box/ammo/flechetteshells = 2,
				/obj/item/storage/box/ammo/stunshells = 1,
				/obj/item/ammo_magazine/pistol = 2,
				/obj/item/ammo_magazine/smg_top = 2,
				/obj/item/ammo_magazine/smg_top/rubber = 6,
				/obj/item/ammo_magazine/pistol/throwback = 1)

/obj/random/junkyard/cash
	name = "random currency"
	desc = "LOADSAMONEY!"
	icon = 'icons/obj/items.dmi'
	icon_state = "spacecash1"
	spawn_nothing_percentage = 50

/obj/random/cash/junkyard/spawn_choices()
	return list(/obj/item/spacecash/bundle/c1 = 4,
				/obj/item/spacecash/bundle/c10 = 3,
				/obj/item/spacecash/bundle/c20 = 3,
				/obj/item/spacecash/bundle/c50 = 2,
				/obj/item/spacecash/bundle/c100 = 2,
				/obj/item/spacecash/bundle/c1000 = 1)

/obj/random/junkyard/advdevice
	name = "random advanced device"
	desc = "This is a random advanced device."
	icon = 'icons/obj/items.dmi'
	icon_state = "game_kit"
	spawn_nothing_percentage = 30

/obj/random/junkyard/advdevice/spawn_choices()
	return list(/obj/item/device/flashlight/lantern,
				/obj/item/device/flashlight/flare,
				/obj/item/device/flashlight/pen,
				/obj/item/device/toner,
				/obj/item/device/paicard,
				/obj/item/device/destTagger,
				/obj/item/beartrap,
				/obj/item/handcuffs,
				/obj/item/camera_assembly,
				/obj/item/device/camera,
				/obj/item/modular_computer/pda,
				/obj/item/card/emag_broken,
				/obj/item/device/radio/headset,
				/obj/item/device/flashlight/flare/glowstick/yellow,
				/obj/item/device/flashlight/flare/glowstick/orange,
				/obj/item/grenade/light,
				/obj/item/device/oxycandle,
				/obj/item/device/flashlight/upgraded)

/obj/random/junkyard/handgun
	name = "Random Handgun"
	desc = "This is a random sidearm."
	icon = 'icons/obj/guns/pistol.dmi'
	icon_state = "secguncomp"
	spawn_nothing_percentage = 50

/obj/random/junkyard/handgun/spawn_choices()
	return list(/obj/item/gun/projectile/pistol/sec = 3,
				/obj/item/gun/energy/gun = 2,
				/obj/item/gun/projectile/pistol/military/alt = 1,
				/obj/item/gun/projectile/pistol/holdout = 2,
				/obj/item/gun/energy/retro = 1,
				/obj/item/gun/projectile/pistol/throwback = 1,
				/obj/item/gun/projectile/pistol/broomstick = 1)

obj/random/junkyard/obstruction //Large objects to block things off in maintenance
	name = "random obstruction"
	desc = "This is a random obstruction."
	icon = 'icons/obj/cult.dmi'
	icon_state = "cultgirder"
	spawn_nothing_percentage = 30

obj/random/junkyard/obstruction/spawn_choices()
	return list(/obj/structure/barricade,
				/obj/structure/girder,
				/obj/structure/girder/displaced,
				/obj/structure/grille,
				/obj/structure/grille/broken,
				/obj/structure/foamedmetal,
				/obj/item/caution,
				/obj/item/caution/cone,
				/obj/structure/inflatable/wall,
				/obj/structure/inflatable/door)

obj/random/junkyard/pod
	name = "survivor pod"
	desc = "This is a random survivor pod."
	icon_state = "x3"
	spawn_nothing_percentage = 80

obj/random/junkyard/pod/spawn_choices()
	return list(/obj/structure/abandoned_cryo)

/obj/random/junkyard/loot /*Better loot for away missions and salvage */
	name = "random loot"
	desc = "This is some random loot."
	icon = 'icons/obj/items.dmi'
	icon_state = "gift3"
	spawn_nothing_percentage = 30

/obj/random/junkyard/loot/spawn_choices()
	return list(/obj/random/junkyard/tool = 10,
				/obj/random/junkyard/ammo = 10,
				/obj/random/junkyard/biggun = 10,
				/obj/random/junkyard/lilgun = 10,
				/obj/random/junkyard/handgun = 10,
				/obj/random/junkyard/material = 10,
				/obj/random/junkyard/medical/lite = 10,
				/obj/random/junkyard/toolbox = 10,
				/obj/random/junkyard/cash = 10,
				/obj/random/junkyard/advdevice = 10,
				/obj/random/junkyard/tech_supply = 10,
				/obj/item/clothing/mask/muzzle = 7,
				/obj/item/clothing/mask/gas/vox = 8,
				/obj/item/clothing/mask/gas/syndicate = 10,
				/obj/item/clothing/glasses/night = 3,
				/obj/item/clothing/glasses/thermal = 1,
				/obj/item/clothing/glasses/welding/superior = 7,
				/obj/item/clothing/head/collectable/petehat = 4,
				/obj/item/clothing/suit/storage/vest/merc = 3,
				/obj/item/clothing/suit/straight_jacket = 6,
				/obj/item/clothing/head/helmet/merc = 3,
				/obj/item/stack/material/diamond/ten = 7,
				/obj/item/stack/material/glass/phoronrglass/ten = 7,
				/obj/item/stack/material/marble/ten = 8,
				/obj/item/stack/material/phoron/ten = 7,
				/obj/item/stack/material/gold/ten = 7,
				/obj/item/stack/material/silver/ten = 7,
				/obj/item/stack/material/osmium/ten = 7,
				/obj/item/stack/material/platinum/ten = 8,
				/obj/item/stack/material/tritium/ten = 7,
				/obj/item/stack/material/mhydrogen/ten = 6,
				/obj/item/stack/material/plasteel/ten = 9,
				/obj/item/storage/box/monkeycubes = 5,
				/obj/item/storage/box/monkeycubes/neaeracubes = 4,
				/obj/item/storage/box/monkeycubes/stokcubes = 4,
				/obj/item/storage/box/monkeycubes/farwacubes = 4,
				/obj/item/storage/firstaid/surgery = 4,
				/obj/item/archaeological_find = 2,
				/obj/item/device/multitool/hacktool = 2,
				/obj/item/surgicaldrill = 7,
				/obj/item/FixOVein = 7,
				/obj/item/retractor = 7,
				/obj/item/hemostat = 7,
				/obj/item/cautery = 7,
				/obj/item/bonesetter = 7,
				/obj/item/bonegel = 7,
				/obj/item/circular_saw = 7,
				/obj/item/scalpel = 7,
				/obj/item/melee/baton/loaded = 9,
				/obj/item/device/radio/headset/syndicate = 6)

/obj/random/junkyard/hostile
	name = "Random Hostile Mob"
	desc = "This is a random hostile mob."
	icon = 'icons/mob/crow.dmi'
	icon_state = "crow"
	spawn_nothing_percentage = 80

obj/random/junkyard/hostile/spawn_choices()
	return list(/mob/living/simple_animal/hostile/viscerator,
				/mob/living/simple_animal/hostile/carp,
				/mob/living/simple_animal/hostile/carp/pike,
				/mob/living/simple_animal/hostile/hivebot/range,
				/mob/living/simple_animal/hostile/hivebot/strong,
				/mob/living/simple_animal/hostile/hivebot/rapid)