GLOBAL_LIST_INIT(psistatus2text, list("C", "B", "A", "S"))
GLOBAL_LIST_INIT(text2psistatus, list("C" = 1, "B" = 2, "A" = 3, "S" = 4))

/datum/preferences
	var/psi_threat_level = 0
	var/psi_status       = 4
	var/psi_openness     = FALSE

/datum/category_item/player_setup_item/physical/psionics
	name = "psionics"
	sort_order = 5

/datum/category_item/player_setup_item/physical/psionics/load_character(datum/pref_record_reader/R)
	pref.psi_threat_level = R.read("psi_threat_level")
	pref.psi_status       = R.read("psi_status")
	pref.psi_openness     = R.read("psi_openness")

/datum/category_item/player_setup_item/physical/psionics/save_character(datum/pref_record_writer/W)
	W.write("psi_threat_level", pref.psi_threat_level)
	W.write("psi_status",       pref.psi_status)
	W.write("psi_openness",     pref.psi_openness)

/datum/category_item/player_setup_item/physical/psionics/sanitize_character()
	pref.psi_threat_level = clamp(pref.psi_threat_level, 0, 4)
	pref.psi_status       = clamp(pref.psi_status      , 1, 4)

/datum/category_item/player_setup_item/physical/psionics/content()
	. = list()
	. += "<hr><b>Psionics:</b><br>"
	. += "Threat level: <a href='?src=\ref[src];select_psi_threat_level=1'><b>[pref.psi_threat_level]</b></a><br>"
	if(pref.psi_threat_level)
		. += "Psionic status: <a href='?src=\ref[src];select_psi_status=1'><b>[GLOB.psistatus2text[pref.psi_status]]</b></a><br>"
		. += "Openness: <a href='?src=\ref[src];select_psi_openness=1'><b>[pref.psi_openness ? "Yes" : "No"]</b></a><br>"
	. = jointext(.,null)

/datum/category_item/player_setup_item/physical/psionics/OnTopic(var/href,var/list/href_list, var/mob/user)
	if(href_list["select_psi_threat_level"])
		pref.psi_threat_level = clamp(input("Select threat level (0 - 4)", CHARACTER_PREFERENCE_INPUT_TITLE, pref.psi_threat_level), 0, 4)
		return TOPIC_REFRESH
	else if(href_list["select_psi_status"])
		var/selection = input("Select psionics status", CHARACTER_PREFERENCE_INPUT_TITLE, GLOB.psistatus2text[pref.psi_status]) in GLOB.text2psistatus
		if(!(selection in GLOB.text2psistatus))
			return TOPIC_HANDLED
		pref.psi_status = GLOB.text2psistatus[selection]
		return TOPIC_REFRESH
	else if(href_list["select_psi_openness"])
		var/selection = input("Select psionics openness", CHARACTER_PREFERENCE_INPUT_TITLE, pref.psi_openness ? "Yes" : "No") in list("Yes", "No")
		pref.psi_openness = (selection == "Yes")
		return TOPIC_REFRESH
	return ..()
