extends CharacterBody2D

signal startCar()
signal addBullet(bullet)

@export var speed: float = 500.0
@export var carDistance: float = 250.0
var bullet_scene: PackedScene = preload("res://Car Test/Bullet.tscn")

func _ready():
	toggle(false)

func _process(_delta):
	#Movement
	var movementDirection = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = movementDirection * speed
	move_and_slide()
	CarGlobals.playerPos = global_position
		
	if Input.is_action_just_pressed("Fire"):
		var bullet = bullet_scene.instantiate() as Area2D
		addBullet.emit(bullet)
		bullet.position = $EndOfGun.global_position
		var direction = (get_global_mouse_position() - $EndOfGun.global_position).normalized()
		bullet.direction = direction
		bullet.rotation_degrees = rad_to_deg(direction.angle())
		
	if Input.is_action_just_pressed("Space") and global_position.distance_to($"../Car".global_position) <= carDistance:
		startCar.emit()
		toggle(false)
	
func toggle(activate: bool):
	visible = activate
	set_process(activate)

func _on_hit_box_area_entered(area):
	if area.is_in_group("Enemies"):
		CarGlobals.playerHealth -= 10
		if CarGlobals.playerHealth <= 0:
			print('You lose!')
			Engine.time_scale = 0.0
