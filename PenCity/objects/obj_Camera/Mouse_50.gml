safemx = mouse_x - camera_get_view_x(cam)
safemy = mouse_y - camera_get_view_y(cam)

camera_set_view_pos(
	cam,
	clamp(ocx + omx - safemx, 0, room_width - camera_get_view_width(cam)),
	clamp(ocy + omy - safemy, 0, room_height - camera_get_view_height(cam))
)