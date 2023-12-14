extends RigidBody2D

@onready var sprite = $Sprite2D
@export var texture_1: Texture
@export var texture_5: Texture
@export var texture_10: Texture
@export var value: int = 1:
	set(val):
		value = val
		change_texture()

func _ready():
	change_texture()
	$AnimationPlayer.play("Shine")
	$AnimationPlayer.seek(randf_range(0, 4))

func _on_area_2d_body_entered(body):
	if body.is_in_group("PlayerAndTank"):
		GameManager.gears += value
		queue_free()

func change_texture():
	if sprite:
		print("yea")
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
