extends GridUnitType
class_name Swordsman

func _init():
	id = "swordsman";
	asset_path = "res://assets/swordsman.png";

func can_place_in_ground():
	return true;

func can_place_in_wall():
	return false;
