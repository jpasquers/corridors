extends GridUnitType
class_name CustomWallType

func _init():
	simple_view_path = "res://assets/custom_wall.png";
	id = "custom_wall";

func can_place_in_ground():
	return true;

func can_place_in_wall():
	return false;

func blocks_pathing():
	return true;

func instance_template():
	return preload("res://units/terraform/custom_wall/custom_wall.tscn");
