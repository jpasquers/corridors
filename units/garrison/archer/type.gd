extends GarrisonType
class_name ArcherType

func _init():
	simple_view_path = "res://assets/archer.png";
	id = "archer";
	starting_base_dmg = 3;
	starting_base_range = 200;
	starting_base_attack_rate = 0.3;

func can_place_in_ground():
	return false;

func can_place_in_wall():
	return true;
	
func blocks_pathing():
	return false;

func instance_template():
	return preload("res://units/garrison/archer/archer.tscn");
