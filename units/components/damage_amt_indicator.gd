extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func display(dmg: int):
	$Label.text = "[center]" + str(dmg) + "[/center]";
	var tween = get_tree().create_tween();
	tween.tween_property($Label, "scale", Vector2(), 0.3);
	tween.tween_callback($Label.queue_free);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
