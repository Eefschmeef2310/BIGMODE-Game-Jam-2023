extends Area2D

#region variables
var health := 100:
	#introduce a setter that automatically clamps the health
	set(value):
		health = value
		health = clamp(health, 0, 100)
		
@onready var healthbar = $"../healthbar"

func _ready():
	update_health()

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
func deal_damage(damage):
	health -= damage
	update_health()
#endregion
