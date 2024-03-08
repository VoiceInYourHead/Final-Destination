/********
Synthetic
********/

/datum/job/cyborg
	total_positions = 3
	spawn_positions = 3
	supervisors = "your laws"
	minimal_player_age = 3
	allowed_ranks = list(
		/datum/mil_rank/civ/synthetic
	)

/datum/job/ai
	minimal_player_age = 7
	allowed_ranks = list(
		/datum/mil_rank/civ/synthetic
	)

/*******
Civilian
*******/

/datum/job/assistant
	title = "Crewman"
	total_positions = -1
	spawn_positions = -1
	minimal_player_age = 16
	supervisors = "the Right Hand"
	economic_power = 6
	announced = FALSE
	alt_titles = list(
		"Engineer" = /decl/hierarchy/outfit/job/torch/passenger/passenger/engineer,
		"Doctor" = /decl/hierarchy/outfit/job/torch/passenger/passenger/doctor,
		"Scientist",
		"Shipman" = /decl/hierarchy/outfit/job/torch/passenger/passenger/soldier/fleet,
		"Soldier" = /decl/hierarchy/outfit/job/torch/passenger/passenger/soldier,
		"Soldier ICCGN" = /decl/hierarchy/outfit/job/torch/passenger/passenger/soldier/iccgn,
		"Explorer" = /decl/hierarchy/outfit/job/torch/passenger/passenger/explorer,
		"Corpo",
		"Governor"
	)
	outfit_type = /decl/hierarchy/outfit/job/torch/passenger/passenger
	allowed_branches = list(/datum/mil_branch/civilian,
							/datum/mil_branch/expeditionary_corps,
							/datum/mil_branch/fleet,
							/datum/mil_branch/army,
							/datum/mil_branch/solgov
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/civ,
		/datum/mil_rank/civ/contractor,
		/datum/mil_rank/fleet/e1,
		/datum/mil_rank/fleet/e2,
		/datum/mil_rank/fleet/e3,
		/datum/mil_rank/fleet/e4,
		/datum/mil_rank/fleet/e5,
		/datum/mil_rank/fleet/e6,
		/datum/mil_rank/fleet/e7,
		/datum/mil_rank/fleet/e8,
		/datum/mil_rank/fleet/e9,
		/datum/mil_rank/fleet/e9_alt1,
		/datum/mil_rank/fleet/e9_alt2,
		/datum/mil_rank/fleet/e9_alt3,
		/datum/mil_rank/fleet/e9_alt4,
		/datum/mil_rank/fleet/o0,
		/datum/mil_rank/fleet/o1,
		/datum/mil_rank/fleet/o2,
		/datum/mil_rank/fleet/o3,
		/datum/mil_rank/fleet/o4,
		/datum/mil_rank/fleet/o5,
		/datum/mil_rank/fleet/o6,
		/datum/mil_rank/fleet/o7,
		/datum/mil_rank/fleet/o8,
		/datum/mil_rank/fleet/o9,
		/datum/mil_rank/fleet/o10,
		/datum/mil_rank/fleet/o10_alt,
		/datum/mil_rank/army/e1,
		/datum/mil_rank/army/e2,
		/datum/mil_rank/army/e3,
		/datum/mil_rank/army/e4,
		/datum/mil_rank/army/e4_alt,
		/datum/mil_rank/army/e5,
		/datum/mil_rank/army/e6,
		/datum/mil_rank/army/e7,
		/datum/mil_rank/army/e7_meme,
		/datum/mil_rank/army/e8,
		/datum/mil_rank/army/e8_alt,
		/datum/mil_rank/army/e9,
		/datum/mil_rank/army/e9_alt,
		/datum/mil_rank/army/e9_meme,
		/datum/mil_rank/army/o1,
		/datum/mil_rank/army/o2,
		/datum/mil_rank/army/o3,
		/datum/mil_rank/army/o4,
		/datum/mil_rank/army/o5,
		/datum/mil_rank/army/o6,
		/datum/mil_rank/army/o7,
		/datum/mil_rank/army/o8,
		/datum/mil_rank/army/o9,
		/datum/mil_rank/army/o10,
		/datum/mil_rank/army/o10_alt,
		/datum/mil_rank/sol/gov,
		/datum/mil_rank/sol/junior_agent,
		/datum/mil_rank/sol/duty_agent,
		/datum/mil_rank/sol/agent,
		/datum/mil_rank/sol/senior_agent,
		/datum/mil_rank/sol/inspector_agent,
		/datum/mil_rank/sol/curator_agent,
		/datum/mil_rank/sol/deputy_agent,
		/datum/mil_rank/sol/director_agent,
		/datum/mil_rank/sol/scientist,
		/datum/mil_rank/ec/e3,
		/datum/mil_rank/ec/e5,
		/datum/mil_rank/ec/e7,
		/datum/mil_rank/ec/o1,
		/datum/mil_rank/ec/o3,
		/datum/mil_rank/ec/o5,
		/datum/mil_rank/ec/o6,
		/datum/mil_rank/iccgn/e1,
		/datum/mil_rank/iccgn/e3,
		/datum/mil_rank/iccgn/e4,
		/datum/mil_rank/iccgn/e5,
		/datum/mil_rank/iccgn/e6,
		/datum/mil_rank/iccgn/e7,
		/datum/mil_rank/iccgn/e8,
		/datum/mil_rank/iccgn/e9,
		/datum/mil_rank/iccgn/o1,
		/datum/mil_rank/iccgn/o2,
		/datum/mil_rank/iccgn/o3,
		/datum/mil_rank/iccgn/o4,
		/datum/mil_rank/iccgn/o5,
		/datum/mil_rank/iccgn/o6,
		/datum/mil_rank/iccgn/o7,
		/datum/mil_rank/iccgn/o8,
		/datum/mil_rank/iccgn/o9
	)
	min_goals = 2
	max_goals = 7

	max_skill = list(
		SKILL_BUREAUCRACY = SKILL_MAX,
		SKILL_FINANCE = SKILL_MAX,
		SKILL_EVA = SKILL_MAX,
		SKILL_PILOT = SKILL_MAX,
		SKILL_HAULING = SKILL_MAX,
		SKILL_COMPUTER = SKILL_MAX,
		SKILL_BOTANY = SKILL_MAX,
		SKILL_COOKING = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_FORENSICS = SKILL_MAX,
		SKILL_CONSTRUCTION = SKILL_MAX,
		SKILL_ELECTRICAL = SKILL_MAX,
		SKILL_ATMOS = SKILL_MAX,
		SKILL_ENGINES = SKILL_MAX,
		SKILL_DEVICES = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_MAX,
		SKILL_ANATOMY = SKILL_MAX,
		SKILL_CHEMISTRY = SKILL_MAX
	)
	skill_points = 35

/datum/job/wanderer
	title = "Vagabond"
	department_flag = CIV
	total_positions = 10
	spawn_positions = 10
	supervisors = "the Right Hand"
	economic_power = 6
	announced = FALSE
	alt_titles = list(
		"Crafter" = /decl/hierarchy/outfit/job/torch/passenger/passenger/engineer,
		"Corpsman" = /decl/hierarchy/outfit/job/torch/passenger/passenger/doctor,
		"Recon" = /decl/hierarchy/outfit/job/torch/passenger/passenger/vagabond,
		"Fighter" = /decl/hierarchy/outfit/job/torch/passenger/passenger/soldier,
		"Fighter ICCGN" = /decl/hierarchy/outfit/job/torch/passenger/passenger/soldier/iccgn,
		"Gatherer" = /decl/hierarchy/outfit/job/torch/passenger/passenger/explorer
	)
	outfit_type = /decl/hierarchy/outfit/job/torch/passenger/passenger
	allowed_branches = list(/datum/mil_branch/civilian,
							/datum/mil_branch/expeditionary_corps,
							/datum/mil_branch/fleet,
							/datum/mil_branch/army,
							/datum/mil_branch/solgov
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/civ,
		/datum/mil_rank/civ/contractor,
		/datum/mil_rank/fleet/e1,
		/datum/mil_rank/fleet/e2,
		/datum/mil_rank/fleet/e3,
		/datum/mil_rank/fleet/e4,
		/datum/mil_rank/fleet/e5,
		/datum/mil_rank/fleet/e6,
		/datum/mil_rank/fleet/e7,
		/datum/mil_rank/fleet/e8,
		/datum/mil_rank/fleet/e9,
		/datum/mil_rank/fleet/e9_alt1,
		/datum/mil_rank/fleet/e9_alt2,
		/datum/mil_rank/fleet/e9_alt3,
		/datum/mil_rank/fleet/e9_alt4,
		/datum/mil_rank/fleet/o0,
		/datum/mil_rank/fleet/o1,
		/datum/mil_rank/fleet/o2,
		/datum/mil_rank/fleet/o3,
		/datum/mil_rank/fleet/o4,
		/datum/mil_rank/fleet/o5,
		/datum/mil_rank/fleet/o6,
		/datum/mil_rank/fleet/o7,
		/datum/mil_rank/fleet/o8,
		/datum/mil_rank/fleet/o9,
		/datum/mil_rank/fleet/o10,
		/datum/mil_rank/fleet/o10_alt,
		/datum/mil_rank/army/e1,
		/datum/mil_rank/army/e2,
		/datum/mil_rank/army/e3,
		/datum/mil_rank/army/e4,
		/datum/mil_rank/army/e4_alt,
		/datum/mil_rank/army/e5,
		/datum/mil_rank/army/e6,
		/datum/mil_rank/army/e7,
		/datum/mil_rank/army/e7_meme,
		/datum/mil_rank/army/e8,
		/datum/mil_rank/army/e8_alt,
		/datum/mil_rank/army/e9,
		/datum/mil_rank/army/e9_alt,
		/datum/mil_rank/army/e9_meme,
		/datum/mil_rank/army/o1,
		/datum/mil_rank/army/o2,
		/datum/mil_rank/army/o3,
		/datum/mil_rank/army/o4,
		/datum/mil_rank/army/o5,
		/datum/mil_rank/army/o6,
		/datum/mil_rank/army/o7,
		/datum/mil_rank/army/o8,
		/datum/mil_rank/army/o9,
		/datum/mil_rank/army/o10,
		/datum/mil_rank/army/o10_alt,
		/datum/mil_rank/sol/gov,
		/datum/mil_rank/sol/junior_agent,
		/datum/mil_rank/sol/duty_agent,
		/datum/mil_rank/sol/agent,
		/datum/mil_rank/sol/senior_agent,
		/datum/mil_rank/sol/inspector_agent,
		/datum/mil_rank/sol/curator_agent,
		/datum/mil_rank/sol/deputy_agent,
		/datum/mil_rank/sol/director_agent,
		/datum/mil_rank/sol/scientist,
		/datum/mil_rank/ec/e3,
		/datum/mil_rank/ec/e5,
		/datum/mil_rank/ec/e7,
		/datum/mil_rank/ec/o1,
		/datum/mil_rank/ec/o3,
		/datum/mil_rank/ec/o5,
		/datum/mil_rank/ec/o6,
		/datum/mil_rank/iccgn/e1,
		/datum/mil_rank/iccgn/e3,
		/datum/mil_rank/iccgn/e4,
		/datum/mil_rank/iccgn/e5,
		/datum/mil_rank/iccgn/e6,
		/datum/mil_rank/iccgn/e7,
		/datum/mil_rank/iccgn/e8,
		/datum/mil_rank/iccgn/e9,
		/datum/mil_rank/iccgn/o1,
		/datum/mil_rank/iccgn/o2,
		/datum/mil_rank/iccgn/o3,
		/datum/mil_rank/iccgn/o4,
		/datum/mil_rank/iccgn/o5,
		/datum/mil_rank/iccgn/o6,
		/datum/mil_rank/iccgn/o7,
		/datum/mil_rank/iccgn/o8,
		/datum/mil_rank/iccgn/o9
	)
	min_goals = 2
	max_goals = 7

	max_skill = list(
		SKILL_BUREAUCRACY = SKILL_MAX,
		SKILL_FINANCE = SKILL_MAX,
		SKILL_EVA = SKILL_MAX,
		SKILL_PILOT = SKILL_MAX,
		SKILL_HAULING = SKILL_MAX,
		SKILL_COMPUTER = SKILL_MAX,
		SKILL_BOTANY = SKILL_MAX,
		SKILL_COOKING = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_FORENSICS = SKILL_MAX,
		SKILL_CONSTRUCTION = SKILL_MAX,
		SKILL_ELECTRICAL = SKILL_MAX,
		SKILL_ATMOS = SKILL_MAX,
		SKILL_ENGINES = SKILL_MAX,
		SKILL_DEVICES = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
		SKILL_MEDICAL = SKILL_MAX,
		SKILL_ANATOMY = SKILL_MAX,
		SKILL_CHEMISTRY = SKILL_MAX
	)
	skill_points = 35

/datum/job/merchant
	title = "Merchant"
	department = "Civilian"
	department_flag = CIV
	total_positions = 2
	spawn_positions = 2
	availablity_chance = 30
	supervisors = "the invisible hand of the market"
	ideal_character_age = 30
	minimal_player_age = 0
	create_record = 0
	outfit_type = /decl/hierarchy/outfit/job/torch/merchant
	allowed_branches = list(
		/datum/mil_branch/civilian,
		/datum/mil_branch/alien
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/civ,
		/datum/mil_rank/alien
	)
	latejoin_at_spawnpoints = 1
	access = list(access_merchant)
	announced = FALSE
	min_skill = list(   SKILL_FINANCE = SKILL_TRAINED,
	                    SKILL_PILOT	  = SKILL_BASIC)

	max_skill = list(   SKILL_PILOT       = SKILL_MAX)
	skill_points = 24
	required_language = null
	give_psionic_implant_on_join = FALSE
