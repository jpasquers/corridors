extends Garrison

class_name Burner

@onready var attacker: AttackComponent = $AttackComponent;

func _ready():
	type = BurnerType.new();
	stats = AttackerStats.new(type);
	attacker.set_attack_delay(type.starting_base_attack_rate);
	attacker.set_range(type.starting_base_range);
	attacker.do_attack.connect(_on_do_attack);
	attacker.updated_target_queue.connect(_on_updated_target_queue);

func _process(delta):
	pass

func _on_do_attack():
	for target in active_targets:
		target.inbound_damage(stats.get_curr_dmg(target));

func _on_updated_target_queue(target_queue: Array[Enemy]):
	active_targets = target_queue;
