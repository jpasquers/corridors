shader_type canvas_item;

uniform sampler2D fabric;
uniform float frequency = 5.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 fabric_color = texture(fabric, UV / vec2(1.0, 4.0));
	float y_val = (sin(UV.x*frequency) / 4.0) + 0.5;
	if (UV.y > y_val+0.10 || UV.y < y_val-0.10) {
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
