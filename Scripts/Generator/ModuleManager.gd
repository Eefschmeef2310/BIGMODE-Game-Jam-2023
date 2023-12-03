extends Node


@export var modules: Array[PackedScene]
var count : float
signal moduleGenerated


 

# Called when the node enters the scene tree for the first time.
func _ready():
	count = modules.size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func GenerateNextModule(spawnPos:Vector2):
	#print("i want to generate")
	var selectedModule = randi_range(0, count-1)
	print(selectedModule)
	var newModule = modules[selectedModule].instantiate()
	newModule.position = spawnPos
	add_child(newModule)
	moduleGenerated.emit()




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

