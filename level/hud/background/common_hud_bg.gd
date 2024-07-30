extends Control

class_name CommonHudBg;


@export var freq_min = 4.0;
@export var freq_max = 6.0;
@export var rope_vert_displace = 0.4;
@export var ropes_top = true;
@export var ropes_bottom = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	var orange_patches = $Outer/BG.material.get_shader_parameter("orange_patches");
	orange_patches.noise.seed = randi_range(0,10);
	$Outer/BG.material.set_shader_parameter("orange_patches", orange_patches);
	$Outer/Rope1.visible = ropes_bottom;
	$Outer/Rope2.visible = ropes_top;
	$Outer/Rope1.material.set_shader_parameter("vert_displace", rope_vert_displace);
	$Outer/Rope2.material.set_shader_parameter("vert_displace", rope_vert_displace);
	$Outer/Rope1.material.set_shader_parameter("frequency", randi_range(freq_min, freq_max));
	$Outer/Rope2.material.set_shader_parameter("frequency", randi_range(freq_min, freq_max));
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
