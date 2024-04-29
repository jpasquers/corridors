extends Node2D

class_name Unit

var type: UnitType;
var unit_id: int = GlobalID.next();

# Called when the node enters the scene tree for the first time.
func _ready():
	print(type.asset_path);
	var image: Image = Image.load_from_file(type.asset_path);
	var texture: ImageTexture = ImageTexture.create_from_image(image);
	$UnitImage.set_texture(texture);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
