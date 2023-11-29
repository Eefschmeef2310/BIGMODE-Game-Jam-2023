extends Node2D


var root
var tank 
var camera 

var tank_mode := true
var camera_lerping := false

#variables for handling the smooth zooming in/out
var camera_zoom_speed := 2.0
var camera_outer_zoom := 0.5
var camera_inner_zoom := 1.5
var camera_target_zoom
var smooth_zoom = 0.5

var rng = RandomNumberGenerator.new()

const enemySmallPath = preload("res://enemy_small.tscn")

func spawn_enemy_small():
	var enemy_small = enemySmallPath.instantiate()
	root.add_child(enemy_small)
	var distance_from_tank = rng.randf_range(500.0, 1000.0)
	var negative_multiplier = rng.randi_range(-1,0)
	if negative_multiplier == 0:
		negative_multiplier = 1
	var enemy_small_spawn_position = tank.position.x + distance_from_tank*negative_multiplier
	if enemy_small_spawn_position < 120:
		enemy_small_spawn_position = 120
		if tank.position.x < 616:
			enemy_small_spawn_position = tank.position.x + distance_from_tank
	print("Spawned enemy at " + str(enemy_small_spawn_position))
	enemy_small.position.x = enemy_small_spawn_position
	enemy_small.position.y = tank.position.y - 5

# Called when the node enters the scene tree for the first time.d
func _ready():
	root = get_parent()
	tank = root.get_node("Tank")
	camera = tank.get_node("Camera2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("swap_mode"):
		tank_mode = !tank_mode
		#print("tank mode: " + str(tank_mode))
		if (tank_mode):
			#delete the player in the scene and zoom the camera out
			var player = get_node("Player")
			player.queue_free()
			camera_target_zoom = camera_outer_zoom
			camera_lerping = true
		else:
			#spawn the player into the scene and zoom the camera in
			spawn_player()
			camera_target_zoom = camera_inner_zoom
			camera_lerping = true
	if camera_lerping:
		zoom_camera(camera_target_zoom, delta)

#spawns player into the scene slightly to the right of the tank
func spawn_player():
	var player = load("res://player.tscn")
	var player_instance = player.instantiate()
	player_instance.set_name("Player")
	add_child(player_instance)
	var spawned_player = get_node("Player")
	spawned_player.position.x = tank.position.x + 50
	spawned_player.position.y = tank.position.y - 5

#function for camera zoom lerp
func zoom_camera(zoom, delta):
	smooth_zoom = lerp(smooth_zoom, zoom, camera_zoom_speed * delta)
	if smooth_zoom != camera_inner_zoom:
		camera.set_zoom(Vector2(smooth_zoom, smooth_zoom))
	else:
		camera_lerping = false

#function accessed by the tank to check if the current mode is tankmode or not
func is_tank_mode() -> bool:
	return tank_mode



func _on_enemy_spawn_timer_timeout():
	$enemy_spawn_timer.wait_time = rng.randf_range(5.0, 10.0)
	spawn_enemy_small()
