class_name AttackerStats

var base_dmg;
var base_attack_rate;
var base_range;
var incr_dmg; # 1 = 100% = no change.
var incr_attack_rate; # 1 = 100% = no change.
var incr_range; # 1 = 100% = no change.
var curr_dmg; 
var curr_attack_rate;
var curr_range;

var exp_mod;

var type: GarrisonType;

func _init(in_type: GarrisonType):
	type = in_type;
	reset();
	
func reset():
	base_dmg = type.starting_base_dmg;
	base_attack_rate = type.starting_base_attack_rate;
	base_range = type.starting_base_range;
	incr_attack_rate = 1;
	incr_dmg = 1;
	incr_range = 1;
	exp_mod = 1;

func get_curr_dmg(enemy: Enemy = null):
	return base_dmg * incr_dmg;

func get_curr_attack_rate():
	return base_attack_rate * incr_attack_rate;

func get_curr_range():
	return base_range * incr_range;
