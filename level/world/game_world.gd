extends Node
class_name GameWorld;

signal placed_unit;
signal do_inspect;

var map_config: MapConfig;

var shadow_type: GridUnitType;
var shadow: Node2D;

var enemies: Array[Node2D] = [];

@onready var pathing = $Pathing;
@onready var map: Map = $Map;
@onready var camera: DraggableCamera = $DraggableCamera;

#Maps tiles to an occupant.
var tile_occupant_map: Dictionary;



# Called when the node enters the scene tree for the first time.
func _ready():
	map.generate_all();
	map.clicked_tile.connect(clicked_tile);
	map.hovering_tile.connect(hovering_tile);
	camera.global_position = map.grid_point_center();
	pathing.init_pathing(boot_pathing_cfg());

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hovering_tile(tile: Vector2i):
	if (!shadow_type):
		return;
	if (!unit_type_viable_for_tile(shadow_type, tile)):
		return;
	if (!shadow):
		shadow = load("res://units/shadow.tscn").instantiate();
		shadow.type = shadow_type;
		add_child(shadow);
	var pos = map.map_to_local(tile);
	shadow.position = pos;

func unit_type_viable_for_tile(type: GridUnitType, tile: Vector2i):
	if is_occupied(tile):
		return false;
	if (map.is_grass(tile) && !type.can_place_in_ground()):
		return false;
	if (map.is_wall(tile) && !type.can_place_in_wall()):
		return false;
	return true;

func clicked_tile(tile: Vector2i):
	if is_occupied(tile):
		do_inspect.emit(tile_occupant_map[tile]);
	else:
		if (shadow_type):
			if (!unit_type_viable_for_tile(shadow_type, tile)):
				print("Unit not viable for tile");
				return;
			if (try_place_unit(shadow_type, tile)):
				shadow.queue_free();
				shadow_type = null;
				shadow = null;
		else:
			print("Click does not correspond to shadow");

func try_place_unit(type: GridUnitType, tile: Vector2i) -> bool:
	print("Attempt place " + str(type.id) + " at " + str(tile));
	if (type.blocks_pathing() && !pathing.valid_path_if_tile_solid(tile)):
		print("Attempt failed, no valid path after");
		return false;
	var unit = type.instance_template().instantiate();
	unit.type = type;
	unit.tile = tile;
	var pos = map.map_to_local(tile);
	unit.position = pos;
	add_child(unit);
	tile_occupant_map[tile] = unit;
	pathing.update_tile(tile, fully_blocked_pathing(tile));
	placed_unit.emit(type);
	return true;

func fully_blocked_pathing(tile: Vector2i) -> bool:
	if (map.is_wall(tile)):
		return true;
	if (tile_occupant_map.has(tile) && tile_occupant_map[tile].type.blocks_pathing()):
		return true;
	return false;

func boot_pathing_cfg():
	var initial_solid_map = {};
	for tile in map.all_tile_positions():
		initial_solid_map[tile] = fully_blocked_pathing(tile);
	print(map.get_tile_destinations());
	return BootPathingConfig.new(
		Vector2i(map.grid_tile_width(), map.grid_tile_height()),
		map.tile_set.tile_size,
		initial_solid_map,
		map.get_tile_destinations()
	)

# This is a very complicated concept, what being occupied means.
func is_occupied(tile: Vector2i):
	return tile_occupant_map.has(tile);

func set_shadow(type: GridUnitType):
	print("Map registered shadow");
	shadow_type = type;
	
	var tile = map.get_mouse_pos_tile();
	if (map.is_valid_tile(tile)):
		hovering_tile(tile);

func _in_spawn_pathing_unit(type: UnitType):
	print("Spawning type: " + type.id);
	var packed_scene =type.instance_template();
	var enemy = packed_scene.instantiate();
	enemy.type = type;
	enemy.z_index = 2;
	enemies.push_back(enemy);
	pathing.add_enemy(enemy);

