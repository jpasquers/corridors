extends Camera2D

class_name DraggableCamera

var dragging = false;

func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if Input.is_action_just_released("cam_z_out"):
		zoom = zoom - Vector2(0.1,0.1);
	if Input.is_action_just_released("cam_z_in"):
		zoom = zoom + Vector2(0.1,0.1);

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
