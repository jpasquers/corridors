extends Control

class_name Level;

var level_start_config: LevelStartConfig;
var shadow: GridUnitType;

func set_level_start_config(in_level_config: LevelStartConfig):
	$GameWorld/Map.set_map_config(in_level_config.map_config);
	$HUDLayer/HUD/PlayerState.set_boot_player_state(in_level_config.boot_player_state);
	$HUDLayer/HUD/Bottom/Row/Left/DeployableGroups.set_boot_deployable_groups(in_level_config.boot_deployable_groups);
	$HUDLayer/HUD/WaveControl.set_waves_config(in_level_config.waves_config);
	level_start_config = in_level_config;

func _ready():
	$GameWorld.do_inspect.connect(_on_do_inspect);
	$HUDLayer/HUD/WaveControl.spawn_enemy.connect(_on_should_spawn_enemy);

func _on_do_inspect(unit: Unit):
	$HUDLayer/HUD/Bottom/Row/Right/InspectGarrison._in_inspect(unit);

func _on_should_spawn_enemy(type: UnitType):
	$GameWorld._in_spawn_pathing_unit(type);

func _process(delta):
	pass
