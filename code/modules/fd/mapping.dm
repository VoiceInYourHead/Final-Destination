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