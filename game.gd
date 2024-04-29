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
	var level_config = LevelStartConfig.new(
		MapConfig.new(
			Vector2(20,20),
			0.1,
			1
		),
		BootDeployableGarrison.TEST(),
		WavesConfig.new(
			30,
			50,
			[
				WaveConfig.new(
					EnemyPlaceholder.new(),
					10,
					1.0
				)
			]
		)
	);
	level_config.map_config = map_config;
	level.set_level_start_config(level_config);
	add_child(level);
