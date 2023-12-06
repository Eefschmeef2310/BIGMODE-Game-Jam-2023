extends Area2D

func _on_body_entered(body):
	print('connect')
	if body.is_in_group("Man") and body.visible:
		body.toTank()
