extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func name():
	printerr("must define a name");
	return null;
	
func description():
	printerr("must define a description");
	return null;
