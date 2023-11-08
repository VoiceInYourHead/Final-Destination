

/obj/item/fd/ancient_items
	name = "ancient thing"
	desc = "some ancient stuff, idk"
	icon = 'icons/fd/items/oddities.dmi'
	icon_state = "blueprint"

/obj/item/fd/ancient_items/psionic
	name = "strange old folder"
	desc = "An old folder, which contains various research data about psionic powers. You also can see some mentions of 'NEMESIS' here. What could it mean?"
	icon_state = "folder-psi"
	quota_worth = 5

/obj/item/fd/ancient_items/zippo
	name = "broken syndicate zippo"
	desc = "Rusted zippo with three-headed 'S'-shaped snake on it. This one probably belongs to 'Syndicate', terrorist group, that existed in the time of corporate wars."
	icon_state = "syndicate_lighter"
	quota_worth = 5

/obj/item/fd/ancient_items/bs_shard
	name = "bluespace shard"
	desc = "The really rare, non-fluid state of bluespace."
	icon = 'icons/fd/structures/bluespace_crystal_structure.dmi'
	icon_state = "shard"
	origin_tech = list(TECH_BLUESPACE = 10)
	quota_worth = 20

/obj/item/fd/ancient_items/corrupted_radio
	name = "corrupted radio"
	desc = "Really old-looking radio, corrupted by some kind of blue, pulsing vines. God knows where it been."
	icon_state = "warped_radio"
	origin_tech = list(TECH_ESOTERIC = 10, TECH_BIO = 5, TECH_BLUESPACE = 5)
	quota_worth = 10

/obj/item/fd/ancient_items/corrupted_radio/attack_self(mob/living/carbon/user)
	var/option =  alert(user, "Do you really wanna touch it?", "Wait!", "Yes", "No")
	switch(option)
		if("Yes")
			if(do_after(user, 50)) //let's give 'em the last chance
				if(prob(30))
					user.flash_eyes()
					user.adjustBrainLoss(rand(20,30))
					to_chat(user, "<span class='danger'>Radio flashes, turning into!...What is this thing?</span>")
					new /obj/item/fd/ancient_items/bs_shard(src.loc)
					qdel(src)
				else
					user.alpha = 200
					sleep(5)
					user.alpha = 100
					sleep(5)
					user.alpha = 50
					sleep(5)
					user.alpha = 0
					var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
					s.set_up(3, 1, src)
					s.start()
					playsound(src,'sound/effects/teleport.ogg',60,1)
					user.flash_eyes()
					var/turf/T = locate(rand(1, world.maxx), rand(1, world.maxy), rand(1, world.maxz))
					if(T)
						user.forceMove(T)
						user.alpha = 0
						sleep(5)
						user.alpha = 50
						sleep(5)
						user.alpha = 100
						sleep(5)
						user.alpha = 200
						sleep(5)
						user.alpha = 255
						to_chat(user, "<span class='danger'>FUCK, FUCK, FUCK, MY HEAAAAA-</span>")
						user.adjustBrainLoss(rand(20,30))
		else
			return

/obj/item/cell/bluespace_ancient
	name = "unknown cell"
	desc = "Cell of unknown design, capable of self-recharging"
	icon = 'icons/fd/items/items.dmi'
	icon_state = "container_good"
	maxcharge = 2000
	w_class = ITEM_SIZE_NORMAL
	var/recharge_amount = 8
	quota_worth = 30
	origin_tech = list(TECH_MAGNET = 5, TECH_BIO = 5, TECH_POWER = 10)

/obj/item/cell/bluespace_ancient/Initialize()
	START_PROCESSING(SSobj, src)
	. = ..()

/obj/item/cell/bluespace_ancient/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/cell/bluespace_ancient/Process()
	if(charge < maxcharge)
		give(recharge_amount)

/obj/item/fd/ancient_items/energy_container
	name = "handmade container"
	desc = "Hm...what if i try to place something inside?"
	icon = 'icons/fd/items/items.dmi'
	icon_state = "container_emptyclosed"
	quota_worth = 5

	var/closed = TRUE

	origin_tech = list(TECH_MAGNET = 5, TECH_BIO = 5)

/obj/item/fd/ancient_items/energy_container/attackby(obj/item/I, mob/user, params)
	if(!closed)
		to_chat(user, "<span class='notice'>You trying to poke [I] inside, but nothing happens!</span>")
	if(closed && istype(I, /obj/item/screwdriver))
		if(do_after(user, 40))
			playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
			closed = FALSE
			icon_state = "container_empty"
	if(closed)
		to_chat(user, "<span class='notice'>You need to pry it open fist!</span>")
		return
	if(!closed && istype(I, /obj/item/fd/ancient_items/bs_shard))
		if(do_after(user, 40))
			to_chat(user, "<span class='notice'>You starting to carefully insert [I] inside! Looks like mechanism emerged to life!</span>")
			new /obj/item/cell/bluespace_ancient(src.loc)
			qdel(src)
			qdel(I)

/obj/item/fd/ancient_items/teddy_bear
	name = "old bear plushie"
	desc = "We can't sell it, but...still, it's something."
	icon_state = "teddy"
	quota_worth = 5

	var/ripped = FALSE
	var/known = FALSE

/obj/item/fd/ancient_items/teddy_bear/attack_self(mob/living/carbon/user)
	if(do_after(user, 50))
		if(known && !ripped)
			to_chat(user, "<span class='notice'>You noticed some fresh suture on the bear back!</span>")
		if(prob(50) && !ripped)
			to_chat(user, "<span class='notice'>You noticed some fresh suture on the bear back!</span>")
			known = TRUE
		if(ripped)
			to_chat(user, "<span class='notice'>There is nothing left inside for us.</span>")
		else
			to_chat(user, "<span class='notice'>It's just a teddy bear - what do you want?</span>")

/obj/item/fd/ancient_items/teddy_bear/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/material/knife) && !ripped)
		if(do_after(user, 80))
			if(prob(50))
				var/loot = pick(/obj/item/spacecash/bundle/c1000,/obj/item/storage/pill_bottle/three_eye,/obj/item/gun/projectile/revolver/holdout,/obj/item/seeds/ambrosiadeusseed,/obj/item/fd/data/weapons/lvl3/secret)
				new loot(src.loc)
				ripped = TRUE
			else
				to_chat(user, "<span class='notice'>Seems like there's nothing inside, sadly</span>")
				ripped = TRUE
	if(!ripped && known)
		to_chat(user, "<span class='notice'>You need something sharp to cut it!</span>")
	else
		return

/obj/item/fd/ancient_items/gold_necklace
	name = "old necklace"
	desc = "Old, golden necklace...it probably cost something."
	icon_state = "golden_necklace"
	quota_worth = 10

#define STAGE_WAIT		0
#define STAGE_MESSAGE	1
#define STAGE_SLEEP		2
#define STAGE_DAMAGE	3

/obj/item/fd/ancient_items/strange_photo
	name = "very strange photo"
	desc = "You got chills just from looking on that picture..."
	icon_state = "photo_eyes"
	quota_worth = 0
	var/global/list/mob/living/carbon/victims = list()
	var/global/list/mob/living/carbon/next_braindamage_stage = list()
	var/global/list/mob/living/carbon/braindamage_stage = list()
	var/global/list/mob/living/carbon/wake_up_timing = list()
	var/static/list/paranoia_messages = list("You feel as if something is watching you...", "It feels as if something is stalking you...")
	var/static/list/assault_messages = list("A horrifying monster attacks you, before running off!", "You are bolted awake by a horrifying entity attacking you!")
	var/static/list/spook_messages = list("You see a disturbing entity lingering in your peripheral vision.", "You swear you can see an abomination lurking...",
		"A strange entity stares at you, sending chills to your very core.")
	var/static/list/insomnia_messages = list("You feel so tired... but you can't sleep.", "You feel like... like.... sleep is.... can't.... sleep....")

/obj/item/fd/ancient_items/strange_photo/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/fd/ancient_items/strange_photo/Destroy()
	victims = null
	next_braindamage_stage = null
	braindamage_stage = null
	wake_up_timing = null
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/fd/ancient_items/strange_photo/attackby(obj/item/I, mob/user, params)
	if(isflamesource(I) || is_hot(I))
		if(do_after(user, 40))
			to_chat(user, "<span class='danger'>You burned this cursed photo up!</span>")
			qdel(src)

/obj/item/fd/ancient_items/strange_photo/proc/look(mob/living/user)
	for(var/mob/living/carbon/human/M)
		if(M.blinded)
			return
		to_chat(M, "<span class='notice'><i>You look at the red eyes on the photo, and feeling like your hand trembling.</i></span>")
		if(!(M in victims))
			victims += M
			braindamage_stage[M] = STAGE_WAIT
			next_braindamage_stage[M] = world.time + rand(300, 420)

/obj/item/fd/ancient_items/strange_photo/attack_self(mob/living/user)
	if(user in victims)
		to_chat(user, "<span class='notice'>I did it once, and I felt terrible. Why the hell would I that again?!</span>")
		return
	look(user)

/obj/item/fd/ancient_items/strange_photo/Process()
	for(var/mob/living/carbon/M in victims)
		if(prob(2.5))
			to_chat(M, "<span class='notice'><i>[pick(paranoia_messages)]</i></span>")
		var/next_scare = victims[M]
		if (M.sleeping >= 100 && !(M in wake_up_timing))
			wake_up_timing[M] = world.time + rand(100, 150)
		else if(wake_up_timing[M] && world.time >= wake_up_timing)
			to_chat(M, SPAN_DANGER("[pick(assault_messages)]"))
			M.sleeping = 0
			M.adjustBruteLoss(rand(1,7))
			display(get_step(get_turf(src), pick(GLOB.cardinal)), M, 17)
		else if (world.time >= next_scare)
			victims[M] = world.time + rand(100,1200)
			display(find_safe_spot(get_turf(M), M.client.view), M, 17)
			to_chat(M, "<span class='warning'><i>[pick(spook_messages)]</i></span>")
		else if (next_braindamage_stage[M] && world.time >= next_braindamage_stage[M])
			if(M in braindamage_stage) //idk why this is needed but it spams runtime despite everyone being in victims and braindamage_stage
				switch(braindamage_stage[M])
					if(STAGE_WAIT)
						braindamage_stage = STAGE_MESSAGE
					if(STAGE_MESSAGE)
						next_braindamage_stage[M] = world.time + rand(120, 300)
						braindamage_stage = STAGE_SLEEP
					if(STAGE_SLEEP)
						next_braindamage_stage[M] = world.time + rand(600, 720)
						braindamage_stage = STAGE_DAMAGE
		else
			if(M in braindamage_stage) //idk why this is needed but it spams runtime despite everyone being in victims and braindamage_stage
				switch(braindamage_stage[M])
					if(STAGE_MESSAGE)
						if(prob(3.5))
							to_chat(M, "<span class='warning'>[pick(insomnia_messages)]</span>")
					if(STAGE_SLEEP)
						if(prob(4))
							M.sleeping = 500

/obj/item/fd/ancient_items/strange_photo/proc/display(turf/spot, mob/living/target, length = 20, fade=TRUE)
	var/image/img = image('icons/fd/animals/lobotomy/64x64.dmi', spot, "apex_old")
	img.layer = ABOVE_OBJ_LAYER + 0.1
	target.client.images |= img
	spawn(length)
		target.client.images -= img
		qdel(img)

/obj/item/fd/ancient_items/strange_photo/proc/find_safe_spot(turf/spot, range=7, min_dist = 3)
	var/list/valid_turfs = list()
	for(var/turf/T in view(spot, range))
		if(istype(T, /turf/simulated/floor) && get_dist(spot, T) >= min_dist)
			valid_turfs += T
	return pick(valid_turfs)

#undef STAGE_DAMAGE
#undef STAGE_SLEEP
#undef STAGE_MESSAGE
#undef STAGE_WAIT

/obj/item/fd/ancient_items/jap_neko
	name = "Maneki Neko"
	desc = "An old souvenir, used to be very popular in the past. Today it's very rare and expensive, maintaining an relique status for many collectors."
	icon = 'icons/fd/items/faction_item.dmi'
	icon_state = "maneki_neko"
	quota_worth = 30

	var/luck_used = FALSE
	var/have_something = 40

/obj/item/fd/ancient_items/jap_neko/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/material/coin))
		if(do_after(user, 30))
			if(prob(have_something) && !luck_used)
				to_chat(user, "<span class='notice'>You tossed [I] to the moneybox and something fell from Maneki insides!</span>")
				luck_used = TRUE
				qdel(I)
				var/luck = pick(/obj/item/fd/ancient_items/strange_photo,/obj/item/fd/ancient_items/gold_necklace)
				new luck(src.loc)
			else
				to_chat(user, "<span class='notice'>You tossed [I] to the moneybox.</span>")
				qdel(I)

/obj/item/fd/ancient_items/starmap
	name = "strange watches"
	desc = "It's looking like something from pre-modern era of technologies."
	icon = 'icons/fd/items/oddities2.dmi'
	icon_state = "starscope"
	quota_worth = 30
	origin_tech = list(TECH_ESOTERIC = 8, TECH_BLUESPACE = 8)

/obj/item/fd/ancient_items/phone
	name = "old phone"
	desc = "Really old telephone."
	icon = 'icons/fd/items/oddities2.dmi'
	icon_state = "phone_off"
	quota_worth = 10
	origin_tech = list(TECH_ESOTERIC = 5)

/obj/item/fd/ancient_items/skull
	name = "cybernetic skull"
	desc = "Only gods know, to who it belongs"
	icon = 'icons/fd/items/surgery.dmi'
	icon_state = "metal_skull"
	quota_worth = 10
	origin_tech = list(TECH_ESOTERIC = 5, TECH_BIO = 8)

/obj/item/clothing/glasses/psionic
	name = "old-looking glasses"
	desc = "A set of corrective lenses in a cheap, old frame"
	icon_state = "shrooden"
	item_state = "binoclard_lenses"
	body_parts_covered = EMPTY_BITFIELD
	prescription = 7
	quota_worth = 30
	origin_tech = list(TECH_ESOTERIC = 10, TECH_BLUESPACE = 8)

	var/operating = FALSE
	var/list/boosted_faculties
	var/boosted_rank = PSI_RANK_GRANDMASTER
	var/unboosted_rank = PSI_RANK_OPERANT
	var/max_boosted_faculties = 3
	var/boosted_psipower = 120

/obj/item/clothing/glasses/psionic/Initialize()
	. = ..()
	verbs += /obj/item/clothing/glasses/psionic/proc/integrate

/obj/item/clothing/glasses/psionic/attack_self(var/mob/user)

	if(operating)
		return

	if(!canremove)
		deintegrate()
		return

	var/mob/living/carbon/human/H = loc
	if(istype(H) && H.glasses == src)
		integrate()
		return

	var/choice = input("Something reaches to you from this lenses...","Psionic Amplifier") as null|anything in SSpsi.faculties_by_name
	if(!choice)
		return

	var/removed
	var/slots_left = max_boosted_faculties - LAZYLEN(boosted_faculties)
	var/decl/psionic_faculty/faculty = SSpsi.get_faculty(choice)
	if(faculty.id in boosted_faculties)
		LAZYREMOVE(boosted_faculties, faculty.id)
		removed = TRUE
	else
		if(slots_left <= 0)
			to_chat(user, SPAN_WARNING("Seems like voices is silent...for now."))
			return
		LAZYADD(boosted_faculties, faculty.id)
	UNSETEMPTY(boosted_faculties)

	slots_left = max_boosted_faculties - LAZYLEN(boosted_faculties)
	to_chat(user, SPAN_NOTICE("You [removed ? "refused" : "accepted"] the offering of \the [src], [removed ? "extracting" : "keeping"] [choice] [removed ? "from" : "in"] your head."))

/obj/item/clothing/glasses/psionic/proc/deintegrate()

	set name = "Remove Psi"
	set desc = "Enhance your brainpower."
	set category = "Abilities"
	set src in usr

	if(operating)
		return

	if(canremove)
		return

	var/mob/living/carbon/human/H = loc
	if(!istype(H) || H.glasses != src)
		canremove = TRUE
		return

	to_chat(H, SPAN_WARNING("Million voices echoing in your head, while \the [src] reconstructing your brain itself..."))
	playsound(H, 'sound/effects/ghost2.ogg', 50, 1, -1)
	operating = TRUE

	sleep(80)

	if(H.psi)
		H.psi.reset()

	to_chat(H, SPAN_NOTICE("Voices stops, as \The [src] it finishes removing the slave-minds from your brain."))

	canremove = TRUE
	operating = FALSE

	verbs -= /obj/item/clothing/glasses/psionic/proc/deintegrate
	verbs |= /obj/item/clothing/glasses/psionic/proc/integrate

	action_button_name = "Accept Psi"
	H.update_action_buttons()

	set_light(0)

/obj/item/clothing/glasses/psionic/Move()
	var/lastloc = loc
	. = ..()
	if(.)
		var/mob/living/carbon/human/H = lastloc
		if(istype(H) && H.psi)
			H.psi.reset()
		H = loc
		if(!istype(H) || H.glasses != src)
			canremove = TRUE

/obj/item/clothing/glasses/psionic/proc/integrate()

	set name = "Accept Psi"
	set desc = "Enhance your brainpower."
	set category = "Abilities"
	set src in usr

	if(operating)
		return

	if(!canremove)
		return

	var/mob/living/carbon/human/H = loc
	if(!istype(H) || H.glasses != src)
		to_chat(usr, SPAN_WARNING("Something urges you to wear [src]..."))
		return

	canremove = FALSE
	operating = TRUE
	to_chat(H, SPAN_WARNING("You feel a series of sharp pinpricks as \the [src] goes deep into your mind..."))
	playsound(H, 'sound/effects/ghost2.ogg', 50, 1, -1)

	sleep(80)

	for(var/faculty in list(PSI_COERCION, PSI_CONSCIOUSNESS, PSI_CRYOKINESIS, PSI_ELECTRONICS, PSI_PSYCHOBALLISTICS, PSI_PSYCHOKINESIS, PSI_MANIFESTATION, PSI_REDACTION, PSI_ENERGISTICS, PSI_ARCHERY,))
		if(faculty in boosted_faculties)
			H.set_psi_rank(faculty, boosted_rank, take_larger = TRUE, temporary = TRUE)
		else
			H.set_psi_rank(faculty, unboosted_rank, take_larger = TRUE, temporary = TRUE)
	if(H.psi)
		H.psi.max_stamina = boosted_psipower
		H.psi.stamina = H.psi.max_stamina
		H.psi.update(force = TRUE)

	to_chat(H, SPAN_NOTICE("You experience a brief but powerful wave of deja vu as \the [src] finishes modifying your brain."))
	verbs |= /obj/item/clothing/glasses/psionic/proc/deintegrate
	verbs -= /obj/item/clothing/glasses/psionic/proc/integrate
	operating = FALSE
	action_button_name = "Remove Psi"
	H.update_action_buttons()

	set_light(0.5, 0.1, 3, 2, l_color = "#880000")

/obj/item/fd/ancient_items/emerald
	name = "green cell"
	desc = "Shiny green thing with dead-eye in center. Can we somehow revive it?"
	icon = 'icons/fd/items/artefacts.dmi'
	icon_state = "emerald"
	var/list/item_copied = list()
	var/last_used = 0 //last world.time it was used.
	var/chance_to_break = 50
	var/broken = FALSE
	quota_worth = 30
	origin_tech = list(TECH_ESOTERIC = 8, TECH_MATERIAL = 8, TECH_BLUESPACE = 8)

/obj/item/fd/ancient_items/emerald/Process()
	. = ..()
	update_icon()

/obj/item/fd/ancient_items/emerald/on_update_icon()
	if(chance_to_break >= 100)
		icon_state = "emerald_off"
	if(broken)
		icon_state = "emerald_broken"
	else
		icon_state = "emerald"
	return

/obj/item/fd/ancient_items/emerald/proc/delay(mob/user as mob)
	//capacitor recharges over time
	for(var/i=0, i<3, i++)
		if(last_used+600 > world.time)
			to_chat(user, "<span class='notice'>You can't use [src] again yet!</span>")
			return
		last_used += 600
	last_used = world.time

/obj/item/fd/ancient_items/emerald/verb/verb_wipe()
	set src in usr
	set category = "Object"
	set name = "Delete data"

	var/option = input(usr, "What do you want to remove?") as null | anything in item_copied
	if(!option)
		return
	else
		item_copied -= option

/obj/item/fd/ancient_items/emerald/afterattack(atom/A, mob/user as mob, proximity)
	if(broken)
		to_chat(user, "<span class='warning'>You can't use [src] anymore, it's broken!</span>")
		return
	if(istype(A, /obj/effect))
		to_chat(user, "<span class='warning'>You can't copy this!</span>")
		return
	if(istype(A, /obj/structure/closet))
		to_chat(user, "<span class='warning'>You can't copy this!</span>")
		return
	if(istype(A, /obj/item/storage))
		to_chat(user, "<span class='warning'>Why do you even need to copy the box? You wanna be a box knight?</span>")
		return
	if(istype(A, /mob/living/carbon))
		to_chat(user, "<span class='warning'>You can't copy this!</span>")
		return
	if(istype(A, /obj/item/fd/ancient_items) && do_after(user, 80))
		to_chat(user, "<span class='warning'>[src] falling apart in desperate attempt to copy [A]!</span>")
		qdel(src)
		return
	var/option =  alert(user, "Do you want to add [A] as a new design?", "Waiting", "Yes", "No")
	switch(option)
		if("Yes")
			if(do_after(user, 50))
				to_chat(user, "<span class='notice'>You added [A] blueprint as a new design to use!</span>")
				item_copied += A
		else
			return

/obj/item/fd/ancient_items/emerald/attackby(obj/item/I, mob/user, params)
	if(broken)
		to_chat(user, "<span class='warning'>You can't use [src] anymore, it's broken!</span>")
		return
	if(chance_to_break <= 0 && istype(I, /obj/item/fd/ancient_items/bs_shard))
		to_chat(user, "<span class='notice'>[src] is already fully charged!</span>")
		return
	if(istype(I, /obj/item/fd/ancient_items/bs_shard))
		if(do_after(user, 40))
			playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
			if(chance_to_break < 20)
				chance_to_break -= chance_to_break
				qdel(I)
			else
				chance_to_break -= 20
				qdel(I)

/obj/item/fd/ancient_items/emerald/attack_self(mob/living/carbon/user)

	if(broken)
		to_chat(user, "<span class='warning'>You can't use [src] anymore, it's broken!</span>")
		return

	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	var/atom/make_copy = input("What you want to make?", "Choose something") as null|anything in item_copied
	if(!make_copy)
		return
	if(chance_to_break == 100)
		to_chat(user, "<span class='warning'>[src] don't have enough energy to copy [make_copy]!</span>")
		return
	if(prob(chance_to_break) && do_after(user, 50))
		to_chat(user, "<span class='warning'>[src] falling apart in desperate try to recreate [make_copy]!</span>")
		broken = TRUE
		update_icon()
		return
	if(do_after(user, 50))
		delay()
		new make_copy.type(get_turf(src))
		chance_to_break += 5
		update_icon()

/obj/item/fd/ancient_items/corrupted_crowbar
	name = "glowing crowbar"
	desc = "I probably wouldn't try to hit something with this thing..."
	icon = 'icons/fd/items/artefacts.dmi'
	icon_state = "anocrowbar"
	force = 10
	quota_worth = 10
	origin_tech = list(TECH_BLUESPACE = 8)

/obj/item/fd/ancient_items/corrupted_crowbar/afterattack(atom/A as mob|obj|turf|area, mob/user as mob, proximity)
	..()

	var/mob/living/carbon/victim = A

	if(prob(5))
		to_chat(user, "<span class='warning'>You hitted [A] with [src], and it starts to disappear!</span>")
		A.alpha = 200
		sleep(1)
		A.alpha = 100
		sleep(1)
		A.alpha = 50
		sleep(1)
		A.alpha = 0
		sleep(1)
		if(istype(victim))
			to_chat(user, "<span class='danger'>You hear how [victim] screams right before dissapearing from this reality!</span>")
		qdel(A)

/obj/item/fd/ancient_items/bio_implant
	name = "weird tendril"
	desc = "Whatever knows what this thing for!"
	icon = 'icons/fd/items/device_eris.dmi'
	icon_state = "implant_uplink"
	origin_tech = list(TECH_ESOTERIC = 8, TECH_BIO = 12)

//копипаст из аугмент имплантера

	var/obj/item/organ/internal/augment/augment
	var/instant
	var/working

/obj/item/fd/ancient_items/bio_implant/Initialize()
	. = ..()
	if (ispath(augment))
		augment = new augment (src)

/obj/item/fd/ancient_items/bio_implant/attack_self(mob/living/carbon/human/user)
	if (working)
		return
	if (!istype(user))
		return
	if (!ishuman(user))
		to_chat(user, SPAN_WARNING("\The [src] don't seems to accept you."))
		return
	var/target_zone = user.zone_sel.selecting
	if (!target_zone)
		return
	var/obj/item/organ/external/parent = user.get_organ(target_zone)
	if (!parent)
		to_chat(user, SPAN_WARNING("You don't have \a [target_zone]!"))
		return
	var/flavor = (parent.status & ORGAN_ROBOTIC) ? 1 : (parent.status & ORGAN_CRYSTAL) ? 2 : 0
	if (flavor == 0 && !(augment.augment_flags & AUGMENT_BIOLOGICAL))
		to_chat(user, SPAN_WARNING("\The [augment] cannot be installed in biological organs."))
		return
	if (flavor == 1 && !(augment.augment_flags & AUGMENT_MECHANICAL))
		to_chat(user, SPAN_WARNING("\The [augment] cannot be installed in mechanical organs."))
		return
	if (flavor == 2 && !(augment.augment_flags & AUGMENT_CRYSTALINE))
		to_chat(user, SPAN_WARNING("\The [augment] cannot be installed in crystaline organs."))
		return
	var/surgery_step = decls_repository.get_decl(/decl/surgery_step/internal/replace_organ)
	if (augment.surgery_configure(user, user, parent, src, surgery_step))
		return
	var/occupied = user.internal_organs_by_name[augment.organ_tag]
	if (occupied)
		to_chat(user, SPAN_WARNING("You already have \an [occupied] installed there."))
		return
	if (flavor != -1)
		var/old_loc = loc
		var/proceed = alert(user, "This is probably going to hurt. Are you prepared?", "Woah there!", "I am!", "Wait...")
		if (proceed != "I am!")
			return
		if (loc != old_loc)
			return
	var/success = instant
	if (!instant)
		working = TRUE
		to_chat(user, SPAN_WARNING("\icon[src] will now enter your body. " + SPAN_DANGER("Please remain calm.")))
		user.visible_message(SPAN_WARNING("\The [user] places \his [parent.name] against \the [src]."))
		if (!do_after(user, 2 SECONDS, src))
			goto FailedAugmentImplant
		user.visible_message(SPAN_DANGER("\The [src] starts to move, piercing your skin!"))
		if (flavor != 1)
			user.custom_pain("Your [parent.name] feels like it's being pierced by thousands knives!", 160)
		else
			to_chat(user, SPAN_ITALIC("The access panel on your [parent.name] is torn open."))
			playsound(user, 'sound/items/electronic_assembly_emptying.ogg', 50, TRUE)
		parent.createwound(CUT, parent.min_broken_damage / 2, 1)
		parent.clamp_organ()
		parent.open_incision()
		parent.fracture()
		if (!do_after(user, 8 SECONDS, src))
			goto FailedAugmentImplant
		user.visible_message(SPAN_DANGER("\The [src] almost fully entered [user]'s [parent.name]!"))
		if (flavor != 1)
			user.custom_pain("You feel something rooting around violently inside your [parent.name]!", 160)
		else
			to_chat(user, SPAN_ITALIC("Your [parent.name] shifts and twitches as \the [src] works."))
		if (!flavor)
			playsound(user, 'sound/effects/squelch1.ogg', 25, TRUE)
		else
			playsound(user, 'sound/items/jaws_pry.ogg', 50, TRUE)
		if (!do_after(user, 8 SECONDS, src))
			goto FailedAugmentImplant
		if (!do_after(user, 2 SECONDS, src))
			goto FailedAugmentImplant
		parent.status &= ~ORGAN_BROKEN
		parent.stage = 0
		parent.update_wounds()
		var/datum/wound/wound = parent.get_incision()
		if (istype(wound))
			wound.close()
		if (parent.clamped())
			parent.remove_clamps()
		parent.update_wounds()
		success = TRUE
	FailedAugmentImplant:
	working = FALSE
	if (!success)
		user.visible_message(SPAN_DANGER("\The [src] falls away from \the [user], leaving \his [parent.name] a mangled mess!"))
		parent.take_general_damage(25)
		augment = null
		return
	to_chat(user, SPAN_WARNING("\icon[src] Procedure complete. ") + SPAN_NOTICE("Have a nice day."))
	playsound(user, 'sound/machines/ping.ogg', 50, FALSE)
	augment.forceMove(user)
	augment.replaced(user, parent)
	augment = null
	qdel(src)

/obj/item/fd/ancient_items/bio_implant/health
	icon_state = "implant_health"
	augment = /obj/item/organ/internal/augment/armor/bionic

/obj/item/fd/ancient_items/bio_implant/reflexes
	icon_state = "implant_freedom"
	augment = /obj/item/organ/internal/augment/boost/reflex/bionic

/obj/item/fd/ancient_items/bio_implant/accuracy
	icon_state = "implant_excel"
	augment = /obj/item/organ/internal/augment/boost/shooting/bionic