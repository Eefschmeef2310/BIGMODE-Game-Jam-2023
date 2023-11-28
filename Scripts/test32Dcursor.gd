extends Node3D

@export var topDownCam : Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func _input(event):
#	if Input.is_action_pressed("click"):
#		var position2D = get_viewport().get_mouse_position()
#		print(position2D)
#		position = Vector3(position2D.y*-1,0, position2D.x) 
		#var z = 9999999
		#var dropPlane  = Plane(Vector3(0, 0, 10), z)
		#var position3D = dropPlane.intersects_ray(topDownCam.project_ray_origin(position2D),topDownCam.project_ray_normal(position2D))
		#print(position3D)
