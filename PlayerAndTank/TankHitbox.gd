extends Area2D

#region variables
var max_health := 100
var health := 100:
	#introduce a setter that automatically clamps the health
	set(value):
		health = value
		health = clamp(health, 0, max_health)
		
@onready var healthbar = $"../healthbar"

func _ready():
	update_health()

func _process(delta):
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
	
	if health <= 0:
		GameManager.game_over = true
#endregion


func _on_body_entered(body): #tank tread hitbox
	print(body.name)
	if body.is_in_group("SmallEnemy"):
		body.hit(999)
	#if its the small enemy
	#destroy them (hp = 0)
	pass # Replace with function body.
