extends RigidBody2D

#region signals
signal addBullet(bullet)
signal toPlayerControl()
#endregion

#region variables
var max_health : int = 100
var health := max_health:
	#introduce a setter that automatically clamps the health
	set(value):
		health = value
		health = clamp(health, 0, max_health)

@export var SPEED = 400.0
const bulletPath: PackedScene = preload("res://Objects/Projectiles/bullet.tscn")
var extra_bullets: int = 0
var extra_bullet_angle_offset = 0
var fire_rate: float = 0.5
var time_until_next_shot: float = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var healthbar = $healthbar
@onready var player = $"../Player"

@export var Wheels : Array[PinJoint2D] #add all the wheel prefabs to this array
var WheelsRB : Array[RigidBody2D]
#endregion

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.tank_mode = true
	for i in range(0, Wheels.size()): #get the actual rigidbody of each wheel
		WheelsRB.push_back(Wheels[i].get_node("wheel"))

func _physics_process(delta):	
	if GameManager.tank_mode:
		GameManager.tank_position = global_position
		
		#handle bullet firing
		time_until_next_shot -= delta
		if time_until_next_shot <= 0.0 and Input.is_action_pressed("fire"):
			time_until_next_shot = fire_rate
			shoot()
		#region old_code
		## Add the gravity.
		#if not is_on_floor():
			#velocity.y += gravity * delta
		## Get the input direction and handle the movement/deceleration.
		#var direction = Input.get_axis("left", "right")
		#if direction:
			#velocity.x = direction * SPEED
		#else:
			#velocity.x = move_toward(velocity.x, 0, SPEED)
		#move_and_slide()
		#endregion
		#TODO ^remove
		
		var direction = Input.get_axis("left", "right") as float
	
		for i in range(0, WheelsRB.size()):
			WheelsRB[i].apply_torque(direction * SPEED * delta * 10000)
			if(direction == 0):
				#HACK: if we can find a way to do this without completely locking the rotation (eg variable brakes) that might be better, but this is good enough for now
				WheelsRB[i].lock_rotation = true
			else:
				WheelsRB[i].lock_rotation = false
				pass
		
		#Toggle
		if Input.is_action_just_pressed("swap_mode"):
			GameManager.tank_mode = false
			toPlayerControl.emit()
			createPlayer()
			
func createPlayer():
	player.toggle(true)
	player.global_position =  $PlayerHatch/PlayerSpawnPos.global_position

#region shooting
func shoot():
	var middle_angle = $Sprites/Turret.global_rotation
	spawn_bullet(middle_angle)
	for i in extra_bullets:
		print(i)
		spawn_bullet(middle_angle + (extra_bullet_angle_offset * (i + 1)))
		spawn_bullet(middle_angle - (extra_bullet_angle_offset * (i + 1))) 

func spawn_bullet(angle: float):
	var bullet = bulletPath.instantiate()
	
	var direction = Vector2(cos(angle), sin(angle))
	bullet.position = $Sprites/Turret/MuzzleMarker.global_position
	bullet.direction = direction
	bullet.rotation_degrees = rad_to_deg(angle)
	
	addBullet.emit(bullet)
#endregion

#region healthAndDamage
#updates the health to the health bar
func update_health():
	healthbar.value = health / max_health
	#hides the healthbar if at 100%
	healthbar.visible = health < max_health

#there is a timer attached to the tank, everytime it times out, decrease/increase health
func _on_regen_timer_timeout():
	if GameManager.tank_mode:
		health -= 2
	else:
		health += 1

func _on_nyan_debug_cmd_stuck():
	position.y -= 100
