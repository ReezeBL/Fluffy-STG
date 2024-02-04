/datum/mod_theme/security/New()
	. = ..()
	skins += list(
		"blacksec" = list(
			MOD_ICON_OVERRIDE = 'tff_modular/modules/blacksec/icons/blacksec_mod_icon.dmi',
			MOD_WORN_ICON_OVERRIDE = 'tff_modular/modules/blacksec/icons/blacksec_mod_worn.dmi',
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/obj/item/mod/control/pre_equipped/security/set_mod_skin(new_skin)
	. = ..()
	if(new_skin == "blacksec")
		helmet.worn_icon_muzzled = 'tff_modular/modules/blacksec/icons/blacksec_mod_worn_anthro.dmi'
		chestplate.worn_icon_digi = 'tff_modular/modules/blacksec/icons/blacksec_mod_worn_anthro.dmi'
		boots.worn_icon_digi = 'tff_modular/modules/blacksec/icons/blacksec_mod_worn_anthro.dmi'
