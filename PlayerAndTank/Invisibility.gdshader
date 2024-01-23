shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

uniform float target_opacity: hint_range(0.0, 1.0) = 0.5;

void fragment() {
	//Make sure the final sprite is the same shape
	float mask = texture(TEXTURE, UV).a;
	
	COLOR.a = target_opacity * mask;
}
