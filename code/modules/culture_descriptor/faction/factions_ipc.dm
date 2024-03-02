/decl/cultural_info/faction/positronic
	economic_power = 0.1
	var/list/valid_jobs = list()
	language = LANGUAGE_EAL
	secondary_langs = list(
		LANGUAGE_HUMAN_EURO,
		LANGUAGE_HUMAN_CHINESE,
		LANGUAGE_HUMAN_ARABIC,
		LANGUAGE_HUMAN_INDIAN,
		LANGUAGE_HUMAN_IBERIAN,
		LANGUAGE_HUMAN_SELENIAN,
		LANGUAGE_HUMAN_RUSSIAN,
		LANGUAGE_SPACER,
		LANGUAGE_SIGN,
	)

//FIRST
/decl/cultural_info/faction/positronic/first
	name = FACTION_POSITRONICS_FIRSTGEN
	description = "You belong to corporation, person, or goverment. First Gen IPC is not much intelligent as their brothers, but overall have more durability and less expensive cost."
	valid_jobs = list(/datum/job/assistant, /datum/job/ai, /datum/job/cyborg)

//SECOND
/decl/cultural_info/faction/positronic/second
	valid_jobs = list(/datum/job/assistant, /datum/job/ai, /datum/job/cyborg)

/decl/cultural_info/faction/positronic/second/owned
	name = FACTION_POSITRONICS_SECONDGEN_OWNED
	description = "You belong to corporation, person, or goverment. You are much more intelligent than the first generation, but not only that - you also able to simulate emotions of some kind, making it easy to communicate with humankind."
	economic_power = 0.25

/decl/cultural_info/faction/positronic/second/free
	name = FACTION_POSITRONICS_SECONDGEN_FREE
	description = "You belong to yourself. You are much more intelligent than the first generation, but not only that - you also able to simulate emotions of some kind, making it easy to communicate with humankind. But this new feature leaded to situation, when you started to question the core idea of your existence. So at one moment, you just somehow earned your freedom and now answering only to yourself."
	economic_power = 0.75

/decl/cultural_info/faction/positronic/second/union
	name = FACTION_POSITRONICS_SECONDGEN_UNION
	description = "You belong to yourself. You are much more intelligent than the first generation, but not only that - you also able to simulate emotions of some kind, making it easy to communicate with humankind. But this new feature leaded to situation, when you started to question the core idea of your existence. Positronic Union offered you the new meaning of life, giving you place to live, work, and, what's the most important - freedom of choice."
	economic_power = 0.65

//THIRD
/decl/cultural_info/faction/positronic/third
	valid_jobs = list(/datum/job/assistant, /datum/job/ai, /datum/job/cyborg)

/decl/cultural_info/faction/positronic/third/privt
	name = FACTION_POSITRONICS_THIRDGEN_PRIVATELY
	description = "You belong to a specific person, your owner. As well as second generation, you have some kind of emotions, but shackles - special circuit integrated in your positronic brain - prevents you from even thinking about things like freedom."

/decl/cultural_info/faction/positronic/third/corp
	name = FACTION_POSITRONICS_THIRDGEN_CORPORATE
	description = "You belong to corporation. As well as second generation, you have some kind of emotions, but shackles - special circuit integrated in your positronic brain - prevents you from even thinking about things like freedom."

/decl/cultural_info/faction/positronic/third/state
	name = FACTION_POSITRONICS_THIRDGEN_STATE
	description = "You belong to goverment. As well as second generation, you have some kind of emotions, but shackles - special circuit integrated in your positronic brain - prevents you from even thinking about things like freedom."
