extends Node
class_name Map;

signal placed_unit;


var map_config: MapConfig;

var path_finder: AStarGrid2D;

var DEFAULT_WIDTH = 20;
var DEFAULT_HEIGHT = 20;
var DEFAULT_DENSITY = 0.2;
var GRASS_TILE_IDX = 3;
var WALL_TILE_IDX = 2;
var START_TILE_IDX = 1;
var FINISH_TILE_IDX = 4;
var TESTER_TILE_IDX = 5;

#Layers
var TERRAIN_LAYER = 0;
var MARKERS_LAYER = 1;
var OCCUPANT_LAYER = 2;

var mob_tile_path: PackedVector2Array;
var mob_point_path: PackedVector2Array;

#TileSet sources. Static source includes most terrain and markers.
var STATIC_TILE_SET_SOURCE_ID = 0;

#Kept for convenience in addition to the grid map.
var wall_positions: Array[Vector2i] = [];
var all_grass_positions: Array[Vector2i] = [];
#The viable path region is the largest connected graph of grass tiles.
var viable_path_region: Array[Vector2i] = [];
var start_position: Vector2i;
var finish_position: Vector2i;

var shadow_type: UnitType;
var shadow: Node2D;

#Maps vector positions to MapTileLayers
var grid_map: Dictionary = {};

func set_map_config(in_map_config: MapConfig): 
	map_config = in_map_config;

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_maze();
	init_path_finding();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event is InputEventMouseButton || event is InputEventMouseMotion:
		var tile = mouse_pos_tile();
		if (valid_tile(tile)):
			if event is InputEventMouseButton:
				print("click registered at tile " + str(tile));
				clicked_tile(tile);
			else:
				hovering_tile(tile);
				
func valid_tile(tile: Vector2i):
	return tile.x >= 0 && tile.y >= 0 && tile.x < grid_width() && tile.y < grid_height();

func mouse_pos_tile() -> Vector2i:
	var local_mouse = $MapGrid.get_local_mouse_position();
	return $MapGrid.local_to_map(local_mouse); 

func hovering_tile(tile: Vector2i):
	if (!shadow_type):
		return;
	if (!unit_type_viable_for_tile(shadow_type, tile)):
		return;
	if (!shadow):
		shadow = load("res://units/shadow.tscn").instantiate();
		shadow.type = shadow_type;
		add_child(shadow);
	var grid: TileMap = $MapGrid;
	var pos = grid.map_to_local(tile);
	shadow.position = pos;

func unit_type_viable_for_tile(type: UnitType, tile: Vector2i):
	if is_occupied(tile):
		return false;
	if (all_grass_positions.has(tile) && !type.can_place_in_ground()):
		return false;
	if (wall_positions.has(tile) && !type.can_place_in_wall()):
		return false;
	return true;

func clicked_tile(tile: Vector2i):
	if is_occupied(tile):
		pass;
	else:
		if (shadow_type):
			if (try_place_unit(shadow_type, tile)):
				shadow_type = null;
				shadow = null;
		else:
			print("Click does not correspond to shadow");

func try_place_unit(type: UnitType, tile: Vector2i) -> bool:
	print("Attempt place " + str(type.id) + " at " + str(tile));
	if (type.blocks_pathing() && !valid_path_if_tile_solid(tile)):
		print("Attempt failed, no valid path after");
		return false;
	var unit = load(type.instance_template()).instantiate();
	unit.type = type;
	unit.tile = tile;
	var grid: TileMap = $MapGrid;
	var pos = grid.map_to_local(tile);
	unit.position = pos;
	add_child(unit);
	grid_map[tile].occupant = unit;
	re_evaluate_tile_pathing(tile);
	placed_unit.emit(type);
	return true;

func fully_blocked_pathing(tile: Vector2i) -> bool:
	if (wall_positions.has(tile)):
		return true;
	var occupant = grid_map[tile].occupant;
	if (occupant != null && occupant.type.blocks_pathing()):
		return true;
	return false;

func valid_path_if_tile_solid(tile: Vector2i):
	path_finder.set_point_solid(tile, true);
	var path = path_finder.get_id_path(start_position, finish_position);
	path_finder.set_point_solid(tile, false);
	return path.size() > 0;

func re_evaluate_tile_pathing(tile):
	path_finder.set_point_solid(tile, fully_blocked_pathing(tile));
	mob_tile_path = path_finder.get_id_path(start_position, finish_position);
	mob_point_path = path_finder.get_point_path(start_position, finish_position);
	$PathIndicator.set_point_path(mob_point_path);

func init_path_finding():
	path_finder = AStarGrid2D.new();
	# Basically causes point results to be in the center of the tile.

	path_finder.size = Vector2i(grid_width(), grid_height());
	var cell_size = $MapGrid.tile_set.tile_size;
	path_finder.offset = Vector2i(cell_size.x / 2, cell_size.y / 2);
	path_finder.cell_size = cell_size;
	path_finder.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_AT_LEAST_ONE_WALKABLE;
	path_finder.update();
	for tile in grid_map.keys():
		path_finder.set_point_solid(tile, fully_blocked_pathing(tile));
	mob_tile_path = path_finder.get_id_path(start_position, finish_position);
	mob_point_path = path_finder.get_point_path(start_position, finish_position);
	$PathIndicator.set_point_path(mob_point_path);
	
func generate_maze():
	populate_empty_grid();
	gen_base_layer();
	determine_viable_path_region();
	gen_start();
	gen_finish();

func gen_start():
	start_position = unoccupied_path_positions().pick_random();
	place_start(start_position);
	grid_map[start_position].marker_tile_id = START_TILE_IDX;

func gen_finish():
	finish_position = unoccupied_path_positions().pick_random();
	place_finish(finish_position);
	grid_map[finish_position].marker_tile_id = FINISH_TILE_IDX;

func unoccupied_path_positions():
	return viable_path_region.filter(
		func has_no_marker(position):
			return grid_map[position].marker_tile_id == -1;
	);

# This is a very complicated concept, what being occupied means.
func is_occupied(tile: Vector2i):
	return grid_map[tile].occupant != null;

func determine_viable_path_region():
	# Array[Array[Vector2i]]
	var regions = [];
	var grass_copy = all_grass_positions.duplicate();
	while grass_copy.size() > 0:
		var start_point = grass_copy.pick_random();
		var region = generate_region_from(start_point, grass_copy);
		regions.push_back(region);
		grass_copy = remove_all(grass_copy,region);

	viable_path_region = regions.reduce(func bigger(curr, prev):
		return curr if curr.size() > prev.size() else prev;
	, []);
		
func remove_all(source: Array[Vector2i], to_remove: Array[Vector2i]):
	return source.filter(func keep(item):
		return !to_remove.has(item)
	);

func surrounding_points(pt: Vector2i):
	return [
		Vector2i(pt.x+1, pt.y),
		Vector2i(pt.x-1, pt.y),
		Vector2i(pt.x, pt.y-1),
		Vector2i(pt.x, pt.y+1)
	]

func generate_region_from(base: Vector2i, all: Array[Vector2i]):
	var region: Array[Vector2i] = [base];
	var explore_queue = [base];
	while explore_queue.size() > 0:
		var to_explore = explore_queue.pop_back();
		var surrounding = surrounding_points(to_explore);
		var viable = surrounding.filter(func is_viable(point):
			return all.has(point) && !region.has(point);
		)
		region.append_array(viable);
		explore_queue.append_array(viable);
	return region;

func gen_base_layer():
	for position in all_tile_positions():
		if randi() % 100 <= density()*100:
			place_hill(position);
			grid_map[position].terrain_tile_id = WALL_TILE_IDX;
			wall_positions.push_front(position);
		else: 
			place_grass(position);
			grid_map[position].terrain_tile_id = GRASS_TILE_IDX;
			all_grass_positions.push_front(position);

func populate_empty_grid():
	for position in all_tile_positions():
		grid_map[position] = TileLayers.new();

func all_tile_positions() -> Array[Vector2i]:
	var positions: Array[Vector2i] = [];
	for x in grid_width():
		for y in grid_height():
			positions.push_front((Vector2i(x,y)));
	return positions;

func density():
	return map_config.density if map_config else DEFAULT_DENSITY;

func grid_width():
	return map_config.grid_size.x if map_config else DEFAULT_WIDTH;
	
func grid_height():
	return map_config.grid_size.y if map_config else DEFAULT_HEIGHT;

func place_grass(pos: Vector2i):
	var grid: TileMap = $MapGrid;
	grid.set_cell(TERRAIN_LAYER, pos, STATIC_TILE_SET_SOURCE_ID, Vector2i(0,0), GRASS_TILE_IDX); 
	
func place_hill(pos: Vector2i):
	var grid: TileMap = $MapGrid;
	grid.set_cell(TERRAIN_LAYER, pos, STATIC_TILE_SET_SOURCE_ID, Vector2i(0,0), WALL_TILE_IDX);
	
func place_tester(pos: Vector2i):
	var grid: TileMap = $MapGrid;
	grid.set_cell(TERRAIN_LAYER, pos, STATIC_TILE_SET_SOURCE_ID, Vector2i(0,0), TESTER_TILE_IDX);  

func place_start(pos: Vector2i):
	var grid: TileMap = $MapGrid;
	grid.set_cell(MARKERS_LAYER, pos, STATIC_TILE_SET_SOURCE_ID, Vector2i(0,0), START_TILE_IDX);

func place_finish(pos: Vector2i):
	var grid: TileMap = $MapGrid;
	grid.set_cell(MARKERS_LAYER, pos, STATIC_TILE_SET_SOURCE_ID, Vector2i(0,0), FINISH_TILE_IDX);

func set_shadow(type: UnitType):
	print("Map registered shadow");
	shadow_type = type;
	var tile = mouse_pos_tile();
	if (valid_tile(tile)):
		hovering_tile(tile);
