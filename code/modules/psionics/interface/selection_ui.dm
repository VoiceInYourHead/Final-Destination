/mob/living/carbon/human
	var/datum/psi_abilities_selection/psi_sel
	var/is_psi_abilities_selected = FALSE

/mob/living/carbon/human/Destroy()
	. = ..()
	psi_sel = null

/mob/living/carbon/human/proc/SelectPsiAbilities()
	set name     = "Select Psi Abilities"
	set category = "Psionics"
	if(!client?.prefs?.psi_threat_level || is_psi_abilities_selected)
		return

	var/datum/nano_module/psi_ui/ui = new(src)
	ui.ui_interact(src)

/datum/psi_abilities_selection
	var/list/selected = list() // faculty = level
	var/global/list/levels = list(
		"Blunt" = 0,
		"Latent"= 1,
		"Apprentice" = 2,
		"Operant" = 4,
		"Master" = 6

	)
	var/mob/living/carbon/human/M

/datum/psi_abilities_selection/proc/get_free_points()
	switch(M.client.prefs.psi_threat_level)
		if(1)
			. = 3
		if(2)
			. = 4
		if(3)
			. = 9
		if(4)
			. = 13

	for(var/category in selected)
		for(var/level in 1 to levels.len)
			var/level_name = levels[level]
			var/level_cost = levels[level_name]

			if(selected[category] == level)
				. -= level_cost

/datum/psi_abilities_selection/New(mob/living/carbon/human/host)
	. = ..()
	ASSERT(host.client?.prefs)
	M = host

	for(var/faculty in SSpsi.faculties_by_name_new)
		selected[faculty] = 1

/datum/psi_abilities_selection/proc/transfer()
	M.psi_sel = null
	M.is_psi_abilities_selected = TRUE
	M.verbs -= /mob/living/carbon/human/proc/SelectPsiAbilities
	for(var/name in selected)
		var/id = SSpsi.faculties_by_name_new[name]
		M.set_psi_rank(id, selected[name], defer_update = TRUE)
	M.psi.update()

/datum/psi_abilities_selection/proc/get_data()
	var/free_points = get_free_points()

	.               = list()
	.["faculties"]  = list()
	.["free_points"]= free_points

	for(var/category in selected)
		var/list/levels_to_select = list()
		for(var/level in 1 to levels.len)
			var/level_name    = levels[level]
			var/selected_level= selected[category]

			levels_to_select += list(list(
				"name"        = level_name,
				"level"       = "[level]",
				"category"    = category,
				"selected"    = selected_level == level,
				"selectable"  = can_select(category, level)
			))

		.["faculties"] += list(list(
			"name"      = category,
			"levels"    = levels_to_select
		))

	return .

/datum/psi_abilities_selection/proc/can_select(category, level)
	return (get_free_points() + levels[levels[selected[category]]]) >= levels[levels[level]]

/datum/psi_abilities_selection/proc/select(category, level)
	selected[category] = level

/datum/nano_module/psi_ui
	var/datum/psi_abilities_selection/psi_sel = null

/datum/nano_module/psi_ui/New(mob/living/carbon/human/host, topic_manager)
	if(!host.psi_sel)
		host.psi_sel = new(host)
	psi_sel = host.psi_sel
	..()

/datum/nano_module/psi_ui/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = GLOB.self_state)
	if(!psi_sel)
		return

	var/list/data = psi_sel.get_data()

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "psi_ui.tmpl", "Psi abilities", 500, 370, src, state = state)
		ui.set_initial_data(data)
		ui.open()

/datum/nano_module/psi_ui/Topic(href, href_list)
	if(..())
		return TOPIC_HANDLED
	if(!psi_sel)
		return TOPIC_HANDLED


	if(href_list["select"])
		var/level = text2num(href_list["select"])
		var/category= href_list["category"]
		if(!psi_sel.can_select(category, level))
			return TOPIC_HANDLED
		psi_sel.select(category, level)

	if(href_list["confirm"])
		var/confirmation = alert("Are you sure? After confirming you won't be able to change your starting abilities later", "Confirmation", "No", "Yes, give me my psi")
		if(confirmation != "Yes, give me my psi")
			return TOPIC_HANDLED

		psi_sel.transfer()
		qdel(src)
		return TOPIC_HANDLED

	return TOPIC_REFRESH
