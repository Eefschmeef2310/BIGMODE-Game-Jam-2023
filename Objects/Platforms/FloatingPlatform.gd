extends StaticBody2D

var gear_scene: PackedScene = preload("res://Objects/Pickups/Gear.tscn")
var gear_spawn_chance = 0.4
var gear_spawn_amount = [3, 3]
var gear_spawn_margin = 10
var gear_values = [1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 10]

func _ready():
	if randf() < gear_spawn_chance:
		spawnGear()
	
func spawnGear():
	var number_of_gears = randi_range(gear_spawn_amount[0], gear_spawn_amount[1])
	for n in number_of_gears:
		var gear = gear_scene.instantiate()
		var randomX = randf_range(-$CollisionShape2D.shape.get_rect().size.x/2, $CollisionShape2D.shape.get_rect().size.x/2)
		#TODO HACK may need to change y value - E
		gear.position = Vector2(randomX, -20)
		gear.value = gear_values[randi_range(0, gear_values.size() - 1)]
		add_child(gear)
