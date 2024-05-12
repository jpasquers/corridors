extends Garrison

@onready var attacker: AttackComponent = $AttackComponent;

var active_beam: Beam;


# Called when the node enters the scene tree for the first time.
func _ready():
	type = SyfonType.new();
	stats = SyfonAttackerStats.new(type);
	# Probably connect these more directly
	attacker.set_attack_delay(stats.get_curr_attack_rate());
	attacker.set_range(stats.get_curr_range());
	attacker.do_attack.connect(_on_do_attack);
	attacker.updated_target_queue.connect(_on_updated_target_queue);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func select_targets(target_queue: Array[Enemy]) -> Array[Enemy]:
	if target_queue.size() > 0:
		return [target_queue[0]];
	else:
		return [];

func _on_do_attack():
	for target in active_targets:
		var dmg = stats.get_curr_dmg(target);
		target.inbound_damage(dmg);
		stats.do_ramp(target);

func _on_updated_target_queue(target_queue: Array[Enemy]):
	var selected = select_targets(target_queue);
	stats.ramp_adjust_targets(selected);
	active_targets = selected;
	print("new target set of size " + str(active_targets.size()));
	if active_targets.size() > 0:
		look_at(active_targets[0].global_position);
