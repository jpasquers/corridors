extends Node2D

class_name AttackComponent;

signal do_attack;
signal updated_target_queue;

@export var attack_when_no_target = false;

var range: int;
var attack_delay: float; 
var waiting_for_enemy: bool = false;

var target_queue: Array[Enemy];

func set_range(in_range):
	range = in_range;
	$RangeArea/Range.shape.set_radius(range);

func set_attack_delay(in_attack_delay):
	attack_delay = in_attack_delay;
	$AttackTimer.wait_time = attack_delay;

func _ready():
	$RangeArea.area_entered.connect(_on_enemy_enter);
	$RangeArea.area_exited.connect(_on_enemy_exit);
	$AttackTimer.start();
	$AttackTimer.timeout.connect(_on_attack_timer);
	if (owner.has_signal("update_stats")):
		owner.update_stats.connect(_in_sync_stats)

func _process(delta):
	pass
	
func _in_sync_stats(stats: AttackerStats):
	set_attack_delay(stats.get_curr_attack_rate());
	set_range(stats.get_curr_range());

func _on_attack_timer():
	var should_attack = attack_when_no_target || target_queue.size() > 0;
	if should_attack:
		go();
	else:
		waiting_for_enemy = true;
	
func _on_enemy_enter(enemy_area):
	var enemy = enemy_area.owner;
	target_queue.push_back(enemy);
	updated_target_queue.emit(target_queue);
	if waiting_for_enemy:
		waiting_for_enemy = false;
		go();
	
func _on_enemy_exit(enemy_area):
	var enemy = enemy_area.owner;
	target_queue = target_queue.filter(func x(target):
		return 	target.id != enemy.id
	);
	updated_target_queue.emit(target_queue);

func go():
	do_attack.emit();
	$AttackTimer.start();
