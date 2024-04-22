extends UnitType
class_name Barricade

func _init():
	id = "barricade";
	asset_path = "res://assets/barricade.png";

func can_place_in_ground():
	return true;

func can_place_in_wall():
	return false;
