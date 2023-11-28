extends Label

func _process(_delta):
	#Obviously make this event-driven
	text = "Player Health: " + str(CarGlobals.playerHealth)
