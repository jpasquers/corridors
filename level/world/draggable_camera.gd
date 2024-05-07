extends Camera2D

class_name DraggableCamera

var dragging = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom = zoom + Vector2(0.1,0.1);
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom = zoom - Vector2(0.1,0.1);
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		dragging = event.is_pressed();
	if dragging and DisplayServer.mouse_get_mode() == DisplayServer.MOUSE_MODE_VISIBLE:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN);
	if !dragging and DisplayServer.mouse_get_mode() == DisplayServer.MOUSE_MODE_HIDDEN:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE);
		
	if event is InputEventMouseMotion and dragging:
		global_position -= event.relative;
