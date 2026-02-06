var dsw = 11
var dsh = 11
global.Grid = ds_grid_create(dsw,dsh)

for(var i = 0; dsw > i; i++){
	for(var j = 0; dsh > j; j++){
		var build = global.EmptyBuilding
		ds_grid_set(global.Grid,i,j,build)
	}
}

function calculatePollution(){
	for(i = 0; ds_grid_width(global.Grid) > i;i++){
		for (j = 0; ds_grid_height(global.Grid) > j; j++){
			if(ds_grid_get(global.Grid,i,j).type == "Factory"){
				for(i2 = -ds_grid_get(global.Grid,i,j).radius ; ds_grid_get(global.Grid,i,j).radius >i2;i2++){
					for(j2 = -ds_grid_get(global.Grid,i,j).radius ; ds_grid_get(global.Grid,i,j).radius >j2;j2++){
						try{
							var tempTile = ds_grid_get(global.Grid,i+i2,j+j2);
							tempTile.pollution += ds_grid_get(global.Grid,i,j).damage
							ds_grid_set(global.Grid,i,j,tempTile)
						}
						catch(error){
						
						}
					}
				}
			}
			else if(ds_grid_get(global.Grid,i,j).type == "Hospital"){
				for(i2 = -ds_grid_get(global.Grid,i,j).radius ; ds_grid_get(global.Grid,i,j).radius >i2;i2++){
					for(j2 = -ds_grid_get(global.Grid,i,j).radius ; ds_grid_get(global.Grid,i,j).radius >j2;j2++){
						try{
							var tempTile = ds_grid_get(global.Grid,i+i2,j+j2);
							tempTile.pollution -= ds_grid_get(global.Grid,i,j).damage
							ds_grid_set(global.Grid,i,j,tempTile)
						}
						catch(error){
						
						}
					}
				}
			}
			else{
				var tempTile = ds_grid_get(global.Grid,i,j);
				tempTile.pollution = 0;
				ds_grid_set(global.Grid,i,j,tempTile)
			}
		}
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
	calculatePollution()
}

function remove_building(_x,_y){
	ds_grid_set(global.Grid,_x,_y,global.EmptyBuilding)
	calculatePollution()
}


function decrease_damage_building(_x,_y){
	var tempTile = ds_grid_get(global.Grid,_x,_y)
	tempTile.damage = clamp(ds_grid_get(global.Grid,_x,_y).damage-1,0,999) 
	ds_grid_set(global.Grid,_x,_y,tempTile)
	calculatePollution()
}

function generateGrid() {
	for (var i = 0; i < ds_grid_width(global.Grid); i++) {
		for (var j = 0; j < ds_grid_height(global.Grid); j++) {
			instance_create_layer(1312 + i*128 - j*128, j*64 + i*64 + room_height/2 - ds_grid_height(global.Grid)*128/2, layer_get_id("Tiles"),obj_Tile,{dsx : i, dsy : j})
		}
	}
}