class_name WallFactory

static var ADJ_TILE_ID_MAP = {
	"": 0,
	"t": 1,
	"r": 2,
	"b": 3,
	"l": 4,
	"tr": 5,
	"tb": 6,
	"tl": 7,
	"trl": 8,
	"tbl": 9,
	"trb": 10,
	"trbl": 11,
	"rbl": 12,
	"rb": 13,
	"rl": 14,
	"bl": 15
}

static func generate_tile_set_source()->TileSetSource:
	var set_source = TileSetScenesCollectionSource.new();
	for key in ADJ_TILE_ID_MAP:
		set_source.create_scene_tile(
			wall_with_adj(key),
			ADJ_TILE_ID_MAP[key]
		);
	return set_source;
	
static func wall_with_adj(adjacency: String)->PackedScene:
	var wall_base = preload("res://level/world/map/tiles/terrain/wall.tscn");
	var instance = wall_base.instantiate();
	instance.adjacency = adjacency;
	var packed = PackedScene.new();
	packed.pack(instance);
	return packed;
