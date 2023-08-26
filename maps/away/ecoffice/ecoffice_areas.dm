//AREAS

/area/ec_office
	name = "\improper ECO Mars Office"
	icon_state = "centcom"
	requires_power = 0
	dynamic_lighting = 1
	base_turf = /turf/unsimulated/floor/exoplanet/barren

/area/ec_office/outdoor
	name = "\improper Streets of Mars"
	icon_state = "dark128"
	requires_power = 0
	dynamic_lighting = 1
	lighting_tone = AREA_LIGHTING_WARM
	ambience = list('sound/ambience/ambicity1.ogg', 'sound/ambience/ambicity2.ogg', 'sound/ambience/ambicity3.ogg')

/area/ec_office/outdoor/near
	name = "\improper Surrondings of ECO Mars Office"
	icon_state = "dark160"

/area/ec_office/outdoor/near/memorial
	name = "\improper ECO Mars Memorial"
	icon_state = "bluenew"
	ambience = list('sound/ambience/ambisad1.ogg', 'sound/ambience/ambisad2.ogg', 'sound/ambience/ambisad3.ogg')

/area/ec_office/indoor
	name = "\improper ECO Mars Office indoors"
	icon_state = "centcom"
	requires_power = 1
	dynamic_lighting = 1
	lighting_tone = AREA_LIGHTING_COOL

/area/ec_office/indoor/reception
	name = "\improper ECO Mars Reception"
	icon_state = "hallC1"

/area/ec_office/indoor/hallway
	name = "\improper ECO Mars Office Hallway"
	icon_state = "hallF1"
	lighting_tone = AREA_LIGHTING_WHITE

/area/ec_office/indoor/mission
	name = "\improper ECO Mars Mission room"
	icon_state = "bridge_meeting"

/area/ec_office/indoor/mission/second
	name = "\improper ECO Mars Mission room 2nd Floor"
	icon_state = "bridge_meeting"

/area/ec_office/indoor/boss
	name = "\improper ECO Mars Boss Office"
	icon_state = "captain"
	lighting_tone = AREA_LIGHTING_WARM

/area/ec_office/indoor/press
	name = "\improper ECO Mars Press Conference room"
	icon_state = "conference"

/area/ec_office/indoor/staff
	name = "\improper ECO Mars Staff room"
	icon_state = "cafeteria"

/area/ec_office/indoor/bathroom
	name = "\improper ECO Mars Bathroom"
	icon_state = "toilet"

/area/ec_office/indoor/locker
	name = "\improper ECO Mars Locker room"
	icon_state = "locker"

/area/ec_office/indoor/medical
	name = "\improper ECO Mars Medical room"
	icon_state = "medbay"

/area/ec_office/indoor/security
	name = "\improper ECO Mars Security room"
	icon_state = "brig"

/area/ec_office/indoor/archive
	name = "\improper ECO Mars Archive"
	icon_state = "heads"
	lighting_tone = AREA_LIGHTING_WARM

/area/ec_office/indoor/showcase
	name = "\improper ECO Mars Showcase Room"
	icon_state = "showroom"
	lighting_tone = AREA_LIGHTING_WHITE
	ambience = list('sound/ambience/ambispace1.ogg','sound/ambience/ambispace2.ogg','sound/ambience/ambispace3.ogg')

/area/ec_office/indoor/booth
	name = "\improper ECO Mars Booth"
	icon_state = "centcom"
	lighting_tone = AREA_LIGHTING_WARM

/area/ec_office/indoor/booth/security
	name = "\improper ECO Mars Security booth"
	icon_state = "checkpoint1"

/area/ec_office/indoor/booth/technican
	name = "\improper ECO Mars Technican booth"
	icon_state = "engine"

/area/ec_office/indoor/fleet
	name = "\improper ECO Mars Armed Forces Liaison office"
	icon_state = "heads_sea"

/area/ec_office/indoor/exo
	name = "\improper ECO Mars Corporate Liaison office"
	icon_state = "heads_cl"

/area/ec_office/shuttle
	name = "\improper SGV L.M.O."
	icon_state = "shuttle"
	requires_power = 1
	dynamic_lighting = 1
	base_turf = /turf/unsimulated/floor/exoplanet/concrete/reinforced/road

//NAV POINTS

/obj/effect/shuttle_landmark/nav_eco/nav1
	name = "ECO Office Landing Point #1"
	landmark_tag = "nav_eco_1"
	base_area = /area/ec_office/outdoor

/obj/effect/shuttle_landmark/transit/lmo
	name = "In transit"
	landmark_tag = "nav_transit_lmo"

/obj/effect/shuttle_landmark/lmo
	name = "SGV L.M.O. Shuttlepad"
	landmark_tag = "nav_lmo"
	base_turf = /turf/unsimulated/floor/exoplanet/concrete/reinforced/road
	movable_flags = MOVABLE_FLAG_EFFECTMOVE
