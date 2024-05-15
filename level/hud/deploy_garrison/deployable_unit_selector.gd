extends Control

class_name DeployableUnitSelector;

signal select_unit;

var selected = false;
var count: int;
var type: GridUnitType;
var ui_position: int = 1;

func _ready():
	sync_count();
	var image: Image = Image.load_from_file(type.simple_view_path);
	var texture: ImageTexture = ImageTexture.create_from_image(image);
	$Selectable/UnitImage.set_texture(texture);
	$Selectable.pressed.connect(_on_selected);

func _process(delta):
	if Input.is_action_just_released("ui_" + str(ui_position)):
		_on_selected();
	
func decr_count():
	set_count(count-1);
	
func set_count(in_count):
	count = in_count;
	sync_count();
	
func deselect():
	selected = false;
	
func _on_selected():
	if (count) > 0 && !selected:
		select_unit.emit(type);
		selected = true;

func sync_count(): 
	$Count.text = String.num_int64(count);
