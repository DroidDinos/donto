draw_self()

var building = ds_grid_get(global.Grid,dsx,dsy)

if building.sprite != noone {
	draw_sprite(building.sprite, 0, x, y+192)
}

draw_set_colour(c_black)
draw_text(x,y,dsx)