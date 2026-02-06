cam = view_camera[0]
global.cam = cam
global.camx = camera_get_view_x(global.cam)
global.camy = camera_get_view_y(global.cam)
global.camw = camera_get_view_width(global.cam)
global.camh = camera_get_view_height(global.cam)

omx = 0
omy = 0

ocx = camera_get_view_x(cam)
ocy = camera_get_view_y(cam)