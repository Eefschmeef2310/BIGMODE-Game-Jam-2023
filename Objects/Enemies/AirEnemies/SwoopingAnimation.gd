extends AnimatedSprite2D

@onready var _animated_sprite = $"../Frames"
@onready var enemy = $".."

var calculatedYVelocity
var lastPosition

var state := "idle"

# Called when the node enters the scene tree for the first time.
func _ready():
	lastPosition = position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	calculatedYVelocity = (lastPosition-enemy.position.y)/delta
	#print("calculated y velocity is: (" + str(lastPosition) + "-" + str(enemy.position.y) + ")/" + str(delta) + " = " + str(calculatedYVelocity))
	lastPosition = enemy.position.y
	
	if (calculatedYVelocity < -100) and (state == "idle"):
		state = "swooping"
		#print("swooping")
		_animated_sprite.play("swoop down")
	elif (calculatedYVelocity > 0) and (state == "swooping"):
		state = "climbing"
		#print("climbing")
		_animated_sprite.play("climbing")
	elif (calculatedYVelocity > 500) and (state == "climbing"):
		state = "slowing down"
		#print("slowing down")
	elif (calculatedYVelocity < 500) and (state == "slowing down"):
		state = "transitioning"
		#print("transitioning")
		_animated_sprite.play("transition")
	elif (calculatedYVelocity < 50) and (state == "transitioning"):
		state = "idle"
		#print("idle")
		_animated_sprite.play("flying")
	
	#print(delta)
	#print(calculatedYVelocity)
