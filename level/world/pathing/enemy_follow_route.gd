extends PathFollow2D

class_name EnemyFollowRoute;

signal reached_end;

var recipient: Enemy;

# Called when the node enters the scene tree for the first time.
func _ready():
	loop = false;
	rotates = false;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func bind_recipient(enemy: Enemy):
	recipient = enemy;
	add_child(recipient);
	
func get_recipient():
	return recipient;

func do_progress(amt):
	set_progress(progress + amt);
	if get_progress_ratio() == 1:
		reached_end.emit(self);
