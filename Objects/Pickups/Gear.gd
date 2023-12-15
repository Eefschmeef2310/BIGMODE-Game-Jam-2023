extends RigidBody2D

@onready var sprite = $Sprite2D
@export var texture_1: Texture
@export var texture_5: Texture
@export var texture_10: Texture
@export var value: int = 1:
	set(val):
		value = val
		change_texture()
		
var magnet_node: Node
var magnet_radius: float
@export var attract_speed: float = 3

func _ready():
	change_texture()
	$AnimationPlayer.play("Shine")
	$AnimationPlayer.seek(randf_range(0, 4))

func _process(delta):
	if magnet_node != null:
		var dist = magnet_node.global_position.distance_to(global_position)
		if dist < magnet_radius:
			var vel = global_position.direction_to(magnet_node.global_position)
			
			var speed = magnet_radius - dist
			speed = speed * attract_speed * delta
			vel = vel * speed
			
			global_position += vel
		else:
			magnet_node = null

func _on_area_2d_body_entered(body):
	if body.is_in_group("PlayerAndTank"):
		GameManager.gears += value
		$AnimationPlayer.play("pickup")

func _on_area_2d_area_entered(area):
	if area.is_in_group("Magnet"):
		magnet_node = area
		magnet_radius = global_position.distance_to(magnet_node.global_position) + 5

func change_texture():
	if sprite:
		match value:
			5:
				sprite.texture = texture_5
				$FloorCollider.shape.radius = 35
				$Area2D/CollisionShape2D.shape.radius = 35
			10:
				sprite.texture = texture_10
				$FloorCollider.shape.radius = 45
				$Area2D/CollisionShape2D.shape.radius = 45
			_:
				sprite.texture = texture_1
				$FloorCollider.shape.radius = 30
				$Area2D/CollisionShape2D.shape.radius = 30
