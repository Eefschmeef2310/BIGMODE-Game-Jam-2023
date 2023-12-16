extends Node

var score: int
var elapsedTime: float = 0.0
var countTime: bool = true

var totalTime: float = 420

var enemiesKilled: int = 0

#This is not named correctly lol, the score correctly calculates gears NOT spent (less spend = higher score) - E
var gearsSpent: int = 0

func _process(delta):
	
	if countTime:
		elapsedTime += delta

func calculateScore():
	#Time, enemies killed, gears collected
	countTime = false
	score = int(totalTime - elapsedTime) + enemiesKilled + gearsSpent
	return score
