extends Node

@export var modules: Array[PackedScene]
@export var fullGenerate : bool = false 
@export var maxModules: int = 999
var currrentModules: int = 0
var count : int
var enemyCount : int
@export var endNode : Node2D #HACK probably shouldnt reference it like this (module manager should be compeltely standalone)
signal moduleGenerated
@export var enemyPrefabs : Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready():
	count = modules.size()
	enemyCount = enemyPrefabs.size()

func GenerateNextModule(spawnPos:Vector2):
	if currrentModules <= maxModules:
		currrentModules += 1
		#print("i want to generate")
		var selectedModule = randi_range(0, count-1)
		#print(selectedModule)
		var newModule = modules[selectedModule].instantiate()
		newModule.position = spawnPos
		add_child.call_deferred(newModule)
		
		
		
		moduleGenerated.emit()
		
	if currrentModules == maxModules:
		endNode.position = spawnPos

func SpawnRandomEnemy(spawnPos:Vector2):
	var selectedEnemy = randi_range(0, enemyCount-1) as int
	var newEnemy = enemyPrefabs[selectedEnemy].instantiate()
	newEnemy.global_position = spawnPos
	newEnemy.global_position += Vector2(-50, -50)
	add_child.call_deferred(newEnemy)
	

### Module Manager Plan
# aka level generator
#
# Step 1: wait for game to start (starting module will already be in the scene)
# Step 2: once the game has started wait for a notifier to appear on screen
	# this is the edge of the last module - time to generate the next
# Step 3: pick a module at random from "modules" array, spawn it and set its 
	# position to the notifer so it connects with the rest of the level

# every module should have the component to load the next module 
# every spawned module should be a child of this manager so it can access the array 

