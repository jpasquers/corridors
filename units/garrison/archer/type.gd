extends GarrisonType
class_name ArcherType

func _init():
	simple_view_path = "res://assets/archer.png";
	id = "archer";
	base_dmg = 3;
	base_range = 200;
	base_attack_speed = 2;

func can_place_in_ground():
	return false;

func can_place_in_wall():
	return true;
	
func blocks_pathing():
	return false;

func instance_template():
	return preload("res://units/garrison/archer/archer.tscn");
