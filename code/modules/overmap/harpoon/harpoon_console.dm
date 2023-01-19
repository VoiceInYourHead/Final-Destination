/obj/machinery/computer/ship/autocannon/harpoon
	name = "harpoon cannon control"
	caldigit = 6 //number of digits that needs calibration
	coolinterval = 60 SECONDS //time to wait between safe shots in deciseconds
	console_html_name = "autocannon.tmpl"

	obj/machinery/autocannon/harpoon/front
	obj/machinery/autocannon/harpoon/middle
	obj/machinery/autocannon/harpoon/back
	obj/structure/ship_munition/ammobox/harpoon/ammobox

	danger_zone = 0
	burst_size = 1
	gun_name = "harpoon cannon"
	fire_sound = 'sound/machines/autocannon_fire.ogg'
	overmap_icon = "n_beam" // icons\effects\beam.dmi

/obj/machinery/computer/ship/autocannon/harpoon/OnTopic(mob/user, list/href_list, state)
	. = ..()
	if(.)
		return

	if(!linked)
		return TOPIC_HANDLED

	if (href_list["choose"])
		overmapdir = sanitize_integer(text2num(href_list["choose"]), 0, 9, 0)
		reset_calibration()

	if(href_list["calibration"])
		var/input = input("0-9", "[gun_name] calibration", 0) as num|null
		if(!isnull(input)) //can be zero so we explicitly check for null
			var/calnum = sanitize_integer(text2num(href_list["calibration"]), 0, caldigit)//sanitiiiiize
			calibration[calnum + 1] = sanitize_integer(input, 0, 9, 0)//must add 1 because nanoui indexes from 0

	if(href_list["skill_calibration"])
		for(var/i = 1 to min(caldigit, user.get_skill_value(core_skill) - skill_offset))
			calibration[i] = calexpected[i]

	if(href_list["fire"])
		var/atomcharge_ammo = get_ammo()
		if(atomcharge_ammo <= 0)
			return TOPIC_REFRESH
		if(prob(cool_failchance())) //Some moron disregarded the cooldown warning. Let's blow in their face.
			explosion(middle,1,rand(1,2),rand(2,3))
			next_shot = coolinterval + world.time
			return TOPIC_REFRESH
		next_shot = coolinterval + world.time + burst_interval * burst_size
		log_and_message_admins("attempted to fire the [gun_name].")
		for(var/i = 1 to burst_size)
			if(get_charge() == 0)
				break
			fire(user)
			remove_ammo()
			sleep(burst_interval)
		reset_calibration()
	return TOPIC_REFRESH