#define FABRICATOR_CLASS_PRECISION    "precision"

/obj/machinery/fabricator/precision
	name = "high-precision lathe"
	desc = "Allows you to produce ammunition and other items that require high precision."
	icon = 'maps/away/gccv_ulyanovsk/ulyanovsk.dmi'
	idle_power_usage = 5
	active_power_usage = 1000
	base_type = /obj/machinery/fabricator/precision
	fabricator_class = FABRICATOR_CLASS_PRECISION
	base_storage_capacity = list(
		/material/steel =		25000,
		/material/aluminium =	25000,
		/material/glass =		25000,
		/material/plastic =		25000,
		/material/silver =		25000,
		/material/gold =		25000,
		/material/uranium =		25000,
		/material/plasteel =	25000,
		/material/diamond =		25000
	)
	mat_efficiency = 1
	build_time_multiplier = 0.5
	machine_name = "high-precision lathe"
	machine_desc = "A high-precision fabricator for the production of weapon modules, cartridges, and explosive mechanisms."

//Subtype for mapping, starts preloaded with glass and set to print glasses
/obj/machinery/fabricator/precision/full

/obj/machinery/fabricator/precision/full/Initialize()
	. = ..()
	stored_material[/material/steel] = base_storage_capacity[/material/steel]
	stored_material[/material/aluminium] = base_storage_capacity[/material/aluminium]
	stored_material[/material/glass] = base_storage_capacity[/material/glass]
	stored_material[/material/plastic] = base_storage_capacity[/material/plastic]
	stored_material[/material/silver] = base_storage_capacity[/material/silver] / 2
	stored_material[/material/gold] = base_storage_capacity[/material/gold] / 2
	stored_material[/material/uranium] = base_storage_capacity[/material/uranium] / 4
	stored_material[/material/diamond] = base_storage_capacity[/material/diamond] / 4
	stored_material[/material/plasteel] = base_storage_capacity[/material/plasteel]

/obj/item/stock_parts/circuitboard/autolathe/precision ///////////////////////// fix
	name = T_BOARD("high-precision lathe")
	build_path = /obj/machinery/fabricator/precision
	origin_tech = list(TECH_ENGINEERING = 3, TECH_DATA = 2, TECH_COMBAT = 2)
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/scanning_module = 1
	)

/// FABRICATION DESIGNS

// TOOLS

/datum/fabricator_recipe/atool
	path = /obj/item/syringe_cartridge
	category = "Tools"
	fabricator_types = list(FABRICATOR_CLASS_PRECISION)

/datum/fabricator_recipe/atool/flaregun
	name = "flare gun"
	path = /obj/item/gun/projectile/flare

/datum/fabricator_recipe/atool/tacknife
	path = /obj/item/material/knife/combat

/datum/fabricator_recipe/atool/machete
	path = /obj/item/material/hatchet/machete/steel

/datum/fabricator_recipe/atool/machete/plasteel
	path = /obj/item/material/hatchet/machete/plasteel

/datum/fabricator_recipe/atool/machete/uranium
	path = /obj/item/material/hatchet/machete/uranium

/datum/fabricator_recipe/atool/flamethrower
	path = /obj/item/flamethrower/full

// SHOTGUN

/datum/fabricator_recipe/shotgun
	path = /obj/item/ammo_magazine/shotholder/empty
	category = "Shotgun"
	fabricator_types = list(FABRICATOR_CLASS_PRECISION)

/datum/fabricator_recipe/shotgun/shotgun_blanks
	name = "ammunition (shotgun, blank)"
	path = /obj/item/ammo_casing/shotgun/blank

/datum/fabricator_recipe/shotgun/shotgun_beanbag
	name = "ammunition (shotgun, beanbag)"
	path = /obj/item/ammo_casing/shotgun/beanbag

/datum/fabricator_recipe/shotgun/shotgun_flash
	name = "ammunition (shotgun, flash)"
	path = /obj/item/ammo_casing/shotgun/flash

/datum/fabricator_recipe/shotgun/shotgun_slug
	name = "ammunition (slug, shotgun)"
	path = /obj/item/ammo_casing/shotgun

/datum/fabricator_recipe/shotgun/shotgun_pellet
	name = "ammunition (shell, shotgun)"
	path = /obj/item/ammo_casing/shotgun/pellet

/datum/fabricator_recipe/shotgun/shotgun_flechette
	name = "ammunition (flechette, shotgun)"
	path = /obj/item/ammo_casing/shotgun/flechette

/datum/fabricator_recipe/shotgun/stunshell
	name = "ammunition (stun cartridge, shotgun)"
	path = /obj/item/ammo_casing/shotgun/stunshell

/datum/fabricator_recipe/shotgun/magazine_assaultshotgun
	name = "ammunition (slug, assault shotgun drum)"
	path = /obj/item/ammo_magazine/shotgun/scg

/datum/fabricator_recipe/shotgun/magazine_assaulthotgun/shell
	name = "ammunition (shell, assault shotgun drum)"
	path = /obj/item/ammo_magazine/shotgun/scg/shell

/datum/fabricator_recipe/shotgun/magazine_assaultshotgun/beanbag
	name = "ammunition (beanbag, assault shotgun drum)"
	path = /obj/item/ammo_magazine/shotgun/scg/beanbag

/datum/fabricator_recipe/shotgun/magazine_assaultshotgun/empty
	name = "ammunition (empty, assault shotgun drum)"
	path = /obj/item/ammo_magazine/shotgun/scg/empty

/datum/fabricator_recipe/shotgun/magazine_shotgun
	name = "ammunition (slug, shotgun drum)"
	path = /obj/item/ammo_magazine/shotgun/iccgn

/datum/fabricator_recipe/shotgun/magazine_shotgun/beanbag
	name = "ammunition (beanbag, shotgun drum)"
	path = /obj/item/ammo_magazine/shotgun/iccgn/beanbag

/datum/fabricator_recipe/shotgun/magazine_shotgun/magnum
	name = "ammunition (magnum shell, shotgun drum)"
	path = /obj/item/ammo_magazine/shotgun/iccgn/magnum

/datum/fabricator_recipe/shotgun/magazine_shotgun/empty
	name = "ammunition (empty, shotgun drum)"
	path = /obj/item/ammo_magazine/shotgun/iccgn/empty

/datum/fabricator_recipe/shotgun/shotholder
	name = "large sholholder (slug, shotgun)"
	path = /obj/item/ammo_magazine/shotholder/large

/datum/fabricator_recipe/shotgun/shotholder_shell
	name = "large sholholder (shell, shotgun)"
	path = /obj/item/ammo_magazine/shotholder/large/shell

/datum/fabricator_recipe/shotgun/box_slug
	name = "box (slug, shotgun)"
	path = /obj/item/ammo_magazine/box/shotgun

/datum/fabricator_recipe/shotgun/box_shell
	name = "box (shell, shotgun)"
	path = /obj/item/ammo_magazine/box/shotgun/shell

// SPEEDLOADER

/datum/fabricator_recipe/speedloader
	name = "ammunition (speedloader)"
	path = /obj/item/ammo_magazine/speedloader
	category = "Speedloader"
	fabricator_types = list(FABRICATOR_CLASS_PRECISION)

/datum/fabricator_recipe/speedloader/speedloader_small
	name = "ammunition (speedloader, holdout)"
	path = /obj/item/ammo_magazine/speedloader/small

/datum/fabricator_recipe/speedloader/speedloader_small_rubber
	name = "ammunition (speedloader, holdout, rubber)"
	path = /obj/item/ammo_magazine/speedloader/small/rubber

/datum/fabricator_recipe/speedloader/speedloader_magnum
	name = "ammunition (speedloader, magnum)"
	path = /obj/item/ammo_magazine/speedloader/magnum

/datum/fabricator_recipe/speedloader/speedloader_rifle
	name = "ammunition (speedloader, rifle)"
	path = /obj/item/ammo_magazine/speedloader/rifle

/datum/fabricator_recipe/speedloader/stripperclip
	name = "ammunition (rifle stripper clip)"
	path = /obj/item/ammo_magazine/speedloader/clip

/datum/fabricator_recipe/speedloader/pistolstripperclip
	name = "ammunition (magnum pistol stripper clip)"
	path = /obj/item/ammo_magazine/speedloader/pclip

/datum/fabricator_recipe/speedloader/broomstickstripperclip
	name = "ammunition (holdout pistol stripper clip)"
	path = /obj/item/ammo_magazine/speedloader/hpclip

/datum/fabricator_recipe/speedloader/dmr
	name = "ammunition (7mmR DMR clip)"
	path = /obj/item/ammo_magazine/speedloader/dmr

/datum/fabricator_recipe/speedloader/dmr/apds
	name = "ammunition (7mmR APDS DMR clip)"
	path = /obj/item/ammo_magazine/speedloader/dmr/apds

// SPECIAL

/datum/fabricator_recipe/special
	name = "ammunition (flechette rifle)"
	path = /obj/item/magnetic_ammo
	category = "Special"
	fabricator_types = list(FABRICATOR_CLASS_PRECISION)

/datum/fabricator_recipe/special/skrellian_rifle_flechette
	name = "ammunition (skrellian rifle, flechette)"
	path = /obj/item/magnetic_ammo/skrell

/datum/fabricator_recipe/special/skrellian_rifle_slug
	name = "ammunition (skrellian rifle, slug)"
	path = /obj/item/magnetic_ammo/skrell/slug

// PISTOL

/datum/fabricator_recipe/pistol
	name = "ammunition (10mm pistol)"
	path = /obj/item/ammo_magazine/pistol
	category = "Pistol"
	fabricator_types = list(FABRICATOR_CLASS_PRECISION)

/datum/fabricator_recipe/pistol/magazine_pistol_rubber
	name = "ammunition (10mm pistol, rubber)"
	path = /obj/item/ammo_magazine/pistol/rubber

/datum/fabricator_recipe/pistol/magazine_pistol_double
	name = "ammunition (10mm pistol, doublestack)"
	path = /obj/item/ammo_magazine/pistol/double

/datum/fabricator_recipe/pistol/magazine_pistol_double_rubber
	name = "ammunition (10mm pistol, doublestack, rubber)"
	path = /obj/item/ammo_magazine/pistol/double/rubber

/datum/fabricator_recipe/pistol/magazine_small
	name = "ammunition (7mm, holdout)"
	path = /obj/item/ammo_magazine/pistol/small

/datum/fabricator_recipe/pistol/magazine_magnum
	name = "ammunition (15mm, magnum)"
	path = /obj/item/ammo_magazine/magnum

/datum/fabricator_recipe/pistol/magazine_handbreaker
	name = "ammunition (15mm 'handbreaker' magnum magazine)"
	path = /obj/item/ammo_magazine/pistol/scg

/datum/fabricator_recipe/pistol/magazine_handbreaker/rubber
	name = "ammunition (15mm 'handbreaker' magnum magazine, rubber)"
	path = /obj/item/ammo_magazine/pistol/scg/rubber

/datum/fabricator_recipe/pistol/magazine_assasin
	name = "ammunition (4mm assasin pistol magazine)"
	path = /obj/item/ammo_magazine/pistol/assasin

/datum/fabricator_recipe/pistol/magazine_assasin/rubber
	name = "ammunition (4mm assasin pistol magazine, rubber)"
	path = /obj/item/ammo_magazine/pistol/assasin/rubber

/datum/fabricator_recipe/pistol/magazine_ksp
	name = "ammunition (15mm KSP magazine)"
	path = /obj/item/ammo_magazine/pistol/iccgn

/datum/fabricator_recipe/pistol/magazine_ksp/rubber
	name = "ammunition (15mm KSP magazine, rubber)"
	path = /obj/item/ammo_magazine/pistol/iccgn/rubber

/datum/fabricator_recipe/pistol/magazine_pisautomatic
	name = "ammunition (10mm automatic pistol magazine)"
	path = /obj/item/ammo_magazine/pistol/automatic

/datum/fabricator_recipe/pistol/magazine_pisautomatic/rubber
	name = "ammunition (10mm automatic pistol magazine, rubber)"
	path = /obj/item/ammo_magazine/pistol/automatic/rubber

// SMG

/datum/fabricator_recipe/smg
	name = "ammunition (7mm SMG, top mounted)"
	path = /obj/item/ammo_magazine/smg_top
	category = "SMG"
	fabricator_types = list(FABRICATOR_CLASS_PRECISION)

/datum/fabricator_recipe/smg/top_smg_rubber
	name = "ammunition (7mm SMG rubber, top mounted)"
	path = /obj/item/ammo_magazine/smg_top/rubber

/datum/fabricator_recipe/smg/magazine_smg
	name = "ammunition (10mm submachine gun)"
	path = /obj/item/ammo_magazine/smg

/datum/fabricator_recipe/smg/magazine_uzi
	name = "ammunition (10mm machine pistol)"
	path = /obj/item/ammo_magazine/machine_pistol

/datum/fabricator_recipe/smg/magazine_scgsmg
	name = "ammunition (10mm scg smg magazine)"
	path = /obj/item/ammo_magazine/smg/scg

/datum/fabricator_recipe/smg/magazine_scgsmg/rubber
	name = "ammunition (10mm scg smg magazine, rubber)"
	path = /obj/item/ammo_magazine/smg/scg/rubber

/datum/fabricator_recipe/smg/magazine_smgspecial
	name = "ammunition (10mm specops smg magazine)"
	path = /obj/item/ammo_magazine/smg/special/scg

/datum/fabricator_recipe/smg/magazine_smgspecial/rubber
	name = "ammunition (10mm specops smg magazine, rubber)"
	path = /obj/item/ammo_magazine/smg/special/scg/rubber

/datum/fabricator_recipe/smg/proto
	name = "ammunition (4mm prototype smg)"
	path = /obj/item/ammo_magazine/proto_smg

// RIFLE

/datum/fabricator_recipe/rifle
	name = "ammunition (5mmR rifle magazine)"
	path = /obj/item/ammo_magazine/rifle
	category = "Rifle"
	fabricator_types = list(FABRICATOR_CLASS_PRECISION)

/datum/fabricator_recipe/rifle/magazine_carbine
	name = "ammunition (7mmR military rifle)"
	path = /obj/item/ammo_magazine/mil_rifle

/datum/fabricator_recipe/rifle/magazine_assault
	name = "ammunition (5mmR assault rifle)"
	path = /obj/item/ammo_magazine/rifle/fleet

/datum/fabricator_recipe/rifle/magazine_battle
	name = "ammunition (7mmR battle rifle)"
	path = /obj/item/ammo_magazine/rifle/army

/datum/fabricator_recipe/rifle/magazine_precise
	name = "ammunition (7mmR precise rifle magazine)"
	path = /obj/item/ammo_magazine/rifle/precise

/datum/fabricator_recipe/rifle/magazine_iccgn
	name = "ammunition (5mmR iccgn rifle magazine)"
	path = /obj/item/ammo_magazine/rifle/iccgn

/datum/fabricator_recipe/rifle/rifleinternalclip
	name = "ammunition (5mmR rifle internal clip)"
	path = /obj/item/ammo_magazine/iclipr

/datum/fabricator_recipe/rifle/sniper
	name = "ammunition (7mmR heavy rifle)"
	path = /obj/item/ammo_magazine/sniper/iccgn

/datum/fabricator_recipe/rifle/sniper/dmr
	name = "ammunition (7mmR DMR)"
	path = /obj/item/ammo_magazine/sniper/scg

/datum/fabricator_recipe/rifle/bolter
	name = "ammunition (.75 HEAVY rifle)"
	path = /obj/item/ammo_magazine/rifle/bolter

/datum/fabricator_recipe/rifle/bolter/explosive
	name = "ammunition (.75-HE HEAVY rifle)"
	path = /obj/item/ammo_magazine/rifle/bolter/explosive

/datum/fabricator_recipe/rifle/box
	name = "ammunition (5mmR machinegun box)"
	path = /obj/item/ammo_magazine/box/machinegun

// AMMO BOXES

/datum/fabricator_recipe/ammobox
	name = "ammo box (pistol, 10mm)"
	path = /obj/item/ammo_magazine/box/pistol
	category = "Ammobox"
	fabricator_types = list(FABRICATOR_CLASS_PRECISION)

/datum/fabricator_recipe/ammobox/smallpistol
	name = "ammo box (small pistol, 7mm)"
	path = /obj/item/ammo_magazine/box/smallpistol

/datum/fabricator_recipe/ammobox/pistol_emp
	name = "ammo box (pistol, 10mm, haywire)"
	path = /obj/item/ammo_magazine/box/emp/pistol

/datum/fabricator_recipe/ammobox/smallpistol_emp
	name = "ammo box (pistol, 7mm, haywire)"
	path = /obj/item/ammo_magazine/box/emp/smallpistol

/datum/fabricator_recipe/ammobox/rifle
	name = "ammo box (rifle, 5mmR)"
	path = /obj/item/ammo_magazine/box/rifle

/datum/fabricator_recipe/ammobox/rifle_mil
	name = "ammo box (rifle, 7mmR military)"
	path = /obj/item/ammo_magazine/box/rifle/military

/datum/fabricator_recipe/ammobox/rifle_rus
	name = "ammo box (rifle, 12,7x55mm)"
	path = /obj/item/ammo_magazine/box/rifle/military/rus

// PARTS

/datum/fabricator_recipe/parts/igniter
	path = /obj/item/device/assembly/igniter
	category = "Parts"
	fabricator_types = list(FABRICATOR_CLASS_PRECISION)

/datum/fabricator_recipe/parts/signaler
	path = /obj/item/device/assembly/signaler

/datum/fabricator_recipe/parts/sensor_infra
	path = /obj/item/device/assembly/infra

/datum/fabricator_recipe/parts/timer
	path = /obj/item/device/assembly/timer

/datum/fabricator_recipe/parts/sensor_prox
	path = /obj/item/device/assembly/prox_sensor

/datum/fabricator_recipe/parts/cable_coil
	path = /obj/item/stack/cable_coil
	build_time = 10 SECONDS

/datum/fabricator_recipe/parts/grenade
	path = /obj/item/grenade/chem_grenade

/datum/fabricator_recipe/parts/grenade/large
	path = /obj/item/grenade/chem_grenade/large

/datum/fabricator_recipe/parts/beaker
	path = /obj/item/reagent_containers/glass/beaker

/datum/fabricator_recipe/parts/beaker/large
	path = /obj/item/reagent_containers/glass/beaker/large

// CANNON

/datum/fabricator_recipe/cannonammo
	name = "ammo box (minigun, 75mm)"
	path = /obj/item/ammo_magazine/ammobox/minigun
	build_time = 60 SECONDS
	resources = list(
		MATERIAL_PLASTEEL = 10000,
		MATERIAL_STEEL = 18000,
		MATERIAL_PLASTIC = 5000
	)
	category = "Ship Munitions"
	fabricator_types = list(FABRICATOR_CLASS_PRECISION)

/datum/fabricator_recipe/cannonammo/hmg
	name = "ammo box (HMG, 57mm)"
	path = /obj/item/ammo_magazine/ammobox/hmg

/datum/fabricator_recipe/cannonammo/autocannon
	name = "ammo box (autocannon, 105mmRP)"
	path = /obj/item/ammo_magazine/ammobox/autocannon

/datum/fabricator_recipe/cannonammo/autocannon/he
	name = "ammo box (autocannon, HE 105mmRP)"
	path = /obj/item/ammo_magazine/ammobox/autocannon/high_explosive

/datum/fabricator_recipe/cannonammo/autocannon/ap
	name = "ammo box (autocannon, APFSDS 105mmRP)"
	path = /obj/item/ammo_magazine/ammobox/autocannon/armour_piercing
