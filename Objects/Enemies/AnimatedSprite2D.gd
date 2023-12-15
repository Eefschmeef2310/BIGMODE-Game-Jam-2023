@tool
extends AnimatedSprite2D

func _process(_delta):
	(material as ShaderMaterial).set_shader_parameter("base_texture", frame)
