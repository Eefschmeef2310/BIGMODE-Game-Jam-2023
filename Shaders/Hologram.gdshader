shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

// Uniforms
uniform float speed = 1.0;
uniform float intensity = 1.0;

void fragment() {
    // Calculate the position of the lines based on the y coordinate
    //float y = mod(UV.y + TIME * period, 1.0);
    //
    //// Calculate the brightness of the lines
    //float brightness = 1.0 - intensity * smoothstep(0.0, 1.0, y);
    //
    //// Apply the brightness to the original color
    //vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV);
    //col.rgb *= brightness;
    //
    //// Output the final color
    //COLOR = col;
	
	float sineBrightness = abs(sin(UV.y + TIME * speed)) - 0.1;
	float totalBrightness = (1.0 - sineBrightness) * intensity;
	
	vec2 modUV = vec2(UV.x, mod(UV.y + TIME * speed, 1.0));
	
	vec4 tex = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	COLOR = tex * vec4(totalBrightness);
}
