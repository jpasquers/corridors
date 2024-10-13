extends TileMap

# Includes the terrain and any markers.
class_name Map

signal clicked_tile;
signal hovering_tile;


var DEFAULT_WIDTH = 20;
var DEFAULT_HEIGHT = 20;
var DEFAULT_DENSITY = 0.2;
var DEFAULT_CHECKPOINT_COUNT = 2;
# Not a real tile idx, preserved for the tile mapping.
var GROUND_TILE_IDX = 3;
var WALL_TILE_IDX = 2;
var START_TILE_IDX = 1;
var FINISH_TILE_IDX = 4;
var TESTER_TILE_IDX = 5;
var CHECKPOINT_1_TILE_IDX = 6;
var CHECKPOINT_2_TILE_IDX = 7;
var CHECKPOINT_3_TILE_IDX = 8;
var CHECKPOINT_TILE_IDX_MAP = {
	1: CHECKPOINT_1_TILE_IDX,
	2: CHECKPOINT_2_TILE_IDX,
	3: CHECKPOINT_3_TILE_IDX
};
var MODIFIER_TILE_IDX = 9;

#Layers
var TERRAIN_LAYER = 0;
var MARKERS_LAYER = 1;


#TileSet sources
var MARKERS_TILE_SET_SOURCE_ID = 0;
var WALL_TILE_SET_SOURCE_ID = 1;


var map_config: MapConfig;
#Kept for convenience in addition to the grid map.
var wall_positions: Array[Vector2i] = [];
var all_grass_positions: Array[Vector2i] = [];
#The viable path region is the largest connected graph of grass tiles.
var grass_play_region: Array[Vector2i] = [];
var start_position: Vector2i;
var finish_position: Vector2i;
var checkpoint_positions: Array[Vector2i] = [];

var modifiers: Array[MapModifier];

#Maps tile positions to MapTileLayers
var tile_info_map: Dictionary = {};

func set_map_config(in_map_config: MapConfig):
	map_config = in_map_config;

func _ready():
	# We let the game world tell us to init, so there's no ordering issues.
	pass

func _process(delta):
	if Input.is_action_just_released("lmb"):
		var tile = get_mouse_pos_tile();
		if (is_valid_tile(tile)):
			clicked_tile.emit(tile);

func _input(event):
	if event is InputEventMouseMotion:
		var tile = get_mouse_pos_tile();
		if (is_valid_tile(tile)):
			hovering_tile.emit(tile);

# The global tile positions the mob will go to,
# Aka [start, ...checkpoints, finish]
func get_tile_destinations() -> Array[Vector2i]:
	var overall_path: Array[Vector2i] = [];
	overall_path.push_back(start_position);
	for checkpoint in checkpoint_positions:
		overall_path.push_back(checkpoint);
	overall_path.push_back(finish_position);
	return overall_path;

func get_mouse_pos_tile() -> Vector2i:
	var local_mouse = get_local_mouse_position();
	return local_to_map(local_mouse); 

func is_grass(tile: Vector2i):
	return all_grass_positions.has(tile);
	
func is_wall(tile: Vector2i):
	return wall_positions.has(tile);
				
func is_valid_tile(tile: Vector2i):
	return tile.x >= 0 && tile.y >= 0 && tile.x < grid_tile_width() && tile.y < grid_tile_height();
	
func grid_point_width( ) -> int:
	return grid_tile_width() * tile_set.tile_size.x;

func grid_point_height() -> int:
	return grid_tile_height() * tile_set.tile_size.y;

func grid_tile_width():
	return map_config.grid_size.x if map_config else DEFAULT_WIDTH;
	
func grid_tile_height():
	return map_config.grid_size.y if map_config else DEFAULT_HEIGHT;

func checkpoint_count():
	return map_config.checkpoint_count if map_config else DEFAULT_CHECKPOINT_COUNT;


func density():
	return map_config.density if map_config else DEFAULT_DENSITY;
	
func grid_point_center():
	return Vector2i(
		floor(grid_point_width()/2), 
		floor(grid_point_height()/2)
	);
	
func all_tile_positions() -> Array[Vector2i]:
	var positions: Array[Vector2i] = [];
	for x in grid_tile_width():
		for y in grid_tile_height():
			positions.push_front((Vector2i(x,y)));
	return positions;
	

func generate_all():
	_gen_wall_tile_set();
	_gen_background();
	_populate_empty_grid();
	_gen_base_layer();
	_determine_grass_play_region();
	_gen_start();
	_gen_finish();
	_gen_checkpoints();
	_gen_modifiers();
	
	
func _gen_wall_tile_set():
	tile_set.add_source(
		WallFactory.generate_tile_set_source(),
		WALL_TILE_SET_SOURCE_ID
	);

func _gen_background():
	$Bg.size.x = grid_point_width();
	$Bg.size.y = grid_point_height();

func _gen_start():
	start_position = unmarked_grass_play_positions().pick_random();
	_place_start(start_position);
	tile_info_map[start_position].marker_tile_id = START_TILE_IDX;

func _gen_finish():
	finish_position = unmarked_grass_play_positions().pick_random();
	_place_finish(finish_position);
	tile_info_map[finish_position].marker_tile_id = FINISH_TILE_IDX;

func _gen_modifiers():
	for i in range(0,map_config.modifier_count):
		var mod_position = unmarked_wall_positions().pick_random();
		_place_modifier(mod_position, 1.0);
		tile_info_map[mod_position].marker_tile_id = MODIFIER_TILE_IDX;

func _gen_checkpoints():
	var ct = checkpoint_count();
	print("Placing " + str(ct) + " checkpoints");
	for i in range(1,ct+1):
		var checkpoint_position = unmarked_grass_play_positions().pick_random();
		checkpoint_positions.push_back(checkpoint_position);
		print("Placing checkpoint " + str(i) + " at " + str(checkpoint_position));
		_place_checkpoint(checkpoint_position, i);
		tile_info_map[checkpoint_position].marker_tile_id = CHECKPOINT_TILE_IDX_MAP[i];

#These are grass positions that
# 1) are in the 'play region'
# 2) Do not have a marker already
func unmarked_grass_play_positions() -> Array[Vector2i]:
	return grass_play_region.filter(
		func has_no_marker(position):
			return tile_info_map[position].marker_tile_id == -1;
	);

func unmarked_wall_positions() -> Array[Vector2i]:
	return wall_positions.filter(
		func has_no_marker(position):
			return tile_info_map[position].marker_tile_id == -1;
	)
	
func _place_wall(pos: Vector2i, wall_idx: int):
	set_cell(TERRAIN_LAYER, pos, WALL_TILE_SET_SOURCE_ID, Vector2i(0,0), wall_idx);
	
func _place_tester(pos: Vector2i):
	set_cell(TERRAIN_LAYER, pos, MARKERS_TILE_SET_SOURCE_ID, Vector2i(0,0), TESTER_TILE_IDX);  

func _place_start(pos: Vector2i):
	set_cell(MARKERS_LAYER, pos, MARKERS_TILE_SET_SOURCE_ID, Vector2i(0,0), START_TILE_IDX);

func _place_finish(pos: Vector2i):
	set_cell(MARKERS_LAYER, pos, MARKERS_TILE_SET_SOURCE_ID, Vector2i(0,0), FINISH_TILE_IDX);

func _place_checkpoint(pos: Vector2i, idx: int):
	var tile_idx = CHECKPOINT_TILE_IDX_MAP[idx];
	set_cell(MARKERS_LAYER, pos, MARKERS_TILE_SET_SOURCE_ID, Vector2i(0,0), tile_idx);
		
func _place_modifier(pos: Vector2i, mod: float):
	var full_position = map_to_local(pos);
	var scene = load("res://level/world/map/modifiers/map_modifier.tscn");
	var instance = scene.instantiate();
	instance.position = full_position;
	add_child(instance);

# The "grass play" region is the largest region of interconnected grass tiles.
# Calculated by grouping all grass tiles into disparate "regions".
# The largest region is then used for all game markers.
func _determine_grass_play_region():
	# Array[Array[Vector2i]]
	var regions = [];
	var grass_copy = all_grass_positions.duplicate();
	while grass_copy.size() > 0:
		var start_point = grass_copy.pick_random();
		var region = _generate_region_from(start_point, grass_copy);
		regions.push_back(region);
		grass_copy = _remove_all(grass_copy,region);

	grass_play_region = regions.reduce(func bigger(curr, prev):
		return curr if curr.size() > prev.size() else prev;
	, []);
		
func _remove_all(source: Array[Vector2i], to_remove: Array[Vector2i]):
	return source.filter(func keep(item):
		return !to_remove.has(item)
	);

func _surrounding_points(pt: Vector2i):
	return [
		Vector2i(pt.x+1, pt.y),
		Vector2i(pt.x-1, pt.y),
		Vector2i(pt.x, pt.y-1),
		Vector2i(pt.x, pt.y+1)
	]

func _generate_region_from(base: Vector2i, all: Array[Vector2i]):
	var region: Array[Vector2i] = [base];
	var explore_queue = [base];
	while explore_queue.size() > 0:
		var to_explore = explore_queue.pop_back();
		var surrounding = _surrounding_points(to_explore);
		var viable = surrounding.filter(func is_viable(point):
			return all.has(point) && !region.has(point);
		)
		region.append_array(viable);
		explore_queue.append_array(viable);
	return region;
	
# Assumes the tile_info_map is populated.
func wall_adj_for(pos: Vector2i)->String:
	var top_pos = pos - Vector2i(0,1);
	var right_pos = pos + Vector2i(1,0);
	var bottom_pos = pos + Vector2i(0,1);
	var left_pos = pos - Vector2i(1,0);
	var adj = "";
	if (tile_info_map.has(top_pos) && 
			tile_info_map[top_pos].terrain_tile_id == WALL_TILE_IDX):
		adj += "t";
	if (tile_info_map.has(right_pos) && 
			tile_info_map[right_pos].terrain_tile_id == WALL_TILE_IDX):
		adj += "r";
	if (tile_info_map.has(bottom_pos) && 
			tile_info_map[bottom_pos].terrain_tile_id == WALL_TILE_IDX):
		adj += "b";
	if (tile_info_map.has(left_pos) && 
			tile_info_map[left_pos].terrain_tile_id == WALL_TILE_IDX):
		adj += "l";
	return adj;
		
func _gen_base_layer():
	for position in all_tile_positions():
		if randi() % 100 <= density()*100:
			tile_info_map[position].terrain_tile_id = WALL_TILE_IDX;
			wall_positions.push_front(position);
		else: 
			tile_info_map[position].terrain_tile_id = GROUND_TILE_IDX;
			all_grass_positions.push_front(position);
	for position in tile_info_map:
		if tile_info_map[position].terrain_tile_id == WALL_TILE_IDX:
			var adjacency = wall_adj_for(position);
			var tile_idx = WallFactory.ADJ_TILE_ID_MAP[adjacency];
			_place_wall(position, tile_idx);

func _populate_empty_grid():
	for position in all_tile_positions():
		tile_info_map[position] = TileLayers.new();

