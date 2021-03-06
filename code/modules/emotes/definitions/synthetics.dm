/decl/emote/audible/synth
	key = "beep"
	emote_message_3p = "USER пиликает."
	emote_sound = 'sound/machines/twobeep.ogg'

/decl/emote/audible/synth/check_user(var/mob/living/user)
	if(istype(user) && user.isSynthetic())
		return ..()
	return FALSE

/decl/emote/audible/synth/ping
	key = "ping"
	emote_message_3p = "USER издаёт сигнал запроса."
	emote_sound = 'sound/machines/ping.ogg'

/decl/emote/audible/synth/buzz
	key = "buzz"
	emote_message_3p = "USER издает жужжащие звуки."
	emote_sound = 'sound/machines/buzz-sigh.ogg'

/decl/emote/audible/synth/confirm
	key = "confirm"
	emote_message_3p = "USER посылает положительный сигнал."
	emote_sound = 'sound/machines/synth_yes.ogg'

/decl/emote/audible/synth/deny
	key = "deny"
	emote_message_3p = "USER посылает отрицательный сигнал."
	emote_sound = 'sound/machines/synth_no.ogg'

/decl/emote/audible/synth/security
	key = "law"
	emote_message_3p = "USER shows USER_HIS legal authorization barcode."
	emote_message_3p_target = "USER shows TARGET USER_THEIR legal authorization barcode."
	emote_sound = 'sound/voice/biamthelaw.ogg'

/decl/emote/audible/synth/security/check_user(var/mob/living/silicon/robot/user)
	return (istype(user) && istype(user.module,/obj/item/robot_module/security))

/decl/emote/audible/synth/security/halt
	key = "halt"
	emote_message_3p = "USER's speakers skreech, \"Halt! Security!\"."
	emote_sound = 'sound/voice/halt.ogg'
