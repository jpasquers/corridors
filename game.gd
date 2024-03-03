extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuLayer/Start.connect("pressed", self.startLevel);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func startLevel():
	var level: Level = load("res://level/level.tscn").instantiate();
	var level_config = LevelConfig.new();
	var map_config = MapConfig.new();
	map_config.grid_size = Vector2(20,20);
	level_config.map_config = map_config;
	level.set_level_config(level_config);
	add_child(level);
