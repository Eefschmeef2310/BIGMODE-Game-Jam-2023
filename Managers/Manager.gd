extends Node2D

var tank_mode := true:
	get:
		return tank_mode

var tank_position: Vector2

var gears: float

var current_module_count: int = 0
var max_module_count: int = 1
