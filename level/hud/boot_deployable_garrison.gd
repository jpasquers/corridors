class_name BootDeployableGarrison

# Simple map of unit type id -> count
var counts_map: Dictionary;

#returns the standard list of deployable units with counts set to 0.
static func EMPTY():
	var boot = BootDeployableGarrison.new();
	boot.counts_map = {
		"custom_wall": 5,
		"barricade": 1,
		"swordsman": 1,
	}
	return boot;
