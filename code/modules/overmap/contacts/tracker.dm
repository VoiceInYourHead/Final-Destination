/obj/item/ship_tracker
	name = "long range tracker"
	desc = "A complex device that transmits conspicuous signals, easily locked onto by modern sensors hardware."
	icon = 'icons/obj/ship_tracker.dmi'
	icon_state = "disabled"
	w_class = ITEM_SIZE_SMALL

	origin_tech = list(TECH_ENGINEERING = 3, TECH_COMBAT = 2)
	matter = list(MATERIAL_SILVER = 400, MATERIAL_GOLD = 400)
	var/enabled = FALSE

/obj/item/ship_tracker/Initialize()
	. = ..()
	set_extension(src, /datum/extension/interactive/multitool/store)

/obj/item/ship_tracker/attack_self(var/mob/user)
	enabled = !enabled
	to_chat(user, SPAN_NOTICE("You [enabled ? "enable" : "disable"] \the [src]"))
	update_icon()

/obj/item/ship_tracker/on_update_icon()
	. = ..()
	icon_state = enabled ? "enabled" : "disabled"

/obj/item/ship_tracker/examine(var/mob/user)
	. = ..()
	to_chat(user, "It appears to be [enabled ? "enabled" : "disabled"]")