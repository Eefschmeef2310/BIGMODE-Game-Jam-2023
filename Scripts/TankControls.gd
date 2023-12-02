extends RigidBody2D

@export var Force : float
@export var Wheels : Array[PinJoint2D]
var WheelsRB : Array[RigidBody2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, Wheels.size()):
		WheelsRB.push_back(Wheels[i].get_node("wheel"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_axis("left", "right") as float
	
	for i in range(0, WheelsRB.size()):
		WheelsRB[i].apply_torque(direction * Force * delta * 10000)
		if(direction == 0):
			#HACK: if we can find a way to do this without completely locking the rotation (eg variable brakes) that might be better, but this is good enough for now
			WheelsRB[i].lock_rotation = true
		else:
			WheelsRB[i].lock_rotation = false
			pass
	

