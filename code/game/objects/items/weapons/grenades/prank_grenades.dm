/obj/item/grenade/fake
	icon_state = "frggrenade"

/obj/item/grenade/fake/detonate()
	active = 0
	playsound(src.loc, get_sfx("explosion"), 50, 1, 30)

/obj/item/grenade/spawnergrenade/fake_carp
	origin_tech = list(TECH_MATERIAL = 2, TECH_MAGNET = 2, TECH_BLUESPACE = 5)
	spawner_type = /mob/living/simple_animal/hostile/carp/holodeck
	deliveryamt = 4
	newvars = list("faction" = null, "natural_weapon" = /obj/item/natural_weapon/bite/holo, "environment_smash" = 0, "destroy_surroundings" = 0)