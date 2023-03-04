/decl/environment_data/mantid
	important_gasses = list(
		GAS_OXYGEN =         TRUE,
		GAS_METHYL_BROMIDE = TRUE,
		GAS_CO2 =			 TRUE,
		GAS_NITROGEN =		 TRUE,
		GAS_METHANE =        TRUE
	)
	dangerous_gasses = list(
		GAS_CO2 =	   TRUE,
		GAS_NITROGEN = TRUE,
		GAS_METHANE =  TRUE
	)

MANTIDIFY(/obj/machinery/alarm, "mantid thermostat", "atmospherics")

/obj/machinery/alarm/ascent
	req_access = list(access_ascent)
	construct_state = null
	environment_type = /decl/environment_data/mantid

/obj/machinery/alarm/ascent/Initialize()
	. = ..()
	TLV[GAS_METHYL_BROMIDE] = list(16, 19, 135, 140)
	TLV[GAS_NITROGEN] = list(-1.0, -1.0, 5, 10)
	TLV[GAS_METHANE] = list(-1.0, -1.0, 5, 10)

/obj/item/inflatable_dispenser/ascents
	name = "soft atmosphere barriers dispenser"
	color = COLOR_ASCENT_PURPLE

/obj/structure/adherent_bath/ascent
	color = "#a33fbf"

/obj/structure/adherent_bath/ascent/return_air()
	var/datum/gas_mixture/ascentus = new(CELL_VOLUME, 310.15)
	ascentus.adjust_multi(GAS_METHYL_BROMIDE, MOLES_CELLSTANDARD * 0.5, GAS_OXYGEN, MOLES_CELLSTANDARD * 0.5)
	return ascentus