extends CharacterBody2D

#region signals
signal addBullet(bullet)
signal toPlayerControl()
#endregion

#region variables
var health := 100:
	#introduce a setter that automatically clamps the health
	set(value):
		health = value
		health = clamp(health, 0, 100)

@export var SPEED = 200.0
const bulletPath: PackedScene = preload("res://Objects/Projectiles/bullet.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var healthbar = $healthbar
@onready var player = $"../Player"
#endregion

func _physics_process(delta):	
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
		
		#Toggle
		if Input.is_action_just_pressed("swap_mode"):
			GameManager.tank_mode = false
			toPlayerControl.emit()
			createPlayer()
			
func createPlayer():
	player.toggle(true)
	player.position = position + Vector2(-3,-36)

#region shooting
func shoot():
	var bullet = bulletPath.instantiate()
	
	var angle = $Sprites/Turret.rotation
	var direction = Vector2(cos(angle), sin(angle))
	bullet.position = $Sprites/Turret/MuzzleMarker.global_position
	bullet.direction = direction
	bullet.rotation_degrees = rad_to_deg(angle)
	
	addBullet.emit(bullet)
#endregion

#region healthAndDamage
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

#Enemy hitbox
func _on_hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		#TODO Refactor so each enemy has their own damage amount
		health -= 10
		update_health()
#endregion
