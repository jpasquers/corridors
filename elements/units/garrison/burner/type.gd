extends GarrisonType
class_name BurnerType

func _init():
	simple_view_path = "res://assets/burner.png";
	type_id = "burner";
	rarity = 1;
	starting_base_dmg = 1;
	starting_base_range = 400;
	starting_base_attack_rate = 0.5;

func can_place_in_ground():
	return false;

func can_place_in_wall():
	return true;
	
func blocks_pathing():
	return false;

func instance_template():
	return preload("res://elements/units/garrison/burner/burner.tscn");
