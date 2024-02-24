/client/proc/order_move(atom/A as mob|obj|turf in view())
	set name = "Mind Control: Move"
	set category = "IC"

	var/datum/mind_control/mind_controller = mob.mind_controller
	if(!mind_controller)
		verbs -= /client/proc/order_move
		return

	mind_controller.target = A
