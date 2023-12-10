extends Control

@export var scroll_direction = 1

@export var texture_default: Texture
@export var texture_hover: Texture
@export var texture_locked: Texture

var is_mouse_hovered = false

signal scroll_category(direction: int)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		scroll_category.emit(scroll_direction)

func _on_mouse_entered():
	is_mouse_hovered = true
	$bg.texture = texture_hover

func _on_mouse_exited():
	is_mouse_hovered = false
	$bg.texture = texture_default
