extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Man") and body.visible and body.velocity.y >= 0:
		body.toTank()
