/particles/snow
	icon = 'icons/fd/mojave_particles/particle.dmi'
	icon_state = list("cross"=2, "snow_1"=5, "snow_2"=2, "snow_3"=2,)

	transform = list( 1, 0, 0,  0  ,
								   0, 1, 0,  0  ,
								   0, 0, 1, 1/10,
								   0, 0, 0,  1)
	width = 500
	height = 500
	count = 3000
	spawning = 12
	bound1 = list(-500,-256,-10)
	bound2 = list(500,500,10)
	lifespan = 600
	fade = 30
	color = "#ffffff"
	position = generator("box", list(-500,-256,5), list(500,500,0))
	spin = generator("num",-10,10)
	gravity = list(0, -2, 0.1)
	drift = generator("circle", 0, 3) // Some random movement for variation
	friction = 0.3  // shed 30% of velocity and drift every 0.1s

/particles/snowstorm
	icon = 'icons/fd/mojave_particles/particle.dmi'
	icon_state = list("cross"=2, "snow_1"=5, "snow_2"=2, "snow_3"=2,)

	transform = list( 1, 0, 0,  0  ,
								   0, 1, 0,  0  ,
								   0, 0, 1, 1/10,
								   0, 0, 0,  1)
	width = 500
	height = 500
	count = 4000
	spawning = 20
	bound1 = list(-500,-256,-10)
	bound2 = list(500,500,10)
	lifespan = 600
	fade = 30
	color = "#ffffff"
	position = generator("box", list(-500,-256,5), list(500,500,0))
	spin = generator("num",-10,10)
	gravity = list(0, -2, 0.1)
	drift = generator("circle", 0, 3.5)
	friction = 0.3

/particles/rain
	icon = 'icons/fd/mojave_particles/particle.dmi'
	icon_state = "drop"
	color = "#ccffff"
	transform = list( 1, 0, 0,  0  ,
								   0, 1, 0,  0  ,
								   0, 0, 1, 1/10,
								   0, 0, 0,  1)
	width = 500
	height = 500
	count = 3000
	spawning = 12
	bound1 = list(-500,-256,-10)
	bound2 = list(500,500,10)
	lifespan = 600
	fade = 30
	position = generator("box", list(-500,-256,0), list(400,500,0))
	grow = list(-0.01,-0.01)
	gravity = list(0, -10, 0.5)
	drift = generator("circle", 0, 1)
	friction = 0.3
	transform = null

/particles/dust
	icon = 'icons/fd/mojave_particles/particle.dmi'
	icon_state             = list("dot"=5, "cross"=1)
	transform = list( 1, 0, 0,  0  ,
								   0, 1, 0,  0  ,
								   0, 0, 1, 1/10,
								   0, 0, 0,  1)
	width = 500
	height = 500
	count = 3000
	spawning = 12
	bound1 = list(-500,-256,-10)
	bound2 = list(500,500,10)
	lifespan = 600
	fade = 30
	gradient = list(0,"#422a1de3",10,"#853e1be3","loop")
	color = 0
	color_change = generator("num",0,3)
	spin = generator("num",-5,5)
	position = generator("box", list(-500,-256,0), list(500,500,0))
	gravity = list(-5 -1, 0.1)
	drift = generator("circle", 0, 3) // Some random movement for variation
	friction = 0.3  // shed 30% of velocity and drift every 0.1s

/obj/screenfilter/snow
	mouse_opacity = 0
	screen_loc = "CENTER"
	particles = new/particles/snow

/obj/screenfilter/snow/Fade()
	animate(src, alpha=0, time=10) //let's pretend there is no better way to do this shit
	..()

/obj/screenfilter/proc/Fade() //cool fading effect
	qdel(src)