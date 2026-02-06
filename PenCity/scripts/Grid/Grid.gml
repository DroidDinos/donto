global.Grid = []

for(i = 0; 30>i; i++){
	var sor = []
	for(j = 0; 30 >j; j++){
		var oszlop = global.EmptyBuilding
		array_push(sor,oszlop)
	}
	array_push(global.Grid, sor)
}

function add_building(_x,_y,_building){
	if(global.Grid[_x][_y].name == global.EmptyBuilding.name){
		global.Grid[_x][_y].name = _building.name;
		global.Grid[_x][_y].cost = _building.cost;
		global.Grid[_x][_y].type = _building.type;
		global.Grid[_x][_y].radius = _building.radius;
		global.Grid[_x][_y].damage = _building.damage;
	}
	else{
		return;
	}
	
	switch (_building.type){
		case "Factory":
			for(i = _building.radius; _building.radius>i;i++){
				for(j = _building.radius; _building.radius>j;j++){
					global.Grid[_x+i][_y+j].pollution += _building.damage
				}
			}
			break;
		case "Hospital":
			break;
		default:
			break;
	}
}

function decrease_damage_building(_x,_y){
	global.Grid[_x][_y].damage = clamp(global.Grid[_x][_y].damage-1,0,999)
	switch (global.Grid[_x][_y].type){
		case "Factory":
			for(i = global.Grid[_x][_y].radius; global.Grid[_x][_y].radius>i;i++){
				for(j = global.Grid[_x][_y].radius; global.Grid[_x][_y].radius>j;j++){
					global.Grid[_x+i][_y+j].pollution += global.Grid[_x][_y].damage
				}
			}
			break;
		case "Hospital":
			break;
		default:
			break;
	}
}