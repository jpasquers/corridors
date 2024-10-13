extends Node2D

class_name UnitShadow

var type: UnitType;
var tile: Vector2i;

func _ready():
	var image: Image = Image.load_from_file(type.simple_view_path);
	var texture: ImageTexture = ImageTexture.create_from_image(image);
	$UnitImage.set_texture(texture);

func _process(delta):
	pass
