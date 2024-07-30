extends Modifier

class_name AttackerModifier;

static func addBaseDamage(dmg: float):
	return func(stats: AttackerStats)->AttackerStats:
		stats.base_dmg += dmg;
		return stats;
