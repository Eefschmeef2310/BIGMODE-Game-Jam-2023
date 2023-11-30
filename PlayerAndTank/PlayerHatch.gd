extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player") and body.visible:
		body.toTank()
