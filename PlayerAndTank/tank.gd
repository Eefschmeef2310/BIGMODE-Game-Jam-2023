extends RigidBody2D

#region signals
signal addBullet(bullet)
signal toPlayerControl()
#endregion

#region variables
var max_health : float = 100
var health := max_health:
	#introduce a setter that automatically clamps the health
	set(value):
		health = value
		health = clamp(health, 0, max_health)

@export var SPEED = 400.0

# Bullets
const bulletPath: PackedScene = preload("res://Objects/Projectiles/bullet.tscn")
var extra_bullets: int = 0
var extra_bullet_angle_offset = 0
var fire_rate: float = 0.5
var time_until_next_shot: float = 0.0

# Rockets
const rocket_path: PackedScene = preload("res://Objects/Projectiles/rocket.tscn")
var rocket_fire_rate: float = 5
var time_until_next_rocket: float = 0
var has_rockets: bool = false
var rocket_level: int = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var healthbar = $healthbar
@onready var player = $"../Player"

@export var Wheels : Array[PinJoint2D] #add all the wheel prefabs to this array
var WheelsRB : Array[RigidBody2D]
#endregion

#referenced for animating the tank treads
@onready var treads = $Sprites/TankTreads
@onready var wheel1 = $Sprites/TankWheel1
@onready var wheel2 = $Sprites/TankWheel2
@onready var wheel3 = $Sprites/TankWheel3
var rotate_speed = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.tank_mode = true
	for i in range(0, Wheels.size()): #get the actual rigidbody of each wheel
		WheelsRB.push_back(Wheels[i].get_node("wheel"))

func _physics_process(delta):	
	if GameManager.tank_mode:
		GameManager.tank_position = global_position
		
		var direction = Input.get_axis("left", "right") as float
		
		#for wheel animations
		rotate_speed = (SPEED / 200) * direction
		
		
		#Set dust particles
		$PinJoint2D3/Dust.emitting = direction == -1;
		$PinJoint2D4/Dust.emitting = direction == 1;
	
		for i in range(0, WheelsRB.size()):
			WheelsRB[i].apply_torque(direction * SPEED * delta * 10000)
			if(direction == 0):
				#HACK: if we can find a way to do this without completely locking the rotation (eg variable brakes) that might be better, but this is good enough for now
				WheelsRB[i].lock_rotation = true
			else:
				WheelsRB[i].lock_rotation = false
				pass
		
		#handle bullet firing
		if time_until_next_shot > 0:
			time_until_next_shot -= delta
		if time_until_next_shot <= 0.0 and Input.is_action_pressed("fire"):
			time_until_next_shot = fire_rate
			shoot()
			
		#handle rocket firing
		if has_rockets:
			if time_until_next_rocket > 0:
				time_until_next_rocket -= delta
			if time_until_next_rocket <= 0.0 and Input.is_action_just_pressed("secondary"):
				time_until_next_rocket = rocket_fire_rate
				shoot_rocket()
		
		# Move invisible player along for the ride
		if player.visible == false:
			player.global_position =  $PlayerHatch/PlayerSpawnPos.global_position
		
		#Toggle
		if Input.is_action_just_pressed("swap_mode"):
			GameManager.tank_mode = false
			toPlayerControl.emit()
			createPlayer()
	else:
		rotate_speed = 0
	treads.speed_scale = rotate_speed
	wheel1.rotation_degrees += rotate_speed
	wheel2.rotation_degrees += rotate_speed
	wheel3.rotation_degrees += rotate_speed
				
func createPlayer():
	player.toggle(true)
	player.global_position =  $PlayerHatch/PlayerSpawnPos.global_position
	player.velocity.y = -1000

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

func shoot_rocket():
	var rocket = rocket_path.instantiate()
	var angle = $Sprites/Turret.global_rotation
	var direction = Vector2(cos(angle), sin(angle))
	rocket.position = $Sprites/Turret/MuzzleMarker.global_position
	rocket.direction = direction
	rocket.rotation_degrees = rad_to_deg(angle)
	rocket.rocket_level = rocket_level
	addBullet.emit(rocket)
#endregion

#region healthAndDamage
#updates the health to the health bar
func update_health():
	healthbar.value = health / max_health
	#hides the healthbar if at 100%
	healthbar.visible = health < max_health
	if health <= 0:
		GameManager.game_over = true

#there is a timer attached to the tank, everytime it times out, decrease/increase health
func _on_regen_timer_timeout():
	if GameManager.tank_mode:
		health -= 2
	else:
		health += 1

func _on_nyan_debug_cmd_stuck():
	position.y -= 100
