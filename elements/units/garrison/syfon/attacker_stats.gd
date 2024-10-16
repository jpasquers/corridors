extends AttackerStats

class_name SyfonAttackerStats;

var base_dmg_ramp_tick;

var ramps: Dictionary;

func _init(type: SyfonType):
	super._init(type);
	base_dmg_ramp_tick = type.starting_base_dmg_ramp_tick;
	ramps = {};

func ramp_adjust_targets(enemies: Array[Enemy]):
	for id in ramps.keys():
		if !(enemies.any(func(enemy):
			return enemy.id == id
		)):
			#Enemy is gone, reset ramp to 0
			ramps[id] = 0;

func do_ramp(enemy: Enemy):
	if !(enemy.id in ramps):
		ramps[enemy.id] = base_dmg_ramp_tick;
	else:
		ramps[enemy.id] += base_dmg_ramp_tick;

func get_curr_dmg(enemy: Enemy = null):
	if (!enemy):
		return (base_dmg * incr_dmg);
	if !(enemy.id in ramps):
		ramps[enemy.id] = 0;
	return (base_dmg + ramps[enemy.id]) * incr_dmg;
