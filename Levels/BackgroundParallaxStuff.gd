extends Node2D

var farground
var mountains
var player
var tank

# Called when the node enters the scene tree for the first time.
func _ready():
	farground = $Farground
	mountains = $Mountains
	#player = $"../Player_and_Tank/Player"
	#tank = $"../Player_and_Tank/Tank"
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	farground.position.x = 0.8*GameManager.tank_position.x - 2000
	mountains.position.x = 0.6*GameManager.tank_position.x - 2000
