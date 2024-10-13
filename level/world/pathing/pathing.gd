extends Node2D

class_name Pathing;

var global_id_route: Array;

var astar: AStarGrid2D;

# This is Array[Array[Vector2i]];
var mob_tile_paths: Array;
var mob_point_paths: Array[PackedVector2Array];


func _ready():
	#We wait to init so there are no ordering issues.
	pass;

func _process(delta):
	pass

func init_pathing(boot: BootPathingConfig):
	global_id_route = boot.global_tile_route;
	astar = AStarGrid2D.new();

	astar.size = boot.size;
	astar.offset = Vector2i(boot.cell_size.x / 2, boot.cell_size.y / 2);
	astar.cell_size = boot.cell_size;
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_AT_LEAST_ONE_WALKABLE;
	astar.update();
	for tile in boot.initial_solid_map.keys():
		astar.set_point_solid(tile, boot.initial_solid_map[tile]);
	synchronize_pathing();

func calc_mob_tile_paths() -> Array:
	var paths: Array = [];
	#-1 since we do the path from x to x+1
	for i in range(0,global_id_route.size()-1):
		var path = astar.get_id_path(global_id_route[i], global_id_route[i+1]);
		paths.append(path);
	return paths;
	
func calc_mob_point_paths() -> Array[PackedVector2Array]:
	var new_paths: Array[PackedVector2Array] = [];
	#-1 since we do the path from x to x+1
	for i in range(0,global_id_route.size()-1):
		new_paths.push_back(
			astar.get_point_path(global_id_route[i], global_id_route[i+1])
		);
	return new_paths;

func synchronize_pathing():
	mob_tile_paths = calc_mob_tile_paths();
	mob_point_paths = calc_mob_point_paths();
	$PathsIndicator.set_point_paths(mob_point_paths);
	$EnemyRouter.rebuild_follow_curve(mob_point_paths);
	
func add_enemy(enemy: Enemy):
	$EnemyRouter.add_enemy(enemy);

func valid_path_if_tile_solid(tile: Vector2i):
	astar.set_point_solid(tile, true);
	var paths = calc_mob_tile_paths();
	astar.set_point_solid(tile, false);
	return paths.all(func (path):
		return path.size() > 0;
	);

func update_tile(tile: Vector2i, solid: bool):
	astar.set_point_solid(tile, solid);
	synchronize_pathing();
