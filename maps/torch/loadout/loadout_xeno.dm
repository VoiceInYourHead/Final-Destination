/datum/gear/suit/lab_xyn_machine
	allowed_branches = CIVILIAN_BRANCHES

/datum/gear/gloves/dress/modified
	display_name = "modified gloves, dress"
	path = /obj/item/clothing/gloves/color/white/modified
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_UNATHI)

/datum/gear/gloves/duty/modified
	display_name = "modified gloves, duty"
	path = /obj/item/clothing/gloves/thick/duty/modified
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_UNATHI)

/datum/gear/suit/unathi/savage_hunter
	allowed_branches = CIVILIAN_BRANCHES

/datum/gear/head/skrell_helmet
	allowed_roles = ARMORED_ROLES

/datum/gear/uniform/harness
	allowed_branches = null

// Patches
/datum/gear/accessory/cultex_patch
	display_name = "Cultural Exchange patch"
	path = /obj/item/clothing/accessory/solgov/cultex_patch
	description = "A shoulder patch representing the Expeditionary Corps."
	allowed_branches = list(/datum/mil_branch/expeditionary_corps)
	whitelisted = list(SPECIES_SKRELL, SPECIES_UNATHI, SPECIES_YEOSA, SPECIES_IPC)
	sort_category = "Xenowear"

// Resomi clothing

/datum/gear/uniform/resomi/eng
	allowed_roles = ENGINEERING_ROLES

/datum/gear/uniform/resomi/sec
	allowed_roles = SECURITY_ROLES

/datum/gear/uniform/resomi/med
	allowed_roles = MEDICAL_ROLES

/datum/gear/uniform/resomi/science
	allowed_roles = RESEARCH_ROLES

/datum/gear/uniform/resomi/roboitcs
	allowed_roles = list(/datum/job/roboticist)

/datum/gear/eyes/resomi/lenses_sec
	allowed_roles = SECURITY_ROLES

/datum/gear/eyes/resomi/lenses_med
	allowed_roles = MEDICAL_ROLES