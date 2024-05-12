extends AttackerStats

class_name SyfonAttackerStats;

var base_dmg_ramp_tick;
var curr_dmg_ramp;

func _init(type: SyfonType):
	super._init(type);
	base_dmg_ramp_tick = type.starting_base_dmg_ramp;
	curr_dmg_ramp = 0;

func reset_ramp():
	curr_dmg_ramp = 0;

func do_ramp():
	curr_dmg_ramp += base_dmg_ramp_tick;

func get_curr_dmg():
	return (base_dmg + curr_dmg_ramp) * incr_dmg;
