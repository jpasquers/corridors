extends GarrisonType
class_name SyfonType

var starting_base_dmg_ramp_tick: float;

func _init():
	simple_view_path = "res://assets/syfon.png";
	type_id = "syfon";
	starting_base_dmg = 0;
	starting_base_dmg_ramp_tick = 1;
	starting_base_range = 250;
	starting_base_attack_rate = 0.5;
 
func can_place_in_ground():
	return false;

func can_place_in_wall():
	return true;
	
func blocks_pathing():
	return false;

func instance_template():
	return preload("res://elements/units/garrison/syfon/syfon.tscn");
