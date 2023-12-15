extends Sprite2D

@onready var label = $"../UpgradeLabel"
var label_middle
var scale_middle
var i = 0

func _ready():
	label_middle = label.position.y
	scale_middle = scale

func _process(delta):
	visible = !GameManager.tank_mode
	label.visible = !GameManager.tank_mode

	rotation += delta
	i += delta
	
	scale = Vector2(scale_middle.x + (sin(i*2)*0.1), scale_middle.y + (sin(i*2)*0.1))
	label.position.y = label_middle - (sin(i*2)*5)
