extends Control

var inspectee: Garrison;

var eles: Array[RichTextLabel] = [];

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
	for ele in eles:
		ele.queue_free();
	eles = [
		atk_rate_txt(unit),
		dmg_txt(unit),
		range_txt(unit)
	];
	for ele in eles:
		$Stats.add_child(ele);
	var image: Image = Image.load_from_file(unit.type.simple_view_path);
	var SCALE = 3;
	var texture: ImageTexture = ImageTexture.create_from_image(image);
	$MiddleSection/Centered/StaticUnitAsset.scale = Vector2i(SCALE,SCALE);
	$MiddleSection/Centered/StaticUnitAsset.texture = texture;
	
	inspectee = unit;
	
	visible = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_escape"):
		inspectee = null;
		visible = false;
