/area/map_template/gccv_ulyanovsk
	name = "\improper GCCV Ulyanovsk"
	icon_state = "green"
	req_access = list(access_iccg)
	requires_power = FALSE // FOR DEBUGGING

/area/turbolift/ulyanovsk1
	name = "lift 1 (thirt deck)"
	lift_floor_label = "Deck 3"
	lift_floor_name = "Hangar Deck"
	lift_announce_str = "Arriving at Hangar Deck: Main Hangar."
	base_turf = /turf/simulated/floor

/area/turbolift/ulyanovsk1/deck2
	name = "lift 1 (second deck)"
	lift_floor_label = "Deck 2"
	lift_floor_name = "Second Deck"
	lift_announce_str = "Arriving at Second Deck: Yahoo!"

/area/turbolift/ulyanovsk1/deck1
	name = "lift 1 (first deck)"
	lift_floor_label = "Deck 1"
	lift_floor_name = "First Deck"
	lift_announce_str = "Arriving at Command Deck: Bridge."

/area/turbolift/ulyanovsk2
	name = "lift 2 (thirt deck)"
	lift_floor_label = "Deck 3"
	lift_floor_name = "Hangar Deck"
	lift_announce_str = "Arriving at Hangar Deck: Main Hangar."
	base_turf = /turf/simulated/floor

/area/turbolift/ulyanovsk2/deck2
	name = "lift 2 (second deck)"
	lift_floor_label = "Deck 2"
	lift_floor_name = "Second Deck"
	lift_announce_str = "Arriving at Second Deck: Yahoo!"

/area/turbolift/ulyanovsk2/deck1
	name = "lift 2 (first deck)"
	lift_floor_label = "Deck 1"
	lift_floor_name = "First Deck"
	lift_announce_str = "Arriving at Command Deck: Bridge."

/area/turbolift/ulyanovsk3
	name = "lift 3 (thirt deck)"
	lift_floor_label = "Deck 3"
	lift_floor_name = "Hangar Deck"
	lift_announce_str = "Arriving at Hangar Deck: Main Hangar."
	base_turf = /turf/simulated/floor

/area/turbolift/ulyanovsk3/deck2
	name = "lift 3 (second deck)"
	lift_floor_label = "Deck 2"
	lift_floor_name = "Second Deck"
	lift_announce_str = "Arriving at Second Deck: Yahoo!"

/area/turbolift/ulyanovsk3/deck1
	name = "lift 3 (first deck)"
	lift_floor_label = "Deck 1"
	lift_floor_name = "First Deck"
	lift_announce_str = "Arriving at Command Deck: Bridge."

/// DECK 1

/area/map_template/gccv_ulyanovsk/deck1
	name = "\improper GCCV Ulyanovsk Deck 1"
	icon_state = "1"

// COMMAND

/area/map_template/gccv_ulyanovsk/deck1/command
	name = "\improper Combat Information Center"
	icon_state = "16"
	req_access = list(access_iccg_com, access_iccg)

/area/map_template/gccv_ulyanovsk/deck1/command/hall
	name = "\improper CIC - Hallway"

/area/map_template/gccv_ulyanovsk/deck1/command/main
	name = "\improper CIC - Main"

/area/map_template/gccv_ulyanovsk/deck1/command/control
	name = "\improper CIC - Control"

/area/map_template/gccv_ulyanovsk/deck1/command/armory
	name = "\improper CIC - Armory"

/area/map_template/gccv_ulyanovsk/deck1/command/eva
	name = "\improper CIC - EVA"

/area/map_template/gccv_ulyanovsk/deck1/command/cryo
	name = "\improper CIC - Cryo"

/area/map_template/gccv_ulyanovsk/deck1/command/communications
	name = "\improper CIC - Communications"

/area/map_template/gccv_ulyanovsk/deck1/command/communications/servers
	name = "\improper CIC - Communications - Servers"

/area/map_template/gccv_ulyanovsk/deck1/command/bridge
	name = "\improper CIC - Bridge"

/area/map_template/gccv_ulyanovsk/deck1/command/bridge/storage
	name = "\improper CIC - Bridge - Storage"

/area/map_template/gccv_ulyanovsk/deck1/command/hall
	name = "\improper CIC - Hallway"

/area/map_template/gccv_ulyanovsk/deck1/command/checkpoint
	name = "\improper CIC - Checkpoint"
	req_access = list(access_iccg_sec)

/area/map_template/gccv_ulyanovsk/deck1/command/living
	name = "\improper Command - Living"

/area/map_template/gccv_ulyanovsk/deck1/command/living/mess
	name = "\improper Command - Mess"

/area/map_template/gccv_ulyanovsk/deck1/command/living/commander
	name = "\improper Command - Commander Office"
	req_access = list(access_iccg_com_cap)

/area/map_template/gccv_ulyanovsk/deck1/command/living/starpom
	name = "\improper Command - Starpom Office"
	req_access = list(access_iccg_com, access_iccg_engi, access_iccg_med, access_iccg_sec)

/area/map_template/gccv_ulyanovsk/deck1/command/off_living
	name = "\improper Command - Officers Living"

/area/map_template/gccv_ulyanovsk/deck1/command/off_living/living
	name = "\improper Command - Officers Living Rooms"

/area/map_template/gccv_ulyanovsk/deck1/command/off_living/living/a
	name = "\improper C - O-L-R - A"

/area/map_template/gccv_ulyanovsk/deck1/command/off_living/living/b
	name = "\improper C - O-L-R - B"

/area/map_template/gccv_ulyanovsk/deck1/command/off_living/living/c
	name = "\improper C - O-L-R - C"

/area/map_template/gccv_ulyanovsk/deck1/command/off_living/office
	name = "\improper Command - Office"

/area/map_template/gccv_ulyanovsk/deck1/command/bluespace_drive
	name = "\improper Command - Bluespace Drive"
	req_access = list(access_iccg, access_iccg_com, access_iccg_engi)

/area/map_template/gccv_ulyanovsk/deck1/command/bluespace_drive/core
	name = "\improper Command - Bluespace Drive - Core"

// SPECIAL OPERATIONS

/area/map_template/gccv_ulyanovsk/deck1/specops
	name = "\improper Special Operations"
	icon_state = "13"
	req_access = list(access_iccg_sec, access_iccg)

/area/map_template/gccv_ulyanovsk/deck1/specops/hall
	name = "\improper SO - Hallway"

/area/map_template/gccv_ulyanovsk/deck1/specops/investigation
	name = "\improper SO - Investigations"

/area/map_template/gccv_ulyanovsk/deck1/specops/lounge
	name = "\improper SO - Lounge"

/area/map_template/gccv_ulyanovsk/deck1/specops/range
	name = "\improper SO - Shooting Range"

/area/map_template/gccv_ulyanovsk/deck1/specops/preparations
	name = "\improper SO - Preparations"

/area/map_template/gccv_ulyanovsk/deck1/specops/eva
	name = "\improper SO - EVA"

/area/map_template/gccv_ulyanovsk/deck1/specops/checkpont
	name = "\improper SO - Checkpoint"

/area/map_template/gccv_ulyanovsk/deck1/specops/meeting
	name = "\improper SO - Meeting Room"

/area/map_template/gccv_ulyanovsk/deck1/specops/mission_control
	name = "\improper SO - MC"

/area/map_template/gccv_ulyanovsk/deck1/specops/armory
	name = "\improper SO - Armory"

/area/map_template/gccv_ulyanovsk/deck1/specops/armory/main
	name = "\improper SO - Main Armory"

/area/map_template/gccv_ulyanovsk/deck1/specops/storage
	name = "\improper SO - Storage"

/area/map_template/gccv_ulyanovsk/deck1/specops/interrogation
	name = "\improper SO - Interrogations Hallway"

/area/map_template/gccv_ulyanovsk/deck1/specops/interrogation/observatory
	name = "\improper SO - Interrogation Observatory"

/area/map_template/gccv_ulyanovsk/deck1/specops/interrogation/cell
	name = "\improper SO - Interrogation Cell"

/area/map_template/gccv_ulyanovsk/deck1/specops/interrogation/room
	name = "\improper SO - Interrogation Room"

/area/map_template/gccv_ulyanovsk/deck1/specops/brig
	name = "\improper SO - Brig"

// Everything else

/area/map_template/gccv_ulyanovsk/deck1/ofd
	name = "\improper Obstruction Field Disperser"
	icon_state = "18"
	req_access = list(list(access_iccg_sec, access_iccg_engi))

/area/map_template/gccv_ulyanovsk/deck1/toolstorage
	name = "\improper 1-D Tool Storage"
	icon_state = "17"

/area/map_template/gccv_ulyanovsk/deck1/eva
	name = "\improper Main EVA"
	req_access = list(access_iccg)

/area/map_template/gccv_ulyanovsk/deck1/reactor_a
	name = "\improper N - Reactor 'Alpha'"
	req_access = list(access_iccg, access_iccg_engi)

/area/map_template/gccv_ulyanovsk/deck1/reactor_b
	name = "\improper N - Reactor 'Bravo'"
	req_access = list(access_iccg, access_iccg_engi)

/area/map_template/gccv_ulyanovsk/deck1/substation
	name = "\improper Power Substation"
	req_access = list(access_iccg, access_iccg_engi)

// HALLWAY

/area/map_template/gccv_ulyanovsk/deck1/hallway
	name = "\improper 1-D Fore Hallway"
	icon_state = "14"

/area/map_template/gccv_ulyanovsk/deck1/hallway/mid
	name = "\improper 1-D Midship Hallway"

/area/map_template/gccv_ulyanovsk/deck1/hallway/lift
	name = "\improper 1-D Midship Lift Hallway"

/area/map_template/gccv_ulyanovsk/deck1/hallway/aft
	name = "\improper 1-D Aft Hallway"

// GYM

/area/map_template/gccv_ulyanovsk/deck1/gym
	name = "\improper Gym Hallway"
	icon_state = "17"

/area/map_template/gccv_ulyanovsk/deck1/gym/exercise
	name = "\improper Gym Exercise Equipment"

/area/map_template/gccv_ulyanovsk/deck1/gym/lockers
	name = "\improper Gym Locker Room"

/area/map_template/gccv_ulyanovsk/deck1/gym/pool
	name = "\improper Swimming Pool"

/area/map_template/gccv_ulyanovsk/deck1/gym/box_ring
	name = "\improper Boxing Ring"

// MAINTENANCE

/area/map_template/gccv_ulyanovsk/deck1/maintenance
	name = "\improper 1-D Maintenance"
	icon_state = "22"


/area/map_template/gccv_ulyanovsk/deck1/maintenance/port
	name = "\improper 1-D Midship Port Maint"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/port/fore
	name = "\improper 1-D Fore Port Maint"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/port/aft
	name = "\improper 1-D Aft Port Maint"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/port/atmos
	name = "\improper 1-D Aux Atmospherics"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/port/storage
	name = "\improper 1-D Port Maint Storage"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/port/aux_bunks
	name = "\improper 1-D Aux Injury Bunks"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/port/fabricator
	name = "\improper 1-D Port Fabricator"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/port/circuit_dev
	name = "\improper 1-D Port Circuitry Development"


/area/map_template/gccv_ulyanovsk/deck1/maintenance/starboard
	name = "\improper 1-D Midship Starboard Maint"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/starboard/fore
	name = "\improper 1-D Fore Starboard Maint"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/starboard/aft
	name = "\improper 1-D Aft Starboard Maint"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/starboard/storage
	name = "\improper 1-D Starboard Storage"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/starboard/storage/gases
	name = "\improper 1-D Starboard Gas Storage"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/starboard/storage/tech
	name = "\improper 1-D Starboard Tech Storage"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/starboard/storage/clothes
	name = "\improper 1-D Starboard Clothes Storage"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/starboard/storage/cryo
	name = "\improper 1-D Starboard Cryo Storage"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/starboard/storage/janitor
	name = "\improper 1-D Starboard Janitorial Storage"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/starboard/storage/fuel
	name = "\improper 1-D Starboard Fuel Storage"

/area/map_template/gccv_ulyanovsk/deck1/maintenance/starboard/oxy_regenerator
	name = "\improper 1-D Starboard Oxygen Regenerator"

/// DECK 2

/area/map_template/gccv_ulyanovsk/deck2
	name = "\improper GCCV Ulyanovsk Deck 2"
	icon_state = "2"

// ENGINEERING WING

/area/map_template/gccv_ulyanovsk/deck2/engineering
	name = "\improper GCCV Ulyanovsk Engineering"
	icon_state = "22"
	req_access = list(access_iccg_engi)

/area/map_template/gccv_ulyanovsk/deck2/engineering/hallway
	name = "\improper Engineering Hallway"

/area/map_template/gccv_ulyanovsk/deck2/engineering/hallway/port
	name = "\improper Engineering Port Hallway"

/area/map_template/gccv_ulyanovsk/deck2/engineering/hallway/starboard
	name = "\improper Engineering Starboard Hallway"

/area/map_template/gccv_ulyanovsk/deck2/engineering/locker
	name = "\improper Engineering Locker Room"
	icon_state = "a"

/area/map_template/gccv_ulyanovsk/deck2/engineering/office
	name = "\improper Engineering Office"

/area/map_template/gccv_ulyanovsk/deck2/engineering/smes
	name = "\improper Engineering SMES"

/area/map_template/gccv_ulyanovsk/deck2/engineering/shield
	name = "\improper Ship Shields"

/area/map_template/gccv_ulyanovsk/deck2/engineering/atmospherics
	name = "\improper Atmospherics"
	icon_state = "d"

/area/map_template/gccv_ulyanovsk/deck2/engineering/atmospherics/storage
	name = "\improper Atmospherics Storage"

/area/map_template/gccv_ulyanovsk/deck2/engineering/secure_storage
	name = "\improper Engineering Secure Storage"
	icon_state = "e"

/area/map_template/gccv_ulyanovsk/deck2/engineering/waste
	name = "\improper Waste Tank"

/area/map_template/gccv_ulyanovsk/deck2/engineering/fusion
	name = "\improper F-R Control"
	icon_state = "b"

/area/map_template/gccv_ulyanovsk/deck2/engineering/fusion/core
	name = "\improper F-R Core"

/area/map_template/gccv_ulyanovsk/deck2/engineering/matter
	name = "\improper SM Control"
	icon_state = "c"

/area/map_template/gccv_ulyanovsk/deck2/engineering/matter/core
	name = "\improper SM Core"

/area/map_template/gccv_ulyanovsk/deck2/engineering/eva
	name = "\improper Engineering E.V.A."

/area/map_template/gccv_ulyanovsk/deck2/engineering/aux_storage
	name = "\improper Auxiliary Storage"

/area/map_template/gccv_ulyanovsk/deck2/engineering/maint
	name = "\improper Engineering Maintenance"

// M E D B A Y

/area/map_template/gccv_ulyanovsk/deck2/medbay
	name = "\improper GCCV Ulyanovsk Infirmary"
	icon_state = "14"
	req_access = list(access_iccg_med)

/area/map_template/gccv_ulyanovsk/deck2/medbay/reception
	name = "\improper Infirmary Reception"

/area/map_template/gccv_ulyanovsk/deck2/medbay/chemistry
	name = "\improper Infirmary Chemistry"

/area/map_template/gccv_ulyanovsk/deck2/medbay/storage
	name = "\improper Infirmary Storage"

/area/map_template/gccv_ulyanovsk/deck2/medbay/locker
	name = "\improper Infirmary Locker Room"

/area/map_template/gccv_ulyanovsk/deck2/medbay/office
	name = "\improper Infirmary Office"

/area/map_template/gccv_ulyanovsk/deck2/medbay/hallway
	name = "\improper Infirmary Hallway"

/area/map_template/gccv_ulyanovsk/deck2/medbay/dorm
	name = "\improper Infirmary Patient A"
	icon_state = "a"

/area/map_template/gccv_ulyanovsk/deck2/medbay/dorm/b
	name = "\improper Infirmary Patient B"
	icon_state = "b"

/area/map_template/gccv_ulyanovsk/deck2/medbay/dorm/c
	name = "\improper Infirmary Patient C"
	icon_state = "c"

/area/map_template/gccv_ulyanovsk/deck2/medbay/dorm/d
	name = "\improper Infirmary Patient D"
	icon_state = "d"

/area/map_template/gccv_ulyanovsk/deck2/medbay/surgery
	name = "\improper Infirmary Surgery Theatre A"
	icon_state = "a"

/area/map_template/gccv_ulyanovsk/deck2/medbay/surgery/b
	name = "\improper Infirmary Surgery Theatre B"
	icon_state = "b"

/area/map_template/gccv_ulyanovsk/deck2/medbay/surgery/c
	name = "\improper Infirmary Surgery Theatre C"
	icon_state = "c"

/area/map_template/gccv_ulyanovsk/deck2/medbay/morgue
	name = "\improper Morgue"

/area/map_template/gccv_ulyanovsk/deck2/medbay/maint_storage
	name = "\improper Infirmary Aux Storage"

/area/map_template/gccv_ulyanovsk/deck2/medbay/maint
	name = "\improper Infirmary Maintenance"

/area/map_template/gccv_ulyanovsk/deck2/medbay/rations
	name = "\improper Rations Storage"

// SERVICE

/area/map_template/gccv_ulyanovsk/deck2/service
	name = "\improper Lounge Hall"
	icon_state = "19"

/area/map_template/gccv_ulyanovsk/deck2/service/cryo
	name = "\improper Cryogenic Storage"

/area/map_template/gccv_ulyanovsk/deck2/service/hydroponics
	name = "\improper Hydroponics"

/area/map_template/gccv_ulyanovsk/deck2/service/kitchen
	name = "\improper Kitchen"

/area/map_template/gccv_ulyanovsk/deck2/service/kitchen/freezer
	name = "\improper Freezer"

/area/map_template/gccv_ulyanovsk/deck2/service/toilet
	name = "\improper Toilet Room"

/area/map_template/gccv_ulyanovsk/deck2/service/disposal
	name = "\improper Disposal"

/area/map_template/gccv_ulyanovsk/deck2/service/hallway
	name = "\improper Lounge Hallway"

/area/map_template/gccv_ulyanovsk/deck2/service/bathroom
	name = "\improper Bathroom"

/area/map_template/gccv_ulyanovsk/deck2/service/bathroom/sauna
	name = "\improper Bathhouse"

/area/map_template/gccv_ulyanovsk/deck2/service/briefing
	name = "\improper Briefing Room"

/area/map_template/gccv_ulyanovsk/deck2/service/laundry
	name = "\improper Laundry"

/area/map_template/gccv_ulyanovsk/deck2/service/dorms
	name = "\improper Service Dorms"

// COMMS (Cargo Analog)

/area/map_template/gccv_ulyanovsk/deck2/communications
	name = "\improper Communications Relay"
	icon_state = "4"

/area/map_template/gccv_ulyanovsk/deck2/communications/storage
	name = "\improper Main Storage"

/area/map_template/gccv_ulyanovsk/deck2/communications/control
	name = "\improper Comms Control"

// HARDPOINTS 2-DECK

/area/map_template/gccv_ulyanovsk/deck2/hardpoint
	name = "\improper Hardpoints"
	icon_state = "guns"

/area/map_template/gccv_ulyanovsk/deck2/hardpoint/a
	name = "\improper Hardpoint Alpha"
	icon_state = "a"

/area/map_template/gccv_ulyanovsk/deck2/hardpoint/b
	name = "\improper Hardpoint Bravo"
	icon_state = "b"

/area/map_template/gccv_ulyanovsk/deck2/hardpoint/c
	name = "\improper Hardpoint Charlie"
	icon_state = "c"

/area/map_template/gccv_ulyanovsk/deck2/hardpoint/d
	name = "\improper Hardpoint Delta"
	icon_state = "d"

// TELEPORT

/area/map_template/gccv_ulyanovsk/deck2/teleport
	name = "\improper GCCV - Ulyanovsk - Teleport"
	icon_state = "a"
	req_access = list(access_iccg, access_iccg_com)

// HALLWAY

/area/map_template/gccv_ulyanovsk/deck2/hallway
	name = "\improper 2-D Fore Hallway"
	icon_state = "14"

/area/map_template/gccv_ulyanovsk/deck2/hallway/lift
	name = "\improper 2-D Fore Lift Hallway"

/area/map_template/gccv_ulyanovsk/deck2/hallway/mid
	name = "\improper 2-D Midship Hallway"

/area/map_template/gccv_ulyanovsk/deck2/hallway/mid/lift
	name = "\improper 2-D Midship Lift Hallway"

/area/map_template/gccv_ulyanovsk/deck2/hallway/service
	name = "\improper 2-D Midship Service Hallway"

/area/map_template/gccv_ulyanovsk/deck2/hallway/aft
	name = "\improper 2-D Aft Hallway"

// MAINTENANCE

/area/map_template/gccv_ulyanovsk/deck2/maintenance
	name = "\improper 2-D Maintenance"
	icon_state = "22"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/port
	name = "\improper 2-D Midship Port Maint"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/port/fore
	name = "\improper 2-D Fore Port Maint"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/port/aft
	name = "\improper 2-D Aft Port Maint"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/port/aux_sub
	name = "\improper 2-D Aux Substation"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/port/deep
	name = "\improper 2-D Deep Maint"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/port/warheads
	name = "\improper 2-D Warheads Storage"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/port/circuitry
	name = "\improper 2-D Circuitry Storage"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/port/construction
	name = "\improper 2-D Construction Site"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/port/engineering
	name = "\improper 2-D Port Engineering Maint"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/starboard
	name = "\improper 2-D Midship Starboard Maint"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/starboard/fore
	name = "\improper 2-D Fore Starboard Maint"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/starboard/aft
	name = "\improper 2-D Aft Starboard Maint"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/starboard/storage
	name = "\improper 2-D Maint Storage"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/starboard/staircase
	name = "\improper 2-D Maintenance Staircase"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/starboard/airlock
	name = "\improper 2-D Starboard Airlock"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/starboard/engineering
	name = "\improper 2-D Starboard Engineering Maint"

/area/map_template/gccv_ulyanovsk/deck2/maintenance/starboard/service
	name = "\improper 2-D Service Maint"





/area/map_template/gccv_ulyanovsk/deck3
	name = "\improper GCCV Ulyanovsk Deck 3"
	icon_state = "3"
