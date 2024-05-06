extends GarrisonType
class_name BarricadeType

func _init():
	simple_view_path = "res://assets/barricade.png";
	id = "barricade";

func can_place_in_ground():
	return true;

func can_place_in_wall():
	return false;

func instance_template():
	return preload("res://units/garrison/barricade/barricade.tscn")
