
/datum/map_template/ruin/exoplanet/playablelab
	name = "Laboratory"
	id = "exoplanet_playablelab"
	description = "Laboratory"
	suffixes = list("playablelab/playablelab.dmm")
	spawn_cost = 1000 //NO BITCHES???
	player_cost = 4
	template_flags = TEMPLATE_FLAG_CLEAR_CONTENTS | TEMPLATE_FLAG_NO_RUINS | TEMPLATE_FLAG_NO_RADS
	ruin_tags = RUIN_HUMAN|RUIN_HABITAT

/decl/submap_archetype/playablelab
	descriptor = "Laboratory"
	crew_jobs = list(
		/datum/job/submap/lab_scientist,
		/datum/job/submap/lab_cook,
		/datum/job/submap/lab_senscientist,
		/datum/job/submap/lab_director,
		/datum/job/submap/lab_security,
		/datum/job/submap/lab_unit
	)

/datum/job/submap/lab_unit
	title = "Laboratory Test Unit"
	department_flag = MSC
	total_positions = 2
	spawn_positions = 2
	supervisors = "your laws and the AI"
	loadout_allowed = FALSE
	outfit_type = /decl/hierarchy/outfit/job/silicon/cyborg
	hud_icon = "hudblank"
	skill_points = 0
	no_skill_buffs = TRUE

/datum/job/submap/lab_unit/handle_variant_join(var/mob/living/carbon/human/H, var/alt_title)
	return H && H.Robotize(SSrobots.get_mob_type_by_title(alt_title || title))

/datum/job/submap/lab_unit/equip(var/mob/living/carbon/human/H)
	return !!H

/datum/job/submap/lab_unit/New()
	..()
	alt_titles = SSrobots.robot_alt_titles.Copy()
	alt_titles -= title // So the unit test doesn't flip out if a mob or mmi type is declared for our main title.

/datum/job/submap/lab_scientist
	title = "Laboratory Scientist"
	supervisors = "Lab Director and Senior Scientist"
	info = "You are a scientist, living on the rim of explored, let alone inhabited, space in a recently built base."
	total_positions = 8
	outfit_type = /decl/hierarchy/outfit/job/lab/scientist
	min_skill = list(
			SKILL_BUREAUCRACY	=	SKILL_BASIC,
			SKILL_COMPUTER		=	SKILL_BASIC,
			SKILL_DEVICES		=	SKILL_BASIC,
			SKILL_SCIENCE		=	SKILL_TRAINED
		)

	max_skill = list(
			SKILL_DEVICES		=	SKILL_MAX,
			SKILL_SCIENCE		=	SKILL_MAX,
			SKILL_CHEMISTRY		=	SKILL_MAX
		)
	skill_points = 20

/datum/job/submap/lab_senscientist
	title = "Laboratory Senior scientist"
	supervisors = "Lab Director"
	info = "You are a scientist, living on the rim of explored, let alone inhabited, space in a recently built base."
	total_positions = 2
	outfit_type = /decl/hierarchy/outfit/job/lab/senscientist
	min_skill = list(
			SKILL_BUREAUCRACY	=	SKILL_BASIC,
			SKILL_COMPUTER		=	SKILL_BASIC,
			SKILL_FINANCE		=	SKILL_BASIC,
			SKILL_BOTANY		=	SKILL_BASIC,
			SKILL_ANATOMY		=	SKILL_BASIC,
			SKILL_DEVICES		=	SKILL_TRAINED,
			SKILL_SCIENCE		=	SKILL_TRAINED
		)

	max_skill = list(
			SKILL_DEVICES		=	SKILL_MAX,
			SKILL_SCIENCE		=	SKILL_MAX,
			SKILL_CHEMISTRY		=	SKILL_MAX
		)
	skill_points = 30

/datum/job/submap/lab_director
	title = "Laboratory Director"
	supervisors = "No one"
	info = "You are a laboratory director, living on the rim of explored, let alone inhabited, space in a recently built base."
	total_positions = 1
	outfit_type = /decl/hierarchy/outfit/job/lab/labdirector
	min_skill = list(
		SKILL_BUREAUCRACY	=	SKILL_TRAINED,
		SKILL_COMPUTER		=	SKILL_BASIC,
		SKILL_FINANCE		=	SKILL_TRAINED,
		SKILL_BOTANY		=	SKILL_BASIC,
		SKILL_ANATOMY		=	SKILL_BASIC,
		SKILL_DEVICES		=	SKILL_BASIC,
		SKILL_SCIENCE		=	SKILL_TRAINED
	)

	max_skill = list(
		SKILL_ANATOMY		=	SKILL_MAX,
		SKILL_DEVICES		=	SKILL_MAX,
		SKILL_SCIENCE		=	SKILL_MAX
	)
	skill_points = 36

/datum/job/submap/lab_security
	title = "Laboratory Security"
	supervisors = "Lab Director"
	info = "You are a laboratory security officer, living on the rim of explored, let alone inhabited, space in a recently built base."
	total_positions = 4
	outfit_type = /decl/hierarchy/outfit/job/lab/security
	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_BASIC,
	                    SKILL_HAULING     = SKILL_BASIC,
	                    SKILL_WEAPONS     = SKILL_TRAINED,
	                    SKILL_FORENSICS   = SKILL_BASIC)

	max_skill = list(   SKILL_COMBAT      = SKILL_MAX,
	                    SKILL_WEAPONS     = SKILL_MAX)
	skill_points = 20

/datum/job/submap/lab_cook
	title = "Laboratory Cook"
	total_positions = 2
	outfit_type = /decl/hierarchy/outfit/job/lab/cook
	supervisors = "Lab Director"
	info = "You are the cook on the secret grounside base. Sounds like a joke, you know?"
	min_skill = list(
		SKILL_COOKING = SKILL_EXPERIENCED,
		SKILL_BOTANY    = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_EXPERIENCED
	)

	max_skill = list(
		SKILL_BUREAUCRACY = SKILL_MAX,
		SKILL_FINANCE = SKILL_MAX,
		SKILL_EVA = SKILL_MAX,
		SKILL_PILOT = SKILL_MAX,
		SKILL_HAULING = SKILL_MAX,
		SKILL_COMPUTER = SKILL_MAX,
		SKILL_BOTANY = SKILL_MAX,
		SKILL_COOKING = SKILL_MAX,
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_WEAPONS = SKILL_TRAINED,
		SKILL_FORENSICS = SKILL_MAX,
		SKILL_CONSTRUCTION = SKILL_MAX,
		SKILL_ELECTRICAL = SKILL_EXPERIENCED,
		SKILL_ATMOS = SKILL_EXPERIENCED,
		SKILL_ENGINES = SKILL_EXPERIENCED,
		SKILL_DEVICES = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_EXPERIENCED,
		SKILL_ANATOMY = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_EXPERIENCED
	)
	skill_points = 15

/decl/hierarchy/outfit/job/lab/scientist
	name = "Laboratory Scientist"
	uniform = /obj/item/clothing/under/rank/scientist/nanotrasen
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/coat
	shoes = /obj/item/clothing/shoes/jackboots

/decl/hierarchy/outfit/job/lab/senscientist
	name = "Laboratory Senior scientist"
	uniform = /obj/item/clothing/under/rank/scientist/nanotrasen
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/science/ec
	shoes = /obj/item/clothing/shoes/jackboots

/decl/hierarchy/outfit/job/lab/labdirector
	name = "Laboratory Director"
	uniform = /obj/item/clothing/under/rank/scientist/nanotrasen
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/rd/ec
	shoes = /obj/item/clothing/shoes/jackboots

/decl/hierarchy/outfit/job/lab/cook
	name = "Laboratory Cook"
	uniform = /obj/item/clothing/under/rank/chef
	shoes = /obj/item/clothing/shoes/jackboots

/decl/hierarchy/outfit/job/lab/security
	name = "Laboratory Security"
	uniform = /obj/item/clothing/under/rank/security/corp
	suit = /obj/item/clothing/suit/armor/bulletproof
	gloves = /obj/item/clothing/gloves/guards
	head = /obj/item/clothing/head/helmet/riot
	shoes = /obj/item/clothing/shoes/jackboots

/obj/effect/submap_landmark/spawnpoint/scientist_spawn
	name = "Laboratory Scientist"

/obj/effect/submap_landmark/spawnpoint/cook_spawn
	name = "Laboratory Cook"

/obj/effect/submap_landmark/spawnpoint/labsecurity_spawn
	name = "Laboratory Security"

/obj/effect/submap_landmark/spawnpoint/labdirector_spawn
	name = "Laboratory Director"

/obj/effect/submap_landmark/spawnpoint/senscientist_spawn
	name = "Laboratory Senior scientist"

/obj/effect/submap_landmark/spawnpoint/testunit_spawn
	name = "Laboratory Test Unit"

/obj/effect/submap_landmark/joinable_submap/playablelab
	name = "Laboratory"
	archetype = /decl/submap_archetype/playablelab

/obj/structure/lobotomy/artifact
	name = "alien artifact"
	desc = "A large alien device."
	icon = 'icons/obj/xenoarchaeology.dmi'
	icon_state = "ano90"
	density = TRUE
	var/on = FALSE
	var/uses = 5

/obj/structure/lobotomy/artifact/attack_hand(mob/user as mob)
	if(user.a_intent && user.a_intent == I_HELP)
		on = TRUE
		icon_state = "ano91"
		visible_message("<span class='danger'>Machine starts to flicker</span>")

	// Areas //

/area/map_template/oldlab2

/area/map_template/oldlab2/powerandatmos
	name = "\improper Power and Atmos"
	icon_state = "solar"

/area/map_template/oldlab2/hall
	name = "\improper Main Hall and Storage"
	icon_state = "processing"

/area/map_template/oldlab2/recandlockers
	name = "\improper Recreational Hall"
	icon_state = "processing"

/area/map_template/oldlab2/chem
	name = "\improper Chemistry"
	icon_state = "chemistry"

/area/map_template/oldlab2/medical
	name = "\improper Medical"
	icon_state = "surgery"

/area/map_template/oldlab2/Engineering
	name = "\improper Engineering"
	icon_state = "airlock"

/area/map_template/oldlab2/Airlock
	name = "\improper Airlock"
	icon_state = "airlock"

/area/map_template/oldlab2/living
	name = "\improper Living Quarters"
	icon_state = "surgery"

/area/map_template/oldlab2/living2
	name = "\improper Living Quarters"
	icon_state = "surgery"

/area/map_template/oldlab2/living3
	name = "\improper Living Quarters"
	icon_state = "surgery"

/area/map_template/oldlab2/living4
	name = "\improper Living Quarters"
	icon_state = "surgery"

/area/map_template/oldlab2/living5
	name = "\improper Living Quarters"
	icon_state = "surgery"

/area/map_template/oldlab2/living6
	name = "\improper Living Quarters"
	icon_state = "surgery"

/area/map_template/oldlab2/cso
	name = "\improper CSO Office"
	icon_state = "surgery"

/area/map_template/oldlab2/office
	name = "\improper Office"
	icon_state = "surgery"

/area/map_template/oldlab2/mess
	name = "\improper Mess Hall"
	icon_state = "surgery"

/area/map_template/oldlab2/bathroom
	name = "\improper Bathroom"
	icon_state = "surgery"

/area/map_template/oldlab2/server
	name = "\improper Archives"
	icon_state = "surgery"

/area/map_template/oldlab2/fixedsecurity
	name = "\improper Security Office"
	icon_state = "surgery"

/area/map_template/oldlab2/test1
	name = "\improper Testing Lab"
	icon_state = "surgery"

/area/map_template/oldlab2/test2
	name = "\improper Special Testing Lab"
	icon_state = "surgery"

/area/map_template/oldlab2/mess
	name = "\improper Mess Hall"
	icon_state = "surgery"

/area/map_template/oldlab2/engineerhall
	name = "\improper Engineering Hall"
	icon_state = "surgery"

/area/map_template/oldlab2/lab
	name = "\improper Materials Lab"
	icon_state = "surgery"