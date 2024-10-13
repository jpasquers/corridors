extends Control

@export var adjacency = "trb";


static var quad_size = Vector2i(128,128);
static var total_size = Vector2i(256,256);

static var quad_horiz: Image = Image.load_from_file("res://level/world/map/tiles/terrain/quad_horiz.png");
static var quad_vert: Image = Image.load_from_file("res://level/world/map/tiles/terrain/quad_vert.png");
static var quad_in: Image = Image.load_from_file("res://level/world/map/tiles/terrain/quad_in.png");
static var quad_out: Image = Image.load_from_file("res://level/world/map/tiles/terrain/quad_out.png");

# Maps an adjacency to the unrotated quads (in order: tl, tr, bl, br)
static var ADJACENCY_MAP = {
	"": [quad_in, quad_in, quad_in, quad_in],
	"t": [quad_vert, quad_vert, quad_in, quad_in],
	"r": [quad_in, quad_horiz, quad_in, quad_horiz],
	"b": [quad_in, quad_in, quad_vert, quad_vert],
	"l": [quad_horiz, quad_in, quad_horiz, quad_in],
	"tr": [quad_vert, quad_out, quad_in, quad_horiz],
	"tb": [quad_vert, quad_vert, quad_vert, quad_vert],
	"tl": [quad_out, quad_vert, quad_horiz, quad_in],
	"trl": [quad_out, quad_out, quad_horiz, quad_horiz],
	"tbl": [quad_out, quad_vert, quad_out, quad_vert],
	"trb": [quad_vert, quad_out, quad_vert, quad_out],
	"trbl": [quad_out, quad_out, quad_out, quad_out],
	"rbl": [quad_horiz, quad_horiz, quad_out, quad_out],
	"rb": [quad_in, quad_horiz, quad_vert, quad_out],
	"rl": [quad_horiz, quad_horiz, quad_horiz, quad_horiz],
	"bl": [quad_horiz, quad_in, quad_out, quad_vert]
}

func _ready():
	var composite = build_wall_composite();
	var texture: ImageTexture = ImageTexture.create_from_image(composite);
	$WallTexture.texture = texture;

func build_wall_composite()->Image:
	var base_quads = ADJACENCY_MAP[adjacency];
	var rotated_quads = rotate_quads(base_quads);
	var composite = combine_image_quads(
		rotated_quads[0],
		rotated_quads[1],
		rotated_quads[2],
		rotated_quads[3]
	);
	return composite;

func combine_image_quads(tl: Image, tr: Image, bl: Image, br: Image)-> Image:
	var composite = Image.create(total_size.x, total_size.y, true, Image.FORMAT_RGBA8);
	composite.blend_rect(tl, full_quad(), Vector2i(0,0));
	composite.blend_rect(tr, full_quad(), Vector2i(quad_size.x,0));
	composite.blend_rect(bl, full_quad(), Vector2i(0,quad_size.y));
	composite.blend_rect(br, full_quad(), quad_size);
	return composite;

func rotate_quads(base_quads: Array)->Array:
	return [
		base_quads[0],
		pure_flip_x(base_quads[1]),
		pure_flip_y(base_quads[2]),
		pure_flip_x(pure_flip_y(base_quads[3]))
	];

func full_quad()->Rect2i:
	return Rect2i(Vector2(0,0), quad_size);

func deep_copy(src: Image)->Image:
	var copy = Image.create(src.get_width(), src.get_height(), true, src.get_format());
	copy.copy_from(src);
	return copy;

func pure_flip_x(src: Image)->Image:
	var copy = deep_copy(src);
	copy.flip_x();
	return copy;

func pure_flip_y(src: Image)->Image:
	var copy = deep_copy(src);
	copy.flip_y();
	return copy;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
