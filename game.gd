extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuLayer/Start.connect("pressed", self.start_level);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_level():
	$MenuLayer/Start.queue_free();
	var level: Level = load("res://level/level.tscn").instantiate();
	var level_config = LevelStartConfig.TEST();
	level.set_level_start_config(level_config);
	add_child(level);
