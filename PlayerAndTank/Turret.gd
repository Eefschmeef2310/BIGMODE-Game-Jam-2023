extends StaticBody2D

@export var rotation_speed: float = 1.0

func _process(delta):
	if GameManager.tank_mode:
		var angle = (get_global_mouse_position() - global_position).normalized().angle()
		
		#if angle > 0:
			#if angle > PI/2:
				#angle = -PI
			#elif angle < PI/2:
				#angle = 0
		angle = clamp(angle, -(3*PI)/4, PI/4)
		rotation = lerp(rotation, angle, rotation_speed * delta)
