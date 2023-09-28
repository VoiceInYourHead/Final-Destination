/obj/item/fd/ancient_items
	name = "ancient thing"
	desc = "some ancient stuff, idk"
	icon = 'icons/fd/items/oddities.dmi'
	icon_state = "blueprint"

/obj/item/fd/ancient_items/psionic
	name = "strange old folder"
	desc = "An old folder, which contains various research data about psionic powers. You also can see some mentions of 'NEMESIS' here. What could it mean?"
	icon_state = "folder-psi"

/obj/item/fd/ancient_items/zippo
	name = "broken syndicate zippo"
	desc = "Rusted zippo with three-headed 'S'-shaped snake on it. This one probably belongs to 'Syndicate', terrorist group, that existed in the time of corporate wars."
	icon_state = "syndicate_lighter"

/obj/item/fd/ancient_items/bs_shard
	name = "bluespace shard"
	desc = "The really rare, non-fluid state of bluespace."
	icon = 'icons/fd/structures/bluespace_crystal_structure.dmi'
	icon_state = "shard"
	origin_tech = list(TECH_BLUESPACE = 10)

/obj/item/fd/ancient_items/corrupted_radio
	name = "corrupted radio"
	desc = "Really old-looking radio, corrupted by some kind of blue, pulsing vines. God knows where it been."
	icon_state = "warped_radio"

	var/teleport_x_offset = 0
	var/teleport_y_offset = 0
	var/teleport_z_offset = 0

	origin_tech = list(TECH_ESOTERIC = 10, TECH_BIO = 5, TECH_BLUESPACE = 5)

/obj/item/fd/ancient_items/corrupted_radio/attack_self(mob/living/carbon/user)
	var/option =  alert(user, "Do you really wanna touch it?", "Wait!", "Yes", "No")
	switch(option)
		if("Yes")
			if(do_after(user, 50)) //let's give 'em the last chance
				if(prob(30))
					user.flash_eyes()
					user.adjustBrainLoss(rand(20,30))
					to_chat(user, "<span class='danger'>Radio flashes, turning into!...What is this thing?</span>")
					new /obj/item/fd/ancient_items/bs_shard(src.loc)
					qdel(src)
				else
					user.alpha = 200
					user.alpha = 100
					user.alpha = 50
					user.alpha = 0
					var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
					s.set_up(3, 1, src)
					s.start()
					playsound(src,'sound/effects/teleport.ogg',60,1)
					user.flash_eyes()
					var/turf/T = locate(rand(1, world.maxx), rand(1, world.maxy), rand(1, world.maxz))
					if(T)
						user.forceMove(T)
						user.alpha = 0
						user.alpha = 50
						user.alpha = 100
						user.alpha = 200
						user.alpha = 255
						to_chat(user, "<span class='danger'>FUCK, FUCK, FUCK, MY HEAAAAA-</span>")
						user.adjustBrainLoss(rand(20,30))
		else
			return