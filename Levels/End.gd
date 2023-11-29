extends Marker2D

var distance
var tank 

# Called when the node enters the scene tree for the first time.
func _ready():
	tank = $"../Tank"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	calculate_distance()
	update_progress()

func calculate_distance():
		distance = position.x - tank.position.x

#updates the progress bar
func update_progress():
	var progress = $"../CanvasLayer/ProgressBar"
	progress.value = distance
	
	
