extends Area2D

@export var speed = 1500
@export var damage: float = 20
@export var gravity_scale: float = 0.001
@export var shouldMove := true
var direction
var has_split = false

var rocket_level = 1

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity_float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if rocket_level >= 2:
		scale = Vector2(2, 2)
	if shouldMove:
		print("ayo")
		rotation = direction.angle()
		position += direction * speed * delta
		direction.y += gravity_float * delta * gravity_scale

func _on_body_entered(_body):
	explode()

func _on_area_entered(area):
	explode()

func explode():
	$AnimationPlayer.play("RocketExplosion")
	if rocket_level >= 3 and !has_split:
		has_split = true
		var rocket_scene = load("res://Objects/Projectiles/rocket.tscn")
		var asplit = 20
		var a = -90 - asplit
		for n in 3:
			var rocket = rocket_scene.instantiate()
			var direction = Vector2(cos(deg_to_rad(a + (n*asplit))), sin(deg_to_rad(a + (n*asplit))))
			rocket.position = global_position
			rocket.position.y -= 20
			rocket.direction = direction
			rocket.rotation_degrees = rad_to_deg(a)
			rocket.rocket_level = 1
			rocket.gravity_scale *= 2
			get_parent().add_child(rocket)
	

func _on_aoe_area_entered(area):
	if "hit" in area:
		area.hit(damage)

func _on_aoe_body_entered(body):
	if "hit" in body:
		body.hit(damage)
