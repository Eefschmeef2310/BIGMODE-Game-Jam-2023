extends CharacterBody2D
class_name BaseCharacter

# Horizontal movement
var max_speed = 300.0
var acceleration = 300.0
var deceleration = 300.0

# Jumping and gravity
var jump_speed = -600.0
var air_jump_speed = -400.0
var rise_factor = 1
var fall_factor = 1.75
var jump_phase = 0
var max_air_jumps = 0;
var jump_requested = false
var jump_is_held = false
var is_jumping = false
var coyote_time = 0.2
var coyote_counter = 0.0
var jump_buffer_time = 0.2
var jump_buffer_counter = 0.0

# Global movement scales
var move_factor = 1
var jump_factor = 1
var gravity_factor = 1

# Input
var move_direction: float
var can_change_direction: bool = true

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Lauren variables
@onready var _animated_sprite = $AnimatedSprite2D
var is_falling = false
var is_landing = true
signal toTankControl()

func _ready():
	toggle(false)

func _process(_delta):
	GameManager.tank_position = global_position
	
	#Input
	move_direction = Input.get_axis("left", "right")
	if Input.is_action_just_pressed("jump"):
		jump()
	if Input.is_action_just_released("jump"):
		jump_release()
	
	handle_animations()
	$"../Tank/Upgrade UI".visible = global_position.distance_to($"../Tank/Upgrade UI/UpgradeMarker".global_position) < 150

func _physics_process(delta):
	# Handle movement.
	var desired_velocity = move_direction * max_speed * move_factor
	if desired_velocity != 0:
		velocity = velocity.move_toward(Vector2(desired_velocity, velocity.y), acceleration)
	else:
		velocity = velocity.move_toward(Vector2(0, velocity.y), deceleration)
		
	# Flip based on movement input.
	if can_change_direction:
		update_direction()
		
	# Handle jumping.
	if is_on_floor() and velocity.y == 0:
		jump_phase = 0
		coyote_counter = coyote_time
		is_jumping = false
	else:
		coyote_counter -= delta
	
	if jump_buffer_counter > 0:
		jump_buffer_counter -= delta
		try_jump()
		
	# Add the gravity.
	if jump_is_held and velocity.y < 0:
		velocity.y += gravity * delta * rise_factor
	elif !jump_is_held or velocity.y > 0:
		velocity.y += gravity * delta * fall_factor
	elif velocity.y == 0:
		velocity.y  += gravity * delta
	
	# Move and slide.
	move_and_slide()

func move(direction: float):
	move_direction = direction

func jump():
	jump_is_held = true
	jump_buffer_counter = jump_buffer_time
	
func try_jump():
	if coyote_counter > 0 or (jump_phase < max_air_jumps and is_jumping):
		if is_jumping:
			jump_phase += 1
			
		coyote_counter = 0
		jump_buffer_counter = 0
		is_jumping = true
		
		# Does not use air jump speed at all right now
		velocity.y = jump_speed * jump_factor

func jump_release():
	jump_is_held = false

func update_direction():
	if move_direction != 0:
		scale.x = scale.y * sign(move_direction)

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

#handles all animations
func handle_animations():
	#jumping animations
	if not is_on_floor():
		if (velocity.y < 0):
			_animated_sprite.play("jumping")
		elif (velocity.y > 0):
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
			if move_direction != 0:
					_animated_sprite.play("run")
					is_landing = false
			elif not (is_landing):
				_animated_sprite.play("idle")
				
	$"../Tank/Upgrade UI".visible = global_position.distance_to($"../Tank/Upgrade UI/UpgradeMarker".global_position) < 150

func _on_animated_sprite_2d_animation_finished():
	if (is_landing == true):
		is_landing = false