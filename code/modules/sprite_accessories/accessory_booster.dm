/datum/sprite_accessory/marking/booster
	species_allowed = list(SPECIES_HUMAN)
	subspecies_allowed = list(SPECIES_HUMAN)
	icon = 'icons/mob/human_races/species/human/subspecies/booster_mods.dmi'


/datum/sprite_accessory/marking/booster/ears
	body_parts = list(BP_HEAD)
	draw_target = MARKING_TARGET_HEAD
	draw_order = 75 //before horns
	do_coloration = DO_COLORATION_AUTO
	disallows = list(
		/datum/sprite_accessory/marking/booster/ears,
		/datum/sprite_accessory/marking/booster/horns/ram
	)

//Ears

/datum/sprite_accessory/marking/booster/ears/pointy
	icon_state = "ears_pointy"
	name = "Ear Biomods (Pointy)"
	do_coloration = DO_COLORATION_SKIN


/datum/sprite_accessory/marking/booster/ears/pointy_down
	icon_state = "ears_pointy_down"
	name = "Ear Biomods (Pointy, Down)"
	do_coloration = DO_COLORATION_SKIN


/datum/sprite_accessory/marking/booster/ears/pointy_long
	icon_state = "ears_pointy_long"
	name = "Ear Biomods (Pointy, Long)"
	do_coloration = DO_COLORATION_SKIN


/datum/sprite_accessory/marking/booster/ears/pointy_long_down
	icon_state = "ears_pointy_long_down"
	name = "Ear Biomods (Pointy, Long, Down)"
	do_coloration = DO_COLORATION_SKIN


/datum/sprite_accessory/marking/booster/ears/cat
	icon_state = "ears_cat"
	name = "Ear Biomods (Cat)"
	do_coloration = DO_COLORATION_USER


/datum/sprite_accessory/marking/booster/ears/rabbit
	icon_state = "ears_bun"
	name = "Ear Biomods (Rabbit)"
	do_coloration = DO_COLORATION_USER

/datum/sprite_accessory/marking/booster/ears/fox
	icon_state = "ears_fox"
	name = "Ear Biomods (Fox)"
	do_coloration = DO_COLORATION_USER

/datum/sprite_accessory/marking/booster/ears/mouse
	icon_state = "ears_mouse"
	name = "Ear Biomods (Mouse)"
	do_coloration = DO_COLORATION_USER

//Horns

/datum/sprite_accessory/marking/booster/horns
	body_parts = list(BP_HEAD)
	draw_target = MARKING_TARGET_HEAD
	disallows = list(/datum/sprite_accessory/marking/booster/horns)


/datum/sprite_accessory/marking/booster/horns/ram
	icon_state = "horns_ram"
	name = "Horn Biomods (Goat, Ram)"
	disallows = list(
		/datum/sprite_accessory/marking/booster/horns,
		/datum/sprite_accessory/marking/booster/ears
	)

/datum/sprite_accessory/marking/booster/horns/venom_snake
	icon_state = "venom_snake"
	name = "Horns Biomods (Single, Demonic, Small)"

/datum/sprite_accessory/marking/booster/horns/unathi
	icon_state = "horns_unathi"
	name = "Horns Biomods (Demonic, Swept, Small)"

/datum/sprite_accessory/marking/booster/horns/unathi2
	icon_state = "horns_swept"
	name = "Horns Biomods (Goat, Swept)"

/datum/sprite_accessory/marking/booster/horns/unathi3
	icon_state = "horns_curved"
	name = "Horns Biomods (Goat, Curved)"

/datum/sprite_accessory/marking/booster/horns/spines_short
	icon_state = "horns_spines_short"
	name = "Horn Biomods (Short Spines)"


/datum/sprite_accessory/marking/booster/horns/spines_long
	icon_state = "horns_spines_long"
	name = "Horn Biomods (Long Spines)"


/datum/sprite_accessory/marking/booster/horns/frills_long
	icon_state = "horns_frills_long"
	name = "Horn Biomods (Long Frills)"


/datum/sprite_accessory/marking/booster/horns/frills_short
	icon_state = "horns_frills_short"
	name = "Horn Biomods (Short Frills)"
