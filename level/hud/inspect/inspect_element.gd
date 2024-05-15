extends Control

var inspectee;

func _in_inspect(unit: Unit):
	print("Inspecting " + str(unit.unit_id));
	inspectee = unit;
	visible = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_escape"):
		inspectee = null;
		visible = false;
