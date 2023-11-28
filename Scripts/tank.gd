extends CharacterBody2D

var root
var manager
var health := 100

const SPEED = 200.0
const bulletPath = preload("res://bullet.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	root = get_parent()
	manager = root.get_node("Manager")

func _physics_process(delta):
	update_health()
	if manager.is_tank_mode():
		if Input.is_action_just_pressed("fire"):
			shoot()
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()

func shoot():
	var bullet = bulletPath.instantiate()
	root.add_child(bullet)
	bullet.position = $Marker2D.global_position

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	if health >= 100:
		healthbar.visible = false
	else: 
		healthbar.visible = true

func _on_regen_timer_timeout():
	if manager.is_tank_mode():
		if health > 0:
			health = health - 2
			print("decreasing health")
		else:
			health = 0
	else:
		if health < 100:
			health = health + 1
			print("increasing health")
		else:
			health = 100
	if health <= 0:
		health = 0
