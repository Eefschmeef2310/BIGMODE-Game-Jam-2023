extends Timer

var debris_scene: PackedScene = preload("res://Car Test/Debris.tscn")

func _on_timeout():
	var debris = debris_scene.instantiate() as Area2D
	debris.position = Vector2(get_viewport().size.x + 20, randf_range(get_viewport().size.y /2, get_viewport().size.y))
	add_child(debris)

func _on_car_car_breakdown():
	for node in get_children():
		node.queue_free()
	stop()

func _on_car_car_return():
	start()
