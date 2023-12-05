extends Marker2D

@onready var progress = $"../UI/ProgressBar"
var startDistance : float = 174 #TODO FIXME hardcoded since i cant use GameManager.tank_position.x because it isnt ready yet :(

func _process(_delta):
	progress.value = ((GameManager.tank_position.x - 174)/(position.x))*100
	if progress.value > 99:
		GameManager.end_reached = true
