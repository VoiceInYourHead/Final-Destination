/obj/machinery/computer/ship/ship_weapon/beam_cannon/particle_lance/handle_beam_damage(var/turf/s, var/d, var/killing_floor = FALSE)
	set waitfor = FALSE
	for(var/turf/T in getline(s,get_target_turf(s, d)))
		if(istype(T,/turf/unsimulated/planet_edge))
			return
		var/deflected = FALSE
		for(var/obj/effect/shield/S in T)
			if(S.gen.check_flag(shield_modflag_counter) && S.density)
				S.take_damage(3000,SHIELD_DAMTYPE_EM)
				deflected = TRUE
		if(deflected)
			var/def_angle = pick(90,-90,0)
			handle_beam_damage(get_step(T, turn(d, 180)), turn(d,180 + def_angle), TRUE)
			handle_beam_on_enemy(get_step(T, turn(d, 180)), turn(d,180 + def_angle))
			log_and_message_admins("��� [gun_name] ������ ����������� �� ����.")
			break
		if(T.density && !killing_floor)
			sleep(beam_speed)
			cell_explosion(T, 300, 100)
			if(T && T.density)
				T.ex_act(1,TRUE)
		else if(killing_floor && !istype(T, /turf/unsimulated/floor/exoplanet/clouds))
			sleep(beam_speed)
			cell_explosion(T, 300, 100)
			if(T)
				T.ex_act(1,TRUE)
			var/list/relevant_z = GetConnectedZlevels(s.z)
			for(var/mob/M in GLOB.player_list)
				var/turf/J = get_turf(M)
				if(!J || !(J.z in relevant_z))
					continue
				shake_camera(M, shake_camera_force/10, 0.5)
			if(!T.density && !istype(T, /turf/unsimulated/floor/exoplanet/clouds))
				empulse(T, heavy_ion_effect_range, light_ion_effect_range)
		else
			sleep(beam_speed)
		for(var/mob/living/U in T)
			U.gib()
		for(var/atom/A in T)
			if(A.density && !istype(A,/obj/effect/shield))
				cell_explosion(T, 300, 100)
				if(A && A.density)
					A.ex_act(1,TRUE)
