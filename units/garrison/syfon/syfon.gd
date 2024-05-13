extends Garrison

@onready var attacker: AttackComponent = $AttackComponent;

var active_beams: Array[Beam];


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
	if active_targets.size() > 0:
		look_at(active_targets[0].global_position);
	
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
	active_targets = selected;
	draw_beams_for_active_targets();
	stats.ramp_adjust_targets(active_targets);

func draw_beams_for_active_targets():
	for existing in active_beams:
		existing.queue_free();
	active_beams = [];
	
	var template = preload("res://units/garrison/syfon/beam.tscn");
	for target in active_targets:
		var beam = template.instantiate();
		beam.z_index = 5;
		beam.define($BeamStart, target);
		active_beams.push_back(beam);
		add_sibling(beam);
	
