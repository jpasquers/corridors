shader_type canvas_item;

uniform sampler2D roughnesses;
uniform sampler2D dark_noises;
uniform sampler2D silver_noises;
uniform sampler2D light_noises;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 dark_noise = texture(dark_noises, UV);
	if (dark_noise.r + dark_noise.g + dark_noise.b < 0.7) {
		COLOR.rgb -= dark_noise.rgb / vec3(9.0,9.0,9.0);
	}
	
	vec4 roughness = texture(roughnesses, UV);
	COLOR.rgb += (vec3(1.0,1.0,1.0) - roughness.rgb) / vec3(3.0,3.0,3.0);
	
	vec4 silver_noise = texture(silver_noises, UV);
	//TODO
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
