@tool
extends Sprite2D

func _process(delta):
	zoom_changed()

func _on_item_rect_changed():
	(material as ShaderMaterial).set_shader_parameter("scale", scale)

func zoom_changed():
	(material as ShaderMaterial).set_shader_parameter("y_zoom", get_viewport().global_canvas_transform.y.y)
