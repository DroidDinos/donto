sprite_index = struct_get(global.Buildings,selected).sprite
depth = -40000
x = obj_Toolbar.x - sprite_width/2
y = obj_Toolbar.y - 256 - 64

if global.selectedtool == "Hammer" {
	show = true
} else {
	show = false
}