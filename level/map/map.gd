extends Node
class_name Map;

var map_config: MapConfig;

var DEFAULT_WIDTH = 20;
var DEFAULT_HEIGHT = 20;
var DEFAULT_DENSITY = 0.2;
var GRASS_TILE_IDX = 2;
var WALL_TILE_IDX = 3;
var wall_positions: Array[Vector2] = [];
var grass_positions: Array[Vector2] = [];
#Maps vector positions to MapTileLayers
var grid_map: Dictionary = {};

func set_map_config(in_map_config: MapConfig): 
	map_config = in_map_config;

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_maze();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_maze():
	populate_empty_grid();
	gen_base_layer();

func gen_base_layer():
	for position in all_tile_positions():
		if randi() % 100 <= density()*100:
			place_hill(position);
			grid_map[position].lower_layer = WALL_TILE_IDX;
			wall_positions.push_front(position);
		else: 
			place_grass(position);
			grid_map[position].lower_layer = GRASS_TILE_IDX;
			grass_positions.push_front(position);

func populate_empty_grid():
	for position in all_tile_positions():
		grid_map[position] = TileLayers.new();

func all_tile_positions() -> Array[Vector2]:
	var positions: Array[Vector2] = [];
	for x in grid_width():
		for y in grid_height():
			positions.push_front((Vector2(x,y)));
	return positions;

func density():
	return map_config.density if map_config else DEFAULT_DENSITY;

func grid_width():
	return map_config.grid_size.x if map_config else DEFAULT_WIDTH;
	
func grid_height():
	return map_config.grid_size.y if map_config else DEFAULT_HEIGHT;

func place_grass(pos: Vector2):
	var grid: TileMap = $MapGrid;
	grid.set_cell(0, pos, 0, Vector2i(0,0), GRASS_TILE_IDX); 
	
func place_hill(pos: Vector2):
	var grid: TileMap = $MapGrid;
	grid.set_cell(0, pos, 0, Vector2i(0,0), WALL_TILE_IDX); 
