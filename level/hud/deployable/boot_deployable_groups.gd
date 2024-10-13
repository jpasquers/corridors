class_name BootDeployableGroups

# Simple map of unit type id -> count
var garrison_counts_map: Dictionary;
var item_counts_map: Dictionary;
var terraform_counts_map: Dictionary;

#returns the standard list of deployable units with counts set to 0.
static func EMPTY():
	var boot = BootDeployableGroups.new();
	boot.garrison_counts_map = {
		"custom_wall": 0,
		"barricade": 0,
		"swordsman": 0,
	}
	boot.terraform_counts_map = {
		"custom_wall": 0
	}
	boot.item_counts_map = {
		"simple_whetstone": 0
	}
	return boot;

static func TEST():
	var boot = BootDeployableGroups.new();
	boot.garrison_counts_map = {
		"custom_wall": 5,
		"archer": 2,
		"burner": 1,
		"syfon": 1,
		"swordsman": 1,
	}
	boot.terraform_counts_map = {
		"custom_wall": 1
	}
	boot.item_counts_map = {
		"simple_whetstone": 2
	}
	return boot;
