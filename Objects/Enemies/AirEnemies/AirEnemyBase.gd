extends Area2D

@export var SPEED = 200.0
@export var health = 20
@export var tank_damage = 10

@export var tank_height: float = 750
@export var player_height: float = 200
@export var lerp_speed: float = 0.5

var dead: bool = false
var xPos: float
var yPos: float

#TODO FIXME Make sure enemies follow inheritance! The script is used across ALL inherited classes
#So something referencing specific sprites may not be present on children! - E
@onready var _animated_sprite = $Frames


func _ready():
	$HealthBar.max_value = health
	$HealthBar.value = health
	$HealthBar.visible = false

func _process(delta):
	#for flipping sprite animations
	var distance_to_tank = GameManager.tank_position.x - position.x
	
	if _animated_sprite:
		_animated_sprite.flip_h = 0
		if distance_to_tank < 0:
			_animated_sprite.flip_h = 1
		
	if !dead:
		xPos = GameManager.tank_position.x
		#yPos = GameManager.tank_position.y - height
		if GameManager.tank_mode:
			yPos = GameManager.camera.get_screen_center_position().y - tank_height
		else:
			yPos = GameManager.camera.get_screen_center_position().y - player_height
		
		position = lerp(position, Vector2(xPos, yPos), delta)
	
#Apply damage on projectile hit
func hit(damage):
	health -= damage
	$HealthBar.value = health
	$HealthBar.visible = true
	
	if(health <= 0) and dead == false:
		dead = true
		ScoreManager.enemiesKilled += 1
		GameManager.drop_gears(global_position, 3)
		$AnimationPlayer.play("Death")

func _on_drop_timer_add_item(item):
	get_parent().add_child(item)

func _on_area_entered(area):
	if !dead and "deal_damage" in area:
		area.deal_damage(tank_damage)
