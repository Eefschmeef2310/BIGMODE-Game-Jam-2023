extends StaticBody2D

var gear_scene: PackedScene = preload("res://Objects/Pickups/Gear.tscn")

func _ready():
	spawnGear()
	
func spawnGear():
	var gear = gear_scene.instantiate()
	
	var randomX = randf_range(-$CollisionShape2D.shape.get_rect().size.x/2, $CollisionShape2D.shape.get_rect().size.x/2)
	#TODO HACK may need to change y value - E
	gear.position = Vector2(randomX, -20)
	add_child(gear)
