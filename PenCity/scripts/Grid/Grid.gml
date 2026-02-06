var dsw = 11
var dsh = 11
global.Grid = ds_grid_create(dsw,dsh)

for(var i = 0; dsw > i; i++){
	for(var j = 0; dsh > j; j++){
		var build = global.EmptyBuilding
		ds_grid_set(global.Grid,i,j,build)
	}
}

function add_building(_x,_y,_building){
	if(ds_grid_get(global.Grid,_x,_y).name == global.EmptyBuilding.name){
		var tempTile = ds_grid_get(global.Grid,_x,_y)
		var tempBuilding = _building
		ds_grid_set(global.Grid,_x,_y,tempBuilding)
		ds_grid_get(global.Grid,_x,_y).pollution = tempTile.pollution
		ds_grid_get(global.Grid,_x,_y).damage = tempTile.damage
	}
	else{
		return;
	}
	
	switch (_building.type){
		case "Factory":
			for(i = -(_building.radius); _building.radius>i;i++){
				for(j = -(_building.radius); _building.radius>j;j++){
					try{
						ds_grid_get(global.Grid,_x+i,_y+j).pollution += _building.damage
					}
					catch(error){
						show_debug_message(error)
					}
				}
			}
			break;
		case "Hospital":
			break;
		case "Residential":
			global.Population += _building.citizens
			break;
		default:
			break;
	}
}

function remove_building(_x,_y){
	switch (ds_grid_get(global.Grid,_x,_y).type){
		case "Factory":
			for(i = -ds_grid_get(global.Grid,_x,_y).radius; ds_grid_get(global.Grid,_x,_y).radius>i;i++){
				for(j = -ds_grid_get(global.Grid,_x,_y).radius; ds_grid_get(global.Grid,_x,_y).radius>j;j++){
					try{
						ds_grid_get(global.Grid,_x+i,_y+j).pollution -= ds_grid_get(global.Grid,_x,_y).damage
					}
					catch(error){
						show_debug_message(error)
					}
				}
			}
			for(i = ds_grid_get(global.Grid,_x,_y).damage; i>0;i--){
				decrease_damage_building(_x,_y)
			}
			break;
		case "Hospital":
			break;
		case "Residential":
			global.Population -= ds_grid_get(global.Grid,_x,_y).citizens
			break;
		default:
			break;
	}
	
	ds_grid_set(global.Grid,_x,_y,global.EmptyBuilding)
}


function decrease_damage_building(_x,_y){
	ds_grid_get(global.Grid,_x,_y).damage = clamp(ds_grid_get(global.Grid,_x,_y).damage-1,0,999)
	switch (ds_grid_get(global.Grid,_x,_y).type){
		case "Factory":
			for(i = ds_grid_get(global.Grid,_x,_y).radius; ds_grid_get(global.Grid,_x,_y).radius>i;i++){
				for(j = ds_grid_get(global.Grid,_x,_y).radius; ds_grid_get(global.Grid,_x,_y).radius>j;j++){
					try{
						ds_grid_get(global.Grid,_x+i,_y+j).pollution = clamp(ds_grid_get(global.Grid,_x+i,_y+j).pollution-1,0,999)
					}
					catch(error){
						show_debug_message(error)
					}
				}
			}
			break;
		case "Hospital":
			break;
		default:
			break;
	}
}

function generateGrid() {
	for (var i = 0; i < ds_grid_width(global.Grid); i++) {
		for (var j = 0; j < ds_grid_height(global.Grid); j++) {
			instance_create_layer(1312 + i*128 - j*128, j*64 + i*64 + room_height/2 - ds_grid_height(global.Grid)*128/2, layer_get_id("Tiles"),obj_Tile,{dsx : i, dsy : j})
		}
	}
}