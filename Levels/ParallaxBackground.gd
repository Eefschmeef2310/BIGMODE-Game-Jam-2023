extends ParallaxBackground

var viewport_size
var relative_x
var relative_y

@export var initial_speed := 4
@export var layer_speed := 1.6

func _ready():
	viewport_size = get_viewport().size
	relative_x = 0
	relative_y = 0

func _input(event):
	if event is InputEventMouseMotion:
		relative_x = -1 * (event.position.x - (viewport_size.x/2)) / (viewport_size.x/2)
		relative_y = -1 * (event.position.y - (viewport_size.y/2)) / (viewport_size.y/2)
		
		var count = initial_speed
		for child in self.get_children():
			child.motion_offset.x = count * relative_x
			child.motion_offset.y = count * relative_y
			count = count * layer_speed


#Dead code - E
## gets called on the start of the application once and every time the viewport changes
## centers the images
#func viewport_changed():
	#viewport_size = get_viewport().size
	#for child in self.get_children():
		#pass
		##child.get_node("Sprite2D").offset.x = viewport_size.x/4
		##child.get_node("Sprite2D").offset.y = viewport_size.y/4
