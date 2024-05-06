extends Control

class_name Level;

var level_start_config: LevelStartConfig;
var shadow: GridUnitType;

func set_level_start_config(in_level_config: LevelStartConfig):
	$GameWorld/Map.set_map_config(in_level_config.map_config);
	$HUDLayer/HUD/DeployableGarrison.set_boot_deployable_garrison(in_level_config.boot_deployable_garrison);
	$HUDLayer/HUD/WaveControl.set_waves_config(in_level_config.waves_config);
	level_start_config = in_level_config;

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameWorld.placed_unit.connect(_on_placed_unit);
	$HUDLayer/HUD/DeployableGarrison.selected_shadow.connect(_on_selected_shadow);
	$HUDLayer/HUD/WaveControl.spawn_enemy.connect(_on_should_spawn_enemy);

func _on_placed_unit(type: GridUnitType):
	print("Unit placed");
	$HUDLayer/HUD/DeployableGarrison._in_placed_unit(type);

func _on_selected_shadow(type: GridUnitType):
	print("Level registered select shadow");
	$GameWorld.set_shadow(type);
	
func _on_should_spawn_enemy(type: UnitType):
	$GameWorld._in_spawn_pathing_unit(type);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
