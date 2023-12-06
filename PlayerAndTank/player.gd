extends CharacterBody2D

signal toTankControl()

@export var SPEED = 100.0
@export var JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	toggle(false)

func _physics_process(delta):
	GameManager.tank_position = global_position
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * SPEED

	move_and_slide()
	
func toggle(activate: bool):
	visible = activate
	set_physics_process(activate)

func toTank():
	toTankControl.emit()
	GameManager.tank_mode = true
	toggle(false)

#TODO So far, this is a single hit kill, and doesn't account for jumping on enemies (if we're going for that) - E
func _on_enemy_hit_box_area_entered(area):
	if area.is_in_group("Enemy"):
		GameManager.game_over = true
