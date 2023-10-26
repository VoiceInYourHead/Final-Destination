/obj/item/material/sword
	name = "claymore"
	desc = "What are you standing around staring at this for? Get to killing!"
	icon = 'icons/obj/weapons/melee_physical.dmi'
	icon_state = "claymore"
	item_state = "claymore"
	slot_flags = SLOT_BELT
	w_class = ITEM_SIZE_LARGE
	force_multiplier = 0.5 // 30 when wielded with hardnes 60 (steel)
	armor_penetration = 10
	thrown_force_multiplier = 0.5 // 10 when thrown with weight 20 (steel)
	sharp = TRUE
	edge = TRUE
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	base_parry_chance = 50
	melee_accuracy_bonus = 10
	worth_multiplier = 30
	lunge_dist = 3
	fail_chance = 70
	have_stances = TRUE
	melee_strikes = list(/datum/melee_strike/swipe_strike/sword_slashes,/datum/melee_strike/swipe_strike/mixed_combo)

/obj/item/material/sword/can_embed()
	return FALSE

/obj/item/material/sword/replica
	max_force = 10
	edge = FALSE
	sharp = FALSE
	force_multiplier = 0.2
	thrown_force_multiplier = 0.2
	worth_multiplier = 15

/obj/item/material/sword/katana
	name = "katana"
	desc = "Woefully underpowered in D20. This one looks pretty sharp."
	icon = 'icons/obj/weapons/melee_physical.dmi'
	icon_state = "katana"
	item_state = "katana"
	furniture_icon = "katana_handle"
	slot_flags = SLOT_BELT | SLOT_BACK

/obj/item/material/sword/katana/replica
	max_force = 10
	edge = FALSE
	sharp = FALSE
	force_multiplier = 0.2
	thrown_force_multiplier = 0.2

/obj/item/material/sword/katana/vibro
	name = "vibrokatana"
	desc = "A high-tech take on a woefully underpowered weapon. Can't mistake its sound for anything."
	default_material = MATERIAL_TITANIUM
	hitsound = 'sound/weapons/anime_sword.wav'

/obj/item/material/sword/katana/vibro/equipped(mob/user, slot)
	if(slot == slot_l_hand || slot == slot_r_hand)
		playsound(src, 'sound/weapons/katana_out.wav', 50, 1, -5)

/obj/item/material/sword/katana/raiden
	name = "High frequency sword"
	desc = "a high-frequency sword, its blade is specially sharpened using a blue-space machine. The sword is barely felt in the hand, which means that it is incredibly light. and on the handle is written: 'an instrument of justice'"
	icon = 'proxima/icons/obj/weapons/melee.dmi'
	icon_state = "hfrequency0"
	force = 45
	health_max = 1000
	melee_accuracy_bonus = 20
	default_material = MATERIAL_TITANIUM
	unbreakable = TRUE
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 6)
	item_icons = list(
		slot_l_hand_str = 'proxima/icons/mob/weapons/swords_lefthand.dmi',
		slot_r_hand_str = 'proxima/icons/mob/weapons/swords_righthand.dmi'
		)
	item_state_slots = list(
		slot_r_hand_str = "hfrequency0",
		slot_l_hand_str = "hfrequency0"
		)
	slot_flags = SLOT_BELT
