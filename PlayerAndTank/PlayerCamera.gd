extends Camera2D

var camera_lerping := false

#variables for handling the smooth zooming in/out
var camera_zoom_speed := 2.0
var camera_outer_zoom := 0.5
var camera_inner_zoom := 1.5
var camera_target_zoom
var smooth_zoom = 0.5

func _process(delta):
	if GameManager.camera_lerping:
		if GameManager.tank_mode:
			camera_target_zoom = camera_outer_zoom
		else:
			camera_target_zoom = camera_inner_zoom
		zoom_camera(camera_target_zoom, delta)
		
#function for camera zoom lerp
func zoom_camera(zoom, delta):
	smooth_zoom = lerp(smooth_zoom, zoom, camera_zoom_speed * delta)
	if smooth_zoom != camera_inner_zoom:
		set_zoom(Vector2(smooth_zoom, smooth_zoom))
	else:
		camera_lerping = false
