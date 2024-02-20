#include "school_radio.dm"
#include "school_mobs.dm"

//ASSETS

/obj/structure/fd/school/prop1
	name = "Old shotgun"
	desc = "The mass-produced W-T Remmington 29x shotgun is a favourite of police and security forces in the past. Now - it's only a relic."
	icon = 'icons/obj/guns/shotguns.dmi'
	icon_state = "shotgun"
	anchored = TRUE

/obj/structure/fd/school/prop2
	name = "UFO sign"
	desc = "Just an neon sign of an old UFO vision."
	icon = 'icons/fd/structures/manhattan/signs/signs.dmi'
	icon_state = "ufo"
	anchored = TRUE

/obj/structure/fd/school/prop3
	name = "City sign"
	desc = "Just an neon sign of an night city."
	icon = 'icons/fd/structures/manhattan/signs/signs_large.dmi'
	icon_state = "city_of_night"
	anchored = TRUE

/obj/structure/fd/school/prop4
	name = "Ancient fresco"
	desc = "Very old piece of art, probably from Earth."
	icon = 'icons/fd/structures/manhattan/mnhtn_paintings.dmi'
	icon_state = "1,15"
	anchored = TRUE

/obj/structure/fd/school/prop5
	name = "figure"
	desc = "Just an neon figure"
	icon = 'icons/fd/structures/manhattan/signs/signs.dmi'
	icon_state = "square"
	anchored = TRUE

/obj/structure/fd/school/prop6
	name = "symbol"
	desc = "Strange looking symbol"
	icon = 'icons/fd/fabric_symbols.dmi'
	icon_state = "9"
	anchored = TRUE

/obj/effect/overmap/visitable/sector/camp
	name = "jungle planet"
	desc = "A jungle planet with high amount of hostile xenofauna and environment."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	color = "#6db8b8"
	initial_generic_waypoints = list(
		"nav_camp_1",
		"nav_camp_2",
		"nav_camp_antag"
	)

/obj/effect/submap_landmark/joinable_submap/camp
	name = "Psionics Camp"
	archetype = /decl/submap_archetype/camp

/decl/submap_archetype/camp
	descriptor = "Secret SCG camp on unknown planet"
	map = "Psionics Camp"
	crew_jobs = list(
		/datum/job/submap/camp/ardent,
		/datum/job/submap/camp/saturio,
		/datum/job/submap/camp/maxim,
		/datum/job/submap/camp/okita,
		/datum/job/submap/camp/numerius,
		/datum/job/submap/camp/julian,

		/datum/job/submap/camp/shtorn,
		/datum/job/submap/camp/sara,
		/datum/job/submap/camp/vivian,
		/datum/job/submap/camp/mara,

		/datum/job/submap/camp/psionic2,
		/datum/job/submap/camp/teacher1,
		/datum/job/submap/camp/teacher2,
		/datum/job/submap/camp/teacher3,
		/datum/job/submap/camp/teacher4,
		/datum/job/submap/camp/cook,
		/datum/job/submap/camp/doctor
	)

/decl/hierarchy/outfit/job/psionic
	backpack_overrides = null
	hierarchy_type = /decl/hierarchy/outfit/job/psionic
	uniform = /obj/item/clothing/under/syndicate/tacticool
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = null
	pda_type = null
	back = null
	flags = OUTFIT_RESET_EQUIPMENT

/decl/hierarchy/outfit/job/psionic/student
	uniform = /obj/item/clothing/under/syndicate/tacticool
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = null
	pda_type = null
	back = /obj/item/storage/backpack/satchel/pocketbook/brown
	l_ear = null
	r_pocket = /obj/item/pen
	l_pocket = /obj/item/storage/wallet/random

/decl/hierarchy/outfit/job/psionic/staff
	id_types = null
	pda_type = null
	uniform = /obj/item/clothing/under/lawyer/black
	shoes = /obj/item/clothing/shoes/dress
	glasses = /obj/item/clothing/glasses/prescription
	r_pocket = /obj/item/device/radio/map_preset/psy_school
	l_pocket = /obj/item/storage/wallet/random
	l_ear = /obj/item/device/radio/headset/map_preset/psy_school
	back = /obj/item/storage/backpack/satchel/pocketbook/brown

///BOYS///

/datum/job/submap/camp/ardent
	title = "Ardent Mire"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/ardent
	name = "Ardent Mire"

/datum/job/submap/camp/saturio
	title = "Saturio Amantes"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/saturio
	name = "Saturio Amantes"

/datum/job/submap/camp/maxim
	title = "Maxim Kuznetsov"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/maxim
	name = "Maxim Kuznetsov"

/datum/job/submap/camp/okita
	title = "Okita Takeda"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/okita
	name = "Okita Takeda"

/datum/job/submap/camp/numerius
	title = "Numerius De Vigo"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/numerius
	name = "Numerius De Vigo"

/datum/job/submap/camp/julian
	title = "Julian Morawski"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/julian
	name = "Julian Morawski"

///GIRLS///

/datum/job/submap/camp/shtorn
	title = "Shtorn Avasarala"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/shtorn
	name = "Shtorn Avasarala"

/datum/job/submap/camp/sara
	title = "Sara Mayer"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/sara
	name = "Sara Mayer"

/datum/job/submap/camp/vivian
	title = "Vivian Rockwell"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/vivian
	name = "Vivian Rockwell"

/datum/job/submap/camp/mara
	title = "Mara Sumitomo"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/mara
	name = "Mara Sumitomo"

///END///

/datum/job/submap/camp/psionic2
	title = "New Student"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	loadout_allowed = TRUE
	skill_points = 25

/obj/effect/submap_landmark/spawnpoint/camp/psionic2
	name = "New Student"

/datum/job/submap/camp/teacher1
	title = "Psionic teacher 1"
	info = "You here to teach some dumbasses how to beat bad guys and not die in progress"
	supervisors = "your fantasy and Void google doc."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff
	total_positions = 1
	loadout_allowed = TRUE
	skill_points = 30

/obj/effect/submap_landmark/spawnpoint/camp/teacher1
	name = "Psionic teacher 1"

/datum/job/submap/camp/teacher2
	title = "Psionic teacher 2"
	info = "You here to teach some dumbasses how to beat bad guys and not die in progress"
	supervisors = "your fantasy and Void google doc."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff
	total_positions = 1
	loadout_allowed = TRUE
	skill_points = 30

/obj/effect/submap_landmark/spawnpoint/camp/teacher2
	name = "Psionic teacher 2"

/datum/job/submap/camp/teacher3
	title = "Psionic teacher 3"
	info = "You here to teach some dumbasses how to beat bad guys and not die in progress"
	supervisors = "your fantasy and Void google doc."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff
	total_positions = 1
	loadout_allowed = TRUE
	skill_points = 30

/obj/effect/submap_landmark/spawnpoint/camp/teacher3
	name = "Psionic teacher 3"

/datum/job/submap/camp/teacher4
	title = "Psionic teacher 4"
	info = "You here to teach some dumbasses how to beat bad guys and not die in progress"
	supervisors = "your fantasy and Void google doc."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff
	total_positions = 1
	loadout_allowed = TRUE
	skill_points = 30

/obj/effect/submap_landmark/spawnpoint/camp/teacher4
	name = "Psionic teacher 4"

/datum/job/submap/camp/doctor
	title = "Doctor"
	info = "You here to heal people, your'e the greatest biomant in this whole place."
	supervisors = "the Hippocratic oath."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff
	total_positions = 1
	loadout_allowed = TRUE
	skill_points = 30

/obj/effect/submap_landmark/spawnpoint/camp/doctor
	name = "Doctor"

/datum/job/submap/camp/cook
	title = "Cook"
	info = "You here to cook food for people, what else do you expecting?"
	supervisors = "your imagination."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff
	total_positions = 1
	loadout_allowed = TRUE
	skill_points = 20

/obj/effect/submap_landmark/spawnpoint/camp/cook
	name = "Cook"

/datum/map_template/ruin/away_site/camp
	name = "Jungle Planet"
	id = "awaysite_camp"
	spawn_cost = 1000 //NO BITCHES??
	player_cost = 4
	description = "PSY School with students and teachers. For events only."
	suffixes = list("psycho/school_remake-1.dmm", "psycho/school_remake-2.dmm")
	area_usage_test_exempted_root_areas = list(/area/psionic_school)
	apc_test_exempt_areas = list(
		/area/psionic_school = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/psionic_school/outdoor = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/psionic_school/indoor = NO_SCRUBBER|NO_VENT|NO_APC
	)

/obj/effect/shuttle_landmark/nav_camp/nav1
	name = "Planet Landing Point #1"
	landmark_tag = "nav_camp_1"
	base_area = /area/psionic_school/outdoor

/obj/effect/shuttle_landmark/nav_camp/nav2
	name = "Planet Landing Point #2"
	landmark_tag = "nav_camp_2"
	base_area = /area/psionic_school/outdoor

/obj/effect/shuttle_landmark/nav_camp/nav3
	name = "Planet Navpoint #3"
	landmark_tag = "nav_camp_antag"
	base_area = /area/psionic_school/outdoor

/area/psionic_school
	name = "\improper Camp"
	icon_state = "unknown"
	requires_power = 0
	dynamic_lighting = 1
	base_turf = /turf/unsimulated/floor/exoplanet/barren

/area/psionic_school/outdoor
	name = "\improper Streets"
	icon_state = "dark"
	requires_power = 0
	dynamic_lighting = 1
	sound_env = LARGE_ENCLOSED

/area/psionic_school/indoor
	name = "\improper Indoor"
	icon_state = "red"
	requires_power = 0
	dynamic_lighting = 1

//MAIN BUILDING

/area/psionic_school/indoor/main
	name = "\improper Main Building"

/area/psionic_school/indoor/main/firingrange
	name = "\improper Firing Range"

/area/psionic_school/indoor/main/gym
	name = "\improper Gym"

/area/psionic_school/indoor/main/arena1
	name = "\improper Training Arena 1"

/area/psionic_school/indoor/main/arena2
	name = "\improper Training Arena 2"

/area/psionic_school/indoor/main/arena3
	name = "\improper Training Arena 3"

/area/psionic_school/indoor/main/class1
	name = "\improper Classroom 1"

/area/psionic_school/indoor/main/class2
	name = "\improper Classroom 2"

//OTHER

/area/psionic_school/indoor/train
	name = "\improper Train Station"

/area/psionic_school/indoor/tcomms
	name = "\improper Telecommunications"

/area/psionic_school/indoor/sec
	name = "\improper Security Checkpoint"

/area/psionic_school/indoor/green
	name = "\improper Greenhouse"

//CAMPUS

/area/psionic_school/indoor/campus
	name = "\improper Campus"

/area/psionic_school/indoor/campus/storage
	name = "\improper Storage"

/area/psionic_school/indoor/campus/toilet1
	name = "\improper Restroom 1"

/area/psionic_school/indoor/campus/toilet2
	name = "\improper Restroom 2"

/area/psionic_school/indoor/campus/studentsbath1
	name = "\improper Bath 1"

/area/psionic_school/indoor/campus/studentsbath2
	name = "\improper Bath 2"

/area/psionic_school/indoor/campus/girls
	name = "\improper Girls Block"

/area/psionic_school/indoor/campus/girls/r1
	name = "\improper Girls Block(Room 1)"

/area/psionic_school/indoor/campus/girls/r2
	name = "\improper Girls Block(Room 2)"

/area/psionic_school/indoor/campus/girls/r3
	name = "\improper Girls Block(Room 3)"

/area/psionic_school/indoor/campus/girls/r4
	name = "\improper Girls Block(Room 4)"

/area/psionic_school/indoor/campus/male
	name = "\improper Male Block"

/area/psionic_school/indoor/campus/male/r1
	name = "\improper Male Block(Room 1)"

/area/psionic_school/indoor/campus/male/r2
	name = "\improper Male Block(Room 2)"

/area/psionic_school/indoor/campus/male/r3
	name = "\improper Male Block(Room 3)"

/area/psionic_school/indoor/campus/male/r4
	name = "\improper Male Block(Room 4)"

/area/psionic_school/indoor/campus/teacherroom1
	name = "\improper Teacher Room 1"

/area/psionic_school/indoor/campus/teacherroom1/toilet

/area/psionic_school/indoor/campus/teacherroom2
	name = "\improper Teacher Room 2"

/area/psionic_school/indoor/campus/teacherroom2/toilet

/area/psionic_school/indoor/campus/teacherroom3
	name = "\improper Teacher Room 3"

/area/psionic_school/indoor/campus/teacherroom3/toilet

/area/psionic_school/indoor/campus/teacherroom4
	name = "\improper Teacher Room 4"

/area/psionic_school/indoor/campus/teacherroom4/toilet

/area/psionic_school/indoor/campus/library
	name = "\improper Library"

/area/psionic_school/indoor/campus/stud_hall
	name = "\improper Campus Hallway(Floor 1)"

/area/psionic_school/indoor/campus/teacher_hall
	name = "\improper Campus Hallway(Floor 2)"

//CAFETERIA

/area/psionic_school/indoor/kitchen
	name = "\improper Kitchen"

/area/psionic_school/indoor/kitchen/canteen
	name = "\improper Canteen"

/area/psionic_school/indoor/kitchen/freezer
	name = "\improper Kitchen Freezer"

/area/psionic_school/indoor/bar
	name = "\improper Bar"

/area/psionic_school/indoor/bar/lounge
	name = "\improper Bar Lounge"

//HOSPITAL

/area/psionic_school/indoor/medbay
	name = "\improper Hospital"

/area/psionic_school/indoor/medbay/breakroom
	name = "\improper Hospital Breakroom"

/area/psionic_school/indoor/medbay/ward1
	name = "\improper Hospital Ward 1"

/area/psionic_school/indoor/medbay/ward2
	name = "\improper Hospital Ward 2"

/area/psionic_school/indoor/medbay/storage
	name = "\improper Hospital Storage"

/area/psionic_school/indoor/medbay/office
	name = "\improper Doctor's Office"

// ACCESS
/var/const/access_camp_teacher1 = "ACCESS_CAMP_TEACHER1"

/datum/access/access_camp_teacher1
	id = access_camp_teacher1
	desc = "Teacher 1"
	region = ACCESS_REGION_NONE

/var/const/access_camp_teacher2 = "ACCESS_CAMP_TEACHER2"

/datum/access/access_camp_teacher2
	id = access_camp_teacher2
	desc = "Teacher 2"
	region = ACCESS_REGION_NONE

/var/const/access_camp_teacher3 = "ACCESS_CAMP_TEACHER3"

/datum/access/access_camp_teacher3
	id = access_camp_teacher3
	desc = "Teacher 3"
	region = ACCESS_REGION_NONE

/var/const/access_camp_teacher4 = "ACCESS_CAMP_TEACHER4"

/datum/access/access_camp_teacher4
	id = access_camp_teacher4
	desc = "Teacher 4"
	region = ACCESS_REGION_NONE

/var/const/access_camp_teacher5 = "ACCESS_CAMP_TEACHER5"

/datum/access/access_camp_teacher5
	id = access_camp_teacher5
	desc = "Teacher 5"
	region = ACCESS_REGION_NONE

/var/const/access_camp_med = "ACCESS_CAMP_MED"

/datum/access/access_camp_med
	id = access_camp_med
	desc = "Teacher"
	region = ACCESS_REGION_NONE
