extends HBoxContainer

class_name DeployableGarrison;

signal selected_shadow;

var boot: BootDeployableGarrison = BootDeployableGarrison.EMPTY();
# Maps a unit type id to the instantiated scene for their selector
var type_selector_map: Dictionary = {};
# Flat list of the scenes.
var selectors: Array = [];

func set_boot_deployable_garrison(in_boot: BootDeployableGarrison):
	boot = in_boot;

func did_deploy(unit_type: GridUnitType):
	type_selector_map[unit_type.id].decr_count();

func update_count_for(unit_type: GridUnitType, new_count: int):
	type_selector_map[unit_type.id].set_count(new_count);

# Called when the node enters the scene tree for the first time.
func _ready():
	var scene_template = load("res://level/hud//deploy_garrison/deployable_unit_selector.tscn");
	var ui_position = 0;
	for key in boot.counts_map.keys(): 
		ui_position+= 1;
		var scene = scene_template.instantiate();
		scene.count = boot.counts_map[key];
		scene.type = UnitType.MAP[key];
		scene.ui_position = ui_position;
		scene.select_unit.connect(_on_selected)
		type_selector_map[key] = scene;
		selectors.push_back(scene);
		add_child(scene);

func _in_placed_unit(type: GridUnitType):
	for selector in selectors:
		if (selector.type.id == type.id):
			selector.decr_count();
			selector.deselect();

func _on_selected(type: GridUnitType):
	print("Deployable garrison registered unit select");
	#Deselect other selectors.
	for selector in selectors:
		if (selector.type.id != type.id):
			selector.deselect();
	selected_shadow.emit(type);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
