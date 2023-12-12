shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

uniform vec2 scale;
uniform float y_zoom;

uniform vec4 water_color : source_color;
uniform sampler2D noise : repeat_enable;

uniform vec2 distortion_scale;
uniform float intensity;
uniform float speed;

uniform float wave_amplitude;
uniform float wave_speed;
uniform float wave_period;

void fragment() {

    float waves = UV.y * scale.y + sin(UV.x * scale.x / wave_period - TIME * wave_speed) * cos(0.2 * UV.x * scale.x / wave_period * TIME - wave_speed) *
        wave_amplitude - wave_amplitude;

    float distortion = texture(noise, UV * scale * distortion_scale + TIME * speed).x;
    distortion -= 0.5;

    float uv_height = SCREEN_PIXEL_SIZE.y / TEXTURE_PIXEL_SIZE.y;
	vec2 reflected = vec2(SCREEN_UV.x - distortion * intensity, SCREEN_UV.y - uv_height * UV.y * y_zoom * scale.y * 2.0);
	vec4 reflection = texture(SCREEN_TEXTURE, reflected);

    // Use mask texture to define the irregular shape
    float mask_value = texture(TEXTURE, UV).b;

    // Adjust darkness based on the mask value
    float edge_darkening = smoothstep(0.6, 1.0, mask_value);

    // Mix the reflection color with the water color based on the edge darkness
    COLOR.rgb = mix(reflection.rgb, water_color.rgb, water_color.a);
	COLOR.a = water_color.a * edge_darkening;
	
	//COLOR.rgb = mix(texture(SCREEN_TEXTURE, SCREEN_UV).rgb, COLOR.rgb, mask_value);

    // Waves
    //COLOR.rgb = vec3(smoothstep(0.1, 0.13, waves));
}
