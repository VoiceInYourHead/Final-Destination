/obj/structure/ship_munition/ammobox/cell/disruptor
	name = "3000 MW fusion gun cell"
	desc = "3000 megawatts military grade powercell, often used in ship disruptors."
	icon_state = "ammocrate_disruptor"
	ammo_count = 3000
	ammo_type = null

/obj/item/projectile/bullet/disruptor
	name = "energy bolt"
	icon_state = "spark_green"
	temperature = T0C + 300
	damage = 20
	agony = 20
	damage_type = BURN
	damage_flags = 0
	muzzle_type = null
	fire_sound = null
	distance_falloff = 0.1
	life_span = 200
	var/heavy_effect_range = 2
	var/light_effect_range = 3

	on_impact(var/atom/A)
		empulse(A, heavy_effect_range, light_effect_range)
		return 1

/obj/effect/projectile/bullet/muzzle/ship_weapon/disruptor
	icon_state = "disruptor_muzzle"
