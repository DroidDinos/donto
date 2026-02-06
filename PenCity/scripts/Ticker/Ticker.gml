/// @description Call once per "month" (e.g. when player presses end-month). Advances time, applies/decays modifiers, updates environment, may set global.currentMission.
function Ticker(){
	// 1) Advance month
	global.Months++;

	// 2) Environment = 100 minus total pollution from the grid (factory buildings)
	calculatePollution();
	var totalPollution = 0;
	if (ds_exists(global.Grid, ds_type_grid)) {
		for (var ii = 0; ii < ds_grid_width(global.Grid); ii++) {
			for (var jj = 0; jj < ds_grid_height(global.Grid); jj++) {
				var cell = ds_grid_get(global.Grid, ii, jj);
				if (variable_struct_exists(cell, "pollution"))
					totalPollution += cell.pollution;
			}
		}
	}
	global.Environment = clamp(100 - totalPollution, 0, 100);

	// 3) Apply temporary modifiers and decay (apply effect this month, then decrease monthsLeft)
	var i = array_length(global.TemporaryModifiers) - 1;
	while (i >= 0) {
		var m = global.TemporaryModifiers[i];
		if (m.what == "profit") {
			global.Balance += m.much;
		} else if (m.what == "population") {
			global.Population = max(0, global.Population + m.much);
		} else if (m.what == "pollution") {
			global.Environment = max(0, global.Environment - m.much);
		}
		global.TemporaryModifiers[i].monthsLeft--;
		if (global.TemporaryModifiers[i].monthsLeft <= 0) {
			array_delete(global.TemporaryModifiers, i, 1);
		}
		i--;
	}
	global.Environment = clamp(global.Environment, 0, 100);

	// 4) Monthly profit from buildings (e.g. factories) and add to balance
	global.Profit = 0;
	if (ds_exists(global.Grid, ds_type_grid)) {
		for (var ii = 0; ii < ds_grid_width(global.Grid); ii++) {
			for (var jj = 0; jj < ds_grid_height(global.Grid); jj++) {
				var cell = ds_grid_get(global.Grid, ii, jj);
				if (variable_struct_exists(cell, "profit") && cell.profit > 0)
					global.Profit += cell.profit;
			}
		}
	}
	global.Balance += global.Profit;

	// 5) Mission generation: at least one event every 8 months, can trigger 2–8 months after last
	if (global.currentMission == undefined || global.currentMission == null) {
		global.sinceLastEvent++;
		var forceEvent = (global.sinceLastEvent >= 8);
		var rollEvent = (global.sinceLastEvent >= 2) && (forceEvent || irandom(3) == 0); // 25% when 2–7, 100% at 8
		if (rollEvent) {
			var pool = MissionPool();
			if (array_length(pool) > 0) {
				global.currentMission = pool[irandom(array_length(pool) - 1)];
				global.sinceLastEvent = 0;
			}
		}
	}
}
