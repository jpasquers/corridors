extends GarrisonType
class_name BarricadeType

func _init():
	simple_view_path = "res://assets/barricade.png";
	type_id = "barricade";

func can_place_in_ground():
	return true;

func can_place_in_wall():
	return false;

func instance_template():
	return preload("res://elements/units/garrison/barricade/barricade.tscn")
