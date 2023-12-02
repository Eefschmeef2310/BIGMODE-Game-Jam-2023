extends Sprite2D

func _process(_delta):
	if GameManager.tank_mode:
		var angle = (get_global_mouse_position() - global_position).normalized().angle()
		if angle > 0:
			if angle > PI/2:
				angle = -PI
			elif angle < PI/2:
				angle = 0
		rotation = angle
