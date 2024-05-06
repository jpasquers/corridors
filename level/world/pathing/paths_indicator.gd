extends Node2D

class_name PathsIndicator;

var point_paths: Array[PackedVector2Array];

var lines: Array[Line2D] = [];

func set_point_paths(in_paths: Array[PackedVector2Array]):
	for line in lines:
		line.queue_free();
	lines = [];
	point_paths = in_paths;
	for point_path in point_paths:
		var line = Line2D.new();
		line.default_color = Color(1,1,1,1);
		lines.push_back(line);
		line.set_points(point_path);
		add_child(line);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
