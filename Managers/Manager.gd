extends Node2D

signal toggle_is_game_paused(isPaused: bool)

var tank_mode := true:
	get:
		return tank_mode

var tank_position: Vector2

var gears: float

var game_paused : bool = false:
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		toggle_is_game_paused.emit(game_paused)

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		game_paused = !game_paused

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

#var current_module_count: int = 0
#var max_module_count: int = 5
