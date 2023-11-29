extends Node

@export var maxDifficultySeconds: float = 300
@export var difficultyCurve: Curve

var levelStartTime: float

func _ready():
	#Get current time in seconds
	levelStartTime = Time.get_ticks_msec() / 1000.0

func _process(_delta):
	var elapsedTime = Time.get_ticks_msec() / 1000.0 - levelStartTime
	if CarGlobals.carMode:
		CarGlobals.gameSpeed = difficultyCurve.sample(elapsedTime/maxDifficultySeconds)

func _on_car_car_breakdown():
	levelStartTime = Time.get_ticks_msec() / 1000.0 - levelStartTime
	CarGlobals.gameSpeed = 0.0
