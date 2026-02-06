draw_sprite_ext(
	sprite,
	0,
	x,
	y,
	xscale / sprite_get_width(sprite),
	yscale / sprite_get_height(sprite),
	0,
	c_white,
	1
)

draw_set_font(fnt_Stat)

var text = string_concat("x",struct_get(global,stat))

draw_set_color(c_black)

draw_text(
	x + xscale + 30,
	y + string_height(text)/2 - yscale/2,
	text
)