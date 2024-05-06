extends Terraform

class_name CustomWall

# Called when the node enters the scene tree for the first time.
func _ready():
	type = CustomWallType.new();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
