//маркер света для планет и других мест, нуждающихся в освещении(потому что вызывать сет_лайт каждому турфу в зоне это пиздец как больно)

//это всё ещё костыль, но не такой конченный

//формула из кода света:
//set_light(l_max_bright, l_inner_range, l_outer_range, l_falloff_curve = NONSENSICAL_VALUE, l_color = NONSENSICAL_VALUE)

/obj/effect/landmark/light
	name = "light maker"
	var/light_brightness = 0
	var/light_inrange = 0
	var/light_outrange = 0
	var/colored = "#ffffff"

/obj/effect/landmark/light/New()
	set_light(light_brightness, light_inrange, light_outrange, l_color = colored)

/obj/effect/landmark/light/airfield
	light_brightness = 0.7
	light_inrange = 20
	light_outrange = 30
	colored = "#c3f1fa"

/obj/effect/landmark/light/snow_cage
	light_brightness = 0.5
	light_inrange = 20
	light_outrange = 30
	colored = "#618ac0"

/obj/effect/landmark/light/junk_planet
	light_brightness = 0.7
	light_inrange = 20
	light_outrange = 30
	colored = "#cc9440"

/obj/effect/landmark/light/junk_planet/water
	light_brightness = 0.5
	colored = "#6fb45c"

/obj/effect/landmark/light/undersea/lighthouse
	light_brightness = 0.4
	light_inrange = 15
	light_outrange = 20
	colored = "#f3f544"

/obj/effect/landmark/light/undersea/naturallight
	light_brightness = 0.5
	light_inrange = 5
	light_outrange = 10
	colored = "#1e4679"

//рандом спавнер для растительности(зимней)

/obj/random/flora/snow
	name = "random flora spawn"
	desc = "This is a random flora spawner."
	icon_state = "trees"
	spawn_nothing_percentage = 50

/obj/random/flora/snow/spawn_choices()
	return list(/obj/structure/flora/tree/pine,
				/obj/structure/flora/tree/dead,
				/obj/structure/flora/ausbushes/brflowers,
				/obj/structure/flora/ausbushes/pointybush,
				/obj/structure/flora/ausbushes/grassybush,
				/obj/structure/flora/ausbushes/ppflowers,
				/obj/structure/flora/grass/brown,
				/obj/structure/flora/grass/green,
				/obj/structure/flora/grass/both,
				/obj/structure/flora/bush)