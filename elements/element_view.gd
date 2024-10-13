extends TextureButton

class_name ElementView

var hotkey_enabled: bool = false;
var hotkey: String = '';
var hotkey_vis: String = '';
var count_enabled: bool = false;
var count: int;
var type: BaseElementType;
var bg_color_center = Color(0.1,0.1,0.1,0.9);
var bg_color_edge = Color(0.25,0.25,0.25,0.9);
# Scale is relative to 64x64
@export var scale_by: int = 1;

signal select_element;


static func empty():
	var self_template = load("res://elements/element_view.tscn");
	var scene = self_template.instantiate();
	scene.type = BaseElementType.new();
	return scene;
	
func _ready():
	var rarity_color_val = rarity_color(type.rarity);
	set_bg_colors(rarity_color_val);
	set_bg_size(scale_by);
	pressed.connect(do_select);
	
	#Load inner element asset
	var image: Image = Image.load_from_file(type.simple_view_path);
	var texture: ImageTexture = ImageTexture.create_from_image(image);
	$ElementAsset.texture = texture;
	#Load peripheral text.
	$Count.visible = count_enabled;
	$Count.text = "[center]" + str(count) + "[/center]";
	$Hotkey.visible = hotkey_enabled;
	$Hotkey.text = "[center]" + hotkey_vis + "[/center]";

func _process(delta):
	if is_visible_in_tree() && hotkey_enabled && Input.is_action_just_released(hotkey):
		do_select();
			
func do_select():
	select_element.emit(type);

func rarity_color(rarity: int):
	print("Found rarity:" + str(rarity));
	return [
		#Basic
		Color(0.55,0.55,0.55,0.9),
		Color(0.07,0.45,0.55,0.9),
		Color(0.59,0.16,0.73,0.9)
	][rarity];

func set_count(val: int):
	count = val;
	$Count.text = str(count);

	
func decr_count():
	set_count(count-1);

func deselect():
	#no op for now
	pass;



func set_bg_size(scale_by: int):
	size = Vector2i(64,64)*Vector2i(scale_by,scale_by);
	texture_normal.width = size.x;
	texture_hover.width = size.x;
	texture_pressed.width = size.x;
	texture_focused.width = size.x;
	texture_normal.height = size.y;
	texture_hover.height = size.y;
	texture_pressed.height = size.y;
	texture_focused.height = size.y;
	
# Basically, the 'color' is what's on the edge,
# Which is a lighter color. The inner color (at idx 0)
# Is a slightly darker version.
func set_bg_colors(rarity_color_val: Color):
	var colors = PackedColorArray([
		bg_color_center,
		bg_color_edge,
		rarity_color_val
	])
	texture_normal.gradient.colors = colors;
	texture_hover.gradient.colors = colors;
	texture_pressed.gradient.colors = colors;
	texture_focused.gradient.colors = colors;
