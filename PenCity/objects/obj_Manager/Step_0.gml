var tap = mouse_check_button_pressed(mb_left)
global.input_consumed = false

if tap {
	for (var i = 0; i < array_length(buttons); i++) {
		with (buttons[i]) {
			if (point_in_rectangle(
					mouse_x,
					mouse_y,
					bbox_left,
					bbox_top,
					bbox_right,
					bbox_bottom
				)
			) {
	            global.input_consumed = true
	        }
		}
	}
}