extends RigidBody2D

@export var damage: float = 10

var explosion_active: bool = false
var explosion_radius: int = 400

#TODO make this animation based - E

func _ready():
	$Area2D/ExplosionHitbox.visible = false
	$Area2D.set_process(false)

func _on_explosion_timer_timeout():
	if !explosion_active:
		explosion_active = true
		$ExplosionTimer.start()
		$Area2D/ExplosionHitbox.visible = true
		$Area2D.set_process(true)
	else:
		queue_free()

func _on_area_2d_area_entered(area):
	if "deal_damage" in area:
		area.deal_damage(damage)
