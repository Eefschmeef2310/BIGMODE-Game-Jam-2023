extends Node2D

@onready var manager : Node = $".." #every module must be child of the ModuleManager
@onready var connector : Node2D= $connector #every module must have a connector
var activated = false #prevent a connector from spawning more than 1 module if it appears on screen again

var platform_scene: PackedScene = preload("res://Objects/Platforms/Floating.tscn")

var number_of_enemies_to_spawn = 0
var module_width: float

# Called when the node enters the scene tree for the first time.
func _ready():
	module_width = connector.position.x
	
	if(manager.fullGenerate):
		GenNextModule()
	
	if($connector/VisibleOnScreenNotifier2D.is_on_screen()):
		GenNextModule()
	
	#Water and bushes
	var randomX = randf_range(global_position.x + $Floor/CollisionShape2D.shape.get_rect().size.x/2, global_position.x + $Floor/CollisionShape2D.shape.get_rect().size.x)
	$WaterShader.position.x = randomX
	
	# Spawn enemies and cliff
	var mods = manager.get_children()
	if !mods.is_empty():
		var i = mods.find(self)
		if i != -1 and i > 1:
			spawnEnemies()
		print(i % 2)
		if i % 2 == 1:
			spawnPlatforms()
		else:
			$Cliff.queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered():
	GenNextModule()
		
func spawnPlatforms():
	var presets = $Cliff/PlatformPresets.get_children()
	var chosen_preset = presets[randi_range(0, presets.size() - 1)]
	print(chosen_preset)
	for preset in presets:
		if preset != chosen_preset:
			preset.queue_free()
		else:
			preset.visible = true
			print("I'm here!")
		
	
	#var platform = platform_scene.instantiate()
	#
	#var randomX = randf_range(-$Floor/CollisionShape2D.shape.get_rect().size.x/2, $Floor/CollisionShape2D.shape.get_rect().size.x/2)
	##TODO HACK may need to change y value - E
	#platform.position = Vector2(randomX, -600)
	#add_child(platform)
	
func GenNextModule():
	if (!activated):
		manager.GenerateNextModule(connector.global_position)
		activated = true

func spawnEnemies():
	var progress = manager.get_child_count() - 1
	number_of_enemies_to_spawn = (progress * 2) - 1
	_on_spawn_enemy_timer_timeout()

func _on_spawn_enemy_timer_timeout():
	manager.SpawnRandomEnemy(connector.global_position)
	number_of_enemies_to_spawn -= 1
	if number_of_enemies_to_spawn > 0:
		$SpawnEnemyTimer.start()
