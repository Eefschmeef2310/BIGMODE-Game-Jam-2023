extends Node2D

var camera
var root
var tank

var tank_mode := true
var camera_lerping := false

var camera_zoom_speed := 2.0
var camera_outer_zoom := 0.5
var camera_inner_zoom := 1.5
var camera_target_zoom
var smooth_zoom = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_parent()
	tank = root.get_node("Tank")
	camera = tank.get_node("Camera2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("swap_mode"):
		tank_mode = !tank_mode
		print("tank mode: " + str(tank_mode))
		if (tank_mode):
			#delete the player in the scene and zoom the camera out
			var player = get_node("Player")
			player.queue_free()
			camera_target_zoom = camera_outer_zoom
			camera_lerping = true
		else:
			#spawn the player into the scene and zoom the camera in
			spawn_player()
			var player = get_node("Player")
			player.position.x = tank.position.x + 50
			player.position.y = tank.position.y - 5
			camera_target_zoom = camera_inner_zoom
			camera_lerping = true
	if camera_lerping:
		zoom_camera(camera_target_zoom, delta)

func spawn_player():
	var player = load("res://player.tscn")
	var player_instance = player.instantiate()
	player_instance.set_name("Player")
	add_child(player_instance)

func zoom_camera(zoom, delta):
	smooth_zoom = lerp(smooth_zoom, zoom, camera_zoom_speed * delta)
	if smooth_zoom != camera_inner_zoom:
		camera.set_zoom(Vector2(smooth_zoom, smooth_zoom))

func is_tank_mode() -> bool:
	return tank_mode
