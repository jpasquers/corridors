extends Line2D

class_name Beam

var source: Node2D;
var target: Node2D;

func define(in_source: Node2D, in_target: Node2D):
	source = in_source;
	target = in_target;
	add_point(target.global_position);


func _ready():
	pass # Replace with function body.


func _process(delta):
	sync();
	pass

func sync():
	set_point_position(0, source.global_position);
	set_point_position(1, target.global_position);
