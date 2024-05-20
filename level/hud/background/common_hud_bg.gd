extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var orange_patches = $Outer/BG.material.get_shader_parameter("orange_patches");
	orange_patches.noise.seed = randi_range(0,10);
	$Outer/BG.material.set_shader_parameter("orange_patches", orange_patches);
	$Outer/Rope1.material.set_shader_parameter("frequency", randi_range(3,4));
	$Outer/Rope2.material.set_shader_parameter("frequency", randi_range(5,6));
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
