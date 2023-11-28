extends Sprite2D

func _process(_delta):
	(material as ShaderMaterial).set_shader_parameter("speed", CarGlobals.gameSpeed)
