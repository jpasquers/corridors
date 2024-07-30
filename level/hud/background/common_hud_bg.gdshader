shader_type canvas_item;

uniform sampler2D wrinkles;
uniform sampler2D orange_patches;
uniform sampler2D fray;
uniform sampler2D vert_bark;

void fragment() {
	
	vec4 wrinkle = texture(wrinkles, UV);
	COLOR.rgb += wrinkle.rgb / vec3(3.0,3.0,3.0);
	COLOR.rgb -= vec3(0.1,0.1,0.1);
	
	vec4 orange_patch = texture(orange_patches, UV);
	float orange_patch_lightness = orange_patch.r + orange_patch.g + orange_patch.b;
	float orange_diff = 1.2 - orange_patch_lightness;
	if (orange_diff > 0.0) {
		COLOR.b -= orange_diff / 9.0;
		COLOR.g -= orange_diff / 16.0;
	}
	
	vec2 zoomed = UV.xy * vec2(3.0,3.0);
	vec2 normalized = vec2(mod(zoomed.x,1.0), mod(zoomed.y,1.0));
	vec4 vert = texture(vert_bark, normalized);
	float vert_sum = vert.r + vert.g + vert.b;
	if (vert_sum < 0.05) {
		COLOR.rgb -= vec3(0.1,0.1,0.1);
	}
	
	//float to_edge_x = min(UV.x, 1.0-UV.x);
	//float to_edge_y = min(UV.y, 1.0-UV.y);
	//float to_edge = min(to_edge_x, to_edge_y);
	//if (to_edge < 0.05) {
		//float rough = (to_edge * 5.0) + 0.1;
		//COLOR.rgb = vec3(rough, rough/2.0, rough/3.0);	
	//}
}



//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
