extends Sprite2D

@export var open_speed := 0.1
@export var close_speed := 0.5
var rotation_tween: Tween

func _on_tank_to_player_control():
	#rotation_degrees = -90
	if rotation_tween:
		rotation_tween.kill()
	rotation_tween = create_tween()
	rotation_tween.tween_property(self, "rotation_degrees", -90, open_speed) # take two seconds to move

func _on_player_to_tank_control():
	#rotation_degrees = 0
	if rotation_tween:
		rotation_tween.kill()
	rotation_tween = create_tween()
	rotation_tween.tween_property(self, "rotation_degrees", 0, close_speed)
