extends CharacterBody2D

signal carBreakdown()
signal carReturn()

@onready var player = $"../Player"

@export var speed: float = 500.0
@export var healthIncrease: float = 0.1

func _process(delta):
	if CarGlobals.carMode:
		var direction = Input.get_vector("Left", "Right", "Up", "Down")
		velocity = direction * speed
		move_and_slide()
		
		if Input.is_action_just_pressed("Space"):
			CarGlobals.carMode = false
			carBreakdown.emit()
			createPlayer()
		
		CarGlobals.playerHealth += healthIncrease * delta
	else:
		CarGlobals.carHealth += healthIncrease * delta
		
func createPlayer():
	player.toggle(true)
	player.position = position + Vector2.DOWN * 120

func _on_player_start_car():
	carReturn.emit()
	CarGlobals.carMode = true
