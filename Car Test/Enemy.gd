extends Area2D

@export var speed: float = 30
@export var health: int = 10

func _process(delta):
	global_position = global_position.move_toward(CarGlobals.playerPos, speed * delta)


func _on_area_entered(area):
	if area.is_in_group("Projectiles"):
		health -= 10;
		if health >= 0:
			queue_free()
