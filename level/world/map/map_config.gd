class_name MapConfig

var grid_size: Vector2 = Vector2(20,20);
var density: float = 0.1;
var checkpoint_count: int = 1;
var modifier_count: int = 2;

func _init(in_grid_size: Vector2, 
		in_density: float, 
		in_checkpoint_count: int, 
		in_modifier_count: int
	):
	grid_size = in_grid_size;
	density = in_density;
	checkpoint_count = in_checkpoint_count;
	modifier_count = in_modifier_count;
	
