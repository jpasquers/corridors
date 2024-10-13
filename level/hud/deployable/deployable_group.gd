extends HBoxContainer

class_name DeployableGroup;

# Maps an element type id to the initial count available.
var initial_counts_map: Dictionary = {};
# Maps a element type id to the instantiated scene for their selector
var type_selector_map: Dictionary = {};
# Flat list of the scenes.
var selectors: Array = [];

func set_initial_counts_map(in_counts_map: Dictionary):
	initial_counts_map = in_counts_map;

func _ready():
	var scene_template = load("res://elements/element_view.tscn");
	var ui_position = 0;
	for key in initial_counts_map.keys(): 
		ui_position+= 1;
		var scene = scene_template.instantiate();
		scene.scale_by = 2;
		scene.count_enabled = true;
		scene.count = initial_counts_map[key];
		scene.hotkey_enabled = true;
		scene.hotkey = "ui_" + str(ui_position);
		scene.hotkey_vis = str(ui_position);
		scene.type = ElementTypeMap.MAP[key];
		scene.select_element.connect(_on_selected)
		type_selector_map[key] = scene;
		selectors.push_back(scene);
		add_child(scene);

func consume(type: BaseElementType):
	type_selector_map[type.type_id].decr_count();
	type_selector_map[type.type_id].deselect();

func _on_selected(type: BaseElementType):
	print("Deployable group registered element select");
	#Deselect other selectors.
	for selector in selectors:
		if (selector.type.type_id != type.type_id):
			selector.deselect();

func _process(delta):
	pass
