extends Area2D

func _process(_delta):
	position += Vector2.LEFT * CarGlobals.gameSpeed * 20

func _on_area_entered(area):
	if "hit" in area:
		area.hit()
		queue_free()
