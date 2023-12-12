shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

uniform vec2 center;
uniform float force;
uniform float size;
uniform float thickness;

uniform float abberation_strength = 0.05;

void fragment() {
    float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
    vec2 scaledUV = (SCREEN_UV - vec2(0.5, 0.0)) / vec2(ratio, 1.0) + vec2(0.5,0.0);
    float mask = (1.0 - smoothstep(size-0.1, size, length(scaledUV - center))) * 
        smoothstep(size - thickness - 0.1, size - thickness, length(scaledUV - center));
    vec2 disp = normalize(scaledUV - center) * force * mask;
    
    // Chromatic aberration
    float redChannel = texture(SCREEN_TEXTURE, SCREEN_UV - disp * (1.0 + abberation_strength)).r;
    float greenChannel = texture(SCREEN_TEXTURE, SCREEN_UV - disp).g;
    float blueChannel = texture(SCREEN_TEXTURE, SCREEN_UV - disp * (1.0 - abberation_strength)).b;
    
    COLOR.rgb = vec3(redChannel, greenChannel, blueChannel);
    
    // Uncomment this line to view the shape independent of the screen texture
    //COLOR.rgb = vec3(mask);
}