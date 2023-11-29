extends CharacterBody2D

var speed = 400

var root
var tank 

func _ready():
	root = get_parent()
	tank = root.get_node("Tank")
	#the bullet will be faster if the tank is already moving
	speed += tank.velocity.x
	
	velocity = Vector2(1, 0)

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)




