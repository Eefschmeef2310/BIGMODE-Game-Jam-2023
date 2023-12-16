extends Sprite2D

@onready var tank = $"../../Player_and_Tank/Tank/PlayerHatch"

func _process(_delta):
	#Negative PI/2 is left!!! - E
	if $"../../Player_and_Tank/Player":
		rotation = tank.global_position.angle_to_point($"../../Player_and_Tank/Player".global_position) - PI/2
		position = position.lerp(get_viewport_rect().size * GameManager.camera.zoom - Vector2(0,135).rotated(rotation), 0.1)

func _on_visible_on_screen_notifier_2d_screen_entered():
	visible = false

func _on_visible_on_screen_notifier_2d_screen_exited():
	visible = true
