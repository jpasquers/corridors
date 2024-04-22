extends Node2D

var type: UnitType;
var tile: Vector2i;

# Called when the node enters the scene tree for the first time.
func _ready():
	var image: Image = Image.load_from_file(type.asset_path);
	var texture: ImageTexture = ImageTexture.create_from_image(image);
	$UnitImage.set_texture(texture);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
