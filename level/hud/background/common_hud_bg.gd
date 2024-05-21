extends Control

class_name CommonHudBg;


@export var freq_min = 4.0;
@export var freq_max = 6.0;
@export var ropes = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	var orange_patches = $Outer/BG.material.get_shader_parameter("orange_patches");
	orange_patches.noise.seed = randi_range(0,10);
	$Outer/BG.material.set_shader_parameter("orange_patches", orange_patches);
	$Outer/Rope1.visible = ropes;
	$Outer/Rope2.visible = ropes;
	$Outer/Rope1.material.set_shader_parameter("frequency", randi_range(freq_min, freq_max));
	$Outer/Rope2.material.set_shader_parameter("frequency", randi_range(freq_min, freq_max));
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
