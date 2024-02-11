/obj/item/clothing/under/rank/security/officer/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Black-Sec" = list(
			RESKIN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_icon.dmi',
			RESKIN_ICON_STATE = "BS_suit",
			RESKIN_WORN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_worn.dmi',
			RESKIN_WORN_ICON_STATE = "BS_suit"
		),
	)

/obj/item/clothing/under/rank/security/officer/post_reskin(mob/our_mob)
	. = ..()
	if (current_skin == "Black-Sec")
		worn_icon_digi = 'tff_modular/modules/blacksec/icons/blacksec_worn_anthro.dmi'

/obj/item/clothing/head/helmet/sec/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Black-Sec" = list(
			RESKIN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_icon.dmi',
			RESKIN_ICON_STATE = "BS_helmet",
			RESKIN_WORN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_worn.dmi',
			RESKIN_WORN_ICON_STATE = "BS_helmet"
		),
	)

/obj/item/clothing/head/helmet/sec/post_reskin(mob/our_mob)
	. = ..()
	if (current_skin == "Black-Sec")
		worn_icon_digi = 'tff_modular/modules/blacksec/icons/blacksec_worn_anthro.dmi'

/obj/item/storage/belt/security/Initialize(mapload)
	. = ..()
	if(!unique_reskin)
		return
	unique_reskin += list(
		"Black-Sec" = list(
			RESKIN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_icon.dmi',
			RESKIN_ICON_STATE = "BS_belt",
			RESKIN_WORN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_worn.dmi',
			RESKIN_WORN_ICON_STATE = "BS_belt"
		),
	)

/obj/item/storage/belt/security/webbing/peacekeeper
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black-Sec" = list(
			RESKIN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_icon.dmi',
			RESKIN_ICON_STATE = "BS_webbing",
			RESKIN_WORN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_worn.dmi',
			RESKIN_WORN_ICON_STATE = "BS_webbing"
		),
		"Blue variant" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/belts.dmi',
			RESKIN_ICON_STATE = "peacekeeper_webbing",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/belt.dmi',
			RESKIN_WORN_ICON_STATE = "peacekeeper_webbing"
		),
	)

/obj/item/storage/backpack/duffelbag/sec/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Black-Sec" = list(
			RESKIN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_icon.dmi',
			RESKIN_ICON_STATE = "BS_duffel",
			RESKIN_WORN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_worn.dmi',
			RESKIN_WORN_ICON_STATE = "BS_duffel"
		),
	)

//Ящер вроде прописал, всё что нужно для сачеля в его полях, так что закинем сюды..
/obj/item/storage/backpack/satchel/sec/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Black-Sec" = list(
			RESKIN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_icon.dmi',
			RESKIN_ICON_STATE = "BS_satchel",
			RESKIN_WORN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_worn.dmi',
			RESKIN_WORN_ICON_STATE = "BS_satchel"
		),
	)

//Для мессенджера рескины были..
/obj/item/storage/backpack/messenger/sec/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Black-Sec" = list(
			RESKIN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_icon.dmi',
			RESKIN_ICON_STATE = "BS_messenger",
			RESKIN_WORN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_worn.dmi',
			RESKIN_WORN_ICON_STATE = "BS_messenger"
		),
	)

/obj/item/storage/backpack/security/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Black-Sec" = list(
			RESKIN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_icon.dmi',
			RESKIN_ICON_STATE = "BS_backpack",
			RESKIN_WORN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_worn.dmi',
			RESKIN_WORN_ICON_STATE = "BS_backpack"
		),
	)

/obj/item/clothing/suit/armor/vest/alt/sec/Initialize(mapload)
	. = ..()
	unique_reskin += list(
		"Black-Sec" = list(
			RESKIN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_icon.dmi',
			RESKIN_ICON_STATE = "BS_armor",
			RESKIN_WORN_ICON = 'tff_modular/modules/blacksec/icons/blacksec_worn.dmi',
			RESKIN_WORN_ICON_STATE = "BS_armor"
		),
	)

/obj/item/clothing/suit/armor/vest/alt/sec/post_reskin(mob/our_mob)
	. = ..()
	if (current_skin == "Black-Sec")
		worn_icon_digi = 'tff_modular/modules/blacksec/icons/blacksec_worn_anthro.dmi'
