extends ParallaxLayer

@export var parallax_speed: float

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_pos = event.position
		var viewport = get_viewport().size
		
		var relative_x = (mouse_pos.x - (viewport.x/2)) / (viewport.x/2)
		print(relative_x)
		var relative_y = (mouse_pos.y - (viewport.y/2)) / (viewport.y/2)
		
		motion_offset.x = parallax_speed * relative_x
		motion_offset.y = parallax_speed * relative_y
		
		motion_offset.x += 1
