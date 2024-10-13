extends EnemyType

class_name EnemyPlaceholderType

func _init():
	simple_view_path = "res://assets/enemy_placeholder.png";
	type_id = "enemy_placeholder";
	base_health = 10;

func instance_template():
	return preload("res://elements/units/enemy/placeholder/placeholder.tscn")
