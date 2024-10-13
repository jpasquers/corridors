extends Node2D

var BASE_WIDTH=40;

var max_health: float;
var health: float;

signal no_health;

func init_at(in_max_health):
	max_health = in_max_health;
	set_health(max_health);

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass


# Does not consider any armor/dodge/anything. strictly health loss
func lose_health(damage):
	var dmg_indicator = preload("res://elements/units/components/damage_amt_indicator.tscn").instantiate();
	dmg_indicator.position = $DamageAmtPt.position;
	dmg_indicator.position.x += randi_range(-40,40);
	dmg_indicator.position.y += randi_range(-10,0);
	add_child(dmg_indicator);
	dmg_indicator.display(damage);
	set_health(health-damage);

func set_health(in_health):
	health = max(0, in_health)
	$HealthPctDisplay.size.x = floor((health/ max_health) * BASE_WIDTH);
	if health == 0:
		no_health.emit()
