extends Node2D

var background
var player
var tank

# Called when the node enters the scene tree for the first time.
func _ready():
	#background = $Background
	#player = $"../Player_and_Tank/Player"
	#tank = $"../Player_and_Tank/Tank"
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position.x = 0.8*GameManager.tank_position.x - 2000
