extends Node2D

class_name AttackComponent;

signal do_attack;

@export var attack_when_no_target = false;

var range: int;
var attack_delay: float; 
var waiting_for_enemy: bool = false;

var target_queue: Array;

func set_range(in_range):
	range = in_range;
	$RangeArea/Range.shape.set_radius(range);

func set_attack_delay(in_attack_delay):
	attack_delay = in_attack_delay;
	$AttackTimer.wait_time = attack_delay;

# Called when the node enters the scene tree for the first time.
func _ready():
	$RangeArea.area_entered.connect(_on_enemy_enter);
	$RangeArea.area_exited.connect(_on_enemy_exit);
	$AttackTimer.start();
	$AttackTimer.timeout.connect(_on_attack_timer);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_attack_timer():
	var should_attack = attack_when_no_target || target_queue.size() > 0;
	if should_attack:
		go();
	else:
		waiting_for_enemy = true;
	
func _on_enemy_enter(enemy_area):
	var enemy = enemy_area.owner;
	target_queue.push_back(enemy);
	if waiting_for_enemy:
		waiting_for_enemy = false;
		go();
	
func _on_enemy_exit(enemy_area):
	var enemy = enemy_area.owner;
	target_queue = target_queue.filter(func x(target):
		return 	target.unit_id != enemy.unit_id
	);

func go():
	do_attack.emit(target_queue);
	$AttackTimer.start();
