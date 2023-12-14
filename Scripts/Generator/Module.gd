extends Node2D

@onready var manager : Node = $".." #every module must be child of the ModuleManager
@onready var connector : Node2D= $connector #every module must have a connector
var activated = false #prevent a connector from spawning more than 1 module if it appears on screen again

var platform_scene: PackedScene = preload("res://Objects/Platforms/Floating.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if(manager.fullGenerate):
		GenNextModule()
	
	if($connector/VisibleOnScreenNotifier2D.is_on_screen()):
		GenNextModule()
	spawnEnemies()
	spawnPlatform()
	
	

func _on_visible_on_screen_notifier_2d_screen_entered():
	GenNextModule()
		
func spawnPlatform():
	var platform = platform_scene.instantiate()
	
	var randomX = randf_range(-$Floor/CollisionShape2D.shape.get_rect().size.x/2, $Floor/CollisionShape2D.shape.get_rect().size.x/2)
	#TODO HACK may need to change y value - E
	platform.position = Vector2(randomX, -600)
	add_child(platform)
	
func GenNextModule():
	if (!activated):
		manager.GenerateNextModule(connector.global_position)
		activated = true

func spawnEnemies():
	
	for n in randi_range(6, 10): 
		print("Spawning enemy")
		manager.SpawnRandomEnemy(connector.global_position)
