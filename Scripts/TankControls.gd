extends Node3D

var mode = "Control" #Modes: Control, AI, Off
@export var speed = 5

@export var bulletSpawn : Node3D
@export var bulletPrefab : PackedScene

@export var tankCamera : Camera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(mode == "Control"):
		var input_dir = Input.get_vector("left", "right", "up", "down")
		position += Vector3( input_dir.y*-1, 0 , input_dir.x )   *delta*speed
		
#		if(Input.get_vector("aleft", "aright", "aup", "adown").length() > 0):
#			var attack_dir = Input.get_vector("aleft", "aright", "aup", "adown")
#			var newBullet = bulletPrefab.instantiate() as RigidBody3D
#			newBullet.linear_velocity = Vector3( attack_dir.y*-1, 0 , attack_dir.x )   *delta*speed
#			add_child(newBullet)
		
		if(Input.is_action_just_pressed("click")):
			var mouse_pos = get_viewport().get_mouse_position()
			var ray_length = 10000
			var from = tankCamera.project_ray_origin(mouse_pos)
			var to = from + tankCamera.project_ray_normal(mouse_pos) * ray_length
			var space = get_world_3d().direct_space_state
			var ray_query = PhysicsRayQueryParameters3D.new()
			ray_query.from = from
			ray_query.to = to
			ray_query.collide_with_areas = true
			var raycast_result = space.intersect_ray(ray_query)
			print(raycast_result.get("position"))
			var clickPos = raycast_result.get("position")
			
			var newBullet = bulletPrefab.instantiate() as RigidBody3D
#			newBullet.linear_velocity = Vector3( attack_dir.y*-1, 0 , attack_dir.x )   *delta*speed
#			newBullet.position = raycast_result.get("position")
			newBullet.linear_velocity = clickPos-global_position
			newBullet.position = bulletSpawn.global_position
			$"..".add_child(newBullet)
		
	elif (mode == "AI"): # "ai mode" 
		var input_dir = Vector2(1,-1)
		position += Vector3( input_dir.y*-1, 0 , input_dir.x )   *delta*(speed/5)


func _on_camera_manager_top_down_disable():
	mode = "Off"


func _on_camera_manager_top_down_ready():
	mode = "Control"


func _on_camera_manager_fps_ready():
	mode = "AI"
