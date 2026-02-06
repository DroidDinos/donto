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
	var modifiers = []
	
	array_foreach(global.TemporaryModifiers, function(_value,_index){
		if(_value.what == "damage"){
			array_push(modifiers, _value);
		}
	})
	
	
	
	// Reset pollution: give each cell its own struct copy so they don't share one (which made all cells show same pollution)
	for(var i = 0; i < grid_w; i++){
		for(var j = 0; j < grid_h; j++){
			var tempTile = ds_grid_get(global.Grid,i,j);
			var keys = variable_struct_get_names(tempTile);
			var copy = {};
			for (var idx = 0; idx < array_length(keys); idx++) {
				var k = keys[idx];
				copy[$ k] = tempTile[$ k];
			}
			copy.pollution = 0;
			ds_grid_set(global.Grid,i,j,copy);
		}
	}
    
    for (var i = 0; i < grid_w; i++) {
        for (var j = 0; j < grid_h; j++) {
            var source_tile = ds_grid_get(global.Grid, i, j);
			//source_tile
            
            if (source_tile.type == "Factory") {
                for (var i2 = -source_tile.radius; i2 <= source_tile.radius; i2++) {
                    for (var j2 = -source_tile.radius; j2 <= source_tile.radius; j2++) {
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
            else if (source_tile.type == "Hospital") {
                for (var i2 = -source_tile.radius; i2 <= source_tile.radius; i2++) {
                    for (var j2 = -source_tile.radius; j2 <= source_tile.radius; j2++) {
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

/// @description Returns true if the grid has at least one building of the given type (e.g. "Hospital", "Factory").
function HasBuildingType(_type){
	if (!ds_exists(global.Grid, ds_type_grid)) return false;
	var gw = ds_grid_width(global.Grid);
	var gh = ds_grid_height(global.Grid);
	for (var i = 0; i < gw; i++){
		for (var j = 0; j < gh; j++){
			var tile = ds_grid_get(global.Grid, i, j);
			if (tile.type == _type) return true;
		}
	}
	return false;
}

function generateGrid() {
	for (var i = 0; i < ds_grid_width(global.Grid); i++) {
		for (var j = 0; j < ds_grid_height(global.Grid); j++) {
			instance_create_layer(1312 + i*128 - j*128, j*64 + i*64 + room_height/2 - ds_grid_height(global.Grid)*128/2, layer_get_id("Tiles"),obj_Tile,{dsx : i, dsy : j})
		}
	}
}