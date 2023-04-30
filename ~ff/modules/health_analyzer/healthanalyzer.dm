/obj/item/healthanalyzer/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HealthAnalyzer", name)
		ui.open()

/datum/ui_state/health_analyzer_state/can_use_topic(src_object, mob/user)
	var/obj/item/healthanalyzer/anal = src_object
	if (!user.is_holding(anal))
		return UI_CLOSE
	var/dist = get_dist(anal.patient, user)
	if (dist > 1)
		return UI_CLOSE
	return UI_INTERACTIVE


/obj/item/healthanalyzer/ui_state(mob/user)
	var/datum/ui_state/health_analyzer_state/state = new()
	return state

/obj/item/healthanalyzer/ui_data(mob/user)
	var/list/data = list(
		"name" = patient.name,
		"health" = round (patient.health / patient.maxHealth, 0.01) * 100,

		"bruteLoss" = CEILING(patient.getBruteLoss(), 1),
		"fireLoss" = CEILING(patient.getFireLoss(), 1),
		"toxLoss" = CEILING(patient.getToxLoss(), 1),
		"oxyLoss" = CEILING(patient.getOxyLoss(), 1),
		"tod" = patient.tod
	)
	switch(patient.stat)
		if(CONSCIOUS)
			data["stat"] = "Conscious"
			data["statstate"] = "good"
		if(SOFT_CRIT)
			data["stat"] = "Conscious"
			data["statstate"] = "average"
		if(UNCONSCIOUS, HARD_CRIT)
			data["stat"] = "Unconscious"
			data["statstate"] = "average"
		if(DEAD)
			data["stat"] = "Dead"
			data["statstate"] = "bad"

	//Fake coma, fake death
	if(HAS_TRAIT(patient, TRAIT_FAKEDEATH) && !advanced)
		data["stat"] = "Dead"
		data["statstate"] = "bad"
		data["oxyLoss"] = max(rand(1, 40), data["oxyLoss"], (300 - (data["bruteLoss"] + data["fireLoss"] + data["toxLoss"]))) // Random oxygen loss

	var/cardiac_message
	var/husked_message

	//Hearth attack
	if(ishuman(patient))
		var/mob/living/carbon/human/humantarget = patient
		if(humantarget.undergoing_cardiac_arrest() && humantarget.stat != DEAD)
			cardiac_message = "Subject suffering from heart attack: Apply defibrillation or other electric shock immediately!"
	data["cardiac"] = cardiac_message

	//Husking
	if(HAS_TRAIT(patient, TRAIT_HUSK))
		if(advanced)
			if(HAS_TRAIT_FROM(patient, TRAIT_HUSK, BURN))
				husked_message = "Subject has been husked by severe burns."
			else if (HAS_TRAIT_FROM(patient, TRAIT_HUSK, CHANGELING_DRAIN))
				husked_message = "Subject has been husked by dessication."
			else
				husked_message = "Subject has been husked by mysterious causes."

		else
			husked_message = "Subject has been husked."
	data["husk"] = husked_message

	//Death
	data["tdelta"] = null
	if(patient.tod && (patient.stat == DEAD || ((HAS_TRAIT(patient, TRAIT_FAKEDEATH)) && !advanced)))
		var/tdelta = round(world.time - patient.timeofdeath)
		data["tdelta"] = DisplayTimeText(tdelta)

	//Fatigue, cloneloss, brainmiss
	var/fatigue_message
	var/clone_dmg_message
	var/brain_lost

	if(patient.getStaminaLoss())
		if(advanced)
			fatigue_message = "Fatigue level: [patient.getStaminaLoss()]%."
		else
			fatigue_message = "Subject appears to be suffering from fatigue."
	if (patient.getCloneLoss())
		if(advanced)
			clone_dmg_message = "Cellular damage level: [patient.getCloneLoss()]."
		else
			clone_dmg_message = "Subject appears to have [patient.getCloneLoss() > 30 ? "severe" : "minor"] cellular damage."
	if (!patient.get_organ_slot(ORGAN_SLOT_BRAIN)) // kept exclusively for soul purposes
		brain_lost = "Subject lacks a brain."

	data["stamLoss"] = fatigue_message
	data["cloneLoss"] = clone_dmg_message
	data["brainLoss"] = brain_lost

	// Body part damage report
	var/list/limb_data_lists = list()
	if(iscarbon(patient))
		var/mob/living/carbon/carbontarget = patient
		var/list/damaged = carbontarget.get_damaged_bodyparts(1,1)
		for(var/obj/item/bodypart/limb in damaged)
			var/list/current_limb = list(
				"bruteLoss" = CEILING(limb.brute_dam, 1),
				"fireLoss" = CEILING(limb.burn_dam, 1),
				"maxDamage" = limb.max_damage,
				"name" = limb.bodytype & BODYTYPE_ROBOTIC ? capitalize(limb.name) : capitalize(limb.plaintext_zone)
			)
			limb_data_lists["[limb.name]"] = current_limb

	data["limb_data_lists"] = limb_data_lists
	data["limbs_damaged"] = length(limb_data_lists)

	// Organ damage, missing organs
	var/list/damaged_organs = list()
	var/list/missing_organs = list()

	if (ishuman(patient))
		var/mob/living/carbon/human/humantarget = patient
		for(var/obj/item/organ/organ as anything in humantarget.organs)
			var/status = organ.get_status_text()
			if (status == "")
				continue
			var/list/organ_data = list(
				"name" = organ.name,
				"status" = status
			)
			if (advanced)
				organ_data["damage"] = CEILING(organ.damage, 1)
			else
				organ_data["damage"] = null

			damaged_organs += list(organ_data)

		var/datum/species/the_dudes_species = humantarget.dna.species
		if(!humantarget.get_organ_slot(ORGAN_SLOT_BRAIN))
			missing_organs += "brain"
		if(!HAS_TRAIT(humantarget, TRAIT_NOBLOOD) && !humantarget.get_organ_slot(ORGAN_SLOT_HEART))
			missing_organs += "heart"
		if(!(TRAIT_NOBREATH in the_dudes_species.inherent_traits) && !humantarget.get_organ_slot(ORGAN_SLOT_LUNGS))
			missing_organs += "lungs"
		if(!(TRAIT_NOMETABOLISM in the_dudes_species.inherent_traits) && !humantarget.get_organ_slot(ORGAN_SLOT_LIVER))
			missing_organs += "liver"
		if(the_dudes_species.mutantstomach && !humantarget.get_organ_slot(ORGAN_SLOT_STOMACH))
			missing_organs += "stomach"
		if(the_dudes_species.mutanttongue && !humantarget.get_organ_slot(ORGAN_SLOT_TONGUE))
			missing_organs += "tongue"
		if(!humantarget.get_organ_slot(ORGAN_SLOT_EARS))
			missing_organs += "ears"
		if(!humantarget.get_organ_slot(ORGAN_SLOT_EYES))
			missing_organs += "eyes"

	data["organs_damaged"] = damaged_organs
	data["organs_missing"] = missing_organs

	//Wounds
	var/list/patient_wounded_parts = list()
	if(iscarbon(patient))
		var/mob/living/carbon/carbontarget = patient
		var/list/wounded_parts = carbontarget.get_wounded_bodyparts()
		for(var/i in wounded_parts)
			var/obj/item/bodypart/wounded_part = i
			var/list/wounded_part_data = list();
			wounded_part_data["name"] = wounded_part.name
			var/list/wounds = list()
			// render_list += "<span class='alert ml-1'><b>Physical trauma[LAZYLEN(wounded_part.wounds) > 1 ? "s" : ""] detected in [wounded_part.name]</b>"
			for(var/k in wounded_part.wounds)
				var/datum/wound/W = k
				var/list/wound_data = list(
					"name" = W.name,
					"severity" = W.severity_text(),
					"treat" = W.treat_text
				)
				wounds += list(wound_data)
				//render_list += "<div class='ml-2'>[W.name] ([W.severity_text()])\nRecommended treatment: [W.treat_text]</div>" // less lines than in woundscan() so we don't overload people trying to get basic med info
			wounded_part_data["wounds"] = wounds
			patient_wounded_parts += list(wounded_part_data)
	data["wounds"] = patient_wounded_parts
	data["irradiated"] = HAS_TRAIT(patient, TRAIT_IRRADIATED)
	data["protoviral"] = patient.GetComponent(/datum/component/mutant_infection)
	// Blood data
	var/list/blood_data = list()
	if(patient.has_dna())
		var/mob/living/carbon/carbontarget = patient
		var/blood_id = carbontarget.get_blood_id()
		if(blood_id)
			if(ishuman(carbontarget))
				var/mob/living/carbon/human/humantarget = carbontarget
				blood_data["bleeding"] = humantarget.is_bleeding()
			else
				blood_data["bleeding"] = FALSE
			var/blood_type = carbontarget.dna.blood_type
			if(blood_id != /datum/reagent/blood) // special blood substance
				var/datum/reagent/R = GLOB.chemical_reagents_list[blood_id]
				blood_type = R ? R.name : blood_id
			blood_data["blood_volume"] = carbontarget.blood_volume
			blood_data["blood_type"] = blood_type
	data["blood"] = blood_data

	//Body info
	var/list/body_data = list()
	if(ishuman(patient))
		var/mob/living/carbon/human/humantarget = patient
		if(advanced && humantarget.has_dna())
			//render_list += "<span class='info ml-1'>Genetic Stability: [humantarget.dna.stability]%.</span>\n"
			body_data["stability"] = humantarget.dna.stability
		else
			body_data["stability"] = null

		// Species and body temperature
		var/datum/species/targetspecies = humantarget.dna.species
		var/mutant = humantarget.dna.check_mutation(/datum/mutation/human/hulk) \
			|| targetspecies.mutantlungs != initial(targetspecies.mutantlungs) \
			|| targetspecies.mutantbrain != initial(targetspecies.mutantbrain) \
			|| targetspecies.mutantheart != initial(targetspecies.mutantheart) \
			|| targetspecies.mutanteyes != initial(targetspecies.mutanteyes) \
			|| targetspecies.mutantears != initial(targetspecies.mutantears) \
			|| targetspecies.mutanttongue != initial(targetspecies.mutanttongue) \
			|| targetspecies.mutantliver != initial(targetspecies.mutantliver) \
			|| targetspecies.mutantstomach != initial(targetspecies.mutantstomach) \
			|| targetspecies.mutantappendix != initial(targetspecies.mutantappendix) \
			|| istype(humantarget.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS), /obj/item/organ/external/wings/functional)

		//render_list += "<span class='info ml-1'>Species: [targetspecies.name][mutant ? "-derived mutant" : ""]</span>\n"
		//render_list += "<span class='info ml-1'>Core temperature: [round(humantarget.coretemperature-T0C,0.1)] &deg;C ([round(humantarget.coretemperature*1.8-459.67,0.1)] &deg;F)</span>\n"
		body_data["species"] = targetspecies.name
		body_data["mutant"] = mutant
		body_data["core_temp"] = humantarget.coretemperature
		if (patient.bodytemperature > targetspecies.bodytemp_heat_damage_limit)
			body_data["temp_cond"] = 1
		else if (patient.bodytemperature < targetspecies.bodytemp_cold_damage_limit)
			body_data["temp_cond"] = -1
		else
			body_data["temp_cond"] = 0
	else
		body_data["stability"] = null
		body_data["species"] = null
		body_data["mutant"] = null
		body_data["core_temp"] = null
		body_data["temp_cond"] = 0
	body_data["body_temp"] = patient.bodytemperature
	data["body_data"] = body_data

	//Reagents

	var/list/blood_reagents = list()
	var list/stomach_reagents = list()
	if (patient.reagents)
		if(patient.reagents.reagent_list.len)
			for(var/r in patient.reagents.reagent_list)
				var/datum/reagent/reagent = r
				if(reagent.chemical_flags & REAGENT_INVISIBLE) //Don't show hidden chems on scanners
					continue
				var/list/reagent_data = list()
				reagent_data["volume"] = round(reagent.volume, 0.001)
				reagent_data["name"] = reagent.name
				reagent_data["od"] = reagent.overdosed
				blood_reagents += list(reagent_data)
	data["blood_reagents"] = blood_reagents
	data["stomach_reagents"] = stomach_reagents
	return data

