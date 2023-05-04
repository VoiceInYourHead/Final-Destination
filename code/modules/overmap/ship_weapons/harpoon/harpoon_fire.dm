/obj/machinery/computer/ship/ship_weapon/harpoon_gun/fire_at_sector(var/z_level, var/target_fore_dir, var/obj/effect/overmap/visitable/ship/target)
	log_and_message_admins("Гарпун от [linked.name] успешно попал в [target.name] на Z [z_level] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[linked.x];Y=[linked.y];Z=[linked.z]'>MAP</a>)")

	var/backwards = turn(overmapdir, 180)

	for(var/i = 1 to shoot_range)
		sleep(7)
		if(!target) // наша цель могла съебаться за те пол секунды, так что на всякий случай проверим
			return
		if(linked.z != 11) // куда ты залез ебланище?
			target.forceMove(get_step(target.loc, backwards)) // ладно уговорил, если куда-то и залез - значит мы легче
			return
		if(length(linked.locs))
			var/our_pos = pick(linked.locs)
			if(istype(our_pos, /obj/effect/overmap/visitable/sector))
				target.forceMove(get_step(target.loc, backwards))
				return
			if(istype(our_pos, /obj/effect/overmap/visitable/ship))
				var/obj/effect/overmap/visitable/ship/mothership = our_pos
				if(mothership.vessel_size > target.vessel_size)
					target.forceMove(get_step(target.loc, backwards))
					return
		if(linked.vessel_size > target.vessel_size)
			target.forceMove(get_step(target.loc, backwards))
		else if(linked.vessel_size < target.vessel_size)
			linked.forceMove(get_step(linked.loc, overmapdir))
		else if(linked.vessel_size == target.vessel_size)
			if(linked.vessel_mass > target.vessel_mass)
				target.forceMove(get_step(target.loc, backwards))
			else if(linked.vessel_mass < target.vessel_mass)
				linked.forceMove(get_step(linked.loc, overmapdir))
			else
				target.forceMove(get_step(target.loc, backwards))