extends GridUnitType
class_name CustomWall

func _init():
	id = "custom_wall";
	asset_path = "res://assets/custom_wall.png";

func can_place_in_ground():
	return true;

func can_place_in_wall():
	return false;

func blocks_pathing():
	return true;

func instance_template():
	return "res://units/terraform/terraform.tscn"
