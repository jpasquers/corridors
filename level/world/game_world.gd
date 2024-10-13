extends Node2D
class_name GameWorld;

signal do_inspect;

var map_config: MapConfig;

var unit_shadow_type: GridUnitType;
var item_shadow_type: ItemType;
var unit_shadow: UnitShadow;
var item_shadow: ItemShadow;

var enemies: Array[Node2D] = [];

@onready var pathing = $Pathing;
@onready var map: Map = $Map;
@onready var camera: DraggableCamera = $DraggableCamera;

#Maps tiles to an occupant.
var tile_occupant_map: Dictionary;

func _ready():
	map.generate_all();
	map.clicked_tile.connect(clicked_tile);
	map.hovering_tile.connect(hovering_tile);
	camera.global_position = map.grid_point_center();
	pathing.init_pathing(boot_pathing_cfg());
	Events.player_selected_unit_shadow.connect(set_unit_shadow);
	Events.player_selected_item_shadow.connect(set_item_shadow);

func _process(delta):
	pass

# Items can just use general mouse tracking.
# Units require tile knowledge, so they depend on map events.
func _input(event):
	if event is InputEventMouseMotion:
		if (!item_shadow_type):
			return;
		if (!item_shadow):
			item_shadow = load("res://elements/items/item_shadow.tscn").instantiate();
			item_shadow.type = item_shadow_type;
			add_child(item_shadow);
		var pos = get_local_mouse_position();		
		item_shadow.position = pos;

func hovering_tile(tile: Vector2i):
	if (!unit_shadow_type):
		return;
	if (!unit_type_viable_for_tile(unit_shadow_type, tile)):
		return;
	if (!unit_shadow):
		unit_shadow = load("res://elements/units/shadow.tscn").instantiate();
		unit_shadow.type = unit_shadow_type;
		add_child(unit_shadow);
	var pos = map.map_to_local(tile);
	unit_shadow.position = pos;

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
		var occupant = tile_occupant_map[tile];
		if (item_shadow):
			try_apply_item(occupant, item_shadow_type);
			item_shadow_type = null;
			item_shadow.queue_free();
			item_shadow = null;
		else:
			do_inspect.emit(tile_occupant_map[tile]);
	else:
		if (unit_shadow_type):
			if (!unit_type_viable_for_tile(unit_shadow_type, tile)):
				print("Unit not viable for tile");
				return;
			if (try_place_unit(unit_shadow_type, tile)):
				unit_shadow.queue_free();
				unit_shadow_type = null;
				unit_shadow = null;
		else:
			print("Click does not correspond to shadow");

func try_apply_item(unit: Garrison, item_type: ItemType):
	unit.apply_item(item_type);
	Events.player_applied_item.emit(unit, item_type);
	
func try_place_unit(type: GridUnitType, tile: Vector2i) -> bool:
	print("Attempt place " + str(type.type_id) + " at " + str(tile));
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
	Events.player_placed_unit.emit(type);
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
	return BootPathingConfig.new(
		Vector2i(map.grid_tile_width(), map.grid_tile_height()),
		map.tile_set.tile_size,
		initial_solid_map,
		map.get_tile_destinations()
	)

# This is a very complicated concept, what being occupied means.
func is_occupied(tile: Vector2i):
	return tile_occupant_map.has(tile);

func set_unit_shadow(type: GridUnitType):
	print("Map registered unit shadow");
	unit_shadow_type = type;
	
	var tile = map.get_mouse_pos_tile();
	if (map.is_valid_tile(tile)):
		hovering_tile(tile);

func set_item_shadow(type: ItemType):
	print("Map registered item shadow");
	item_shadow_type = type;

func _in_spawn_pathing_unit(type: UnitType):
	print("Spawning type: " + type.type_id);
	var packed_scene =type.instance_template();
	var enemy = packed_scene.instantiate();
	enemy.type = type;
	enemy.z_index = 2;
	enemies.push_back(enemy);
	pathing.add_enemy(enemy);

