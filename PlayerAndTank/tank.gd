extends CharacterBody2D

signal addBullet(bullet)

var root
var manager
var health := 100:
	#introduce a setter that automatically clamps the health
	set(value):
		health = value
		health = clamp(health, 0, 100)

const SPEED = 200.0
const bulletPath = preload("res://Objects/Projectiles/bullet.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var healthbar = $healthbar

func _ready():
	manager = get_parent().get_node("Manager")

func _physics_process(delta):
	update_health()
	
	GameManager.tank_position = global_position
	
	if GameManager.tank_mode:
		#handle bullet firing
		if Input.is_action_just_pressed("fire"):
			shoot()
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
		# Get the input direction and handle the movement/deceleration.
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()

#spawns bullet
func shoot():
	var bullet = bulletPath.instantiate()
	addBullet.emit(bullet)
	bullet.position = $Marker2D.global_position

#updates the health to the health bar
func update_health():
	healthbar.value = health
	#hides the healthbar if at 100%
	healthbar.visible = health < 100

#there is a timer attached to the tank, everytime it times out, decrease/increase health
func _on_regen_timer_timeout():
	if GameManager.tank_mode:
		health -= 2
	else:
		health += 1
