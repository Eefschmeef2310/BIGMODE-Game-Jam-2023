extends Area2D

@export var damage: float = 10

func _on_body_entered(body):
	if visible and body.global_position.x > global_position.x and "hit" in body:
		body.hit(damage)

func _on_area_entered(area):
	if visible and area.global_position.x > global_position.x and "hit" in area:
		area.hit(damage)
