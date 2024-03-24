/obj/item/mech_equipment/mounted_system/taser/plasma_rifle
	name = "mounted plasma rifle"
	desc = "A very deadly mounted plasma rifle, capable of destroying everything."
	icon_state = "mech_ionrifle"
	holding_type = /obj/item/gun/energy/pulse_rifle/mounted/mech

/obj/item/gun/energy/pulse_rifle/mounted/mech
	self_recharge = TRUE
	use_external_power = TRUE
	has_safety = FALSE
	one_hand_penalty= 0

/obj/item/gun/energy/machingegun/mounted/mech
	name = "mech machingegun"
	desc = "You shouldn't see this!"
	icon = 'icons/obj/guns/saw.dmi'
	icon_state = "l6closed50"
	item_state = "l6closedmag"
	force = 10
	projectile_type = /obj/item/projectile/bullet/pistol
	max_shots = 40
	multi_aim = 1
	move_delay = 0
	fire_delay = 5
	can_autofire = 1
	burst = 3
	accuracy = -1
	bulk = GUN_BULK_RIFLE
	w_class = ITEM_SIZE_HUGE
	one_hand_penalty = 0

	charge_cost = 7.5
	self_recharge = TRUE
	recharge_time = 1
	use_external_power = TRUE
	has_safety = FALSE

/obj/item/mech_equipment/mounted_system/taser/machinegun
	name = "mounted machinegun"
	desc = "An exosuit-mounted machinegun. Handle with care."
	icon_state = "mech_ballistic2"
	restricted_hardpoints = list(HARDPOINT_LEFT_HAND, HARDPOINT_RIGHT_HAND, HARDPOINT_LEFT_SHOULDER, HARDPOINT_RIGHT_SHOULDER)
	holding_type = /obj/item/gun/energy/machingegun/mounted/mech
