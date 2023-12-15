extends RigidBody2D

@export var SPEED = 200.0
@export var health = 20
@export var tank_damage: float = 10
@export var Wheels : Array[PinJoint2D] #add all the wheel prefabs to this array
var WheelsRB : Array[RigidBody2D]

var distance_to_tank
var dead: bool = false

#TODO FIXME Make sure enemies follow inheritance! The script is used across ALL inherited classes
#So something referencing specific sprites may not be present on children! - E
@onready var _animated_sprite = $AnimatedSprite2D


func _ready():
	$HealthBar.max_value = health
	$HealthBar.value = health
	$HealthBar.visible = false
	
	for i in range(0, Wheels.size()): #get the actual rigidbody of each wheel
		WheelsRB.push_back(Wheels[i].get_node("wheel"))
	
func _physics_process(delta):
	#for flipping sprite animations
	distance_to_tank = GameManager.tank_position.x - position.x
	_animated_sprite.flip_h = 1
	if distance_to_tank < 0:
		_animated_sprite.flip_h = 0
		
		
	if !dead:
		distance_to_tank = GameManager.tank_position.x - position.x
		var DIR = 1
		if distance_to_tank < 0:
			DIR = -1
		#velocity.x = DIR * SPEED
		#move_and_slide()
		
		for i in range(0, WheelsRB.size()):
			WheelsRB[i].apply_torque(DIR * SPEED * delta * 10000)
			#if(direction == 0):
				##HACK: if we can find a way to do this without completely locking the rotation (eg variable brakes) that might be better, but this is good enough for now
				#WheelsRB[i].lock_rotation = true
			#else:
				#WheelsRB[i].lock_rotation = false
				#pass
	
#Apply damage on projectile hit
func hit(damage):
	health -= damage
	$HealthBar.value = health
	$HealthBar.visible = true
	
	if(health <= 0) and dead == false:
		#Create a gear
		#var gear = gear_scene.instantiate()
		#gear.position = global_position
		#get_parent().call_deferred("add_child", gear)
		dead = true
		ScoreManager.enemiesKilled += 1
		GameManager.drop_gears(global_position, 3)
		$AnimationPlayer.play("Death")

func _on_hitbox_area_entered(area):
	if !dead and "deal_damage" in area:
		area.deal_damage(tank_damage)
