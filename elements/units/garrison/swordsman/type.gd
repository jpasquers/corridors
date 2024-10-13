extends GarrisonType

class_name SwordsmanType

func _init():
	simple_view_path = "res://assets/swordsman.png";
	type_id = "swordsman";

func can_place_in_ground():
	return true;

func can_place_in_wall():
	return false;

func instance_template():
	return preload("res://elements/units/garrison/swordsman/swordsman.tscn");
