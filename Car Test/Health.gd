extends Label

func _process(_delta):
	#Obviously make this event-driven
	text = "Health: " + str(CarGlobals.carHealth)
