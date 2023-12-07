extends StaticBody2D

var drop_scene: PackedScene = preload("res://Objects/Enemies/AirEnemies/LakituDrop.tscn")

@export var SPEED = 200.0
@export var health = 20

@export var height: float = 250
@export var lerp_speed: float = 0.5

var xPos: float
var yPos: float

func _ready():
	$HealthBar.max_value = health
	$HealthBar.value = health

func _process(delta):
	xPos = lerp(position.x, GameManager.tank_position.x, lerp_speed * delta)
	yPos = GameManager.tank_position.y - height
	
	position = Vector2(xPos, yPos)
	
#Apply damage on projectile hit
func hit(damage):
	health -= damage
	$HealthBar.value = health
	
	if(health <= 0):
		queue_free()

#region dropping
func _on_drop_timer_timeout():
	print('test')
	spawnDrop()
	$DropTimer.start()
	
func spawnDrop():
	var drop = drop_scene.instantiate()
	drop.position = $DropMarker.global_position
	get_parent().add_child(drop)
#endregion
