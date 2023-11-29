extends Node2D

var root
var tank 
var camera 

var tank_mode := true:
	get:
		return tank_mode
var camera_lerping := false

var tank_position: Vector2

# Called when the node enters the scene tree for the first time.d
func _ready():
	root = get_parent()
	#tank = root.get_node("Tank")
	#camera = tank.get_node("Camera2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("swap_mode"):
		tank_mode = !tank_mode
		#print("tank mode: " + str(tank_mode))
		if (tank_mode):
			#delete the player in the scene and zoom the camera out
			var player = get_node("Player")
			player.queue_free()
		else:
			#spawn the player into the scene and zoom the camera in
			spawn_player()
		
		camera_lerping = true

#spawns player into the scene slightly to the right of the tank
func spawn_player():
	var player = load("res://PlayerAndTank/player.tscn")
	var player_instance = player.instantiate()
	player_instance.set_name("Player")
	add_child(player_instance)
	var spawned_player = get_node("Player")
	spawned_player.position.x = GameManager.tank_position.x + 50
	spawned_player.position.y = GameManager.tank_position.y - 5
