
/obj/item
	var/quota_worth = 0
	var/quota_type = 1 // 1 - junk; 2 - minerals

/obj/structure/fd/lethal_company
	name = "Old quota harvester"
	desc = "Hm, is it still working?"
	icon = 'icons/fd/structures/objects.dmi'
	icon_state = "trades0"
	anchored = TRUE
	density = TRUE

	var/activated = FALSE
	var/active = FALSE
	var/current_quota = 0
	var/needed = 0
	var/leaving = FALSE
//	var/junk = TRUE
//	var/minerals = FALSE
	var/timer = 1000

/obj/structure/fd/lethal_company/proc/run_timer()
	set waitfor = 0
	var/T = timer
	while(T > 0)
		sleep(1 SECOND)
		playsound(loc, 'sound/items/timer.ogg', 50)
		T--
	src.audible_message("<b>\The [src]</b> says, 'Quota was not reached in time, <span class='danger'>license termination in progress</span>'")
	sleep(3)
	cell_explosion(get_turf(src), 500, 30)
	qdel(src)

/obj/structure/fd/lethal_company/Initialize()
	START_PROCESSING(SSobj, src)
	return ..()

/obj/structure/fd/lethal_company/New()
	. = ..()
	needed = pick(50,80,100)

/obj/structure/fd/lethal_company/on_update_icon()
	if(active)
		icon_state = "trades1"
	if(!active)
		icon_state = "trades0"
	if(activated)
		icon_state = "trades_deploying"
	if(leaving)
		icon_state = "trades_collecting"

/obj/structure/fd/lethal_company/proc/leave_animation_cancel(mob/user)
	leaving = FALSE
	update_icon()
	active = FALSE
	update_icon()
	fly_away()

/obj/structure/fd/lethal_company/proc/activating(mob/user)
	activated = FALSE
	update_icon()

/obj/structure/fd/lethal_company/Process(mob/user)

	if(current_quota >= needed)
		leaving = TRUE
		update_icon()

		addtimer(CALLBACK(src, .proc/leave_animation_cancel, user), 5)

/obj/structure/fd/lethal_company/proc/fly_away()
	pixel_y = 5
	src.alpha = 200
	sleep(2)
	pixel_y = 8
	src.alpha = 150
	sleep(2)
	pixel_y = 12
	src.alpha = 100
	sleep(2)
	pixel_y = 15
	src.alpha = 50
	sleep(2)
	src.alpha = 0
	sleep(20)
	spawn_money(rand(5000,10000),src.loc)
	qdel(src)

/obj/structure/fd/lethal_company/attack_hand(mob/user)
	if(active)
		to_chat(user, "<span class='notice'>[src] already activated!</span>")
		return
	if(!active)
		activated = TRUE
		update_icon()

		addtimer(CALLBACK(src, .proc/activating, user), 15)
		active = TRUE
		run_timer()
		update_icon()

/obj/structure/fd/lethal_company/attackby(var/obj/item/I, var/mob/user)

	if(active)
		if(I.quota_worth <= 0 && I.quota_type == 1)
			src.audible_message("<b>\The [src]</b> says, 'This object are <span class='danger'>not worthy</span> for the company'")
		if(I.quota_worth > 0 && I.quota_type == 1)
			if(do_after(user, 10))
				var/obj/item/junk_rare = I
				current_quota += junk_rare.quota_worth
				qdel(junk_rare)
				src.audible_message("<b>\The [src]</b> says, 'Your share is valuable for the company'")
				sleep(10)
				src.audible_message("<b>\The [src]</b> says, 'Your current quota status is: <span class='danger'>[current_quota]/[needed]</span>'")
		else
			src.audible_message("<b>\The [src]</b> says, 'Company are <span class='danger'>not interested</span> in such things'")
			return

/*
	if(junk && active)
		if(istype(I, /obj/item/fd/ancient_items/))
			if(do_after(user, 10))
				var/obj/item/fd/ancient_items/junk_rare = I
				current_quota += junk_rare.quota_worth
				qdel(junk_rare)
				src.audible_message("<b>\The [src]</b> says, 'Your share is valuable for the company'")
				sleep(10)
				src.audible_message("<b>\The [src]</b> says, 'Your current quota status is: <span class='danger'>[current_quota]/[needed]</span>'")
		if(istype(I, /obj/item/clothing/glasses/psionic))
			if(do_after(user, 10))
				var/obj/item/clothing/glasses/psionic/junk_rare = I
				current_quota += junk_rare.quota_worth
				qdel(junk_rare)
				src.audible_message("<b>\The [src]</b> says, 'Your share is valuable for the company'")
				sleep(10)
				src.audible_message("<b>\The [src]</b> says, 'Your current quota status is: <span class='danger'>[current_quota]/[needed]</span>'")
		if(istype(I, /obj/item/cell/bluespace_ancient))
			if(do_after(user, 10))
				var/obj/item/cell/bluespace_ancient/junk_rare = I
				current_quota += junk_rare.quota_worth
				qdel(junk_rare)
				src.audible_message("<b>\The [src]</b> says, 'Your share is valuable for the company'")
				sleep(10)
				src.audible_message("<b>\The [src]</b> says, 'Your current quota status is: <span class='danger'>[current_quota]/[needed]</span>'")
		if(istype(I, /obj/item/trash))
			if(do_after(user, 10))
				var/obj/item/trash/just_junk = I
				current_quota += just_junk.quota_worth
				qdel(just_junk)
				src.audible_message("<b>\The [src]</b> says, 'Your share is valuable for the company'")
				sleep(10)
				src.audible_message("<b>\The [src]</b> says, 'Your current quota status is: <span class='danger'>[current_quota]/[needed]</span>'")
*/
/*
	if(minerals && active)
		if(istype(I, /obj/item/ore))
			if(do_after(user, 10))
				var/obj/item/ore/materials = I
				current_quota += materials.quota_worth
				qdel(materials)
				src.audible_message("<b>\The [src]</b> says, 'Your share is valuable for the company'")
				sleep(10)
				src.audible_message("<b>\The [src]</b> says, 'Your current quota status is: <span class='danger'>[current_quota]/[needed]</span>'")
		else
			to_chat(user, "<span class='notice'>[src] do not need this!</span>")
			return
*/

/obj/structure/fd/lethal_company/mining
	name = "mineral quota harvester"
//	junk = FALSE
//	minerals = TRUE

/obj/structure/fd/lethal_company/mining/attackby(var/obj/item/I, var/mob/user)

	if(active)
		if(I.quota_worth <= 0 && I.quota_type == 2)
			src.audible_message("<b>\The [src]</b> says, 'This object are <span class='danger'>not worthy</span> for the company'")
		if(I.quota_worth > 0 && I.quota_type == 2)
			if(do_after(user, 10))
				var/obj/item/mineral_rare = I
				current_quota += mineral_rare.quota_worth
				qdel(mineral_rare)
				src.audible_message("<b>\The [src]</b> says, 'Your share is valuable for the company'")
				sleep(10)
				src.audible_message("<b>\The [src]</b> says, 'Your current quota status is: <span class='danger'>[current_quota]/[needed]</span>'")
		else
			src.audible_message("<b>\The [src]</b> says, 'Company are <span class='danger'>not interested</span> in such things'")
			return

/obj/structure/fd/lethal_company/zone_trigger
	timer = 6000

/obj/structure/fd/lethal_company/zone_trigger/New()
	. = ..()
	needed = pick(100,200,250)

/obj/structure/fd/lethal_company/zone_trigger/Process(mob/user)

	if(!active && (locate(/mob/living/carbon/human) in orange(6, src)))
		activated = TRUE
		update_icon()

		addtimer(CALLBACK(src, .proc/activating, user), 5)
		active = TRUE
		run_timer()
		update_icon()

	. = ..()
