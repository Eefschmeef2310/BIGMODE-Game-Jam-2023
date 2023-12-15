extends Node2D

@export var damage: float = 10
var active_in_player_mode = false

func _ready():
	$AnimationPlayer.play("rotate")
	$Blade/AnimationPlayer.play("spin")

func _process(_delta):
	if GameManager.tank_mode == false and !active_in_player_mode:
		$AnimationPlayer.pause()
		$Blade/AnimationPlayer.pause()
	else:
		$AnimationPlayer.play()
		$Blade/AnimationPlayer.play()

func _on_blade_body_entered(body):
	if visible and $Blade/AnimationPlayer.is_playing() and "hit" in body:
		body.hit(damage)

func _on_blade_area_entered(area):
	if visible and $Blade/AnimationPlayer.is_playing() and "hit" in area:
		area.hit(damage)
