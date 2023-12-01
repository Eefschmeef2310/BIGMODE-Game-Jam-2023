extends Camera2D

var camera_lerping := false

#variables for handling the smooth zooming in/out
var camera_zoom_speed := 2.0
var camera_outer_zoom := 0.5
var camera_inner_zoom := 1.5
var camera_target_zoom
var smooth_zoom = 0.5

@onready var tank = $".."
@onready var player = $"../../Player"

func _process(delta):
	if GameManager.tank_mode:
		camera_target_zoom = camera_outer_zoom
	else:
		camera_target_zoom = camera_inner_zoom
	zoom_camera(camera_target_zoom, delta)
		
#function for camera zoom lerp
func zoom_camera(zoomTarget, delta):
	smooth_zoom = lerp(smooth_zoom, zoomTarget, camera_zoom_speed * delta)
	if smooth_zoom != camera_inner_zoom:
		set_zoom(Vector2(smooth_zoom, smooth_zoom))

func _on_player_to_tank_control():
	reparent(tank)

func _on_tank_to_player_control():
	reparent(player)
