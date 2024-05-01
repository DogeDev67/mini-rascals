shader_type canvas_item;

uniform float scanline_count : hint_range(0, 1800) = 50.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;


vec2 uv_curve(vec2 uv) {
	uv = (uv - 0.5) * 2.0;
	
	// You can modify the numbers and try different values
	uv.x *= 1.0 + pow(abs(uv.y) / 5.0, 2.5);
	uv.y *= 1.0 + pow(abs(uv.x) / 5.0, 2.5);
	
	// The scale part (you can delete it when you want)
	//uv /= 0.5;
	
	uv = (uv/2.0) + 0.5;
	return uv;
}


void fragment() {
	
	// You can modify the *3.0, *-3.0 for a bigger or smaller 
	vec3 rgb = texture(SCREEN_TEXTURE, uv_curve(SCREEN_UV)).rgb;
	
	// If you don't want scanlines, you can delete this part
	float s = sin(uv_curve(SCREEN_UV).y * scanline_count * TAU);
	s = (s * 0.5 + 0.5) * 0.9 + 0.1;
	vec4 scan_line = vec4(vec3(pow(s, 0.25)), 1.0);
	
	
	COLOR = vec4(rgb, 1.0) * scan_line;
	COLOR.a = 0.1;
}