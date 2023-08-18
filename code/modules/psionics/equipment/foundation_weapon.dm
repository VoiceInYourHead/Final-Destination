/obj/item/gun/projectile/revolver/foundation
	name = "\improper Institute revolver"
	icon = 'icons/obj/guns/foundation.dmi'
	icon_state = "foundation"
	desc = "The CIS 'Troubleshooter', a compact plastic-composite weapon designed for concealed carry by Cuchulain's Institute field agents. Smells faintly of copper."
	ammo_type = /obj/item/ammo_casing/pistol/magnum/nullglass

/obj/item/gun/projectile/revolver/foundation/disrupts_psionics()
	return FALSE

/obj/item/storage/briefcase/foundation
	name = "\improper Institute briefcase"
	desc = "A handsome black leather briefcase embossed with a stylized radio telescope."
	icon_state = "fbriefcase"
	item_state = "fbriefcase"

/obj/item/storage/briefcase/foundation/disrupts_psionics()
	return FALSE

/obj/item/storage/briefcase/foundation/New()
	..()
	new /obj/item/ammo_magazine/speedloader/magnum/nullglass(src)
	new /obj/item/gun/projectile/revolver/foundation(src)
	make_exact_fit()
