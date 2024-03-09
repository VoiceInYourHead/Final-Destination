/mob/proc/say()
	return

/mob/verb/whisper()
	set name = "Whisper"
	set category = "IC"
	return

/mob/verb/say_verb(message as text)
	set name = "Say"
	set category = "IC"
	remove_typing_indicator()
	usr.say(message)

/mob/verb/me_verb(message as text)
	set name = "Me"
	set category = "IC"

	message = sanitize(message)

	remove_typing_indicator()
	if(use_me)
		usr.emote("me",usr.emote_type,message)
	else
		usr.emote(message)

/mob/proc/say_dead(var/message)
	communicate(/decl/communication_channel/dsay, client, message)

/mob/proc/say_understands(var/mob/other,var/datum/language/speaking = null)

	if (src.stat == 2)		//Dead
		return 1

	//Universal speak makes everything understandable, for obvious reasons.
	else if(src.universal_speak || src.universal_understand)
		return 1

	//Languages are handled after.
	if (!speaking)
		if(!other)
			return 1
		if(other.universal_speak)
			return 1
		if(isAI(src) && ispAI(other))
			return 1
		if (istype(other, src.type) || istype(src, other.type))
			return 1
		return 0

	if(speaking.flags & INNATE)
		return 1

	//Language check.
	for(var/datum/language/L in src.languages)
		if(speaking.name == L.name && !(L.flags & BAD_SPEAKER)) //INF
			return 1

	return 0

/mob/proc/say_quote(var/message, var/datum/language/speaking = null)
	var/ending = copytext_char(message, length(message) - 1)
	if(speaking)
		return speaking.get_spoken_verb(ending)

	var/verb = pick(speak_emote)
	if(verb == "говорит") //a little bit of a hack, but we can't let speak_emote default to an empty list without breaking other things
		if(ending == "!!")
			verb = "кричит"
		else if(copytext_char(ending, length(ending)) == "!")
			verb = pick("восклицает")
		else if(copytext_char(ending, length(ending)) == "?")
			verb = "спрашивает"
	return verb

/mob/proc/get_ear()
	// returns an atom representing a location on the map from which this
	// mob can hear things

	// should be overloaded for all mobs whose "ear" is separate from their "mob"

	return get_turf(src)

/mob/proc/say_test(var/text)
	var/ending = copytext_char(text, length(text))
	if (ending == "?")
		return "1"
	else if (ending == "!")
		return "2"
	return "0"

//parses the message mode code (e.g. :h, :w) from text, such as that supplied to say.
//returns the message mode string or null for no message mode.
//standard mode is the mode returned for the special ';' radio code.
/mob/proc/parse_message_mode(var/message, var/standard_mode="headset")
	if(length(message) >= 1 && copytext_char(message,1,2) == get_prefix_key(/decl/prefix/radio_main_channel))
		return standard_mode

	if(length(message) >= 2)
		var/channel_prefix = copytext_char(message, 1 ,3)
		return department_radio_keys[channel_prefix]

	return null

//parses the language code (e.g. :j) from text, such as that supplied to say.
//returns the language object only if the code corresponds to a language that src can speak, otherwise null.
/mob/proc/parse_language(var/message)
	var/prefix = copytext_char(message,1,2)
	if(length(message) >= 1 && prefix == get_prefix_key(/decl/prefix/audible_emote))
		return all_languages["Noise"]

	if(length(message) >= 2 && is_language_prefix(prefix))
		var/language_prefix = lowertext(copytext_char(message, 2 ,3))
		var/datum/language/L = language_keys[language_prefix]
		if (can_speak(L))
			return L

	return null

/mob/var/tmp/accent_tag_cache
/mob/proc/get_accent_tag(mob/speaker)
	if(client?.get_preference_value(/datum/client_preference/accent_tags) != GLOB.PREF_SHOW)
		return ""

	if(!speaker.client || !iscarbon(speaker))
		return ""

	if(!speaker.accent_tag_cache)
		var/static/list/culture2state = list(
			CULTURE_HUMAN_LUNAPOOR = "luna_low",
			CULTURE_HUMAN_LUNARICH = "luna_upper",
			CULTURE_HUMAN_VENUSIAN = "venus",
			CULTURE_HUMAN_VENUSLOW = "venus",
			CULTURE_HUMAN_MARTIAN  = "mars_surface",
			CULTURE_HUMAN_MARSTUN  = "mars_tunneller",
			CULTURE_HUMAN_BELTER   = "belter",
			CULTURE_HUMAN_PLUTO    = "pluto",
			CULTURE_HUMAN_EARTH    = "earth",
			CULTURE_HUMAN_CETI     = "ceti",
			CULTURE_HUMAN_SPACER   = "spacer",
			CULTURE_HUMAN_SPAFRO   = "spacer",
			CULTURE_HUMAN_KIPERIUSMINER = "kiperius",
			CULTURE_HUMAN_KIPERIUSPRISONER = "kiperius",
			CULTURE_HUMAN_CONFED   = "terran",
			CULTURE_HUMAN_MEOT	   = "meonian",
			CULTURE_HUMAN_REPUBL   = "republican"

		)

		var/culture = speaker.client.prefs.cultural_info[TAG_CULTURE]
		speaker.accent_tag_cache = (culture in culture2state) ? culture2state[culture] : "human_other"

	return icon2html(icon('icons/accent_tags.dmi', speaker.accent_tag_cache), src, realsize = TRUE, class = "text_tag", incy = 3)
