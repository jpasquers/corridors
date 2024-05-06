extends GarrisonType

class_name SwordsmanType

func _init():
	simple_view_path = "res://assets/swordsman.png";
	id = "swordsman";

func can_place_in_ground():
	return true;

func can_place_in_wall():
	return false;

func instance_template():
	return preload("res://units/garrison/swordsman/swordsman.tscn");
