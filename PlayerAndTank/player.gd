extends CharacterBody2D

signal toTankControl()

var max_speed = 300.0
@export var JUMP_VELOCITY = -600.0

@export var midair_buffer = 100
var is_falling = false
var is_landing = true

@onready var _animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	toggle(false)

#handles all animations
func _process(_delta):
	if Input.is_action_pressed("right"):
		_animated_sprite.flip_h = 0
	if Input.is_action_pressed("left"):
		_animated_sprite.flip_h = 1
	#jumping animations
	if not is_on_floor():
		if (velocity.y < (midair_buffer*(-1))):
			_animated_sprite.play("jumping")
		elif (velocity.y > midair_buffer):
			_animated_sprite.play("falling")
			is_falling = true
		else:
			_animated_sprite.play("midair")
	else:
		if (is_falling == true):
			is_falling = false
			is_landing = true
			_animated_sprite.play("land")
		else:
			if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
					_animated_sprite.play("run")
					is_landing = false
			elif not (is_landing):
				_animated_sprite.play("idle")
				
	$"../Tank/Upgrade UI".visible = global_position.distance_to($"../Tank/Upgrade UI/UpgradeMarker".global_position) < 150
	
func _on_animated_sprite_2d_animation_finished():
	if (is_landing == true):
		is_landing = false


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
	velocity.x = direction * max_speed

	move_and_slide()
	
func toggle(activate: bool):
	visible = activate
	if activate:
		process_mode = Node.PROCESS_MODE_INHERIT
	else:
		process_mode = Node.PROCESS_MODE_DISABLED

func toTank():
	toTankControl.emit()
	GameManager.tank_mode = true
	toggle(false)

#TODO So far, this is a single hit kill, and doesn't account for jumping on enemies (if we're going for that) - E
func _on_enemy_hit_box_area_entered(area):
	if area.is_in_group("Enemy"):
		GameManager.game_over = true
