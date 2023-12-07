extends Node2D

signal toggle_is_game_paused(isPaused: bool)
signal game_over_signal()
signal end_reached_signal()

var tank_mode := true:
	get:
		return tank_mode

var tank_position: Vector2
var camera: Camera2D

var gears: int

var game_paused : bool = false:
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		toggle_is_game_paused.emit(game_paused)
		
var game_over : bool = false:
	set(value):
		game_over = value
		get_tree().paused = game_over
		game_over_signal.emit()

var end_reached : bool = false:
	set(value):
		end_reached = value
		get_tree().paused = end_reached
		end_reached_signal.emit()

func _input(_event):
	if Input.is_action_just_pressed("pause") and !game_over:
		game_paused = !game_paused

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

#var current_module_count: int = 0
#var max_module_count: int = 5
