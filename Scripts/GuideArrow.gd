extends Sprite2D

@onready var tank = $"../../Player_and_Tank/Tank"

func _process(_delta):
	#Negative PI/2 is left!!! - E
	rotation = tank.global_position.angle_to_point(GameManager.tank_position) - PI/2
	position = position.lerp(get_viewport_rect().size * GameManager.camera.zoom - Vector2(0,135).rotated(rotation), 0.1)

#func _process(_delta):
	#var target_position = get_viewport_rect().size * GameManager.camera.zoom - Vector2(0, 135).rotated(rotation)
#
	## Calculate the angle from the tank to the GameManager's tank position
	#var angle_to_target = -(GameManager.tank_position.angle_to(tank.global_position))
#
	## Check if the GameManager's tank is to the left or right
	#if angle_to_target > PI / 2 or angle_to_target < -PI / 2:
		#rotation = angle_to_target + PI / 2
		#position = position.lerp(target_position, 0.1)
	#else:
	## If the tank is to the left, adjust the rotation accordingly
		#rotation = angle_to_target - PI / 2
		#position = position.lerp(target_position, 0.1)

func _on_visible_on_screen_notifier_2d_screen_entered():
	visible = false

func _on_visible_on_screen_notifier_2d_screen_exited():
	visible = true
