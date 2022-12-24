/obj/item/psychic_power/psiblade
	name = "psychokinetic slash"
	force = 15
	sharp = TRUE
	edge = TRUE
	maintain_cost = 1
	icon_state = "psiblade_short"
	item_state = "psiblade"
	attack_cooldown = 8

/obj/item/psychic_power/psiblade/master
	force = 25
	maintain_cost = 2

/obj/item/psychic_power/psiblade/master/grand
	force = 35
	maintain_cost = 3
	icon_state = "psiblade_long"

/obj/item/psychic_power/psiblade/master/grand/paramount // Silly typechecks because rewriting old interaction code is outside of scope.
	force = 50
	maintain_cost = 4
	icon_state = "psiblade_long"
