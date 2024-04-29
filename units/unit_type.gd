class_name UnitType

var id: String;
var asset_path: String;

static var MAP = {
	"swordsman": Swordsman.new(),
	"barricade": Barricade.new(),
	"custom_wall": CustomWall.new(),
	"enemy_placeholder": EnemyPlaceholder.new()
}

func instance_template():
	return "res://units/garrison/garrison.tscn"
