var dsw = 11
var dsh = 11
global.Grid = ds_grid_create(dsw,dsh)

for(var i = 0; dsw > i; i++){
	for(var j = 0; dsh > j; j++){
		var build = global.EmptyBuilding
		ds_grid_set(global.Grid,i,j,build)
	}
}

function calculatePollution() {
    var grid_w = ds_grid_width(global.Grid);
    var grid_h = ds_grid_height(global.Grid);
	
	for(var i = 0; i < grid_w; i++){
		for(var j = 0; j < grid_h; j++){
			var tempTile = ds_grid_get(global.Grid,i,j)
			tempTile.pollution = 0;
			ds_grid_set(global.Grid,i,j,tempTile)
		}
	}
    
    for (var i = 0; i < grid_w; i++) {
        for (var j = 0; j < grid_h; j++) {
            var source_tile = ds_grid_get(global.Grid, i, j);
			//source_tile
            
            if (source_tile.type == "Factory") {
                var r = source_tile.radius;
                var r_sq = r * r; // squared distance for integer grid (avoids sqrt)
                for (var i2 = -r; i2 <= r; i2++) {
                    for (var j2 = -r; j2 <= r; j2++) {
                        // Only cells within circular radius (including factory cell)
                        if (i2 * i2 + j2 * j2 <= r_sq) {
                            var target_x = i + i2;
                            var target_y = j + j2;
                            if (target_x >= 0 && target_x < grid_w && target_y >= 0 && target_y < grid_h) {
                                var tempTile = ds_grid_get(global.Grid, target_x, target_y);
                                tempTile.pollution += source_tile.damage;
                                ds_grid_set(global.Grid, target_x, target_y, tempTile);
                            }
                        }
                    }
                }
            }
            else if (source_tile.type == "Hospital") {
                var r = source_tile.radius;
                var r_sq = r * r;
                for (var i2 = -r; i2 <= r; i2++) {
                    for (var j2 = -r; j2 <= r; j2++) {
                        if (i2 * i2 + j2 * j2 <= r_sq) {
                            var target_x = i + i2;
                            var target_y = j + j2;
                            if (target_x >= 0 && target_x < grid_w && target_y >= 0 && target_y < grid_h) {
                                var tempTile = ds_grid_get(global.Grid, target_x, target_y);
                                tempTile.pollution -= source_tile.damage;
                                if (tempTile.pollution < 0) tempTile.pollution = 0;
                                ds_grid_set(global.Grid, target_x, target_y, tempTile);
                            }
                        }
                    }
                }
            }
            else {                
                ds_grid_set(global.Grid, i, j, source_tile);
            }
        }
    }
}

function add_building(_x,_y,_building){
	if(ds_grid_get(global.Grid,_x,_y).name == global.EmptyBuilding.name){
		var tempTile = ds_grid_get(global.Grid,_x,_y)
		var tempBuilding = _building
		ds_grid_set(global.Grid,_x,_y,tempBuilding)
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