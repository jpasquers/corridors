extends Unit

class_name Enemy

signal died;

func get_forward_global_position():
	printerr("MUST IMPLEMENT PER ENEMY");

func inbound_damage(damage: int):
	printerr("MUST IMPLEMENT PER ENEMY");
