class_name BootPlayerState

var ka: int;
var lives: int;

func _init(in_ka: int, in_lives: int):
	ka = in_ka;
	lives = in_lives;

static func TEST():
	return BootPlayerState.new(
		50, 100
	);
