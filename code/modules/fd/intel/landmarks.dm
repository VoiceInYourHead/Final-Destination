obj/random/intel_console //Large objects to block things off in maintenance
	name = "intel terminal"
	desc = "This is a terminal spawn."
	icon = 'icons/fd/overmap_eris.dmi'
	icon_state = "field"
	spawn_nothing_percentage = 50

obj/random/junkyard/obstruction/spawn_choices()
	return list(/obj/structure/fd/intel_console)

obj/random/relic //Large objects to block things off in maintenance
	name = "random relique"
	desc = "This is a random relique spawn."
	icon = 'icons/fd/overmap_eris.dmi'
	icon_state = "relic"
	spawn_nothing_percentage = 70

obj/random/junkyard/obstruction/spawn_choices()
	return list(/obj/item/fd/ancient_items/psionic,
				/obj/item/fd/ancient_items/zippo,
				/obj/item/fd/ancient_items/corrupted_radio,
				/obj/item/fd/ancient_items/energy_container,
				/obj/item/fd/ancient_items/teddy_bear,
				/obj/item/fd/ancient_items/gold_necklace,
				/obj/item/fd/ancient_items/jap_neko,
				/obj/item/fd/ancient_items/starmap,
				/obj/item/fd/ancient_items/phone,
				/obj/item/fd/ancient_items/skull,
				/obj/item/clothing/glasses/psionic)