// Immovable rod LITE. Cleanly cleaves through a set amount of dense objects
/obj/structure/missile/breacher
	name = "HBM67 missile"
	overmap_name = "breacher missile"
	desc = "A breacher missile developed by Haephestus Industries. It is widely known and feared for eating through hulls like butter, often making it through multiple wall sections before coming to a halt."

	equipment = list(
		/obj/item/missile_equipment/thruster,
		/obj/item/missile_equipment/autoarm/breacher
	)

	// how many pieces of dense objects can this missile still punch through
	var/inertia = 8

// This doesn't have a detonation mechanism, it simply punches through hulls.
/obj/structure/missile/breacher/Bump(var/atom/obstacle)
	if(!active)
		return

	// cleaves through anything that isn't a shield while it still has inertia left
	if(inertia)
		if(istype(obstacle, /obj/effect/shield))
			inertia = 0
		else
			if(prob(25))
				obstacle.Destroy()
			inertia--

		if(!inertia)
			..()
			walk(src, 0)
			qdel(src)
//			log_and_message_admins("A breacher missile reached it's destignation (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[obstacle.x];Y=[obstacle.y];Z=[obstacle.z]'>JMP</a>)")

/obj/structure/missile/breacher/fall()
	if(active)
		return
	..()

/obj/structure/missile/breacher/he
	name = "HBM92 missile"
	equipment = list(
		/obj/item/missile_equipment/thruster,
		/obj/item/missile_equipment/autoarm/breacher,
		/obj/item/missile_equipment/payload/explosive
	)