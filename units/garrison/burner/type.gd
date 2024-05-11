extends GarrisonType
class_name BurnerType

func _init():
	simple_view_path = "res://assets/burner.png";
	id = "burner";
	base_dmg = 1;
	base_range = 400;
	base_attack_speed = 0.5;

func can_place_in_ground():
	return false;

func can_place_in_wall():
	return true;
	
func blocks_pathing():
	return false;

func instance_template():
	return preload("res://units/garrison/burner/burner.tscn");
