class_name MapConfig

var grid_size: Vector2 = Vector2(20,20);
var density: float = 0.1;
var checkpoint_count: int = 1;

func _init(in_grid_size: Vector2, in_density: float, in_checkpoint_count: int):
	grid_size = in_grid_size;
	density = in_density;
	checkpoint_count = in_checkpoint_count;
