extends Node2D

var max_health: float;
var health: float;

signal no_health;

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health;
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Does not consider any armor/dodge/anything. strictly health loss
func lose_health(damage):
	health = max(0, health - damage);
	if health == 0:
		no_health.emit()
