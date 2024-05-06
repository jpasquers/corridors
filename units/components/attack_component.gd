extends Node2D

var range: int;
var attack_speed: float;

func set_range(in_range):
	range = in_range;

func set_attack_speed(in_attack_speed):
	attack_speed = in_attack_speed;

# Called when the node enters the scene tree for the first time.
func _ready():
	$RangeArea/Range.shape.set_radius(range);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
