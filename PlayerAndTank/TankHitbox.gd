extends Area2D

#region variables
var max_health := 100.0:
	set(value):
		if value > max_health:
			health += value - max_health
		max_health = value
var health := 100.0:
	#introduce a setter that automatically clamps the health
	set(value):
		health = value
		health = clamp(health, 0, max_health)
		
@onready var healthbar = $"../healthbar"

func _ready():
	update_health()

func _process(_delta):
	update_health()

#region healthAndDamage
#updates the health to the health bar
func update_health():
	healthbar.value = 100 * (health / max_health)
	#hides the healthbar if at 100%
	healthbar.visible = health < max_health

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
	
	if health <= 0:
		GameManager.game_over = true
#endregion
