extends Node

var gameSpeed: float = 0.08
var carHealth: float = 100:
	set(value):
		carHealth = value
		carHealth = clamp(carHealth, 0, 100)
		
var playerHealth: float = 100:
	set(value):
		playerHealth = value
		playerHealth = clamp(playerHealth, 0, 100)
		
var carMode: bool = true

var playerPos: Vector2
