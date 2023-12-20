extends Marker2D

@onready var progress = $"../UI/ProgressBar"

func _ready():
	progress.min_value = $"../Player_and_Tank/Tank".global_position.x
	progress.max_value = position.x

func _process(_delta):
	progress.value = GameManager.tank_position.x
	if progress.value >= progress.max_value:
		GameManager.end_reached = true
