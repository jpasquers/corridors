extends Node2D

var BASE_WIDTH=40;

var max_health: float;
var health: float;

signal no_health;

func init_at(in_max_health):
	max_health = in_max_health;
	set_health(max_health);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Does not consider any armor/dodge/anything. strictly health loss
func lose_health(damage):
	print("enemy has " + str(health) + " and will take " + str(damage) + " damage")
	set_health(health-damage);

func set_health(in_health):
	health = max(0, in_health)
	$HealthPctDisplay.size.x = floor((health/ max_health) * BASE_WIDTH);
	if health == 0:
		no_health.emit()
