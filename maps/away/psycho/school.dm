#include "school_radio.dm"
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
		/datum/job/submap/camp/psionic,
		/datum/job/submap/camp/teacher,
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
	back = null
	l_ear = null
	r_pocket = /obj/item/pen

/decl/hierarchy/outfit/job/psionic/staff
	id_types = null
	pda_type = null
	uniform = /obj/item/clothing/under/lawyer/black
	shoes = /obj/item/clothing/shoes/dress
	glasses = /obj/item/clothing/glasses/prescription
	r_pocket = /obj/item/device/radio/map_preset/psy_school
	l_pocket = /obj/item/device/flashlight/maglight
	l_ear = /obj/item/device/radio/headset/map_preset/psy_school
	back = /obj/item/storage/backpack/satchel/pocketbook/brown

/datum/job/submap/camp/psionic
	title = "Psionic student"
	info = "You here to learn how to beat the bad guys"
	supervisors = "a Teachers."
	outfit_type = /decl/hierarchy/outfit/job/psionic/student
	total_positions = 30
	skill_points = 15

/obj/effect/submap_landmark/spawnpoint/camp/psionic
	name = "Psionic student"

/datum/job/submap/camp/teacher
	title = "Psionic teacher"
	info = "You here to teach some dumbasses how to beat bad guys and not die in progress"
	supervisors = "your fantasy and Void google doc."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff
	total_positions = 3
	skill_points = 30

/obj/effect/submap_landmark/spawnpoint/camp/teacher
	name = "Psionic teacher"

/datum/job/submap/camp/doctor
	title = "Doctor"
	info = "You here to heal people, your'e the greatest biomant in this whole place."
	supervisors = "the Hippocratic oath."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff
	total_positions = 1
	skill_points = 30

/obj/effect/submap_landmark/spawnpoint/camp/doctor
	name = "Doctor"

/datum/job/submap/camp/cook
	title = "Cook"
	info = "You here to cook food for people, what else do you expecting?"
	supervisors = "your imagination."
	outfit_type = /decl/hierarchy/outfit/job/psionic/staff
	total_positions = 1
	skill_points = 20

/obj/effect/submap_landmark/spawnpoint/camp/cook
	name = "Cook"

/datum/map_template/ruin/away_site/camp
	name = "Jungle Planet"
	id = "awaysite_camp"
	spawn_cost = 1000 //NO BITCHES??
	player_cost = 4
	description = "PSY School with students and teachers. For events only."
	suffixes = list("psycho/school-1.dmm", "psycho/school-2.dmm")
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
	icon_state = "centcom"
	requires_power = 0
	dynamic_lighting = 1

/area/psionic_school/outdoor
	name = "\improper Streets"
	icon_state = "centcom"
	requires_power = 0
	dynamic_lighting = 1
	lighting_tone = AREA_LIGHTING_COOL
	sound_env = LARGE_ENCLOSED

/area/psionic_school/indoor
	name = "\improper Indoor"
	icon_state = "centcom"
	requires_power = 0
	dynamic_lighting = 1
	lighting_tone = AREA_LIGHTING_WARM

/area/psionic_school/indoor/library
	name = "\improper Library"

/area/psionic_school/indoor/stud_hall
	name = "\improper Student's Hallway"
	lighting_tone = AREA_LIGHTING_WHITE

/area/psionic_school/indoor/studentsbath1
	name = "\improper Bath 1"

/area/psionic_school/indoor/studentsbath2
	name = "\improper Bath 2"

/area/psionic_school/indoor/toilet
	name = "\improper Restroom"
	lighting_tone = AREA_LIGHTING_WHITE

/area/psionic_school/indoor/room1
	name = "\improper Room 1"

/area/psionic_school/indoor/room2
	name = "\improper Room 2"

/area/psionic_school/indoor/room3
	name = "\improper Room 3"

/area/psionic_school/indoor/room4
	name = "\improper Room 4"

/area/psionic_school/indoor/room5
	name = "\improper Room 5"

/area/psionic_school/indoor/room6
	name = "\improper Room 6"

/area/psionic_school/indoor/room7
	name = "\improper Room 7"

/area/psionic_school/indoor/room8
	name = "\improper Room 8"

/area/psionic_school/indoor/room9
	name = "\improper Room 9"

/area/psionic_school/indoor/room10
	name = "\improper Room 10"

/area/psionic_school/indoor/room11
	name = "\improper Room 11"

/area/psionic_school/indoor/room12
	name = "\improper Room 12"

/area/psionic_school/indoor/room13
	name = "\improper Room 13"

/area/psionic_school/indoor/room14
	name = "\improper Room 14"

/area/psionic_school/indoor/room15
	name = "\improper Room 15"

/area/psionic_school/indoor/room16
	name = "\improper Room 16"

/area/psionic_school/indoor/teacher_hall
	name = "\improper Teacher's Hallway"
	lighting_tone = AREA_LIGHTING_WHITE

/area/psionic_school/indoor/teacherroom1
	name = "\improper Teacher room 1"

/area/psionic_school/indoor/teacherroom2
	name = "\improper Teacher room 2"

/area/psionic_school/indoor/teacherroom3
	name = "\improper Teacher room 3"

/area/psionic_school/indoor/teacherroom4
	name = "\improper Teacher room 4"

/area/psionic_school/indoor/teacherroom5
	name = "\improper Teacher room 5"

/area/psionic_school/indoor/kitchen
	name = "\improper Kitchen"
	lighting_tone = AREA_LIGHTING_COOL

/area/psionic_school/indoor/kitchen/canteen
	name = "\improper Canteen"

/area/psionic_school/indoor/gym
	name = "\improper Gym"

/area/psionic_school/indoor/class1
	name = "\improper Classroom 1"

/area/psionic_school/indoor/class2
	name = "\improper Classroom 2"

/area/psionic_school/indoor/training
	name = "\improper Training Arena"

/area/psionic_school/indoor/medbay
	name = "\improper Hospital"
	lighting_tone = AREA_LIGHTING_WHITE

/area/psionic_school/indoor/medbay/ward1
	name = "\improper Hospital Ward 1"

/area/psionic_school/indoor/medbay/ward2
	name = "\improper Hospital Ward 2"

/area/psionic_school/indoor/medbay/ward3
	name = "\improper Hospital Ward 3"

/area/psionic_school/indoor/medbay/ward4
	name = "\improper Hospital Ward 4"

/area/psionic_school/indoor/medbay/storage
	name = "\improper Hospital Storage"

/area/psionic_school/indoor/medbay/office
	name = "\improper Phisician's Office"
	lighting_tone = AREA_LIGHTING_WARM

/area/psionic_school/indoor/tcomms
	name = "\improper Telecommunications"

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
