extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var root
var tank

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	root = get_parent()
	tank = root.get_node("Tank")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var distance_to_tank = tank.position.x - position.x
	var DIR = 1
	if distance_to_tank < 0:
		DIR = -1
	velocity.x = DIR * SPEED
	
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_area_2d_body_entered(body):
	print("enemy shot")
	var enemy = body
	enemy.queue_free()
