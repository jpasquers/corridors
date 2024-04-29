extends Control

class_name Level;

var level_start_config: LevelStartConfig;
var shadow: GridUnitType;

func set_level_start_config(in_level_config: LevelStartConfig):
	$MapLayer/Map.set_map_config(in_level_config.map_config);
	$HUDLayer/HUD/DeployableGarrison.set_boot_deployable_garrison(in_level_config.boot_deployable_garrison)
	$HUDLayer/Hud/WaveControl.set_
	level_start_config = in_level_config;

# Called when the node enters the scene tree for the first time.
func _ready():
	$MapLayer/Map.placed_unit.connect(_on_placed_unit);
	$HUDLayer/HUD/DeployableGarrison.selected_shadow.connect(_on_selected_shadow);

func _on_placed_unit(type: GridUnitType):
	print("Unit placed");
	$HUDLayer/HUD/DeployableGarrison._in_placed_unit(type);

func _on_selected_shadow(type: GridUnitType):
	print("Level registered select shadow");
	$MapLayer/Map.set_shadow(type);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
