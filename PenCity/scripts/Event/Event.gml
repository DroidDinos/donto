/// @description Consequence: temporary modifier for profit, pollution or population. meddig = duration in months.
function Consequence(_what, _much, _meddig){
	return {
		what : _what,   // "profit" | "population" | "pollution"
		much : _much,
		meddig : _meddig
	};
}

/// @description Choice: answer text, optional cost, optional building type requirement, array of Consequence structs.
function Choice(_answer, _cost, _building, _consequence){
	return {
		answer : _answer,
		cost : _cost,           // number, 0 = free
		requirement : _building, // string building type e.g. "Hospital", or "" for none
		consequence : _consequence // array of Consequence
	};
}

/// @description Event/Mission: type id, title, description, choices (max 3).
function Event(_type, _title, _description, _choices){
	return {
		type : _type,
		title : _title,
		description : _description,
		choices : _choices
	};
}

// ---- Mission pool (add more Event() entries as needed) ----
function MissionPool(){
	return [
		Event("outbreak", "Outbreak", "Residents report illness. The water may be contaminated.",
			[
				Choice("Ignore it.", 0, "", [Consequence("population", -5, 2), Consequence("profit", -3, 2)]),
				Choice("Distribute bottled water. (Cost: 15)", 15, "", [Consequence("profit", -1, 1)]),
				Choice("We have a hospital — use it.", 0, "Hospital", [])
			]
		),
		Event("strike", "Labour strike", "Workers demand better conditions.",
			[
				Choice("Refuse. Production halts.", 0, "", [Consequence("profit", -8, 3)]),
				Choice("Pay a one-time settlement. (Cost: 20)", 20, "", []),
				Choice("Improve facilities. (Cost: 25, requires Hospital)", 25, "Hospital", [Consequence("profit", 2, 4)])
			]
		),
		Event("pollution_fine", "Pollution fine", "The council fines the city for excess pollution.",
			[
				Choice("Pay the fine. (Cost: 30)", 30, "", []),
				Choice("Dispute it. Relations sour.", 0, "", [Consequence("pollution", 5, 2), Consequence("profit", -2, 2)]),
				Choice("Show our green initiatives. (Requires Hospital)", 0, "Hospital", [Consequence("pollution", -3, 2)])
			]
		),
		Event("refugees", "Refugees", "Refugees seek shelter.",
			[
				Choice("Turn them away.", 0, "", [Consequence("population", -2, 1)]),
				Choice("Accept them. (Cost: 10)", 10, "", [Consequence("population", 8, 1), Consequence("profit", -1, 2)]),
				Choice("Accept and provide healthcare. (Requires Hospital, Cost: 15)", 15, "Hospital", [Consequence("population", 12, 1)])
			]
		),
		Event("fire", "Factory fire", "A factory caught fire.",
			[
				Choice("Let it burn. Rebuild later.", 0, "", [Consequence("profit", -10, 2), Consequence("pollution", 3, 1)]),
				Choice("Pay for firefighting. (Cost: 20)", 20, "", [Consequence("profit", -2, 1)]),
				Choice("Use city fire service. (Requires Fire station)", 0, "Fire", [])
			]
		)
	];
}

/// @description Returns whether the player can take this choice (afford cost + has building requirement).
function MissionCanTakeChoice(_mission, _choiceIndex){
	if (_mission == undefined || _choiceIndex < 0 || _choiceIndex >= array_length(_mission.choices))
		return false;
	var c = _mission.choices[_choiceIndex];
	if (c.cost > 0 && global.Balance < c.cost)
		return false;
	if (c.requirement != "" && !HasBuildingType(c.requirement))
		return false;
	return true;
}

/// @description Applies the chosen option: deducts cost, adds consequences to TemporaryModifiers, clears currentMission. Call after player picks a choice.
function MissionApplyChoice(_mission, _choiceIndex){
	if (_mission == undefined || _choiceIndex < 0 || _choiceIndex >= array_length(_mission.choices))
		return false;
	var c = _mission.choices[_choiceIndex];
	if (!MissionCanTakeChoice(_mission, _choiceIndex))
		return false;
	if (c.cost > 0)
		global.Balance -= c.cost;
	var i = 0;
	var cons = c.consequence;
	for (i = 0; i < array_length(cons); i++){
		array_push(global.TemporaryModifiers, {
			what : cons[i].what,
			much : cons[i].much,
			monthsLeft : cons[i].meddig
		});
	}
	global.currentMission = undefined;
	return true;
}

/// @description Get list of choice indices the player can take for this mission.
function MissionAvailableChoices(_mission){
	var out = [];
	for (var i = 0; i < array_length(_mission.choices); i++){
		if (MissionCanTakeChoice(_mission, i))
			array_push(out, i);
	}
	return out;
}

/// @description Legacy: list choices (returns array of choice indices that are valid).
function whatChoices(_event){
	return MissionAvailableChoices(_event);
}
