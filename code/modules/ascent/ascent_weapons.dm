// MANTIDIFY(/obj/item/magnetic_ammo/skrell, "mantid flechette cylinder", "A magazine containing steel flechettes.")
// MANTIDIFY(/obj/item/gun/magnetic/railgun/flechette, "mantid flechette rifle", "A viciously pronged rifle-like weapon.")

/obj/item/gun/energy/particle
	name = "particle emitter"
	desc = "A long, thick-bodied energy rifle of some kind, clad in a curious indigo polymer and lit from within by Cherenkov radiation. The grip is clearly not designed for human hands."
	icon = 'icons/obj/guns/particle_rifle.dmi'
	icon_state = "particle_rifle"
	item_state = "particle_rifle"
	slot_flags = SLOT_BACK
	force = 25 // Heavy as Hell.
	projectile_type = /obj/item/projectile/beam/particle
	max_shots = 18
	self_recharge = 1
	multi_aim = 1
	burst_delay = 3
	burst = 3
	move_delay = 4
//inf	accuracy = -1
	wielded_item_state = "particle_rifle-wielded"
	charge_meter = 0
	has_safety = FALSE

	init_firemodes = list(
		list(mode_name="kill", projectile_type=/obj/item/projectile/beam/particle),
		list(mode_name="shock", projectile_type=/obj/item/projectile/beam/stun/shock),
		list(mode_name="stun", projectile_type=/obj/item/projectile/beam/stun),
		)

	var/global/list/species_can_use = list(
		SPECIES_MANTID_ALATE,
		SPECIES_MANTID_GYNE,
		SPECIES_NABBER,
		SPECIES_MONARCH_QUEEN,
		SPECIES_MONARCH_WORKER
	)
	var/charge_state = "pr"

	bulk = GUN_BULK_RIFLE //inf
	w_class = ITEM_SIZE_HUGE
	one_hand_penalty = 6

/obj/item/gun/energy/particle/special_check(mob/living/carbon/human/user)
	. = ..()
	if(.)
//		if(istype(user, /mob/living/silicon/robot/flying/ascent))
//			return TRUE
		if(!length(species_can_use))
			return TRUE
		if(!istype(user) || !(user.species.get_bodytype(user) in species_can_use))
			return FALSE

/obj/item/gun/energy/particle/small
	name = "particle projector"
	desc = "A smaller variant on the Ascent particle lance, usually carried by drones and alates."
	icon_state = "particle_rifle_small"
	force = 12
	max_shots = 9
	burst = 1
	move_delay = 2
	charge_state = "prsmall"
	slot_flags = SLOT_DENYPOCKET | SLOT_HOLSTER
	projectile_type = /obj/item/projectile/beam/particle/small

	init_firemodes = list(
		list(mode_name="stun", projectile_type=/obj/item/projectile/beam/stun/smalllaser),
		list(mode_name="shock", projectile_type=/obj/item/projectile/beam/stun/shock/smalllaser),
		list(mode_name="kill", projectile_type=/obj/item/projectile/beam/particle/small),
		)

/obj/item/gun/energy/particle/flechette
	name = "crystal flechette rifle"
	desc = "A viscious looking rifle decorated with a growth of sharp purple crystals."
	one_hand_penalty = 6
	burst = 1
	projectile_type = /obj/item/projectile/bullet/magnetic/flechette
	init_firemodes = list(list(projectile_type = /obj/item/projectile/bullet/magnetic/flechette))
	color = COLOR_ASCENT_PURPLE

/obj/item/projectile/beam/particle
	name = "particle lance"
	icon_state = "particle"
	damage = 35
	armor_penetration = 50
	fire_sound= 'sound/weapons/laser3.ogg'
	muzzle_type = /obj/effect/projectile/laser_particle/muzzle
	tracer_type = /obj/effect/projectile/laser_particle/tracer
	impact_type = /obj/effect/projectile/laser_particle/impact
	penetration_modifier = 0.5

/obj/item/projectile/beam/particle/small
	name = "particle beam"
	damage = 20
	armor_penetration = 20
	fire_sound= 'sound/weapons/scan.ogg'
	penetration_modifier = 0.3

/obj/item/gun/energy/particle/on_update_icon()
	. = ..()
//	var/datum/firemode/current_mode = firemodes[sel_mode]
//	overlays = list(
//		image(icon, "[charge_state]mode-[istype(current_mode) ? current_mode.name : "lethal"]"),
//		image(icon, "[charge_state]charge-[Floor(power_supply.percent()/20)]")
//	)

/obj/item/gun/energy/particle/get_mob_overlay(var/mob/living/carbon/human/user, var/slot)
	if(istype(user) && (slot == slot_l_hand_str || slot == slot_r_hand_str))
		var/bodytype = user.species.get_bodytype(user)
		if(bodytype in species_can_use)
			if(slot == slot_l_hand_str)
				if(bodytype == SPECIES_MANTID_ALATE)
					return overlay_image('icons/mob/species/mantid/onmob_lefthand_particle_rifle_alate.dmi',  item_state_slots[slot_l_hand_str], color, RESET_COLOR)
				else if(bodytype == SPECIES_MANTID_GYNE)
					return overlay_image('icons/mob/species/mantid/onmob_lefthand_particle_rifle_gyne.dmi',   item_state_slots[slot_l_hand_str], color, RESET_COLOR)
				else if(bodytype == SPECIES_MONARCH_QUEEN)
					return overlay_image('icons/mob/species/nabber/msq/onmob_lefthand_particle_rifle.dmi',   item_state_slots[slot_l_hand_str], color, RESET_COLOR)
				else
					return overlay_image('icons/mob/species/nabber/onmob_lefthand_particle_rifle.dmi',  item_state_slots[slot_l_hand_str], color, RESET_COLOR)
			else if(slot == slot_r_hand_str)
				if(bodytype == SPECIES_MANTID_ALATE)
					return overlay_image('icons/mob/species/mantid/onmob_righthand_particle_rifle_alate.dmi', item_state_slots[slot_r_hand_str], color, RESET_COLOR)
				else if(bodytype == SPECIES_MANTID_GYNE)
					return overlay_image('icons/mob/species/mantid/onmob_righthand_particle_rifle_gyne.dmi',  item_state_slots[slot_r_hand_str], color, RESET_COLOR)
				else if(bodytype == SPECIES_MONARCH_QUEEN)
					return overlay_image('icons/mob/species/nabber/msq/onmob_righthand_particle_rifle.dmi',   item_state_slots[slot_l_hand_str], color, RESET_COLOR)
				else
					return overlay_image('icons/mob/species/nabber/onmob_righthand_particle_rifle.dmi', item_state_slots[slot_r_hand_str], color, RESET_COLOR)
	. = ..(user, slot)

/*
/obj/item/gun/magnetic/railgun/flechette/ascent
	one_hand_penalty = 7
	fire_delay = 10
	slowdown_held = 1
	slowdown_worn = 1
	removable_components = FALSE
	has_safety = FALSE
	cell = /obj/item/cell/mantid
	capacitor = /obj/item/stock_parts/capacitor/super
	load_type = /obj/item/magnetic_ammo/skrell
	loaded = /obj/item/magnetic_ammo/skrell/ascent
	projectile_type = /obj/item/projectile/bullet/magnetic/flechette
	slot_flags = SLOT_BACK
	power_cost = 100
	var/global/list/species_can_use = list(
		SPECIES_MANTID_ALATE,
		SPECIES_MANTID_GYNE,
		SPECIES_NABBER,
		SPECIES_MONARCH_QUEEN,
		SPECIES_MONARCH_WORKER
	)

/obj/item/gun/magnetic/railgun/flechette/ascent/special_check(mob/living/carbon/human/user)
	. = ..()
	if(.)
//		if(istype(user, /mob/living/silicon/robot/flying/ascent))
//			return TRUE
		if(!length(species_can_use))
			return TRUE
		if(!istype(user) || !(user.species.get_bodytype(user) in species_can_use))
			return FALSE

/obj/item/magnetic_ammo/skrell/ascent
	projectile_name = "flechette"
*/