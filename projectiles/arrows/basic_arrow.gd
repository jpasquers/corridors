extends Projectile

var fixed_target: Vector2;

# Called when the node enters the scene tree for the first time.
func _ready():
	look_at(fixed_target);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += transform.x * projectile_speed*delta;
