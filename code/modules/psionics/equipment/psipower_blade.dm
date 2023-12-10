/obj/item/psychic_power/psiblade
	name = "psychokinetic slash"
	force = 15
	sharp = TRUE
	edge = TRUE
	maintain_cost = 6
	icon_state = "psiblade_short"
	item_state = "psiblade_short"
	attack_cooldown = 8

	base_parry_chance = 20
	have_stances = TRUE

	fail_chance = 20
	lunge_dist = 6
	melee_strikes = list(/datum/melee_strike/precise_strike/fast_attacks,/datum/melee_strike/swipe_strike/mixed_combo)

/obj/item/psychic_power/psiblade/master
	force = 25
	maintain_cost = 5

/obj/item/psychic_power/psiblade/master/grand
	force = 35
	maintain_cost = 4
	icon_state = "psiblade_long"
	item_state = "psiblade_long"

	base_parry_chance = 50

	lunge_dist = 4
	fail_chance = 40
	melee_strikes = list(/datum/melee_strike/swipe_strike/sword_slashes,/datum/melee_strike/swipe_strike/mixed_combo)

/obj/item/psychic_power/psiblade/master/grand/paramount // Silly typechecks because rewriting old interaction code is outside of scope.
	force = 50
	maintain_cost = 3
	icon_state = "psiblade_long"
	item_state = "psiblade_long"



/obj/item/psychic_power/psiaxe
	name = "psychokinetic axe"
	force = 25
	sharp = TRUE
	edge = TRUE
	maintain_cost = 8
	icon_state = "psiaxe"
	item_state = "psiaxe"
	attack_cooldown = 16

	base_parry_chance = 50
	have_stances = TRUE

	lunge_delay = 10 SECONDS
	lunge_dist = 2
	fail_chance = 40
	melee_strikes = list(/datum/melee_strike/swipe_strike/polearm_slash, /datum/melee_strike/swipe_strike/polearm_wide)

/obj/item/psychic_power/psiaxe/master
	force = 35
	maintain_cost = 6

/obj/item/psychic_power/psiaxe/master/grand
	force = 45
	maintain_cost = 4

/obj/item/psychic_power/psiaxe/master/grand/paramount
	force = 60
	maintain_cost = 2



/obj/item/psychic_power/psiclub
	name = "psychokinetic club"
	force = 10
	sharp = TRUE
	edge = TRUE
	maintain_cost = 5
	icon_state = "psiclub"
	item_state = "psiclub"
	attack_cooldown = 6

	base_parry_chance = 10
	have_stances = TRUE

	lunge_dist = 4
	fail_chance = 10
	melee_strikes = list(/datum/melee_strike/swipe_strike/blunt_swing/mixed_combo, /datum/melee_strike/circle_strike/blunt)

/obj/item/psychic_power/psiclub/master
	force = 20
	maintain_cost = 4

/obj/item/psychic_power/psiclub/master/grand
	force = 30
	maintain_cost = 3

/obj/item/psychic_power/psiclub/master/grand/paramount
	force = 45
	maintain_cost = 2



/obj/item/psychic_power/psispear
	name = "psychokinetic spear"
	force = 20
	sharp = TRUE
	edge = TRUE
	maintain_cost = 6
	icon_state = "psispear"
	item_state = "psispear"
	attack_cooldown = 12

	base_parry_chance = 30
	have_stances = TRUE

	lunge_delay = 10 SECONDS
	lunge_dist = 4
	fail_chance = 60
	melee_strikes = list(/datum/melee_strike/swipe_strike/polearm_mixed,/datum/melee_strike/swipe_strike/polearm_slash, /datum/melee_strike/swipe_strike/polearm_wide)

/obj/item/psychic_power/psispear/master
	force = 30
	maintain_cost = 5

/obj/item/psychic_power/psispear/master/grand
	force = 40
	maintain_cost = 4

/obj/item/psychic_power/psispear/master/grand/paramount
	force = 50
	maintain_cost = 3