#include "gccv_ulyanovsk_areas.dm"
#include "gccv_ulyanovsk_radio.dm"
#include "gccv_ulyanovsk_shuttles.dm"
#include "gccv_ulyanovsk_jobs.dm"

/obj/effect/overmap/visitable/ship/gccv_ulyanovsk
	name = "GCCV - Ulyanovsk"
	desc = "Waterloo-Class Heavy Cruiser broadcasting codes 'GCCV - Ulyanovsk', belonging to the Confederation."
	icon_state = "ship"
	color = "#c79fa9"
	known = 0
	initial_generic_waypoints = list()
	initial_restricted_waypoints = list(

	)

/datum/map_template/ruin/away_site/gccv_ulyanovsk
	name = "GCCV - Ulyanovsk"
	id = "awaysite_gccv_ulyanovsk"
	description = "This is A Heavy Aircraft Carrier Of The Confederation."
	suffixes = list("gccv_ulyanovsk/gccv_ulyanovsk1.dmm", "gccv_ulyanovsk/gccv_ulyanovsk2.dmm", "gccv_ulyanovsk/gccv_ulyanovsk3.dmm")
	spawn_cost = 99
	shuttles_to_initialise = list()
	area_usage_test_exempted_root_areas = list()
	apc_test_exempt_areas = list()



// Misc

/turf/simulated/wall/iccg
	paint_color = COLOR_DARK_BLUE_GRAY

/turf/simulated/wall/iccg/New(var/newloc)
	..(newloc, MATERIAL_PLASTEEL)

/turf/simulated/wall/r_iccg
	paint_color = COLOR_DARK_BLUE_GRAY
	icon_state = "r_generic"
	explosion_resistance_add = 50
	floor_type = /turf/simulated/floor/reinforced

/turf/simulated/wall/r_iccg/New(var/newloc)
	..(newloc, MATERIAL_PLASTEEL,MATERIAL_PLASTEEL)

/turf/simulated/wall/r_iccg/Initialize()
	. = ..()
	color = null //color is just for mapping
	health_max = health_current + 100
	health_current = health_max
	if(prob(90))
		var/spacefacing = FALSE
		for(var/direction in GLOB.cardinal)
			var/turf/T = get_step(src, direction)
			var/area/A = get_area(T)
			if(A && (A.area_flags & AREA_FLAG_EXTERNAL))
				spacefacing = TRUE
				break
		if(spacefacing)
			var/bleach_factor = rand(10,50)
			paint_color = "[pick("#420d0d", COLOR_DARK_GRAY)]"
			paint_color = adjust_brightness(paint_color, bleach_factor)
	update_icon()

/obj/structure/grille/plasteel
	init_material = MATERIAL_PLASTEEL

/obj/structure/wall_frame/iccg
	paint_color = COLOR_DARK_BLUE_GRAY
	material = MATERIAL_PLASTEEL

/obj/effect/wallframe_spawn/iccg
	name = "iccg wall frame window spawner"
	frame_path = /obj/structure/wall_frame/iccg
	grille_path = null

/obj/effect/wallframe_spawn/reinforced/iccg
	name = "reinforced iccg wall frame window spawner"
	frame_path = /obj/structure/wall_frame/iccg
	grille_path = /obj/structure/grille/plasteel

/obj/item/grenade/chem_grenade/large/metalfoam
	name = "metal-foam grenade"
	desc = "Used for emergency sealing of air breaches."
	path = 1
	stage = 2


/obj/item/grenade/chem_grenade/large/metalfoam/Initialize()
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/large/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/large/B2 = new(src)
	B1.reagents.add_reagent(/datum/reagent/aluminium, 120)
	B2.reagents.add_reagent(/datum/reagent/foaming_agent, 60)
	B2.reagents.add_reagent(/datum/reagent/acid/polyacid, 60)
	detonator = new/obj/item/device/assembly_holder/timer_igniter(src)
	beakers += B1
	beakers += B2
	icon_state = initial(icon_state) +"_locked"

/obj/turbolift_map_holder/ulyanovsk1
	name = "Ulyanovsk 1 turbolift map placeholder"
	depth = 3
	lift_size_x = 4
	lift_size_y = 4

	areas_to_use = list(
		/area/turbolift/ulyanovsk1,
		/area/turbolift/ulyanovsk1/deck2,
		/area/turbolift/ulyanovsk1/deck1
		)

/obj/turbolift_map_holder/ulyanovsk2
	name = "Ulyanovsk 2 turbolift map placeholder"
	depth = 3
	dir = NORTH
	lift_size_x = 4
	lift_size_y = 4

	areas_to_use = list(
		/area/turbolift/ulyanovsk2,
		/area/turbolift/ulyanovsk2/deck2,
		/area/turbolift/ulyanovsk2/deck1
		)

/obj/turbolift_map_holder/ulyanovsk3
	name = "Ulyanovsk 3 turbolift map placeholder"
	icon = 'icons/obj/turbolift_preview_2x2.dmi'
	depth = 3
	lift_size_x = 3
	lift_size_y = 3

	areas_to_use = list(
		/area/turbolift/ulyanovsk3,
		/area/turbolift/ulyanovsk3/deck2,
		/area/turbolift/ulyanovsk3/deck1
		)


/obj/item/clothing/suit/space/void/iccg
	name = "armored terran voidsuit"
	desc = "A somewhat clumsy voidsuit layered with impact and laser-resistant armor plating. Specially designed to dissipate minor electrical charges."
	icon_state = "rig_iccg"
	item_state_slots = list(
		slot_l_hand_str = "sec_voidsuit",
		slot_r_hand_str = "sec_voidsuit",
	)
	armor = list(
		melee = ARMOR_MELEE_MAJOR,
		bullet = ARMOR_BALLISTIC_RESISTANT,
		laser = ARMOR_LASER_HANDGUNS,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_RESISTANT
		)
	siemens_coefficient = 0.3
	allowed = list(/obj/item/device/flashlight,/obj/item/tank,/obj/item/device/suit_cooling_unit,/obj/item/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/melee/energy/sword,/obj/item/handcuffs)

/obj/item/clothing/head/helmet/space/void/iccg
	name = "armored terran voidsuit helmet"
	desc = "A comfortable voidsuit helmet with cranial armor and eight-channel surround sound."
	icon_state = "rig_iccg"
	item_state = "rig_iccg"
	item_state_slots = list(
		slot_l_hand_str = "sec_helm",
		slot_r_hand_str = "sec_helm",
		)
	armor = list(
		melee = ARMOR_MELEE_MAJOR,
		bullet = ARMOR_BALLISTIC_RESISTANT,
		laser = ARMOR_LASER_HANDGUNS,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_RESISTANT
		)
	siemens_coefficient = 0.3

/obj/item/clothing/suit/space/void/iccg/engineering
	name = "armored engineering voidsuit"
	icon_state = "rig_iccg_engi"
	armor = list(
		melee = ARMOR_MELEE_MAJOR,
		bullet = ARMOR_BALLISTIC_RESISTANT,
		laser = ARMOR_LASER_HANDGUNS,
		energy = ARMOR_ENERGY_SMALL,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_SHIELDED
		)
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	max_pressure_protection = ENG_VOIDSUIT_MAX_PRESSURE

/obj/item/clothing/head/helmet/space/void/iccg/engineering
	name = "armored engineering voidsuit helmet"
	icon_state = "rig_iccg_engi"
	item_state = "rig_iccg_engi"
	flash_protection = FLASH_PROTECTION_MAJOR
	armor = list(
		melee = ARMOR_MELEE_MAJOR,
		bullet = ARMOR_BALLISTIC_RESISTANT,
		laser = ARMOR_LASER_HANDGUNS,
		energy = ARMOR_ENERGY_SMALL,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_SHIELDED
		)
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECTION_TEMPERATURE
	max_pressure_protection = ENG_VOIDSUIT_MAX_PRESSURE

/obj/item/clothing/suit/space/void/iccg/security
	name = "armored security voidsuit"
	icon_state = "rig_iccg_sec"
	armor = list(
		melee = ARMOR_MELEE_VERY_HIGH,
		bullet = ARMOR_BALLISTIC_RIFLE,
		laser = ARMOR_LASER_MAJOR,
		energy = ARMOR_ENERGY_RESISTANT,
		bomb = ARMOR_BOMB_RESISTANT,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_RESISTANT
		)

/obj/item/clothing/head/helmet/space/void/iccg/security
	name = "armored security voidsuit helmet"
	icon_state = "rig_iccg_sec"
	item_state = "rig_iccg_sec"
	flash_protection = FLASH_PROTECTION_MAJOR
	armor = list(
		melee = ARMOR_MELEE_VERY_HIGH,
		bullet = ARMOR_BALLISTIC_RIFLE,
		laser = ARMOR_LASER_MAJOR,
		energy = ARMOR_ENERGY_RESISTANT,
		bomb = ARMOR_BOMB_RESISTANT,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_RESISTANT
		)

/obj/item/clothing/suit/space/void/iccg/command
	name = "armored command voidsuit"
	icon_state = "rig_iccg_com"
	armor = list(
		melee = ARMOR_MELEE_MAJOR,
		bullet = ARMOR_BALLISTIC_RESISTANT,
		laser = ARMOR_LASER_RIFLES,
		energy = ARMOR_ENERGY_STRONG,
		bomb = ARMOR_BOMB_RESISTANT,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_RESISTANT
		)

/obj/item/clothing/suit/space/void/iccg/command/Initialize()
	. = ..()
	slowdown_per_slot[slot_wear_suit] = 0

/obj/item/clothing/head/helmet/space/void/iccg/command
	name = "armored command voidsuit helmet"
	icon_state = "rig_iccg_com"
	item_state = "rig_iccg_com"
	flash_protection = FLASH_PROTECTION_MAJOR
	armor = list(
		melee = ARMOR_MELEE_MAJOR,
		bullet = ARMOR_BALLISTIC_RESISTANT,
		laser = ARMOR_LASER_RIFLES,
		energy = ARMOR_ENERGY_STRONG,
		bomb = ARMOR_BOMB_RESISTANT,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_RESISTANT
		)

/obj/machinery/suit_storage_unit/iccg
	name = "Voidsuit Storage Unit"
	suit = /obj/item/clothing/suit/space/void/iccg
	helmet = /obj/item/clothing/head/helmet/space/void/iccg
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen/full
	mask = /obj/item/clothing/mask/gas/half
	req_access = list(access_iccg)

/obj/machinery/suit_storage_unit/iccg/engineering
	name = "Engineering Voidsuit Storage Unit"
	suit = /obj/item/clothing/suit/space/void/iccg/engineering
	helmet = /obj/item/clothing/head/helmet/space/void/iccg/engineering
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen/full
	mask = /obj/item/clothing/mask/gas
	req_access = list(access_iccg_engi)

/obj/machinery/suit_storage_unit/iccg/security
	name = "Security Voidsuit Storage Unit"
	suit = /obj/item/clothing/suit/space/void/iccg/security
	helmet = /obj/item/clothing/head/helmet/space/void/iccg/security
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen/full
	mask = /obj/item/clothing/mask/gas/swat
	req_access = list(access_iccg_sec)

/obj/machinery/suit_storage_unit/iccg/command
	name = "Command Voidsuit Storage Unit"
	suit = /obj/item/clothing/suit/space/void/iccg/command
	helmet = /obj/item/clothing/head/helmet/space/void/iccg/command
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen/full
	mask = /obj/item/clothing/mask/gas/swat
	req_access = list(access_iccg_com)

/obj/structure/closet/secure_closet/iccg
	name = "ICCG locker"
	req_access = list(access_iccg)
	closet_appearance = /decl/closet_appearance/secure_closet/iccg

/obj/structure/closet/secure_closet/iccg/WillContain()
	return list()

/obj/structure/closet/secure_closet/iccg/command
	name = "ICCG command locker"
	req_access = list(access_iccg_com)
	closet_appearance = /decl/closet_appearance/secure_closet/iccg/command

/obj/structure/closet/secure_closet/iccg/engineering
	name = "ICCG engineering locker"
	req_access = list(access_iccg_engi)
	closet_appearance = /decl/closet_appearance/secure_closet/iccg/engineering

/obj/structure/closet/secure_closet/iccg/security
	name = "ICCG security locker"
	req_access = list(access_iccg_sec)
	closet_appearance = /decl/closet_appearance/secure_closet/iccg/security

/obj/structure/closet/secure_closet/iccg/medical
	name = "ICCG medical locker"
	req_access = list(access_iccg_med)
	closet_appearance = /decl/closet_appearance/secure_closet/iccg/medical

/obj/structure/closet/secure_closet/iccg/preparations
	name = "ICCG preparations locker"

/obj/structure/closet/secure_closet/iccg/preparations/WillContain()
	return list(
		/obj/item/device/radio/headset/map_preset/ulyanovsk,
		/obj/item/device/radio/map_preset/ulyanovsk,
		/obj/item/storage/belt/general,
		/obj/item/device/flashlight/maglight,
		/obj/item/storage/firstaid/individual/military,
		/obj/item/material/knife/combat,
		/obj/item/device/binoculars,
		/obj/item/device/gps,
		/obj/item/clothing/accessory/buddy_tag,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/storage/backpack/satchel/sec
	)

/obj/structure/closet/secure_closet/iccg/security/pilot_officer
	name = "Pilot Officer locker"

/obj/structure/closet/secure_closet/iccg/security/pilot_officer/WillContain()
	return list(
		/obj/item/device/radio/headset/map_preset/ulyanovsk,
		/obj/item/device/radio/map_preset/ulyanovsk,
		/obj/item/storage/belt/utility/full,
		/obj/item/storage/belt/holster/security,
		/obj/item/device/flashlight/maglight,
		/obj/item/storage/firstaid/individual/military,
		/obj/item/material/knife/combat,
		/obj/item/device/binoculars,
		/obj/item/device/gps,
		/obj/item/clothing/suit/iccgn/service_officer,
		/obj/item/clothing/suit/storage/hazardvest/blue,
		/obj/item/clothing/head/helmet/solgov/pilot,
		/obj/item/clothing/accessory/buddy_tag,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/storage/backpack/satchel/sec,
		/obj/item/gun/projectile/revolver/rsh21,
		/obj/item/ammo_magazine/speedloader/rifle = 3
	)

/obj/structure/closet/secure_closet/iccg/medical/doctor
	name = "Vrach locker"

/obj/structure/closet/secure_closet/iccg/medical/doctor/WillContain()
	return list(
		/obj/item/clothing/suit/iccgn/service_enlisted,
		/obj/item/clothing/under/sterile,
		/obj/item/clothing/suit/storage/toggle/labcoat,
		/obj/item/clothing/suit/storage/medical_chest_rig,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/suit/surgicalapron,
		/obj/item/device/radio/headset/map_preset/ulyanovsk,
		/obj/item/device/radio/map_preset/ulyanovsk,
		/obj/item/storage/firstaid/individual/military,
		/obj/item/device/flashlight/pen,
		/obj/item/clothing/glasses/hud/health,
		/obj/item/clothing/accessory/stethoscope,
		/obj/item/storage/belt/medical,
		/obj/item/storage/box/freezer,
		/obj/item/storage/firstaid/adv,
		/obj/item/device/scanner/health,
		/obj/item/storage/backpack/satchel/med
	)

/obj/structure/closet/secure_closet/iccg/engineering/engineer
	name = "Deck Engineer locker"

/obj/structure/closet/secure_closet/iccg/engineering/engineer/WillContain()
	return list(
		/obj/item/clothing/suit/iccgn/service_enlisted,
		/obj/item/clothing/under/hazard,
		/obj/item/gun/energy/plasmacutter,
		/obj/item/clothing/accessory/storage/brown_vest,
		/obj/item/clothing/mask/gas,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/device/radio/headset/map_preset/ulyanovsk,
		/obj/item/device/radio/map_preset/ulyanovsk,
		/obj/item/device/flashlight/upgraded,
		/obj/item/clothing/glasses/meson,
		/obj/item/storage/belt/utility/full,
		/obj/item/storage/box/engineer,
		/obj/item/extinguisher/mini,
		/obj/item/storage/toolbox/mechanical,
		/obj/item/storage/backpack/satchel/eng
	)




/*
/obj/machinery/rotating_alarm/door
	name = "door alarm"
	desc = "An industrial rotating alarm light. This one is used to monitor door state."

	frame_type = /obj/item/frame/door_alarm
	construct_state = /decl/machine_construction/default/item_chassis
	base_type = /obj/machinery/rotating_alarm/door
	stock_part_presets = list(/decl/stock_part_preset/radio/basic_transmitter/button = 1)

/obj/machinery/rotating_alarm/door/Initialize()
	. = ..()
	GLOB.supermatter_status.register_global(src, .proc/check_supermatter)

/obj/machinery/rotating_alarm/door/Destroy()
	GLOB.supermatter_status.unregister_global(src, .proc/check_supermatter)
	. = ..()

/obj/machinery/rotating_alarm/door/proc/check_door(obj/machinery/door/door, opened)
	if (door)
		if (SM.z in GetConnectedZlevels(src.z))
			if (danger && !on)
				set_on()
			else if (!danger && on)
				set_off()

/obj/item/frame/door_alarm
	name = "supermatter alarm frame"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "bulb-construct-item"
	refund_amt = 1
	build_machine_type = /obj/machinery/rotating_alarm/door
*/
