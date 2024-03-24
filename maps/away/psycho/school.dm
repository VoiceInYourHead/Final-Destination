#include "school_radio.dm"

//assets
#include "school_mobs.dm"
#include "school_npcs.dm"
#include "school_assets.dm"

//jobs
#include "jobs/school_teachers.dm"
#include "jobs/school_students.dm"
#include "jobs/school_outfit.dm"

/obj/effect/overmap/visitable/sector/camp
	name = "jungle planet"
	desc = "A jungle planet."
	sector_flags = OVERMAP_SECTOR_KNOWN
	icon_state = "globe"
	color = "#6db8b8"
	initial_generic_waypoints = list(
		"nav_camp_1",
		"nav_camp_2",
		"nav_camp_antag"
	)

	var/list/lightup
	var/lightlevel = 0.3 //This default makes turfs not generate light. Adjust to have exoplanents be lit.

/obj/effect/overmap/visitable/sector/camp/Initialize()
	..()

	lightup = block(locate(world.maxx, world.maxy, max(map_z)), locate(1, 1, min(map_z)))
	for(var/atom/A as anything in lightup)
		if(!istype(A.loc, /area/psionic_school/outdoor) || A.density || istype(A.loc, /area/psionic_school/outdoor/cave))
			lightup -= A
	update_daynight()

/obj/effect/overmap/visitable/sector/camp/proc/update_daynight(light = 0.7, light_color = "#e2d1b2")
	for(var/turf/T as anything in lightup)
		T.set_light(light, 0.1, 2, l_color = light_color)

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
		/datum/job/submap/camp/zeza,
		/datum/job/submap/camp/akira,

		/datum/job/submap/camp/shtorn,
		/datum/job/submap/camp/sara,
		/datum/job/submap/camp/vivian,
		/datum/job/submap/camp/mara,
		/datum/job/submap/camp/demetra,

		/datum/job/submap/camp/teacher1,
		/datum/job/submap/camp/teacher2,
		/datum/job/submap/camp/teacher3,
		/datum/job/submap/camp/cook,
		/datum/job/submap/camp/doctor
	)


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

/area/psionic_school/indoor/sara
	name = "\improper Sara's Treehouse"

/area/psionic_school/indoor/sara/upper
	base_turf = /turf/simulated/open

/area/psionic_school/outdoor/cave
	name = "\improper Cave"

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

/area/psionic_school/indoor/campus/girls/kitchen
	name = "\improper Girls Kitchen"

/area/psionic_school/indoor/campus/male
	name = "\improper Male Block"

/area/psionic_school/indoor/campus/male/forge
	name = "\improper Male Block(Forge)"

/area/psionic_school/indoor/campus/male/church
	name = "\improper Male Block(Church)"

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
