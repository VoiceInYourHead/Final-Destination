/obj/structure/ship_munition/ammobox/crystal/ex_act()
	return

/obj/structure/ship_munition/ammobox/crystal/New()
	..()
	max_ammo = ammo_count

/obj/structure/ship_munition/ammobox/crystal/Initialize()
	..()
	START_PROCESSING(SSobj, src)

/obj/structure/ship_munition/ammobox/crystal/Destroy()
	..()
	STOP_PROCESSING(SSobj, src)

/obj/structure/ship_munition/ammobox/crystal/Process()
	if(regenerate_ammo && ammo_count < max_ammo)
		regen++
		if(regen >= regenerate_delay)
			regen = 0
			ammo_count++
	..()

///////////////////////////AMMOBOX///////////////////////////

/obj/structure/ship_munition/ammobox/crystal
	name = "Mobile crystal growth chamber"
	desc = "A box where the crystals growth. (PLACEHOLDER)"
	ammo_count = 48
	ammo_type = /obj/item/projectile/bullet/crystal

	var/max_ammo = 0

	var/regenerate_ammo = TRUE
	var/regenerate_delay = 10
	var/regen = 0

/obj/structure/ship_munition/ammobox/crystal/high_explosive
	name = "Mobile B-type crystal growth chamber"
	icon_state = "ammocrate_autocannon_he"
	ammo_count = 24
	ammo_type = /obj/item/projectile/bullet/crystal/high_explosive

/obj/structure/ship_munition/ammobox/crystal/shrapnel
	name = "Mobile X-type crystal growth chamber"
	icon_state = "ammocrate_autocannon_ap"
	ammo_count = 24
	ammo_type = /obj/item/projectile/bullet/crystal/shrapnel

///////////////////////////BULLETS///////////////////////////

/obj/item/projectile/bullet/crystal
	name ="crystal shard"
	icon_state= "Needler Shot"
	damage = 350
	damage_flags = DAM_BULLET | DAM_SHARP | DAM_EDGE
	armor_penetration = 100
	penetration_modifier = 1.1
	muzzle_type = null
	fire_sound = null
	distance_falloff = 0.1
	life_span = 250
	var/explosion_radius = 6
	var/explosion_max_power = EX_ACT_DEVASTATING

	var/exploded = FALSE

/obj/item/projectile/bullet/crystal/Bump(atom/A as mob|obj|turf|area, forced=0)
	if(!exploded)
		exploded = TRUE
		playsound(get_turf(src),pick(SOUNDS_CRYSTAL_METAL),150)
	..()

/obj/item/projectile/bullet/crystal/Destroy()
	if(src)
		playsound(get_turf(src),pick(SOUNDS_CRYSTAL_METAL))
	..()


/obj/item/projectile/bullet/crystal/high_explosive/Bump(atom/A as mob|obj|turf|area, forced=0)
	var/backwards = turn(dir, 180)
	if(!exploded)
		exploded = TRUE
		playsound(get_turf(src),pick(SOUNDS_CRYSTAL_METAL),150)
		explosion(get_step(get_turf(A), backwards), explosion_radius, explosion_max_power)
		qdel(src)


/obj/item/projectile/bullet/crystal/shrapnel
	armor_penetration = 50

/obj/item/projectile/bullet/crystal/shrapnel/Bump(atom/A as mob|obj|turf|area, forced=0)
	if(!exploded)
		exploded = TRUE
		playsound(get_turf(src),pick(SOUNDS_CRYSTAL_METAL),150)
		src.fragmentate(get_turf(src), rand(40,60), 7, list(/obj/item/projectile/bullet/pellet/fragment/crystal))
		qdel(src)
	..()

/obj/item/projectile/bullet/crystal/shrapnel/Destroy()
	if(src && !exploded)
		playsound(get_turf(src),pick(SOUNDS_CRYSTAL_METAL),150)
		src.fragmentate(get_turf(src), rand(40,60), 7, list(/obj/item/projectile/bullet/pellet/fragment/crystal))
	..()

/obj/item/projectile/bullet/pellet/fragment/crystal
	name = "crystal fragment"
	damage = 45
	icon_state= "needle"

/obj/item/projectile/bullet/pellet/fragment/crystal/Bump(atom/A as mob|obj|turf|area, forced=0)
	if(src)
		playsound(get_turf(src),pick(SOUNDS_CRYSTAL_METAL))
	..()