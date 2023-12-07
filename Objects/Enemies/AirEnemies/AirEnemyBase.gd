extends StaticBody2D

@export var SPEED = 200.0
@export var health = 20

@export var tank_height: float = 750
@export var player_height: float = 200
@export var lerp_speed: float = 0.5

var xPos: float
var yPos: float

func _ready():
	$HealthBar.max_value = health
	$HealthBar.value = health

func _process(delta):
	xPos = lerp(position.x, GameManager.tank_position.x, lerp_speed * delta)
	#yPos = GameManager.tank_position.y - height
	if GameManager.tank_mode:
		yPos = GameManager.camera.get_screen_center_position().y - tank_height
	else:
		yPos = GameManager.camera.get_screen_center_position().y - player_height
	
	position = Vector2(xPos, yPos)
	
#Apply damage on projectile hit
func hit(damage):
	health -= damage
	$HealthBar.value = health
	
	if(health <= 0):
		queue_free()

func _on_drop_timer_add_item(item):
	get_parent().add_child(item)
