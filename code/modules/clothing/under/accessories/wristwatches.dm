/obj/item/clothing/accessory/wristwatches
	name = "black wrist watch"
	desc = "A simple time keeping device. Its nylon strap fits snugly on the wrist."
	icon_state = "wristwatch_black"
	body_location = HANDS


/obj/item/clothing/accessory/wristwatches/leather
	name = "leather wrist watch"
	desc = "A simple time keeping device. Its leather strap is quite fashionable."
	icon_state = "wristwatch_leather"


/obj/item/clothing/accessory/wristwatches/fancy
	name = "fancy wrist watch"
	desc = "A simple time keeping device. It probably cost more than your education."
	icon_state = "wristwatch_fancy"



/obj/item/clothing/accessory/wristwatches/examine(mob/user)
	. = ..()
	if (in_range(src, user))
		checktime()


/obj/item/clothing/accessory/wristwatches/proc/checktime()
	to_chat(usr, "You check \the [src]. The time is [stationtime2text()].")


/obj/item/clothing/accessory/wristwatches/OnTopic(mob/user, list/href_list)
	if(href_list["check_watch"])
		if(istype(user))
			examine(user)
			return TOPIC_HANDLED