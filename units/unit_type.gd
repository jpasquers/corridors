class_name UnitType

var id: String;
var simple_view_path: String;
# Simple asset path for static presentation, i.e. hud or shadow

static var MAP = {
	"swordsman": SwordsmanType.new(),
	"barricade": BarricadeType.new(),
	"custom_wall": CustomWallType.new(),
	"archer": ArcherType.new(),
	"enemy_placeholder": EnemyPlaceholderType.new()
}

func instance_template() -> PackedScene:
	printerr("must define an instance template");
	return null;
