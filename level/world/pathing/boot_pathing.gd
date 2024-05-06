class_name BootPathingConfig

var size: Vector2i;
var cell_size: Vector2i;
#Maps tiles to a boolean indicating if the tile is fully blocking, aka "solid"
var initial_solid_map: Dictionary;
var global_tile_route: Array[Vector2i];

func _init(
	in_size: Vector2i,
	in_cell_size: Vector2i,
	in_initial_solid_map: Dictionary,
	in_global_tile_route: Array[Vector2i]
):
	size = in_size;
	cell_size = in_cell_size;
	initial_solid_map = in_initial_solid_map;
	global_tile_route = in_global_tile_route;
