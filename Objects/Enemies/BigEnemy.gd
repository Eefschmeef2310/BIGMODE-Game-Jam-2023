extends CharacterBody2D

var root

var health = 100

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	root = get_parent()

func _physics_process(delta):
	update_health()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var distance_to_tank = GameManager.tank_position.x - position.x
	var DIR = 1
	if distance_to_tank < 0:
		DIR = -1
	velocity.x = DIR * SPEED


	move_and_slide()
	
func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	#hides the healthbar if at 100%
	if health >= 100:
		healthbar.visible = false
	else: 
		healthbar.visible = true
		
	if health < 0:
		self.queue_free()
