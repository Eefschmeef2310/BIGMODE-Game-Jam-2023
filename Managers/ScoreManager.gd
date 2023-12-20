extends Node

var score: int

var enemiesKilled: int = 0

var progress_bar: ProgressBar
var progress_score

func calculateScore():
	#Time, enemies killed, gears collected
	progress_score = progress_bar.value / progress_bar.max_value * 100
	score = int(progress_score) + enemiesKilled + GameManager.gears
	return score
