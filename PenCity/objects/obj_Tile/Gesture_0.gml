if(ds_grid_get(global.Grid,dsx,dsy).name == global.EmptyBuilding.name){
	add_building(dsx,dsy,global.Buildings.kicsi_tombhaz)
}
else{
	remove_building(dsx,dsy)
}
//ds_grid_set(global.Grid, dsx, dsy, global.Buildings.kicsi_tombhaz)