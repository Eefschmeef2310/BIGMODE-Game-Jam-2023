extends Marker2D

@onready var distance: float
@onready var progress = $"../UI/ProgressBar"
var startDistance : float = 174 #fixme hardcoded since i cant use GameManager.tank_position.x because it isnt ready yet :(


func ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	calculate_distance()
	update_progress()

func calculate_distance():
	distance = ((GameManager.tank_position.x - 174)/(position.x))*100

#updates the progress bar
func update_progress():
	progress.value = distance
