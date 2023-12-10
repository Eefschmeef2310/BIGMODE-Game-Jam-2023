extends CollisionShape2D

@export var groupName = "Man"
@onready var target = get_tree().get_first_node_in_group(groupName)
@export var offset = 25

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	disabled = (target.position.y - offset) > position.y
	#print(disabled)
