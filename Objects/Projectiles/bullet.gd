extends Area2D

@export var speed = 2000
@export var damage: float = 10
var direction

func _process(delta):
	position += direction * speed * delta

#func _physics_process(delta):
#	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
#	if collision_info:
#		var hit = collision_info.get_collider()
#		#print("collision_info: ", collision_info)
#		#print("collision_info.get_collider(): ", collision_info.get_collider())
#		#print("collision_info.get_collider().name:  ", collision_info.get_collider().name)
#		#print("collision_info.get_collider().get_parent(): ", collision_info.get_collider().get_parent())
#		print(hit.name)
#		if (hit.name != ("Player")):
#			if (hit.name == ("BigEnemy")):
#				hit.health += -10
#				self.queue_free()
#			else:
#				hit.queue_free()
#				self.queue_free()

func _on_body_entered(body):
	if "hit" in body:
		body.hit(damage)
		queue_free()


func _on_area_entered(area):
	if "hit" in area:
		area.hit(damage)
		queue_free()
