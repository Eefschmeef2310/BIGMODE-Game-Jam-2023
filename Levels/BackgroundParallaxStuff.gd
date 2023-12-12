extends Node2D

var background
var player
var tank

# Called when the node enters the scene tree for the first time.
func _ready():
	background = $Background
	player = $"../Player_and_Tank/Player"
	tank = $"../Player_and_Tank/Tank"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.tank_mode:
		position.x = 0.8*tank.global_position.x - 2000
	elif GameManager.tank_mode == false:
		position.x = 0.8*player.global_position.x - 2000
