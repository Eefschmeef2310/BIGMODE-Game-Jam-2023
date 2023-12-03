extends CharacterBody2D

signal addGear(gear)

#var gear_scene: PackedScene = preload("res://Objects/Pickups/Gear.tscn")

@export var SPEED = 200.0
@export var health = 20

func _ready():
	$HealthBar.max_value = health
	$HealthBar.value = health

func _physics_process(_delta):
	var distance_to_tank = GameManager.tank_position.x - position.x
	var DIR = 1
	if distance_to_tank < 0:
		DIR = -1
	velocity.x = DIR * SPEED
	move_and_slide()
	
func hit():
	health -= 10
	$HealthBar.value = health
	if(health <= 0):
		#Create a gear
		#var gear = gear_scene.instantiate()
		#gear.position = global_position
		#get_parent().call_deferred("add_child", gear)
		
		queue_free()
