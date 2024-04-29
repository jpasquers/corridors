extends UnitType

class_name GridUnitType

func can_place_in_ground():
	printerr("Abstract method");

func can_place_in_wall():
	printerr("Abstract method");

func blocks_pathing():
	return false;
