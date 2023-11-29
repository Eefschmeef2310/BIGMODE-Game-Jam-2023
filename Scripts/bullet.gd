extends CharacterBody2D

var speed = 400

var root
var tank 
var manager

func _ready():
	root = get_parent()
	#tank = root.get_node("Tank")
	#manager = root.get_node("Manager")
	
	#the bullet will be faster if the tank is already moving // breaks the game when shooting from player so commented out
	#if manager.is_tank_mode():
	#	speed += tank.velocity.x
	
	velocity = Vector2(1, 0)

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
	if collision_info:
		var hit = collision_info.get_collider()
		#print("collision_info: ", collision_info)
		#print("collision_info.get_collider(): ", collision_info.get_collider())
		#print("collision_info.get_collider().name:  ", collision_info.get_collider().name)
		#print("collision_info.get_collider().get_parent(): ", collision_info.get_collider().get_parent())
		print(hit.name)
		if (hit.name != ("Player")):
			if (hit.name == ("BigEnemy")):
				hit.health += -10
				self.queue_free()
			else:
				hit.queue_free()
				self.queue_free()




