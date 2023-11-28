extends Area2D

func _process(_delta):
	position += Vector2.LEFT * CarGlobals.gameSpeed * 20


func _on_body_entered(body):
	if "hit" in body:
		body.hit()
		queue_free()
