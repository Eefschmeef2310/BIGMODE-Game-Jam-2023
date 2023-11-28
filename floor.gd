extends StaticBody2D

var g_texture_width: float = 0

var world_node #the root
var tank
var sprite2d
var area2d

# Called when the node enters the scene tree for the first time.
func _ready():
	world_node = get_parent()
	tank = world_node.get_node("Tank")
	sprite2d = get_node("Sprite2D")
	area2d = get_node("Area2D")
	
	g_texture_width = sprite2d.texture.get_size().x * scale.x
	print("Texture width: " + str(g_texture_width))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_check_position()
	#print("Tank position: " + str(_get_tank_position()))
	
func _check_position() -> void:
	print(area2d.get_overlapping_areas())
	
	#if the tank is not currently touching this floor piece
	if (!area2d.get_overlapping_areas().is_empty()):
		if tank.position.x > 100:
			self.position.x += g_texture_width
		if tank.position.x < -100:
			self.position.x -= g_texture_width
