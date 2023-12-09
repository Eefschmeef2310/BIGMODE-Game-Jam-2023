extends StaticBody2D

@export var rotation_speed: float = 1.0

func _process(delta):
	if GameManager.tank_mode:
		var angle = (get_global_mouse_position() - global_position).angle()
		
		if angle > 0:
			if angle > PI/2 and angle < (11*PI)/12:
				angle = (11*PI)/12
			elif angle < PI/2 and angle > PI/12:
				angle = PI/12
		
		#if angle > 0:
			#if angle > PI/2:
				#angle = -PI
			#elif angle < PI/2:
				#angle = 0
		#angle = clamp(angle, -(3*PI)/4, PI/4)
		rotation = rotate_toward(rotation, angle, rotation_speed * delta)
