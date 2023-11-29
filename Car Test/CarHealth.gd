extends Label

func _process(_delta):
	#Obviously make this event-driven
	text = "Car Health: " + str(CarGlobals.carHealth)
