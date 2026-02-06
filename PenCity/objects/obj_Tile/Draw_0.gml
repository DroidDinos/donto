draw_self()
tempColor = c_white

var building = ds_grid_get(global.Grid,dsx,dsy)

if building.pollution > 0{
	tempColor = c_lime
}

if building.sprite != noone {
	draw_sprite_ext(building.sprite, 0, x, y+192,1,1,0,tempColor,0.5)
}

/*draw_set_colour(c_black)
var text = string_concat(dsx, ", ", dsy)
draw_text(x + 128 - string_width(text)/2, y + 128 - string_height(text)/2, text)