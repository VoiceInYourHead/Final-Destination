/obj/machinery/telecomms/hub/map_preset/aegis
	preset_name = "Aegis"

/obj/machinery/telecomms/receiver/map_preset/aegis_alt
	id = "Aegis Receiver"
	network = "tcomm_aegis"
	freq_listening = list(PUB_FREQ, HAIL_FREQ, MERC_FREQ, BUREAU_FREQ)
	autolinkers = list("aegis_receiver")

/obj/machinery/telecomms/bus/map_preset/aegis_alt
	id = "Aegis Bus"
	network = "tcomm_aegis"
	freq_listening = list(PUB_FREQ, HAIL_FREQ, MERC_FREQ, BUREAU_FREQ)
	autolinkers = list("aegis_processor", "aegis_server")

/obj/machinery/telecomms/processor/map_preset/aegis
	preset_name = "Aegis"

/obj/machinery/telecomms/server/map_preset/aegis_alt
	network = "tcomm_aegis"
	id = "Aegis Server"
	freq_listening = list(PUB_FREQ, HAIL_FREQ, MERC_FREQ, BUREAU_FREQ) // All shit in one place
	channel_tags = list(
		list(PUB_FREQ, "Common", COMMS_COLOR_COMMON),
		list(MERC_FREQ, "Mercenaries", COMMS_COLOR_SECURITY),
		list(BUREAU_FREQ, "Bureau 12", COMMS_COLOR_ENTERTAIN),
		list(HAIL_FREQ, "Hailing", COMMS_COLOR_HAILING)
	)
	autolinkers = list("aegis_server")

/obj/machinery/telecomms/broadcaster/map_preset/aegis
	preset_name = "Aegis"

/obj/item/device/radio/map_preset/aegis
	name = "B-CV-12 Aegis shortwave radio"
	preset_name = "Aegis"

/obj/item/device/radio/intercom/map_preset/aegis
	name = "B-CV-12 Aegis Intercom"
	preset_name = "Aegis"

/obj/item/device/encryptionkey/map_preset/aegis_alt
	name = "B-CV-12 Aegis encryption key"
	channels = list("Mercenaries" = 1, "Hailing" = 1)

/obj/item/device/radio/headset/map_preset/aegis_alt
	name = "aegis radio headset"
	ks1type = /obj/item/device/encryptionkey/map_preset/aegis_alt
	use_common = 1

/obj/item/device/radio/headset/map_preset/aaaa_head
	name = "bureua 12 radio headset"
	ks1type = /obj/item/device/encryptionkey/map_preset/aaaa_head
	use_common = 1

/obj/item/device/encryptionkey/map_preset/aaaa_head
	channels = list("Bureau 12" = 1, "Hailing" = 1)

/obj/item/device/radio/headset/map_preset/aaaa_head/leader
	name = "bureua 12 radio headset"
	ks1type = /obj/item/device/encryptionkey/map_preset/aaaa_head
	ks2type = /obj/item/device/encryptionkey/map_preset/aegis_alt
	use_common = 1

/obj/item/device/radio/map_preset/aaaa_head
	preset_name = "Bureau 12"
