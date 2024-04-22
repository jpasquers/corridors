class_name UnitType

var id: String;
var asset_path: String;

static var MAP = {
	"swordsman": Swordsman.new(),
	"barricade": Barricade.new(),
	"custom_wall": CustomWall.new()
}

func instance_template():
	return "res://units/garrison/garrison.tscn"

func can_place_in_ground():
	printerr("Abstract method");

func can_place_in_wall():
	printerr("Abstract method");

func blocks_pathing():
	return false;
