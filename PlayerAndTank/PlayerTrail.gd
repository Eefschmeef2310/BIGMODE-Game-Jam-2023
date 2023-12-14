extends Line2D

const max_points: int = 200
@export var fade_time := 3.0
@onready var curve := Curve2D.new()

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(_delta):
	curve.add_point(get_parent().global_position)
	if curve.get_baked_points().size() > max_points:
		curve.remove_point(0)
	points = curve.get_baked_points()
	
func stop():
	set_process(false)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 3.0)
	await tween.finished
