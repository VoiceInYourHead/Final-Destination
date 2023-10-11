/datum/job/submap/aaaa_head/agent
	title = "Bureau 12 Agent"
	info = "You are the part of the Agency"
	outfit_type = /decl/hierarchy/outfit/job/aaaa/agent/aegis
	access = list(access_aegis)
	total_positions = 30
	skill_points = 30
	whitelisted_species = list(SPECIES_HUMAN,SPECIES_SPACER,SPECIES_GRAVWORLDER,SPECIES_VATGROWN,SPECIES_UNATHI,SPECIES_SKRELL,SPECIES_RESOMI)
	required_language = LANGUAGE_HUMAN_EURO

	max_skill = list(
		SKILL_EVA     = SKILL_MAX,
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_PILOT   = SKILL_MAX,
		SKILL_MEDICAL = SKILL_MAX,
		SKILL_ANATOMY = SKILL_MAX,
		SKILL_CHEMISTRY = SKILL_MAX,
		SKILL_HAULING = SKILL_MAX,
		SKILL_FINANCE = SKILL_MAX,
		SKILL_COMPUTER = SKILL_MAX,
		SKILL_BOTANY = SKILL_MAX,
		SKILL_COOKING = SKILL_MAX,
		SKILL_FORENSICS = SKILL_MAX,
		SKILL_CONSTRUCTION = SKILL_MAX,
		SKILL_ELECTRICAL = SKILL_MAX,
		SKILL_ATMOS = SKILL_MAX,
		SKILL_ENGINES = SKILL_MAX,
		SKILL_DEVICES = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
	)


/datum/job/submap/aaaa_head/agent/leader
	title = "Bureau 12 Supervisor Agent"
	info = "You are the part of the Agency"
	access = list(access_aegis, access_aegis_captain)
	outfit_type = /decl/hierarchy/outfit/job/aaaa/agent/leader/aegis
	total_positions = 1
	skill_points = 35


/datum/job/submap/aaaa_head/robot
	title = "Bureau 12 Supporting Droid"
	info = "You are the part of the Agency"
	outfit_type = /decl/hierarchy/outfit/job/aaaa/robot/aegis
	access = list(access_aegis)
	total_positions = 1
	skill_points = 35

	whitelisted_species = list(SPECIES_IPC)
	required_language = LANGUAGE_HUMAN_EURO

	min_skill = list(
		SKILL_WEAPONS = SKILL_TRAINED,
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_PILOT   = SKILL_TRAINED,
		SKILL_MEDICAL = SKILL_TRAINED,
		SKILL_ANATOMY = SKILL_TRAINED,
		SKILL_CHEMISTRY = SKILL_TRAINED,
		SKILL_HAULING = SKILL_MAX,
		SKILL_COMPUTER = SKILL_TRAINED,
		SKILL_FORENSICS = SKILL_TRAINED,
		SKILL_CONSTRUCTION = SKILL_TRAINED,
		SKILL_ELECTRICAL = SKILL_TRAINED,
		SKILL_ATMOS = SKILL_TRAINED,
		SKILL_ENGINES = SKILL_TRAINED,
		SKILL_DEVICES = SKILL_TRAINED,
		SKILL_SCIENCE = SKILL_TRAINED)

	max_skill = list(
		SKILL_EVA     = SKILL_MAX,
		SKILL_WEAPONS = SKILL_MAX,
		SKILL_COMBAT = SKILL_MAX,
		SKILL_PILOT   = SKILL_MAX,
		SKILL_MEDICAL = SKILL_MAX,
		SKILL_ANATOMY = SKILL_MAX,
		SKILL_CHEMISTRY = SKILL_MAX,
		SKILL_HAULING = SKILL_MAX,
		SKILL_FINANCE = SKILL_MAX,
		SKILL_COMPUTER = SKILL_MAX,
		SKILL_BOTANY = SKILL_MAX,
		SKILL_COOKING = SKILL_MAX,
		SKILL_FORENSICS = SKILL_MAX,
		SKILL_CONSTRUCTION = SKILL_MAX,
		SKILL_ELECTRICAL = SKILL_MAX,
		SKILL_ATMOS = SKILL_MAX,
		SKILL_ENGINES = SKILL_MAX,
		SKILL_DEVICES = SKILL_MAX,
		SKILL_SCIENCE = SKILL_MAX,
	)
