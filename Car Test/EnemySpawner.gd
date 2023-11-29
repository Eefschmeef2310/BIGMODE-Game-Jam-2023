extends Timer

var enemy_scene: PackedScene = preload("res://Car Test/Enemy.tscn")

func _on_timeout():
	var enemy = enemy_scene.instantiate() as Area2D
	
	var xPos;
	if randf() > 0.5:
		xPos = get_viewport().size.x
	else:
		xPos = 0
	enemy.position = Vector2(xPos, randf_range(get_viewport().size.y /2, get_viewport().size.y))
	
	add_child(enemy)

func _on_car_car_breakdown():
	start()

func _on_car_car_return():
	for node in get_children():
		node.queue_free()
	stop()
