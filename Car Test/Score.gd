extends Label

var score: float

func _process(_delta):
	score += CarGlobals.gameSpeed * .25
	text = "Score: " + str(int(score))
