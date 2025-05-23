/obj/item/stock_parts/power_store/cell
	icon = 'modular_nova/modules/aesthetics/cells/icons/cell.dmi'
	/// The charge overlay icon file for the cell charge lights
	var/charging_icon = "cell_in"
	connector_type = null

/obj/item/stock_parts/power_store/cell/high
	charging_icon = "hcell_in"

/obj/item/stock_parts/power_store/cell/super
	charging_icon = "scell_in"

/obj/item/stock_parts/power_store/cell/hyper
	charging_icon = "hpcell_in"

/obj/item/stock_parts/power_store/cell/bluespace
	charging_icon = "bscell_in"

/obj/item/stock_parts/power_store/cell/infinite
	charging_icon = "icell_in"

/obj/item/stock_parts/power_store/cell/potato
	charging_icon = "potato_in"
	charge_light_type = "old"

/obj/item/stock_parts/power_store/cell/emproof/slime
	charging_icon = "slime_in"

/obj/item/stock_parts/power_store/cell/high/slime_hypercharged
	charging_icon = "slime_in"

/obj/item/stock_parts/power_store/cell/lead
	charging_icon = "lead_in"

/obj/item/stock_parts/power_store/cell/update_overlays()
	. = ..()
	if(grown_battery)
		. += mutable_appearance('icons/obj/machines/cell_charger.dmi', "grown_wires")
	if((charge < 0.01) || !charge_light_type)
		return
	var/icon_link
	if(!grown_battery)
		icon_link = 'modular_nova/modules/aesthetics/cells/icons/cell.dmi'
	else
		icon_link = 'icons/obj/machines/cell_charger.dmi'
	. += mutable_appearance(icon_link, "cell-[charge_light_type]-o[(percent() >= 99.5) ? 2 : 1]")

/obj/machinery/cell_charger
	icon = 'modular_nova/modules/aesthetics/cells/icons/cell.dmi'

/obj/machinery/cell_charger/update_overlays()
	. = ..()

	if(!charging)
		return

	if(!(machine_stat & (BROKEN|NOPOWER)))
		var/newlevel = round(charging.percent() * 4 / 100)
		. += "ccharger-o[newlevel]"
	if(!charging.charging_icon)
		. += image(charging.icon, charging.icon_state)
	else
		.+= image('modular_nova/modules/aesthetics/cells/icons/cell.dmi', charging.charging_icon)\
