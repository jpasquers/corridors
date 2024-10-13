extends EnemyType

class_name AmmitKinDemoType

func _init():
	#simple_view_path = "res://assets/enemy_placeholder.png";
	type_id = "ammit_kin_demo";
	base_health = 10;

func instance_template():
	return preload("res://elements/units/enemy/ammit_kin_demo/ammit_kin_demo.tscn")
