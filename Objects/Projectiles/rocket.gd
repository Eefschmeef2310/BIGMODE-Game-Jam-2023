extends Area2D

@export var speed = 1500
@export var damage: float = 10
@export var gravity_scale: float = 0.001
var direction

var rocket_level = 1

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity_float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	rotation = direction.angle()
	position += direction * speed * delta
	direction.y += gravity_float * delta * gravity_scale

func _on_body_entered(body):
	if "hit" in body:
		body.hit(damage)
		queue_free()

func _on_area_entered(area):
	if "hit" in area:
		area.hit(damage)
		queue_free()