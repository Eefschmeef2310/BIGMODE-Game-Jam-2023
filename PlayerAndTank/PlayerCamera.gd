extends Camera2D

var camera_lerping := false
var freecamActive = false

#variables for handling the smooth zooming in/out
var camera_zoom_speed := 2.0
var camera_outer_zoom := 0.15
var camera_inner_zoom := 0.5
var camera_target_zoom
var smooth_zoom = 0.5
var camera_move_speed = 3

var cam_offset_tank = Vector2(350, -450)
var cam_offset_player = Vector2(0, -90)
var target_offset: Vector2

@onready var tank = $".."
@onready var player = $"../../Player"
@onready var upgrade = $"../Upgrade UI/UpgradeMarker"

func _ready():
	GameManager.camera = self
	target_offset = cam_offset_tank

func _process(delta):
	if (!freecamActive):
		make_current()
	if GameManager.tank_mode:
		camera_target_zoom = camera_outer_zoom
	else:
		camera_target_zoom = camera_inner_zoom
	offset = lerp(offset, target_offset, camera_move_speed*delta)
	zoom_camera(camera_target_zoom, delta)
	
	
#function for camera zoom lerp
func zoom_camera(zoomTarget, delta):
	smooth_zoom = lerp(smooth_zoom, zoomTarget, camera_zoom_speed * delta)
	if smooth_zoom != camera_inner_zoom:
		set_zoom(Vector2(smooth_zoom, smooth_zoom))

func _on_player_to_tank_control():
	reparent(tank)
	target_offset = cam_offset_tank
	position = Vector2.ZERO

func _on_tank_to_player_control():
	reparent(player)
	target_offset = cam_offset_player
	position = Vector2.ZERO

func _on_nyan_debug_cmd_freecam():
	freecamActive = true

func _on_nyan_debug_cmd_gamecam():
	freecamActive = false

func _on_upgrade_ui_to_upgrade_screen(screenActive):
	if screenActive:
		reparent(upgrade)
		target_offset = cam_offset_player
		position = Vector2.ZERO
	else:
		reparent(player)
		target_offset = cam_offset_player
		position = Vector2.ZERO
