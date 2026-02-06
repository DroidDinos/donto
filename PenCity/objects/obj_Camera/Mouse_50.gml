safemx = mouse_x - camera_get_view_x(cam)
safemy = mouse_y - camera_get_view_y(cam)

camera_set_view_pos(
	cam,
	ocx + omx - safemx,
	ocy + omy - safemy
)