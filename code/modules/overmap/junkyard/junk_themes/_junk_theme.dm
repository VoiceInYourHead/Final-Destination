/datum/junkyard_theme
	var/name = "Nothing Special"
	var/ruin_tags_whitelist
	var/ruin_tags_blacklist
	var/list/sub_themes = list() // other themes that work in tandem

// Called by exoplanet datum before applying its map generators
/datum/junkyard_theme/proc/before_map_generation(obj/effect/overmap/visitable/sector/junkyard/E)

// Called by exoplanet datum after applying its map generators and spawning ruins
/datum/junkyard_theme/proc/after_map_generation(obj/effect/overmap/visitable/sector/junkyard/E)

/datum/junkyard_theme/proc/get_sensor_data()
	return "No significant terrain features detected."