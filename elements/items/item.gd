extends BaseElement

class_name Item

func _ready():
	pass

func _process(delta):
	pass

func name():
	printerr("must define a name");
	return null;
	
func description():
	printerr("must define a description");
	return null;
