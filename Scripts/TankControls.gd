extends Node3D

var mode = "Control" #Modes: Control, AI, Off
@export var speed = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(mode == "Control"):
		var input_dir = Input.get_vector("left", "right", "up", "down")
		position += Vector3( input_dir.y*-1, 0 , input_dir.x )   *delta*speed
	elif (mode == "AI"): # "ai mode" 
		var input_dir = Vector2(1,-1)
		position += Vector3( input_dir.y*-1, 0 , input_dir.x )   *delta*(speed/5)


func _on_camera_manager_top_down_disable():
	mode = "Off"


func _on_camera_manager_top_down_ready():
	mode = "Control"


func _on_camera_manager_fps_ready():
	mode = "AI"
