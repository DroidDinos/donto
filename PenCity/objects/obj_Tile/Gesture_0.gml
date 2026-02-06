if(ds_grid_get(global.Grid,dsx,dsy).name == global.EmptyBuilding.name){
	add_building(dsx,dsy,global.Buildings.acelonto)
}
else if (ds_grid_get(global.Grid,dsx,dsy).name == global.Buildings.kicsi_tombhaz.name) {
	remove_building(dsx,dsy)
	add_building(dsx,dsy,global.Buildings.kozepes_tombhaz)
}
else if (ds_grid_get(global.Grid,dsx,dsy).name == global.Buildings.kozepes_tombhaz.name) {
	remove_building(dsx,dsy)
	add_building(dsx,dsy,global.Buildings.nagy_tombhaz)
}
else {
	remove_building(dsx,dsy)
}
//ds_grid_set(global.Grid, dsx, dsy, global.Buildings.kicsi_tombhaz)

