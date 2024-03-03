extends Control

class_name Level;

var level_config: LevelConfig;

func set_level_config(in_level_config: LevelConfig):
	$MapLayer/Map.set_map_config(in_level_config.map_config);
	level_config = in_level_config;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
