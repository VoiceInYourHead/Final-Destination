/obj/item/device/fd/searcher
	name = "Intel searching device"
	desc = "A device that used to scan location for valuable intel or other odd things"
	icon = 'icons/fd/marines/experimental_tools.dmi'
	icon_state = "crew_monitor"
	item_state = "analyzer"
	throwforce = 5
	w_class = ITEM_SIZE_SMALL
	throw_speed = 4
	throw_range = 10
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	origin_tech = list(TECH_MAGNET = 4, TECH_ENGINEERING = 5)

	var/list/scanning = list(/obj/structure/abandoned_cryo, /obj/structure/fd/intel_console)
	var/last_used = 0 //last world.time it was used.

/obj/item/device/fd/searcher/proc/searcher_recharge(mob/user as mob)
	//capacitor recharges over time
	for(var/i=0, i<3, i++)
		if(last_used+600 > world.time)
			to_chat(user, "<span class='notice'>Девайс ещё перезаряжается!</span>")
			return
		last_used += 600
	last_used = world.time

/obj/item/device/fd/searcher/afterattack(atom/A, mob/user as mob, proximity)
	var/option =  alert(user, "Вы хотите добавить [A] в доступные варианты поиска?", "Сканирование", "Да", "Нет")
	switch(option)
		if("Да")
			to_chat(user, "<span class='notice'>Успешно добавлено!</span>")
			scanning += A
		else
			return

/obj/item/device/fd/searcher/verb/verb_wipe()
	set src in usr
	set category = "Object"
	set name = "Delete data"

	var/option = input(usr, "Что вы хотите удалить?") as null | anything in scanning
	if(!option)
		return
	else
		scanning -= option

/obj/item/device/fd/searcher/attack_self(mob/living/carbon/user)

	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	playsound(src.loc, 'sound/weapons/flash.ogg', 100, 1)

	var/searching_object = input("Что вы хотите найти?", "Поиск...") as null|anything in scanning
	if(!searching_object)
		return
	else
		var/atom/located_item_in_range = locate(searching_object) in orange(30)
		if(located_item_in_range)
			searcher_recharge()
			to_chat(user, "<span class='notice'>Ближайшее местоположение [located_item_in_range] находится по координатам: [located_item_in_range.x], [located_item_in_range.y]</span>")
		else
			searcher_recharge()
			to_chat(user, "<span class='notice'>Похоже, что в текущем радиусе не было найдено никаких совпадений с [located_item_in_range]!</span>")
