shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

uniform float fade_scale : hint_range(0.0, 1.0) = 0.5;
uniform sampler2D noise_texture;
//uniform sampler2D base_texture : hint_default_black;

void fragment() {
	//Get height threshold of noise
	float height_cutoff = round(mix(fade_scale, texture(noise_texture, UV).r, 0.5));
	
	float mask = texture(TEXTURE, UV).a;

	//Set final albedo (if height in noise is higher than cutoff, use end colour, otherwise do base color)
	COLOR = vec4(mix(texture(SCREEN_TEXTURE, SCREEN_UV).rgb, texture(TEXTURE, UV).rgb, step(height_cutoff, 0.0)), mask);
}