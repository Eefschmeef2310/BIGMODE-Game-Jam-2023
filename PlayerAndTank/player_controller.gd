extends CharacterBody2D
class_name BaseCharacter

# Horizontal movement
var max_speed = 300.0
var acceleration = 300.0
var deceleration = 300.0

# Jumping and gravity
var jump_speed = -650.0
var air_jump_speed = -400.0
var rise_factor = 1
var fall_factor = 2
var jump_phase = 0
var max_air_jumps = 0;
var jump_requested = false
var jump_is_held = false
var is_jumping = false
var coyote_time = 0.2
var coyote_counter = 0.0
var jump_buffer_time = 0.2
var jump_buffer_counter = 0.0

# Jetpack params
var hover_factor = 0.1
var max_hover_velocity = 10
var max_hover_time = 0
var hover_counter = 0
var hover_recover_rate = 1.5

# Magnet params
@onready var magnet_shape = $GearMagnet/CollisionShape2D
var magnet_radius = 0:
	set(value):
		magnet_radius = value
		if magnet_shape:
			magnet_shape.shape.radius = value

# Invisibility params
var max_invis_time = 3.0:
	set(value):
		max_invis_time = value
		invis_counter = value
		invis_recovering = false
var invis_counter = max_invis_time
var invis_cooldown_rate = 0.5
var invis_recovering = false
var is_invisible = false

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
@onready var sprite_animator = $SpriteAnimator
var is_falling = false
var is_landing = true
signal toTankControl()

var killY = 9999

func _ready():
	toggle(false)

func _process(_delta):
	if !is_invisible:
		GameManager.tank_position = global_position
	
	if position.y > killY || GameManager.tank_position.y > killY:
		GameManager.game_over = true
		
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
	if is_on_floor():
		jump_phase = 0
		coyote_counter = coyote_time
		is_jumping = false
		if hover_counter < max_hover_time:
			hover_counter += hover_recover_rate * delta
		else:
			hover_counter = max_hover_time
	else:
		coyote_counter -= delta
	
	if jump_buffer_counter > 0:
		jump_buffer_counter -= delta
		try_jump()
		
	# Handle hovering.
	if !is_on_floor() and velocity.y > 0 and jump_is_held and hover_counter > 0:
		hover_counter -= delta
		if velocity.y > max_hover_velocity:
			velocity.y = lerpf(velocity.y, max_hover_velocity, 0.1)
		$HoverParticles.emitting = true
	else:
		$HoverParticles.emitting = false
	
	# Handle invisibility
	if is_invisible:
		invis_counter -= delta
		if invis_counter <= 0 or Input.is_action_just_pressed("secondary"):
			is_invisible = false
			$ShaderAnimator.play("outInvisibility");
			invis_recovering = true
	elif invis_recovering:
		if invis_counter < max_invis_time:
			invis_counter += invis_cooldown_rate * delta
		else:
			invis_counter = max_invis_time
			invis_recovering = false
			
		if Input.is_action_just_pressed("secondary") and max_invis_time > 0:
			is_invisible = true
			$ShaderAnimator.play("toInvisibility");
	else:
		if Input.is_action_just_pressed("secondary") and max_invis_time > 0:
			is_invisible = true
			$ShaderAnimator.play("toInvisibility");
	
	# Hover meter
	$Bars/HoverCooldown.value = 100 * (hover_counter / max_hover_time)
	$Bars/HoverCooldown.visible = max_hover_time > 0 and $Bars/HoverCooldown.value < 100
	
	# Invis meter
	$Bars/InvisCooldown.value = 100 * (invis_counter / max_invis_time)
	$Bars/InvisCooldown.visible = max_invis_time > 0 and $Bars/InvisCooldown.value < 100
		
	# Add the gravity.
	if jump_is_held and velocity.y < 0:
		velocity.y += gravity * delta * rise_factor
	elif jump_is_held and velocity.y > 0 and hover_counter > 0:
		velocity.y += gravity * delta * hover_factor
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

func force_jump():
	coyote_counter = 0
	jump_buffer_counter = 0
	is_jumping = true
	
	# Does not use air jump speed at all right now
	velocity.y = jump_speed * jump_factor

func jump_release():
	jump_is_held = false

func update_direction():
	if move_direction != 0:
		$AnimatedSprite2D.flip_h = move_direction < 0

func toggle(activate: bool):
	visible = activate
	hover_counter = max_hover_time
	invis_counter = 0
	if activate:
		process_mode = Node.PROCESS_MODE_INHERIT
		$Line2D.curve.clear_points()
	else:
		process_mode = Node.PROCESS_MODE_DISABLED

func toTank():
	toTankControl.emit()
	GameManager.tank_mode = true
	toggle(false)

#handles all animations
func handle_animations():
	#jumping animations
	
	if not is_on_floor():
		if (velocity.y < 0):
			sprite_animator.play("Jump")
		elif (velocity.y > 0):
			sprite_animator.play("Falling")
			is_falling = true
		else:
			sprite_animator.play("midair")
	else:
		if (is_falling == true):
			is_falling = false
			is_landing = true
			sprite_animator.play("Land")
		else:
			if move_direction != 0:
					sprite_animator.play("Run")
					is_landing = false
			elif not (is_landing):
				sprite_animator.play("Idle")
				
	$"../Tank/Upgrade UI".visible = global_position.distance_to($"../Tank/Upgrade UI/UpgradeMarker".global_position) < 150

func _on_animated_sprite_2d_animation_finished():
	if (is_landing == true):
		is_landing = false


func _on_sprite_animator_current_animation_changed(_name):
	$Resetter.play("RESET")
