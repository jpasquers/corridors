extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var orange_patches = $BG.material.get_shader_parameter("orange_patches");
	orange_patches.noise.seed = randi_range(0,10);
	$BG.material.set_shader_parameter("orange_patches", orange_patches);
	
	$TopRope.material.set_shader_parameter("frequency", randi_range(1,8));
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
