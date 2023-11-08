/obj/item/organ/internal/augment/boost/reflex
	name = "synapse interceptor"
	desc = "A miniature computer with a primitive AI, this piece of engineering uses predictive algorithms and machine learning to provide near-instant response to any close combat situation."
	buffs = list(SKILL_COMBAT = 1)
	injury_debuffs = list(SKILL_COMBAT = -1)


/obj/item/organ/internal/augment/boost/reflex/buff()
	. = ..()
	if (.)
		to_chat(owner, SPAN_NOTICE("Notice: Close combat heuristics recalibrated."))


/obj/item/organ/internal/augment/boost/reflex/debuff()
	. = ..()
	if (.)
		to_chat(owner, SPAN_WARNING("E%r00r: dAmage detect-ted to synapse connections."))

/obj/item/organ/internal/augment/boost/reflex/bionic
	icon = 'icons/fd/items/device_eris.dmi'
	icon_state = "implant_freedom"
	desc = "Seems like this thing doubling all my reflexes"
	buffs = list(SKILL_COMBAT = 2,SKILL_HAULING = 1)
	injury_debuffs = list(SKILL_COMBAT = -2, SKILL_HAULING = -2)
	augment_flags = AUGMENT_BIOLOGICAL | AUGMENT_SCANNABLE | AUGMENT_INSPECTABLE

/obj/item/organ/internal/augment/boost/reflex/bionic/buff()
	. = ..()
	if (.)
		to_chat(owner, SPAN_NOTICE("You feel, like your senses doubled."))


/obj/item/organ/internal/augment/boost/reflex/bionic/debuff()
	. = ..()
	if (.)
		owner.Paralyse(5)
		owner.confused = max(owner.confused, 10)
		to_chat(owner, SPAN_DANGER("THE PAIN!"))
