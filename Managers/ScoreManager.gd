extends Node

var score: int
var elapsedTime: float = 0.0
var countTime: bool = false

var totalTime: float = 420

var enemiesKilled: int = 0
var gearsSpent: int = 0

func _process(delta):
	if countTime:
		elapsedTime += delta

func calculateScore():
	#Time, enemies killed, gears collected
	countTime = false
	score = int(totalTime - elapsedTime) + enemiesKilled + gearsSpent
