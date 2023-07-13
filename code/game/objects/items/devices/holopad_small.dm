#define CALL_NONE 0
#define CALL_CALLING 1
#define CALL_RINGING 2
#define CALL_IN_CALL 3

/obj/item/device/holopad
	name = "Holopad"
	desc = "Small handheld disk with controls."
	icon = 'icons/fd/items/stock_parts.dmi'
	icon_state = "holopad"
	item_state = "card-id"
	w_class = ITEM_SIZE_TINY
	var/voice
	var/id
	var/uniq_id
	var/obj/item/device/holopad/abonent = null
	var/call_state = CALL_NONE
	var/obj/effect/overlay/hologram = null
	var/updatingPos = 0
	var/hologram_color = HOLOPAD_SHORT_RANGE
	origin_tech = list(TECH_DATA = 4, TECH_MAGNET = 4)

/obj/item/device/holopad/Initialize()
	uniq_id = random_id("holopad_device", 00000, 99999)
	id = rand(1000, 9999)
	name = "[initial(name)] [id] #[uniq_id]"
	voice = "Holopad [id]"
	GLOB.listening_objects += src
	. = ..()

/obj/item/device/holopad/Destroy()
	GLOB.listening_objects -= src
	abonent = null
	. = ..()


/obj/item/device/holopad/verb/setID()
	set name="Set ID"
	set category = "Object"
	set src in usr
	if(!CALL_NONE)
		to_chat(usr, SPAN_WARNING("Нельзя сменить ID прямо сейчас."))
		return
	var/newid = sanitize(input(usr, "Укажите ID голопада!") as null|text, MAX_NAME_LEN)
	if(newid && CanPhysicallyInteract(usr))
		id = newid
		name = "[initial(name)] [id] #[uniq_id]"

/obj/item/device/holopad/proc/getName(override_busy = 0)
	if(call_state!=CALL_NONE && !override_busy)
		return "Holopad [id] #[uniq_id] - busy"
	else
		return "Holopad [id] #[uniq_id]"

/obj/item/device/holopad/proc/incall(obj/item/device/holopad/caller)
	if(call_state != CALL_NONE)
		return FALSE
	abonent = caller
	call_state = CALL_RINGING
	icon_state = "holopad_ringing"
	desc = "[initial(desc)] Входящий вызов - [caller.getName()]."
	INVOKE_ASYNC(src, .proc/ring)
	return TRUE

/obj/item/device/holopad/proc/ring()
	if(call_state != CALL_RINGING)
		return
	audible_message(SPAN_WARNING("Что-то жужжит..."), hearing_distance = 4)
	addtimer(CALLBACK(src, .proc/ring), 50)

/obj/item/device/holopad/proc/placeCall(mob/user)
	var/list/Targets = list()
	for(var/obj/item/device/holopad/H in GLOB.listening_objects)
		if(H == src || !(H.loc.z in GetConnectedZlevels(loc.z)))
			continue
		Targets[H.getName()] = H
	var/selection = input("Кого вы хотите вызвать?") as null|anything in Targets
	if(!selection)
		return
	var/obj/item/device/holopad/target = Targets[selection]
	if(!target)
		return
	if(target.incall(src))
		call_state = CALL_CALLING
		abonent = target
		icon_state = "holopad_calling"
		desc = "[initial(desc)] Устанавливается соединение - [abonent.getName()]."
		audible_message("<span class='name'>[voice]</span> передаёт, \"Запрос на соединение: [sanitize(abonent.getName(1))]\"", hearing_distance = 4)
	else
		audible_message("<span class='name'>[voice]</span> передаёт, \"Соединение разорвано\"", hearing_distance = 4)

/obj/item/device/holopad/proc/acceptCall()
	if(call_state == CALL_RINGING)
		if(abonent && abonent.call_state == CALL_CALLING)
			abonent.acceptCall()
			call_state = CALL_IN_CALL
			icon_state = "holopad_in_call"
			addtimer(CALLBACK(src, .proc/update_holo), 1)
			audible_message("<span class='name'>[voice]</span> передаёт, \"Соединение установлено\"", hearing_distance = 4)
		else
			call_state = CALL_NONE
			icon_state = initial(icon_state)
			desc = initial(desc)
			abonent.desc = initial(desc)
			abonent = null

	else if(call_state == CALL_CALLING)
		call_state = CALL_IN_CALL
		icon_state = "holopad_in_call"
		addtimer(CALLBACK(src, .proc/update_holo), 1)

		audible_message("<span class='name'>[voice]</span> передаёт, \"Соединение установлено\"", hearing_distance = 4)

/obj/item/device/holopad/proc/hangUp(remote = 0)
	if(!remote && abonent)
		abonent.hangUp(1)

	if(call_state==CALL_NONE)
		return

	audible_message("<span class='name'>[voice]</span> передаёт, \"Соединение разорвано\"", hearing_distance = 4)
	call_state = CALL_NONE
	icon_state = initial(icon_state)
	desc = initial(desc)
	QDEL_NULL(hologram)
	if(abonent)
		if(abonent.hologram)
			QDEL_NULL(abonent.hologram)
		abonent = null

/obj/item/device/holopad/forceMove()
	..()
	update_holo()

/obj/item/device/holopad/proc/update_holo()
	if(!abonent)
		return
	if(call_state == CALL_IN_CALL)
		if(!abonent.hologram)
			abonent.hologram = new()
			abonent.hologram.name = "Hologram [sanitize(id)]"
			abonent.hologram.anchored = 1
			abonent.hologram.layer = 5
		if(isliving(loc))
			abonent.hologram.icon = getHologramIcon(getFullIcon(loc), hologram_color = hologram_color)
		else
			QDEL_NULL(abonent.hologram)
		if(!abonent.updatingPos)
			abonent.update_holo_pos()

/obj/item/device/holopad/proc/update_holo_pos()
	if(call_state != CALL_IN_CALL || !hologram)
		updatingPos = 0
		return
	updatingPos = 1
	if(isliving(loc))
		var/mob/living/L = loc
		hologram.dir = turn(L.dir,180)
		hologram.loc = L.loc
		hologram.pixel_x = ((L.dir&4)?32:((L.dir&8)?-32:0))
		hologram.pixel_y = ((L.dir&1)?32:((L.dir&2)?-32:0))
	else if(isturf(loc))
		hologram.dir = abonent.loc.dir
		hologram.loc = loc
		hologram.pixel_x = pixel_x + 1
		hologram.pixel_y = pixel_y + pixel_z + 18
	else
		hangUp()
	addtimer(CALLBACK(src, .proc/update_holo_pos), 2)


/obj/item/device/holopad/attack_self(mob/user)
	switch(call_state)
		if(CALL_NONE)
			placeCall()
		if(CALL_CALLING)
			hangUp()
		if(CALL_RINGING)
			acceptCall()
		if(CALL_IN_CALL)
			hangUp()


//EMOTES & SPEECH STUFF//

/obj/item/device/holopad/hear_talk(mob/living/M, text, verb, datum/language/speaking)
	if(abonent)
		abonent.broadcast_message(M, text, verb, speaking)

//Leaving this here, but as far as I can see, nowhere actually calls this proc???
/obj/item/device/holopad/see_emote(mob/living/M, text)
	if(abonent)
		abonent.visible_message("<i><span class='message'>[text]</span></i>")

/obj/item/device/holopad/show_message(msg, type, alt, alt_type)
	var/rendered
	if(abonent)
		var/mob/master = abonent.loc
		if(istype(master))
			if(findtext(msg, master.name))
				rendered = "<i><span class='game say'>The holographic image of <span class='message'>[msg]</span></span></i>"
		if(type == AUDIBLE_MESSAGE && !rendered)	//Or what the holopad can hear
			rendered = "<i><span class='game say'>Holopad received, <span class='message'>[msg]</span></span></i>"
		if(rendered)
			for(var/mob/living/mobs in view(abonent))
//				if(mobs == caller_id)
//					continue
				mobs.show_message(rendered, type)

/obj/item/device/holopad/proc/get_hear_message(name_used, text, verb, datum/language/speaking)
	if(speaking)
		return "<i><span class='game say'>Holopad received, <span class='name'>[name_used]</span> [speaking.format_message(text, verb)]</span></i>"
	return "<i><span class='game say'>Holopad received, <span class='name'>[name_used]</span> [verb], <span class='message'>\"[text]\"</span></span></i>"

//Because the holopads can't 'speak', this is used to preserve languages on the other side.
//This is essentially atom.audible_message() except with language taken into account
/obj/item/device/holopad/proc/broadcast_message(mob/living/M, text, verb, datum/language/speaking)
	var/turf/T = get_turf(src)
	var/list/mobs = list()
	var/list/objs = list()
	get_mobs_and_objs_in_view_fast(T, 5, mobs, objs)

	var/used_name = M.GetVoice()
	var/understood = get_hear_message(used_name, text, verb, speaking)
	var/gibberish = get_hear_message(used_name, speaking ? speaking.scramble(text) : stars(text), verb, speaking)

	for(var/mob/hearer in mobs)
		hearer.show_message(hearer.say_understands(M, speaking) ? understood : gibberish,2,null,1)

	for(var/obj/O in objs)
		if(O != src)	//Prevents echoes
			O.show_message(understood,2,null,1)


/*
/obj/item/device/holopad/cheap
	name = "Holopda"
	desc = "New brand pda now with holo-link and built-in clock."
	icon = 'icons/bos/obj/holopda.dmi'
	w_class = ITEM_SIZE_SMALL

/obj/item/device/holopad/cheap/examine(mob/user)
	. = ..()
	to_chat(user, "\the [src] displays [stationtime2text()].")
*/
#undef CALL_NONE
#undef CALL_CALLING
#undef CALL_RINGING
#undef CALL_IN_CALL
