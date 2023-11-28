extends CharacterBody2D

signal carBreakdown()
signal carReturn()

@export var speed: float = 1.0

func _process(_delta):
	if CarGlobals.carMode:
		var direction = Input.get_vector("Left", "Right", "Up", "Down")
		velocity = direction * speed
		move_and_slide()
	elif Input.is_action_pressed("CarReset"):
		carReturn.emit()
		CarGlobals.carMode = true
		CarGlobals.carHealth = 100

func hit():
	CarGlobals.carHealth -= 10;
	if(CarGlobals.carHealth <= 0):
		CarGlobals.carMode = false
		carBreakdown.emit()
