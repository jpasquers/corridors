extends Node2D

class_name BaseElement;

var id: int = GlobalID.next();

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func get_bounds(scale: int = 1) -> Vector2:
	return Vector2(64,64) * Vector2(scale,scale);
