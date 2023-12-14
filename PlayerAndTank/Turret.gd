extends StaticBody2D

@export var rotation_speed: float = 1.0

func _process(delta):
	if GameManager.tank_mode:
		var angle = (get_global_mouse_position() - global_position).angle()
			
		#less than 15
		if angle > PI/12:
			angle -= 2*PI
			
		#move right or left accordingly
		if angle < (-13*PI)/12:
			if angle < -3*PI/2:
				angle = PI/12
			else:
				angle = (-13*PI)/12
		#rotation = rotate_toward(rotation, angle, rotation_speed * delta)
		rotation = lerp(rotation, angle, rotation_speed * delta)
		
		# flip scale based on rotation (so you can walk on the other side)
		if rad_to_deg(angle) >= -90:
			scale.y = 1
		else:
			scale.y = -1
