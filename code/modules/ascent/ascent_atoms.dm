// Submap specific atom definitions.

MANTIDIFY(/obj/item/storage/bag/trash/purple,    "sample collection carrier", "material storage")
MANTIDIFY(/obj/structure/bed/chair/padded/purple,"mantid nest",               "resting place")
MANTIDIFY(/obj/item/pickaxe/diamonddrill,        "lithobliterator",           "drilling")
MANTIDIFY(/obj/item/tank/jetpack/carbondioxide,  "maneuvering pack",          "propulsion")

/obj/structure/bed/chair/padded/purple/ascent
	icon_state = "nest_chair"
	base_icon = "nest_chair"
	buckle_pixel_shift = "x=0;y=5;z=0"
	pixel_z = 0

/obj/structure/bed/chair/padded/purple/ascent/gyne
	name = "mantid throne"
	icon_state = "nest_chair_large"
	base_icon = "nest_chair_large"
	buckle_pixel_shift = "x=0;y=10;z=0"

/obj/structure/bed/chair/padded/purple/ascent/serpentid
	name = "serpentid resting pole"
	icon_state = "bar_stool_preview" //set for the map
	buckle_pixel_shift = "x=0;y=3;z=0"
	item_state = "bar_stool"
	base_icon = "bar_stool"
	color = "#a33fbf"

/obj/item/light/tube/ascent
	name = "mantid light filament"
	color = COLOR_CYAN
	b_colour = COLOR_CYAN
	desc = "Some kind of strange alien lightbulb technology."
	random_tone = FALSE
