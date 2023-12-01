extends Label

func _process(_delta):
	text = "Gears: " + str(GameManager.gears)
