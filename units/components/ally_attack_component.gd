extends Node2D

var range: int;
var attack_delay: float;

func set_range(in_range):
	range = in_range;

func set_attack_speed(in_attack_delay):
	attack_delay = in_attack_delay;

# Called when the node enters the scene tree for the first time.
func _ready():
	$RangeArea.collision_mask = GlobalConst.ENEMY_COLLISION_LAYER;
	$RangeArea/Range.shape.set_radius(range);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
