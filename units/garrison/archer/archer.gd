extends Garrison

class_name Archer

@onready var attacker: AttackComponent = $AttackComponent;

@onready var arrow_scene = preload("res://projectiles/arrows/basic_arrow.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	type = ArcherType.new();
	attacker.set_attack_delay(type.starting_base_attack_rate);
	attacker.set_range(type.starting_base_range);
	attacker.do_attack.connect(_on_do_attack);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_do_attack(target_queue):
	for target in active_targets:
		var arrow = arrow_scene.instantiate();
		arrow.damage = stats.get_curr_dmg(target);
		arrow.projectile_speed = 1200;
		arrow.pierce = 0;
		arrow.position = $ArrowStart.position;
		arrow.fixed_target = target_queue[0].get_forward_position();
		add_child(arrow);

func select_targets(target_queue: Array[Enemy]) -> Array[Enemy]:
	if target_queue.size() > 0:
		return [target_queue[0]];
	else:
		return [];

func _on_updated_target_queue(target_queue: Array[Enemy]):
	active_targets = select_targets(target_queue);
	if active_targets.size() > 0:
		look_at(active_targets[0].global_position);
