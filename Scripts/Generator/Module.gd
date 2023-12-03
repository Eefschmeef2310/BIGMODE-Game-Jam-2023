extends Node2D

@onready var manager : Node = $".." #every module must be child of the ModuleManager
@onready var connector := $connector #every module must have a connector
var activated = false #prevent a connector from spawning more than 1 module if it appears on screen again


# Called when the node enters the scene tree for the first time.
func _ready():
	if($connector/VisibleOnScreenNotifier2D.is_on_screen()):
		manager.GenerateNextModule(connector.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_entered():
	if (!activated):
		manager.GenerateNextModule(connector.global_position)
		activated = true
