extends Marker2D

@onready var distance: float
@onready var progress = $"../UI/ProgressBar"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	calculate_distance()
	update_progress()

func calculate_distance():
	distance = position.x - GameManager.tank_position.x

#updates the progress bar
func update_progress():
	progress.value = distance
