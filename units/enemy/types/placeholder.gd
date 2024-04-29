extends UnitType
class_name EnemyPlaceholder

func _init():
	id = "enemy_placeholder";
	asset_path = "res://assets/enemy_placeholder.png";

func instance_template():
	return "res://units/enemy/enemy.tscn"
