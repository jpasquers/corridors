extends Modifier

class_name AttackerModifier;

var mod;

func _init(in_mod):
	mod = in_mod;
	
func apply(stats: AttackerStats)->AttackerStats:
	return mod.call(stats);

static func addBaseDamage(base_dmg: float):
	return AttackerModifier.new(
		func(stats: AttackerStats)->AttackerStats:
			stats.base_dmg += base_dmg;
			return stats;
	);
	
static func addBaseRange(base_range: int):
	return AttackerModifier.new(
		func(stats: AttackerStats)->AttackerStats:
			stats.base_range += base_range;
			return stats;
	)
	
static func addIncrRange(incr_range: float):
	return AttackerModifier.new(
		func(stats: AttackerStats)->AttackerStats:
			stats.incr_range += incr_range;
			return stats;
	)


static func apply_all(target: AttackerStats, mods: Array[AttackerModifier]):
	for mod in mods:
		target = mod.apply(target);
	return target;

static func unapply_all(target: AttackerStats, mods: Array[AttackerModifier]):
	pass;


