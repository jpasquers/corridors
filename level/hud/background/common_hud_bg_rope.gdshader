shader_type canvas_item;

uniform sampler2D fabric;
uniform float frequency = 5.0;
uniform float vert_displace = 0.4;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 zoomed = UV.xy * vec2(2.0,2.0);
	vec4 fabric_color = texture(fabric, vec2(mod(zoomed.x,1.0), mod(zoomed.y, 1.0)));
	float y_val = (sin(UV.x*frequency) / 4.0) + vert_displace;
	if (UV.y > y_val+0.05 || UV.y < y_val-0.05) {
		COLOR.a=0.0;
	}
	else {
		COLOR.rgb *= fabric_color.rgb;
	}
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
