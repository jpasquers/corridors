class_name MapConfig

var grid_size: Vector2 = Vector2(20,20);
var density: float = 0.1;

func instantiate(in_grid_size: Vector2, in_density: float):
	grid_size = in_grid_size;
	density = in_density;
