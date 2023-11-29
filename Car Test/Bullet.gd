extends Area2D

@export var speed: float = 1000.0
var direction

func _process(delta):
	position += direction * speed * delta
