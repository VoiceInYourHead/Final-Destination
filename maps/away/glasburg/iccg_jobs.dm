#define WEBHOOK_SUBMAP_LOADED_ICCG_SHUTTLE "webhook_submap_iccg_shuttle"

// Submap datum and archetype.
/decl/webhook/submap_loaded/glasburg
	id = WEBHOOK_SUBMAP_LOADED_ICCG_SHUTTLE

/decl/submap_archetype/glasburg
	descriptor = "ICCG shuttle"
	map = "Glasburg"
	blacklisted_species = null
	whitelisted_species = null
	crew_jobs = list(
		/datum/job/submap/glasburg/diplomat,
		/datum/job/submap/glasburg/pilot,
		/datum/job/submap/glasburg/security,
		/datum/job/submap/glasburg/security_chief
	)
	call_webhook = WEBHOOK_SUBMAP_LOADED_ICCG_SHUTTLE

// Jobs.
/datum/job/submap/glasburg/diplomat
	title = "ICCG Diplomat"
	supervisors = "the Ministry of External Affairs and ICCG"
	skill_points = 16
	access = list(access_iccg)
	outfit_type = /decl/hierarchy/outfit/iccg_diplomat
	min_skill = list(	SKILL_BUREAUCRACY = SKILL_EXPERT,
						SKILL_FINANCE     = SKILL_BASIC,
						SKILL_WEAPONS     = SKILL_BASIC)
	total_positions = 2
	loadout_allowed = TRUE
	is_semi_antagonist = TRUE

/datum/job/submap/glasburg/pilot
	title = "ICCGN Pilot"
	supervisors = "the Security Chief of Glazburg"
	skill_points = 16
	access = list(access_iccg)
	outfit_type = /decl/hierarchy/outfit/iccg_pilot
	min_skill = list(	SKILL_EVA         = SKILL_BASIC,
						SKILL_PILOT       = SKILL_ADEPT,
						SKILL_HAULING     = SKILL_ADEPT,
						SKILL_COMBAT      = SKILL_BASIC,
						SKILL_COMPUTER    = SKILL_ADEPT,
						SKILL_WEAPONS     = SKILL_BASIC)
	total_positions = 1
	loadout_allowed = TRUE
	is_semi_antagonist = TRUE
	allowed_branches = list(/datum/mil_branch/iccgn)
	allowed_ranks = list(
		/datum/mil_rank/iccgn/e5,
		/datum/mil_rank/iccgn/e6,
		/datum/mil_rank/iccgn/e7,
		/datum/mil_rank/iccgn/e8
	)

/datum/job/submap/glasburg/security
	title = "ICCGN Security Guard"
	supervisors = "the Security Chief of Glazburg"
	skill_points = 16
	access = list(access_iccg)
	outfit_type = /decl/hierarchy/outfit/iccg_security
	min_skill = list(	SKILL_BUREAUCRACY = SKILL_BASIC,
						SKILL_EVA         = SKILL_BASIC,
						SKILL_COMBAT      = SKILL_BASIC,
						SKILL_WEAPONS     = SKILL_ADEPT,
						SKILL_FORENSICS   = SKILL_BASIC)
	total_positions = 2
	loadout_allowed = TRUE
	is_semi_antagonist = TRUE
	allowed_branches = list(/datum/mil_branch/iccgn)
	allowed_ranks = list(
		/datum/mil_rank/iccgn/e1,
		/datum/mil_rank/iccgn/e3,
		/datum/mil_rank/iccgn/e4,
		/datum/mil_rank/iccgn/e5
	)

/datum/job/submap/glasburg/security_chief
	title = "ICCGN Security Chief"
	supervisors = "the Office of Internal Security and Diplomats"
	skill_points = 20
	access = list(access_iccg)
	outfit_type = /decl/hierarchy/outfit/iccg_security_chief
	min_skill = list(	SKILL_BUREAUCRACY = SKILL_ADEPT,
						SKILL_EVA         = SKILL_BASIC,
						SKILL_COMBAT      = SKILL_ADEPT,
						SKILL_WEAPONS     = SKILL_ADEPT,
						SKILL_FORENSICS   = SKILL_ADEPT)
	total_positions = 1
	loadout_allowed = TRUE
	is_semi_antagonist = TRUE
	allowed_branches = list(/datum/mil_branch/iccgn)
	allowed_ranks = list(
		/datum/mil_rank/iccgn/e9,
		/datum/mil_rank/iccgn/o1,
		/datum/mil_rank/iccgn/o2,
		/datum/mil_rank/iccgn/o3
	)

// Spawn points.

/obj/effect/submap_landmark/spawnpoint/glasburg/diplomat
	name = "ICCG Diplomat"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/submap_landmark/spawnpoint/glasburg/pilot
	name = "ICCGN Pilot"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/submap_landmark/spawnpoint/glasburg/security_chief
	name = "ICCGN Security Chief"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/submap_landmark/spawnpoint/glasburg/security
	name = "ICCGN Security Guard"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

// Outfits blyat.

/obj/item/card/id/iccg
	icon_state = "union"
	access = list(access_iccg)

/obj/item/card/id/iccg/on_update_icon()
	return

/obj/item/card/id/iccg/prevent_tracking()
	return TRUE

/obj/item/clothing/accessory/badge/solgov/representative/iccg
	desc = "A leather-backed plastic badge with a variety of information printed on it. Belongs to a representative of the Independent Colonial Confederation of Gilgamesh."
	icon_state = "solbadge"
	badge_string = "Independent Colonial Confederation of Gilgamesh"

/obj/item/gun/projectile/pistol/military/alt/rubber
	magazine_type = /obj/item/ammo_magazine/pistol/double/rubber

/decl/hierarchy/outfit/iccg_diplomat
	name = "ICCG Diplomat"

	uniform = /obj/item/clothing/under/lawyer/fiendsuit
	back = /obj/item/storage/backpack/satchel/leather/black
	belt = /obj/item/storage/belt/general
	shoes = /obj/item/clothing/shoes/laceup
	l_ear = /obj/item/device/radio/headset/syndicate
	glasses = /obj/item/clothing/glasses/sunglasses/big
	id = /obj/item/card/id/iccg
	l_pocket = /obj/item/gun/projectile/revolver/holdout
	r_pocket = /obj/item/device/flash/advanced
	backpack_contents = list(/obj/item/clothing/accessory/badge/solgov/representative/iccg=1,/obj/item/clothing/accessory/armor_plate/sneaky=1,/obj/item/device/radio/hailing=1)
	id_types = list(/obj/item/card/id/iccg)

/decl/hierarchy/outfit/iccg_pilot
	name = "ICCGN Pilot"

	uniform = /obj/item/clothing/under/iccgn/utility
	suit = /obj/item/clothing/suit/armor/pcarrier/light
	back = /obj/item/storage/backpack/satchel/pocketbook/gray
	belt = /obj/item/storage/belt/holster/security
	gloves = /obj/item/clothing/gloves/iccgn/duty
	shoes = /obj/item/clothing/shoes/iccgn/utility
	head = /obj/item/clothing/head/helmet/solgov/pilot
	mask = /obj/item/clothing/mask/breath/scba
	l_ear = /obj/item/device/radio/headset/syndicate/alt
	glasses = /obj/item/clothing/glasses/meson
	id = /obj/item/card/id/iccg
	l_pocket = /obj/item/ammo_magazine/magnum
	r_pocket = /obj/item/device/flash
	suit_store = /obj/item/gun/projectile/pistol/magnum_pistol
	backpack_contents = list(/obj/item/clothing/accessory/iccgn_rank/e8=1,/obj/item/clothing/accessory/iccgn_patch/security=1,/obj/item/device/flashlight/flare=2,/obj/item/device/radio/hailing=1)
	id_types = list(/obj/item/card/id/iccg)

/decl/hierarchy/outfit/iccg_security_chief
	name = "ICCGN Security Chief"

	uniform = /obj/item/clothing/under/iccgn/utility
	suit = /obj/item/clothing/suit/armor/pcarrier/tan/tactical
	back = /obj/item/storage/backpack/satchel/pocketbook/gray
	belt = /obj/item/storage/belt/holster/security/tactical
	gloves = /obj/item/clothing/gloves/iccgn/duty
	shoes = /obj/item/clothing/shoes/iccgn/utility
	head = /obj/item/clothing/head/iccgn/beret
	l_ear = /obj/item/device/radio/headset/syndicate/alt
	glasses = /obj/item/clothing/glasses/tacgoggles
	id = /obj/item/card/id/iccg
	l_pocket = /obj/item/ammo_magazine/pistol/double/rubber
	r_pocket = /obj/item/device/flash
	suit_store = /obj/item/gun/projectile/pistol/military/alt/rubber
	backpack_contents = list(/obj/item/clothing/accessory/iccgn_rank/o2=1,/obj/item/clothing/accessory/iccgn_patch/security=1,/obj/item/storage/box/handcuffs=1,/obj/item/device/radio/hailing=1)
	id_types = list(/obj/item/card/id/iccg)

/decl/hierarchy/outfit/iccg_security
	name = "ICCGN Security Guard"

	uniform = /obj/item/clothing/under/iccgn/utility
	suit = /obj/item/clothing/suit/armor/pcarrier/tan/tactical
	back = /obj/item/storage/backpack/satchel/pocketbook/gray
	belt = /obj/item/storage/belt/holster/security/tactical
	gloves = /obj/item/clothing/gloves/iccgn/duty
	shoes = /obj/item/clothing/shoes/iccgn/utility
	head = /obj/item/clothing/head/helmet/tactical
	mask = /obj/item/clothing/mask/balaclava/tactical
	l_ear = /obj/item/device/radio/headset/syndicate/alt
	glasses = /obj/item/clothing/glasses/aviators_black
	id = /obj/item/card/id/iccg
	l_pocket = /obj/item/ammo_magazine/pistol/double/rubber
	r_pocket = /obj/item/device/flash
	suit_store = /obj/item/gun/projectile/pistol/military/alt/rubber
	backpack_contents = list(/obj/item/clothing/accessory/iccgn_rank/e5=1,/obj/item/clothing/accessory/iccgn_patch/security=1,/obj/item/storage/box/handcuffs=1,/obj/item/device/radio/hailing=1)
	id_types = list(/obj/item/card/id/iccg)