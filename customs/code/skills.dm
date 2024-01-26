/obj/item/skill_buffer
	name = "skill qualification"
	var/id
	var/list/buffs = list()
	var/buffpath = /datum/skill_buff/badge

/obj/item/skill_buffer/attack_self(mob/living/carbon/human/user)
	if (buffs.len)
		user.buff_skill(buffs, 0, buffpath)
	qdel(src)

/datum/skill_buff/badge
	var/id