extends Area2D

@export var damage: float = 10

func _on_body_entered(body):
	if "hit" in body:
		body.hit(damage)

func _on_area_entered(area):
	if "hit" in area:
		area.hit(damage)
