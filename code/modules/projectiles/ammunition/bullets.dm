
/obj/item/ammo_casing/pistol
	desc = "A pistol bullet casing."
	caliber = CALIBER_PISTOL
	projectile_type = /obj/item/projectile/bullet/pistol
	icon_state = "pistolcasing"
	spent_icon = "pistolcasing-spent"

/obj/item/ammo_casing/pistol/rubber
	desc = "A rubber pistol bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "pistolcasing_r"

/obj/item/ammo_casing/pistol/practice
	desc = "A practice pistol bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/practice
	icon_state = "pistolcasing_p"

/obj/item/ammo_casing/pistol/small
	desc = "A small pistol bullet casing."
	caliber = CALIBER_PISTOL_SMALL
	projectile_type = /obj/item/projectile/bullet/pistol/holdout
	icon_state = "smallcasing"
	spent_icon = "smallcasing-spent"

/obj/item/ammo_casing/pistol/small/rubber
	desc = "A small pistol rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber/holdout
	icon_state = "pistolcasing_r"

/obj/item/ammo_casing/pistol/small/practice
	desc = "A small pistol practice bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/practice
	icon_state = "pistolcasing_p"

/obj/item/ammo_casing/pistol/magnum
	desc = "A high-power pistol bullet casing."
	caliber = CALIBER_PISTOL_MAGNUM
	projectile_type = /obj/item/projectile/bullet/pistol/strong
	icon_state = "magnumcasing"
	spent_icon = "magnumcasing-spent"

/obj/item/ammo_casing/pistol/magnum/rubber
	desc = "A high-power pistol rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/strong/rubber

/obj/item/ammo_casing/pistol/throwback
	desc = "An antique pistol bullet casing. Somewhere between 9 and 11 mm in caliber."
	caliber = CALIBER_PISTOL_ANTIQUE

/obj/item/ammo_casing/gyrojet
	desc = "A minirocket casing."
	caliber = CALIBER_GYROJET
	projectile_type = /obj/item/projectile/bullet/gyro
	icon_state = "lcasing"
	spent_icon = "lcasing-spent"

/obj/item/ammo_casing/flechette
	desc = "A flechette casing."
	caliber = CALIBER_PISTOL_FLECHETTE
	projectile_type = /obj/item/projectile/bullet/flechette
	icon_state = "flechette-casing"
	spent_icon = "flechette-casing-spent"

/obj/item/ammo_casing/shotgun
	name = "shotgun slug"
	desc = "A shotgun slug."
	icon_state = "slshell"
	spent_icon = "slshell-spent"
	caliber = CALIBER_SHOTGUN
	projectile_type = /obj/item/projectile/bullet/shotgun
	matter = list(MATERIAL_STEEL = 360)
	fall_sounds = list('sound/weapons/guns/shotgun_fall.ogg')

/obj/item/ammo_casing/shotgun/pellet
	name = "shotgun shell"
	desc = "A shotshell."
	icon_state = "gshell"
	spent_icon = "gshell-spent"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun
	matter = list(MATERIAL_STEEL = 360)

/obj/item/ammo_casing/magnum/shotgun
	name = "shotgun magnum shell"
	desc = "A shotgun shell with extra power."
	icon_state = "gshell"
	spent_icon = "gshell-spent"
	caliber = CALIBER_SHOTGUN
	fall_sounds = list('sound/weapons/guns/shotgun_fall.ogg')
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun/magnum
	matter = list(MATERIAL_STEEL = 720)

/obj/item/ammo_casing/shotgun/flechette
	name = "flechette shell"
	desc = "A flechette shell."
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun/flechette
	matter = list(MATERIAL_STEEL = 360)

/obj/item/ammo_casing/shotgun/blank
	name = "shotgun shell"
	desc = "A blank shell."
	icon_state = "blshell"
	spent_icon = "blshell-spent"
	projectile_type = /obj/item/projectile/bullet/blank
	matter = list(MATERIAL_STEEL = 90)

/obj/item/ammo_casing/shotgun/practice
	name = "shotgun shell"
	desc = "A practice shell."
	icon_state = "pshell"
	spent_icon = "pshell-spent"
	projectile_type = /obj/item/projectile/bullet/shotgun/practice
	matter = list(MATERIAL_STEEL = 90)

/obj/item/ammo_casing/shotgun/beanbag
	name = "beanbag shell"
	desc = "A beanbag shell."
	icon_state = "bshell"
	spent_icon = "bshell-spent"
	projectile_type = /obj/item/projectile/bullet/shotgun/beanbag
	matter = list(MATERIAL_STEEL = 180)

//Can stun in one hit if aimed at the head, but
//is blocked by clothing that stops tasers and is vulnerable to EMP
/obj/item/ammo_casing/shotgun/stunshell
	name = "stun shell"
	desc = "An energy stun cartridge."
	icon_state = "stunshell"
	spent_icon = "stunshell-spent"
	projectile_type = /obj/item/projectile/energy/electrode/stunshot
	leaves_residue = FALSE
	matter = list(MATERIAL_STEEL = 360, MATERIAL_GLASS = 720)

/obj/item/ammo_casing/shotgun/stunshell/emp_act(severity)
	if(prob(100/severity)) BB = null
	update_icon()

//Does not stun, only blinds, but has area of effect.
/obj/item/ammo_casing/shotgun/flash
	name = "flash shell"
	desc = "A chemical shell used to signal distress or provide illumination."
	icon_state = "fshell"
	spent_icon = "fshell-spent"
	projectile_type = /obj/item/projectile/energy/flash/flare
	matter = list(MATERIAL_STEEL = 90, MATERIAL_GLASS = 90)

/obj/item/ammo_casing/rifle
	desc = "A rifle bullet casing."
	caliber = CALIBER_RIFLE
	projectile_type = /obj/item/projectile/bullet/rifle
	icon_state = "riflecasing"
	spent_icon = "riflecasing-spent"

/obj/item/ammo_casing/rifle/russia
	desc = "A rifle 12.7x55mm bullet casing."
	caliber = CALIBER_RIFLE_RUSSIA
	projectile_type = /obj/item/projectile/bullet/rifle/russian
	icon_state = "ruscasing"
	spent_icon = "ruscasing-spent"

/obj/item/ammo_casing/rifle/russia/ap
	desc = "A rifle AP 12.7x55mm bullet casing."
	caliber = CALIBER_RIFLE_RUSSIA
	projectile_type = /obj/item/projectile/bullet/rifle/russian/ap
	icon_state = "ruscasing_ap"
	spent_icon = "ruscasing_ap-spent"

/obj/item/ammo_casing/rifle/russia/hp
	desc = "A rifle HP 12.7x55mm bullet casing."
	caliber = CALIBER_RIFLE_RUSSIA
	projectile_type = /obj/item/projectile/bullet/rifle/russian/hp
	icon_state = "ruscasing_hp"
	spent_icon = "ruscasing_hp-spent"

/obj/item/ammo_casing/shell
	name = "shell casing"
	desc = "An antimaterial shell casing."
	icon_state = "lcasing"
	spent_icon = "lcasing-spent"
	caliber = CALIBER_ANTIMATERIAL
	projectile_type = /obj/item/projectile/bullet/rifle/shell
	matter = list(MATERIAL_STEEL = 1250)

/obj/item/ammo_casing/shell/apds
	name = "\improper APDS shell casing"
	desc = "An Armour Piercing Discarding Sabot shell."
	projectile_type = /obj/item/projectile/bullet/rifle/shell/apds

/obj/item/ammo_casing/rifle/military
	desc = "A military rifle bullet casing."
	caliber = CALIBER_RIFLE_MILITARY
	projectile_type = /obj/item/projectile/bullet/rifle/military
	icon_state = "rifle_mil"
	spent_icon = "rifle_mil-spent"

/obj/item/ammo_casing/rifle/military/practice
	desc = "A military rifle practice bullet casing."
	projectile_type = /obj/item/projectile/bullet/rifle/military/practice
	icon_state = "rifle_mil_p"

/obj/item/ammo_casing/rocket
	name = "rocket shell"
	desc = "A high explosive designed to be fired from a launcher."
	icon_state = "rocketshell"
	caliber = CALIBER_ROCKET
	projectile_type = /obj/item/projectile/missile
	caliber = "rocket"

/obj/item/ammo_casing/cap
	name = "cap"
	desc = "A cap for children toys."
	caliber = CALIBER_CAPS
	color = "#ff0000"
	projectile_type = /obj/item/projectile/bullet/pistol/cap

// EMP ammo.
/obj/item/ammo_casing/pistol/emp
	name = "haywire round"
	desc = "A pistol bullet casing fitted with a single-use ion pulse generator."
	projectile_type = /obj/item/projectile/ion/small
	icon_state = "pistolcasing_h"
	matter = list(MATERIAL_STEEL = 130, MATERIAL_URANIUM = 100)

/obj/item/ammo_casing/pistol/small/emp
	name = "small haywire round"
	desc = "A small bullet casing fitted with a single-use ion pulse generator."
	projectile_type = /obj/item/projectile/ion/tiny
	icon_state = "smallcasing_h"

/obj/item/ammo_casing/shotgun/emp
	name = "haywire slug"
	desc = "A 12-gauge shotgun slug fitted with a single-use ion pulse generator."
	icon_state = "empshell"
	spent_icon = "empshell-spent"
	projectile_type  = /obj/item/projectile/ion
	matter = list(MATERIAL_STEEL = 260, MATERIAL_URANIUM = 200)

// SCG

/obj/item/ammo_casing/pistol/iccgn
	projectile_type = /obj/item/projectile/bullet/pistol/iccgn
	caliber = CALIBER_PISTOL_MAGNUM

/obj/item/ammo_casing/pistol/automatic
	projectile_type = /obj/item/projectile/bullet/pistol/automatic
/obj/item/ammo_casing/pistol/assasin
	caliber = CALIBER_PISTOL_FLECHETTE

/obj/item/ammo_casing/pistol/assasin/rubber
	desc = "A rubber pistol bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "pistolcasing_r"
	caliber = CALIBER_PISTOL_FLECHETTE

/obj/item/ammo_casing/pistol/automatic/rubber
	projectile_type = /obj/item/projectile/bullet/pistol/automatic/rubber

/obj/item/ammo_casing/rifle/military/marksman
	projectile_type = /obj/item/projectile/bullet/rifle/marksman

/obj/item/ammo_casing/scg/shell
	name = "shell casing"
	desc = "An antimaterial shell casing."
	icon_state = "lcasing"
	spent_icon = "lcasing-spent"
	caliber = CALIBER_ANTIMATERIAL
	projectile_type = /obj/item/projectile/bullet/rifle/shell
	matter = list(MATERIAL_STEEL = 1250)

/obj/item/ammo_casing/scg/shell/apds
	name = "\improper APDS shell casing"
	desc = "An Armour Piercing Discarding Sabot shell."
	projectile_type = /obj/item/projectile/bullet/rifle/shell/apds

/obj/item/ammo_casing/scg/shell/explosive
	name = "HE shell casing"
	desc = "An antimaterial shell casing with explosive"
	projectile_type = /obj/item/projectile/bullet/rifle/shell/explosive

/obj/item/ammo_casing/scg/shell/emp
	name = "haywire shell casing"
	projectile_type  = /obj/item/projectile/ion/heavy
	matter = list(MATERIAL_STEEL = 1100, MATERIAL_URANIUM = 300)

/obj/item/ammo_casing/rifle/fleet
	desc = "A rifle bullet casing."
	caliber = CALIBER_RIFLE
	projectile_type = /obj/item/projectile/bullet/rifle/fleet
	icon_state = "riflecasing"
	spent_icon = "riflecasing-spent"

/obj/item/ammo_casing/rifle/army
	desc = "A rifle bullet casing."
	caliber = CALIBER_RIFLE_MILITARY
	projectile_type = /obj/item/projectile/bullet/rifle/army
	icon_state = "riflecasing"
	spent_icon = "riflecasing-spent"

/obj/item/ammo_casing/rifle/iccgn
	desc = "A rifle bullet casing"
	caliber = CALIBER_RIFLE
	projectile_type = /obj/item/projectile/bullet/rifle
	icon_state = "riflecasing"
	spent_icon = "riflecasing-spent"

/obj/item/ammo_casing/rifle/accurate
	desc = "A rifle bullet casing"
	caliber = CALIBER_RIFLE_MILITARY
	projectile_type = /obj/item/projectile/bullet/rifle/accurate
	icon_state = "riflecasing"
	spent_icon = "riflecasing-spent"

/obj/item/ammo_casing/rifle/bolter
	desc = "A heavy battle rifle casing. This one - Armour-Piercing Discarding Sabot(APDS)"
	caliber = CALIBER_BOLTER
	projectile_type = /obj/item/projectile/bullet/rifle/bolter
	icon_state = "lcasing"
	spent_icon = "lcasing-spent"

/obj/item/ammo_casing/rifle/bolter/explosive
	desc = "A heavy battle rifle casing."
	projectile_type = /obj/item/projectile/bullet/rifle/bolter/explosive

/obj/item/ammo_casing/sniper//emp
	name = "haywire shell casing"
	projectile_type  = /obj/item/projectile/ion/heavy
	matter = list(MATERIAL_STEEL = 1100, MATERIAL_URANIUM = 300)

/obj/item/ammo_casing/rifle/dmr
	desc = "A rifle bullet casing"
	caliber = CALIBER_RIFLE_MILITARY
	projectile_type = /obj/item/projectile/bullet/rifle/marksman/dmr
	icon_state = "riflecasing"
	spent_icon = "riflecasing-spent"

/obj/item/ammo_casing/rifle/dmr/apds
	desc = "A rifle bullet casing"
	caliber = CALIBER_RIFLE_MILITARY
	projectile_type = /obj/item/projectile/bullet/rifle/marksman/dmr/apds
	icon_state = "riflecasing"
	spent_icon = "riflecasing-spent"

/obj/item/ammo_casing/rifle/dmr/haywire
	desc = "A rifle bullet casing. Haywire one."
	caliber = CALIBER_RIFLE_MILITARY
	projectile_type = /obj/item/projectile/ion
	icon_state = "riflecasing"
	spent_icon = "riflecasing-spent"
