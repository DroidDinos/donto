draw_self()
image_blend = c_white

var building = ds_grid_get(global.Grid,dsx,dsy)

if building.pollution > 0{
	image_blend = c_lime
}

if building.sprite != noone {
	draw_sprite(building.sprite, 0, x, y+192)
}



draw_set_colour(c_black)
var text = string_concat(dsx, ", ", dsy)
draw_text(x + 128 - string_width(text)/2, y + 128 - string_height(text)/2, text)