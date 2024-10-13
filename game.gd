extends Control

func _ready():
	$Menu/Options/Start.connect("pressed", self.start_level);

func _process(delta):
	pass

func start_level():
	$Menu/Options/Start.queue_free();
	var level: Level = load("res://level/level.tscn").instantiate();
	var level_config = LevelStartConfig.TEST();
	level.set_level_start_config(level_config);
	add_child(level);
