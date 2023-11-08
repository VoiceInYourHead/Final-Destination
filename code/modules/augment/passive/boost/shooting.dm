/obj/item/organ/internal/augment/boost/shooting
	name = "gunnery booster"
	desc = "Hephaestus Industries' AIM-4 model improves gun accuracy by filtering unnecessary nerve signals."
	buffs = list(SKILL_WEAPONS = 1)
	injury_debuffs = list(SKILL_WEAPONS = -1)


/obj/item/organ/internal/augment/boost/reflex/buff()
	. = ..()
	if (.)
		to_chat(owner, SPAN_NOTICE("Notice: AIM-4 finished reboot."))


/obj/item/organ/internal/augment/boost/reflex/debuff()
	. = ..()
	if (.)
		to_chat(owner, SPAN_WARNING("Catastrophic damage detected: AIM-4 shutting down."))

/obj/item/organ/internal/augment/boost/shooting/bionic
	icon = 'icons/fd/items/device_eris.dmi'
	icon_state = "implant_excel"
	desc = "Seems like this thing doubling my accuracy"
	buffs = list(SKILL_WEAPONS = 3)
	injury_debuffs = list(SKILL_WEAPONS = -4)
	augment_flags = AUGMENT_BIOLOGICAL | AUGMENT_SCANNABLE | AUGMENT_INSPECTABLE

/obj/item/organ/internal/augment/boost/shooting/bionic/buff()
	. = ..()
	if (.)
		to_chat(owner, SPAN_NOTICE("Now i'm seeing the full picture of the world."))


/obj/item/organ/internal/augment/boost/shooting/bionic/debuff()
	. = ..()
	if (.)
		var/mob/living/carbon/human/M = src.loc
		M.eye_blind = 4
		M.eye_blurry = 8
		to_chat(owner, SPAN_DANGER("MY EYES!"))