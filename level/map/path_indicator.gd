extends Node2D

var point_path: PackedVector2Array;

func set_point_path(in_path: PackedVector2Array):
	point_path = in_path;
	$Path.set_points(point_path);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
