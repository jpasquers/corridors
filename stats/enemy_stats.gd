class_name EnemyStats;

var base_speed;
var incr_speed;
var base_armor;
var incr_armor;

var health;
var max_health;

var exp_mod;

var type: EnemyType;

func _init(in_type: EnemyType):
	type = in_type;
	reset();
	
func reset():
	base_speed = type.base_speed;
	base_armor = type.base_armor;
	health = type.base_health;
	max_health = type.base_health;
	incr_speed = 1;
	incr_armor = 1;
	exp_mod = 1;
	
func get_curr_exp_mod():
	return exp_mod;

func get_curr_armor():
	return base_armor * incr_armor;

func get_curr_speed():
	return base_speed * incr_speed;

