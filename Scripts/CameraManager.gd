extends Node3D

@export var fpsCamera : Camera3D
@export var transCamera : Camera3D
@export var topDownCamera : Camera3D

@export var fpsRotHelper : Node3D #get x
@export var playerObj : Node3D #get y

var startPos : Vector3
var startRot : Vector3
var endPos : Vector3
var endRot : Vector3

var currentLerpTime = 0
@export var maxLerpTime = 3

signal topDownReady
signal topDownDisable

signal fpsReady
signal fpsDisable

var currentMode = 0 
	# 0: topDown
	# 1: switching to fps
	# 2: fps
	# 3: swithing to topdown

# Called when the node enters the scene tree for the first time.
func _ready():
	topDownReady.emit()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currentLerpTime += delta
	if(currentLerpTime > maxLerpTime && (currentMode == 1 || currentMode == 3) ) : currentMode+=1
	if(currentMode > 3): currentMode = 0
	
	if(currentMode == 0): 
		topDownCamera.make_current()
		topDownReady.emit()
	if(currentMode == 1): 
		transCamera.make_current()
		topDownDisable.emit()
	if(currentMode == 2): 
		fpsCamera.make_current()
		fpsReady.emit()
	if(currentMode == 3): 
		transCamera.make_current()
		fpsDisable.emit()
		topDownDisable.emit()
	
	if(currentMode == 1 || currentMode == 3):
		transCamera.global_position = lerpPos()
		transCamera.rotation = lerpRot()

func _input(event):
		# switch MODE
	if Input.is_action_just_pressed("switch") && currentMode != 1 && currentMode != 3:
		if(currentMode == 0):
			transCamera.global_position = topDownCamera.global_position
			startPos = topDownCamera.global_position
			startRot = topDownCamera.rotation
			endPos = fpsCamera.global_position
			endRot = Vector3(fpsRotHelper.rotation.x , playerObj.rotation.y, 0)
			currentLerpTime = 0
		
		if(currentMode == 2):
			transCamera.global_position = fpsCamera.global_position
			startPos = fpsCamera.global_position
			startRot = Vector3(fpsRotHelper.rotation.x , playerObj.rotation.y, 0)
			endPos = topDownCamera.global_position
			endRot = topDownCamera.rotation
			currentLerpTime = 0
		
		currentMode += 1
		
		#if(currentMode > 3): currentMode = 0
		

func lerpPos():
	return lerp(startPos, endPos, currentLerpTime/maxLerpTime)
	
	
func lerpRot():
	return lerp(startRot, endRot, currentLerpTime/maxLerpTime)
