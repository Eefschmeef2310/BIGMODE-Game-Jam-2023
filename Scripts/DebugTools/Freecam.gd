extends Camera2D

@export var baseSpeed = 1.0
@export var baseZoom = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previousframe.
func _process(delta):
	if Input.is_key_pressed(KEY_W):
		position.y -= (baseSpeed/baseZoom) * delta
	if Input.is_key_pressed(KEY_S):
		position.y += (baseSpeed/baseZoom) * delta
	if Input.is_key_pressed(KEY_D):
		position.x += (baseSpeed/baseZoom) * delta
	if Input.is_key_pressed(KEY_A):
		position.x -= (baseSpeed/baseZoom) * delta
	if Input.is_key_pressed(KEY_Q):
		baseZoom -= delta*baseZoom
		zoom = Vector2(baseZoom,baseZoom)
	if Input.is_key_pressed(KEY_E):
		baseZoom += delta*baseZoom
		zoom = Vector2(baseZoom,baseZoom)
