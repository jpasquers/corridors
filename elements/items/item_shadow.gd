extends BaseElement

class_name ItemShadow

var type: ItemType;

func _ready():
	var image: Image = Image.load_from_file(type.simple_view_path);
	var texture: ImageTexture = ImageTexture.create_from_image(image);
	texture.set_size_override(get_bounds(1));
	$ItemImage.set_texture(texture);
	
func _process(delta):
	pass
