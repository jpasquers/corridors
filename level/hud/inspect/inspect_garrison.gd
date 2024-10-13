extends Control

var inspectee: Garrison;

var stat_eles: Array[RichTextLabel] = [];
var item_eles: Array[ElementView] = [];
var COUNT_ITEM_SLOTS_VISIBLE = 5;

func common_txt()->RichTextLabel:
	var stat = RichTextLabel.new();
	stat.bbcode_enabled = true;
	stat.fit_content = true;
	return stat;

func atk_rate_txt(unit: Garrison)-> RichTextLabel:
	var stat = common_txt();
	stat.text = "Attack Rate: " + str(unit.stats.get_curr_attack_rate());
	return stat;
	
func dmg_txt(unit: Garrison)-> RichTextLabel:
	var stat = common_txt();
	stat.text = "Damage: " + str(unit.stats.get_curr_dmg());
	return stat;

func range_txt(unit: Garrison)-> RichTextLabel:
	var stat = common_txt();
	stat.text = "Range: " + str(unit.stats.get_curr_range());
	return stat;

func _in_inspect(unit: Garrison):
	for ele in stat_eles:
		ele.queue_free();

	stat_eles = [
		atk_rate_txt(unit),
		dmg_txt(unit),
		range_txt(unit)
	];
	for ele in stat_eles:
		$Stats.add_child(ele);
	var image: Image = Image.load_from_file(unit.type.simple_view_path);
	var SCALE = 3;
	var texture: ImageTexture = ImageTexture.create_from_image(image);
	$MiddleSection/Centered/StaticUnitAsset.scale = Vector2i(SCALE,SCALE);
	$MiddleSection/Centered/StaticUnitAsset.texture = texture;
	
	
	for item in item_eles:
		item.queue_free();
	item_eles = [];
	var blank_count = COUNT_ITEM_SLOTS_VISIBLE - unit.bound_items.size();
	var element_view_templ = load("res://elements/element_view.tscn");
	for type in unit.bound_items:
		var scene = element_view_templ.instantiate();
		scene.scale_by = 1;
		scene.type = ElementTypeMap.MAP[type.type_id];
		item_eles.push_back(scene);
		$Items.add_child(scene);
	for i in range(0,blank_count):
		var scene = ElementView.empty();
		item_eles.push_back(scene);
		$Items.add_child(scene);

	inspectee = unit;
	
	visible = true;

func _ready():
	visible = false;

func _process(delta):
	if Input.is_action_just_released("ui_escape"):
		inspectee = null;
		visible = false;
